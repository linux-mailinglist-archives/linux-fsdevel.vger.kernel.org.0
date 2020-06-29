Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4853620D439
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgF2TG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:06:26 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:49193 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730489AbgF2TGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:24 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 76A73FB1A6
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 16:29:59 +0100 (IST)
Received: (qmail 5487 invoked from network); 29 Jun 2020 15:29:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jun 2020 15:29:59 -0000
Date:   Mon, 29 Jun 2020 16:29:57 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
Message-ID: <20200629152957.GD3183@techsingularity.net>
References: <20200615121358.GF3183@techsingularity.net>
 <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
 <20200616074701.GA20086@quack2.suse.cz>
 <4f6c8dab-4b54-d523-8636-2b01c03d14d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4f6c8dab-4b54-d523-8636-2b01c03d14d3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:17:02AM -0700, Eric Dumazet wrote:
> 
> 
> On 6/16/20 12:47 AM, Jan Kara wrote:
> > On Mon 15-06-20 19:26:38, Amir Goldstein wrote:
> >>> This patch changes alloc_file_pseudo() to always opt out of fsnotify by
> >>> setting FMODE_NONOTIFY flag so that no check is made for fsnotify watchers
> >>> on pseudo files. This should be safe as the underlying helper for the
> >>> dentry is d_alloc_pseudo which explicitly states that no lookups are ever
> >>> performed meaning that fanotify should have nothing useful to attach to.
> >>>
> >>> The test motivating this was "perf bench sched messaging --pipe". On
> >>> a single-socket machine using threads the difference of the patch was
> >>> as follows.
> >>>
> >>>                               5.7.0                  5.7.0
> >>>                             vanilla        nofsnotify-v1r1
> >>> Amean     1       1.3837 (   0.00%)      1.3547 (   2.10%)
> >>> Amean     3       3.7360 (   0.00%)      3.6543 (   2.19%)
> >>> Amean     5       5.8130 (   0.00%)      5.7233 *   1.54%*
> >>> Amean     7       8.1490 (   0.00%)      7.9730 *   2.16%*
> >>> Amean     12     14.6843 (   0.00%)     14.1820 (   3.42%)
> >>> Amean     18     21.8840 (   0.00%)     21.7460 (   0.63%)
> >>> Amean     24     28.8697 (   0.00%)     29.1680 (  -1.03%)
> >>> Amean     30     36.0787 (   0.00%)     35.2640 *   2.26%*
> >>> Amean     32     38.0527 (   0.00%)     38.1223 (  -0.18%)
> >>>
> >>> The difference is small but in some cases it's outside the noise so
> >>> while marginal, there is still some small benefit to ignoring fsnotify
> >>> for files allocated via alloc_file_pseudo in some cases.
> >>>
> >>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >>
> >> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > 
> > Thanks for the patch Mel and for review Amir! I've added the patch to my
> > tree with small amendments to the changelog.
> > 
> > 								Honza
> > 
> 
> Note this patch broke some user programs (one instance being packetdrill)
> 
> Typical legacy packetdrill script has :
> 
> // Create a socket and set it to non-blocking.
>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
>    +0 fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
>    +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> 
> 
> But after this change, fcntl(3, F_GETFL) returns 0x4000002 
> 
> FMODE_NONOTIFY was not meant to be visible to user space. (otherwise
> there would be a O_NONOTIFY) ?
> 

A revert has been sent because it broke chrome as well. It's not visible
on lkml yet because delivery appears to be delayed there for some unknown
reason.

-- 
Mel Gorman
SUSE Labs
