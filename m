Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12220D259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 20:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgF2Ssj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:48:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:43040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgF2Ssi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:48:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3D3AAAC5;
        Mon, 29 Jun 2020 18:48:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9726B1E12E7; Mon, 29 Jun 2020 20:48:35 +0200 (CEST)
Date:   Mon, 29 Jun 2020 20:48:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
Message-ID: <20200629184835.GK26507@quack2.suse.cz>
References: <20200615121358.GF3183@techsingularity.net>
 <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
 <20200616074701.GA20086@quack2.suse.cz>
 <4f6c8dab-4b54-d523-8636-2b01c03d14d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6c8dab-4b54-d523-8636-2b01c03d14d3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 29-06-20 08:17:02, Eric Dumazet wrote:
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

Interesting. As Mel said the patch is reverted anyway (Linus already
applied the revert) but the question about FMODE_NONOTIFY is interesting.
Userspace certainly cannot set the flag (the kernel enforces this on
open(2) and fcntl(F_SETFL)). But it is visible to userspace via
fcntl(F_GETFL) which may have been an oversight... I'm just not sure
whether some of the fanotify(7) users which legitimately get such file
descriptors don't depend on this flag being visible.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
