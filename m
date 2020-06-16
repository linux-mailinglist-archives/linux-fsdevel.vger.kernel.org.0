Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ACF1FAA51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFPHrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 03:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:45026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgFPHrD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:47:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20016AEB1;
        Tue, 16 Jun 2020 07:47:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 410971E1289; Tue, 16 Jun 2020 09:47:01 +0200 (CEST)
Date:   Tue, 16 Jun 2020 09:47:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
Message-ID: <20200616074701.GA20086@quack2.suse.cz>
References: <20200615121358.GF3183@techsingularity.net>
 <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-06-20 19:26:38, Amir Goldstein wrote:
> > This patch changes alloc_file_pseudo() to always opt out of fsnotify by
> > setting FMODE_NONOTIFY flag so that no check is made for fsnotify watchers
> > on pseudo files. This should be safe as the underlying helper for the
> > dentry is d_alloc_pseudo which explicitly states that no lookups are ever
> > performed meaning that fanotify should have nothing useful to attach to.
> >
> > The test motivating this was "perf bench sched messaging --pipe". On
> > a single-socket machine using threads the difference of the patch was
> > as follows.
> >
> >                               5.7.0                  5.7.0
> >                             vanilla        nofsnotify-v1r1
> > Amean     1       1.3837 (   0.00%)      1.3547 (   2.10%)
> > Amean     3       3.7360 (   0.00%)      3.6543 (   2.19%)
> > Amean     5       5.8130 (   0.00%)      5.7233 *   1.54%*
> > Amean     7       8.1490 (   0.00%)      7.9730 *   2.16%*
> > Amean     12     14.6843 (   0.00%)     14.1820 (   3.42%)
> > Amean     18     21.8840 (   0.00%)     21.7460 (   0.63%)
> > Amean     24     28.8697 (   0.00%)     29.1680 (  -1.03%)
> > Amean     30     36.0787 (   0.00%)     35.2640 *   2.26%*
> > Amean     32     38.0527 (   0.00%)     38.1223 (  -0.18%)
> >
> > The difference is small but in some cases it's outside the noise so
> > while marginal, there is still some small benefit to ignoring fsnotify
> > for files allocated via alloc_file_pseudo in some cases.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks for the patch Mel and for review Amir! I've added the patch to my
tree with small amendments to the changelog.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
