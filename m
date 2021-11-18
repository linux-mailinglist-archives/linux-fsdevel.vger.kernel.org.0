Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7768455A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbhKRL1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 06:27:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37930 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbhKRL0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:26:20 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5ADE61FD35;
        Thu, 18 Nov 2021 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637234597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZP2OrTM2vruLHNAH3Bkkec284UppfF4E24Hyfhj1rU=;
        b=pY1OwxrM3M9X0p68lL4V8crk++gpsq44jDeYiY5mpcP70q2gXyQMedxfjc67o/bd4Bmkv1
        4iRumPUNyhrVZzhZvQAAQfS8fpQigBXLTHEMomgCMxkpgXhTK2T1MQwe57cfhQ36d75jqv
        ZVU54jF5d055WNomqSyCNOb2/IDmYVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637234597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZP2OrTM2vruLHNAH3Bkkec284UppfF4E24Hyfhj1rU=;
        b=2IeHefRL5EPKeJmusr9VIl20cIR7Cn6pN29dL6TWDdifGtWXzUsjL5CImx1mDQzMFXgbOo
        /2PMQQHl7BTzFfCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 060EFA3B85;
        Thu, 18 Nov 2021 11:23:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C48FC1F2B83; Thu, 18 Nov 2021 12:23:15 +0100 (CET)
Date:   Thu, 18 Nov 2021 12:23:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20211118112315.GD13047@quack2.suse.cz>
References: <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-11-21 14:32:36, Chengguang Xu wrote:
> 
>  ---- 在 星期三, 2021-11-17 14:11:29 Chengguang Xu <cgxu519@mykernel.net> 撰写 ----
>  >  ---- 在 星期二, 2021-11-16 20:35:55 Miklos Szeredi <miklos@szeredi.hu> 撰写 ----
>  >  > On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@mykernel.net> wrote:
>  >  > >
>  >  > >  ---- 在 星期四, 2021-10-07 21:34:19 Miklos Szeredi <miklos@szeredi.hu> 撰写 ----
>  >  > >  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrote:
>  >  > >  > >  > However that wasn't what I was asking about.  AFAICS ->write_inode()
>  >  > >  > >  > won't start write back for dirty pages.   Maybe I'm missing something,
>  >  > >  > >  > but there it looks as if nothing will actually trigger writeback for
>  >  > >  > >  > dirty pages in upper inode.
>  >  > >  > >  >
>  >  > >  > >
>  >  > >  > > Actually, page writeback on upper inode will be triggered by overlayfs ->writepages and
>  >  > >  > > overlayfs' ->writepages will be called by vfs writeback function (i.e writeback_sb_inodes).
>  >  > >  >
>  >  > >  > Right.
>  >  > >  >
>  >  > >  > But wouldn't it be simpler to do this from ->write_inode()?
>  >  > >  >
>  >  > >  > I.e. call write_inode_now() as suggested by Jan.
>  >  > >  >
>  >  > >  > Also could just call mark_inode_dirty() on the overlay inode
>  >  > >  > regardless of the dirty flags on the upper inode since it shouldn't
>  >  > >  > matter and results in simpler logic.
>  >  > >  >
>  >  > >
>  >  > > Hi Miklos，
>  >  > >
>  >  > > Sorry for delayed response for this, I've been busy with another project.
>  >  > >
>  >  > > I agree with your suggesion above and further more how about just mark overlay inode dirty
>  >  > > when it has upper inode? This approach will make marking dirtiness simple enough.
>  >  > 
>  >  > Are you suggesting that all non-lower overlay inodes should always be dirty?
>  >  > 
>  >  > The logic would be simple, no doubt, but there's the cost to walking
>  >  > those overlay inodes which don't have a dirty upper inode, right?  
>  > 
>  > That's true.
>  > 
>  >  > Can you quantify this cost with a benchmark?  Can be totally synthetic,
>  >  > e.g. lookup a million upper files without modifying them, then call
>  >  > syncfs.
>  >  > 
>  > 
>  > No problem, I'll do some tests for the performance.
>  > 
> 
> Hi Miklos,
> 
> I did some rough tests and the results like below.  In practice,  I don't
> think that 1.3s extra time of syncfs will cause significant problem.
> What do you think?

Well, burning 1.3s worth of CPU time for doing nothing seems like quite a
bit to me. I understand this is with 1000000 inodes but although that is
quite a few it is not unheard of. If there would be several containers
calling sync_fs(2) on the machine they could easily hog the machine... That
is why I was originally against keeping overlay inodes always dirty and
wanted their dirtiness to at least roughly track the real need to do
writeback.

								Honza

> Test bed: kvm vm 
> 2.50GHz cpu 32core
> 64GB mem
> vm kernel  5.15.0-rc1+ (with ovl syncfs patch V6)
> 
> one millon files spread to 2 level of dir hierarchy.
> test step:
> 1) create testfiles in ovl upper dir
> 2) mount overlayfs
> 3) excute ls -lR to lookup all file in overlay merge dir
> 4) excute slabtop to make sure overlay inode number
> 5) call syncfs to the file in merge dir
> 
> Tested five times and the reusults are in 1.310s ~ 1.326s
> 
> root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh 
> syncfs success
> 
> real    0m1.310s
> user    0m0.000s
> sys     0m0.001s
> [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh 
> syncfs success
> 
> real    0m1.326s
> user    0m0.001s
> sys     0m0.000s
> [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh 
> syncfs success
> 
> real    0m1.321s
> user    0m0.000s
> sys     0m0.001s
> [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh 
> syncfs success
> 
> real    0m1.316s
> user    0m0.000s
> sys     0m0.001s
> [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh 
> syncfs success
> 
> real    0m1.314s
> user    0m0.001s
> sys     0m0.001s
> 
> 
> Directly run syncfs to the file in ovl-upper dir.
> Tested five times and the reusults are in 0.001s ~ 0.003s
> 
> [root@VM-144-4-centos test]# time ./syncfs a
> syncfs success
> 
> real    0m0.002s
> user    0m0.001s
> sys     0m0.000s
> [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh 
> syncfs success
> 
> real    0m0.003s
> user    0m0.001s
> sys     0m0.000s
> [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh 
> syncfs success
> 
> real    0m0.001s
> user    0m0.000s
> sys     0m0.001s
> [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh 
> syncfs success
> 
> real    0m0.001s
> user    0m0.000s
> sys     0m0.001s
> [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh 
> syncfs success
> 
> real    0m0.001s
> user    0m0.000s
> sys     0m0.001s
> [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh 
> syncfs success
> 
> real    0m0.001s
> user    0m0.000s
> sys     0m0.001
> 
> 
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
