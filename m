Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9146323B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 12:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhK3LZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 06:25:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59606 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhK3LZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:25:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9EB7F1FD54;
        Tue, 30 Nov 2021 11:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638271328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXbGNKNuwXGO6c7EKOduDaSAJNoK2kWEB4dyQyW5+Mc=;
        b=tFwXyBCGyFOkqZQ8+4+b02/DKke9S3CEVx3EVEPisfBa6xvIuefRRLtycWqxI22Ja5VQov
        6PxeAPqqnigAJ7EPND2I4uHc8o4GkvL8Vw7hLRPqee+XhCq3LjZclfq3F1rUVlyCVqiEda
        VEUskr6HC+ohUevzOb2WXZ68ihrKWYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638271328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXbGNKNuwXGO6c7EKOduDaSAJNoK2kWEB4dyQyW5+Mc=;
        b=8bphTj8o8uRtczjzUyUW7q+zUBy+sljEhm5ioFZnegWR5Upafra8EjVSqNwMk/Ej6tZW1d
        ei4eTWkI3mJaRKAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id DBBE2A3B85;
        Tue, 30 Nov 2021 11:22:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5534F1F2CAE; Tue, 30 Nov 2021 12:22:06 +0100 (CET)
Date:   Tue, 30 Nov 2021 12:22:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20211130112206.GE7174@quack2.suse.cz>
References: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
 <20211118112315.GD13047@quack2.suse.cz>
 <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz>
 <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 19-11-21 14:12:46, Chengguang Xu wrote:
>  ---- 在 星期五, 2021-11-19 00:43:49 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Thu 18-11-21 20:02:09, Chengguang Xu wrote:
>  > >  ---- 在 星期四, 2021-11-18 19:23:15 Jan Kara <jack@suse.cz> 撰写 ----
>  > >  > On Thu 18-11-21 14:32:36, Chengguang Xu wrote:
>  > >  > > 
>  > >  > >  ---- 在 星期三, 2021-11-17 14:11:29 Chengguang Xu <cgxu519@mykernel.net> 撰写 ----
>  > >  > >  >  ---- 在 星期二, 2021-11-16 20:35:55 Miklos Szeredi <miklos@szeredi.hu> 撰写 ----
>  > >  > >  >  > On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@mykernel.net> wrote:
>  > >  > >  >  > >
>  > >  > >  >  > >  ---- 在 星期四, 2021-10-07 21:34:19 Miklos Szeredi <miklos@szeredi.hu> 撰写 ----
>  > >  > >  >  > >  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrote:
>  > >  > >  >  > >  > >  > However that wasn't what I was asking about.  AFAICS ->write_inode()
>  > >  > >  >  > >  > >  > won't start write back for dirty pages.   Maybe I'm missing something,
>  > >  > >  >  > >  > >  > but there it looks as if nothing will actually trigger writeback for
>  > >  > >  >  > >  > >  > dirty pages in upper inode.
>  > >  > >  >  > >  > >  >
>  > >  > >  >  > >  > >
>  > >  > >  >  > >  > > Actually, page writeback on upper inode will be triggered by overlayfs ->writepages and
>  > >  > >  >  > >  > > overlayfs' ->writepages will be called by vfs writeback function (i.e writeback_sb_inodes).
>  > >  > >  >  > >  >
>  > >  > >  >  > >  > Right.
>  > >  > >  >  > >  >
>  > >  > >  >  > >  > But wouldn't it be simpler to do this from ->write_inode()?
>  > >  > >  >  > >  >
>  > >  > >  >  > >  > I.e. call write_inode_now() as suggested by Jan.
>  > >  > >  >  > >  >
>  > >  > >  >  > >  > Also could just call mark_inode_dirty() on the overlay inode
>  > >  > >  >  > >  > regardless of the dirty flags on the upper inode since it shouldn't
>  > >  > >  >  > >  > matter and results in simpler logic.
>  > >  > >  >  > >  >
>  > >  > >  >  > >
>  > >  > >  >  > > Hi Miklos，
>  > >  > >  >  > >
>  > >  > >  >  > > Sorry for delayed response for this, I've been busy with another project.
>  > >  > >  >  > >
>  > >  > >  >  > > I agree with your suggesion above and further more how about just mark overlay inode dirty
>  > >  > >  >  > > when it has upper inode? This approach will make marking dirtiness simple enough.
>  > >  > >  >  > 
>  > >  > >  >  > Are you suggesting that all non-lower overlay inodes should always be dirty?
>  > >  > >  >  > 
>  > >  > >  >  > The logic would be simple, no doubt, but there's the cost to walking
>  > >  > >  >  > those overlay inodes which don't have a dirty upper inode, right?  
>  > >  > >  > 
>  > >  > >  > That's true.
>  > >  > >  > 
>  > >  > >  >  > Can you quantify this cost with a benchmark?  Can be totally synthetic,
>  > >  > >  >  > e.g. lookup a million upper files without modifying them, then call
>  > >  > >  >  > syncfs.
>  > >  > >  >  > 
>  > >  > >  > 
>  > >  > >  > No problem, I'll do some tests for the performance.
>  > >  > >  > 
>  > >  > > 
>  > >  > > Hi Miklos,
>  > >  > > 
>  > >  > > I did some rough tests and the results like below.  In practice,  I don't
>  > >  > > think that 1.3s extra time of syncfs will cause significant problem.
>  > >  > > What do you think?
>  > >  > 
>  > >  > Well, burning 1.3s worth of CPU time for doing nothing seems like quite a
>  > >  > bit to me. I understand this is with 1000000 inodes but although that is
>  > >  > quite a few it is not unheard of. If there would be several containers
>  > >  > calling sync_fs(2) on the machine they could easily hog the machine... That
>  > >  > is why I was originally against keeping overlay inodes always dirty and
>  > >  > wanted their dirtiness to at least roughly track the real need to do
>  > >  > writeback.
>  > >  > 
>  > > 
>  > > Hi Jan,
>  > > 
>  > > Actually, the time on user and sys are almost same with directly excute syncfs on underlying fs.
>  > > IMO, it only extends syncfs(2) waiting time for perticular container but not burning cpu.
>  > > What am I missing?
>  > 
>  > Ah, right, I've missed that only realtime changed, not systime. I'm sorry
>  > for confusion. But why did the realtime increase so much? Are we waiting
>  > for some IO?
>  > 
> 
> There are many places to call cond_resched() in writeback process,
> so sycnfs process was scheduled several times.

I was thinking about this a bit more and I don't think I buy this
explanation. What I rather think is happening is that real work for syncfs
(writeback_inodes_sb() and sync_inodes_sb() calls) gets offloaded to a flush
worker. E.g. writeback_inodes_sb() ends up calling
__writeback_inodes_sb_nr() which does:

bdi_split_work_to_wbs()
wb_wait_for_completion()

So you don't see the work done in the times accounted to your test
program. But in practice the flush worker is indeed burning 1.3s worth of
CPU to scan the 1 million inode list and do nothing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
