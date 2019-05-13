Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C241BAF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfEMQX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 12:23:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:33958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729702AbfEMQX7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 12:23:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00759ABCE;
        Mon, 13 May 2019 16:23:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 867E91E3E10; Mon, 13 May 2019 18:23:57 +0200 (CEST)
Date:   Mon, 13 May 2019 18:23:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Subject: Re: [PATCH v2] fsnotify: fix unlink performance regression
Message-ID: <20190513162357.GD13297@quack2.suse.cz>
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com>
 <20190507161928.GE4635@quack2.suse.cz>
 <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com>
 <20190509094629.GB23589@quack2.suse.cz>
 <CAOQ4uxiE=32a5RhqVyC9YAwoxfAdjLjAH0dgSEEV_EaT7H25UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiE=32a5RhqVyC9YAwoxfAdjLjAH0dgSEEV_EaT7H25UQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 10-05-19 17:57:49, Amir Goldstein wrote:
> On Thu, May 9, 2019 at 12:46 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 07-05-19 22:12:57, Amir Goldstein wrote:
> > > On Tue, May 7, 2019 at 7:19 PM Jan Kara <jack@suse.cz> wrote:
> > > > So I'd rather move the fsnotify call to vfs_unlink(),
> > > > vfs_rmdir(), simple_unlink(), simple_rmdir(), and then those few callers of
> > > > d_delete() that remain as you suggest elsewhere in this thread. And then we
> > > > get more consistent context for fsnotify_nameremove() and could just use
> > > > fsnotify_dirent().
> > > >
> > >
> > > Yes, I much prefer this solution myself and I will follow up with it,
> > > but it would not be honest to suggest said solution as a stable fix
> > > to the performance regression that was introduced in v5.1.
> > > I think is it better if you choose between lesser evil:
> > > v1 with ifdef CONFIG_FSNOTIFY to fix build issue
> > > v2 as subtle as it is
> > > OR another obviously safe stable fix that you can think of
> >
> > OK, fair enough. I'll go with v1 + build fix for current merge window +
> > stable as it's local to fsnotify_nameremove().
> 
> Please note that the patch on your fsnotify branch conflicts with
> fsnotify_nameremove() changes in master:
> 230c6402b1b3 ovl_lookup_real_one(): don't bother with strlen()
> 25b229dff4ff fsnotify(): switch to passing const struct qstr * for file_name

Thanks for the heads up! The conflict is easy enough to resolve but I've
notified Linus about it in my pull request. Hum, which reminds me that I've
forgotten to pull the latest fix in fsnotify branch into my for_next branch
and so I didn't get a notification about the conflict myself. Too late to
fix that now I guess...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
