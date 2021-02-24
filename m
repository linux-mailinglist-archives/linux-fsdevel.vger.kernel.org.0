Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE4D323E68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 14:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhBXNff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 08:35:35 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43540 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237001AbhBXNcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UPT6LS4_1614173506;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UPT6LS4_1614173506)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 21:31:46 +0800
Date:   Wed, 24 Feb 2021 21:31:46 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Su Yue <l@damenly.su>, guaneryu <guaneryu@gmail.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] generic/473: fix expectation properly in out file
Message-ID: <20210224133146.GE96449@e18g06458.et15sqa>
References: <20210223134042.2212341-1-cgxu519@mykernel.net>
 <4ki1rjgu.fsf@damenly.su>
 <177d33c0982.10b8858b515683.1169986601273192029@mykernel.net>
 <wnuxq0px.fsf@damenly.su>
 <177d3666a3c.e47042d016248.8805085013477614929@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177d3666a3c.e47042d016248.8805085013477614929@mykernel.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:37:20PM +0800, Chengguang Xu wrote:
>  ---- 在 星期三, 2021-02-24 17:22:35 Su Yue <l@damenly.su> 撰写 ----
>  > 
>  > On Wed 24 Feb 2021 at 16:51, Chengguang Xu <cgxu519@mykernel.net> 
>  > wrote:
>  > 
>  > >  ---- 在 星期三, 2021-02-24 15:52:17 Su Yue <l@damenly.su> 撰写 
>  > >  ----
>  > >  >
>  > >  > Cc to the author and linux-xfs, since it's xfsprogs related.
>  > >  >
>  > >  > On Tue 23 Feb 2021 at 21:40, Chengguang Xu 
>  > >  > <cgxu519@mykernel.net>
>  > >  > wrote:
>  > >  >
>  > >  > > It seems the expected result of testcase of "Hole + Data"
>  > >  > > in generic/473 is not correct, so just fix it properly.
>  > >  > >
>  > >  >
>  > >  > But it's not proper...
>  > >  >
>  > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > >  > > ---
>  > >  > >  tests/generic/473.out | 2 +-
>  > >  > >  1 file changed, 1 insertion(+), 1 deletion(-)
>  > >  > >
>  > >  > > diff --git a/tests/generic/473.out b/tests/generic/473.out
>  > >  > > index 75816388..f1ee5805 100644
>  > >  > > --- a/tests/generic/473.out
>  > >  > > +++ b/tests/generic/473.out
>  > >  > > @@ -6,7 +6,7 @@ Data + Hole
>  > >  > >  1: [256..287]: hole
>  > >  > >  Hole + Data
>  > >  > >  0: [0..127]: hole
>  > >  > > -1: [128..255]: data
>  > >  > > +1: [128..135]: data
>  > >  > >
>  > >  > The line is produced by `$XFS_IO_PROG -c "fiemap -v 0 65k" 
>  > >  > $file |
>  > >  > _filter_fiemap`.
>  > >  > 0-64k is a hole and 64k-128k is a data extent.
>  > >  > fiemap ioctl always returns *complete* ranges of extents.
>  > >
>  > > Manual testing result in latest kernel like below.
>  > >
>  > > [root@centos test]# uname -a
>  > > Linux centos 5.11.0+ #5 SMP Tue Feb 23 21:02:27 CST 2021 x86_64 
>  > > x86_64 x86_64 GNU/Linux
>  > >
>  > > [root@centos test]# xfs_io -V
>  > > xfs_io version 5.0.0
>  > >
>  > > [root@centos test]# stat a
>  > >   File: a
>  > >   Size: 4194304         Blocks: 0          IO Block: 4096 
>  > >   regular file
>  > > Device: fc01h/64513d    Inode: 140         Links: 1
>  > > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/ 
>  > > root)
>  > > Access: 2021-02-24 16:33:20.235654140 +0800
>  > > Modify: 2021-02-24 16:33:25.070641521 +0800
>  > > Change: 2021-02-24 16:33:25.070641521 +0800
>  > >  Birth: -
>  > >
>  > > [root@centos test]# xfs_io -c "pwrite 64k 64k" a
>  > > wrote 65536/65536 bytes at offset 65536
>  > > 64 KiB, 16 ops; 0.0000 sec (992.063 MiB/sec and 253968.2540 
>  > > ops/sec)
>  > >
>  > > [root@VM-8-4-centos test]# xfs_io -c "fiemap -v 0 65k" a
>  > > a:
>  > >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>  > >    0: [0..127]:        hole               128
>  > >    1: [128..135]:      360..367             8   0x1
>  > >
>  > 
>  > Sorry, my carelessness. I only checked btrfs implementation but 
>  > xfs
>  > and ext4 do return the change you made.
>  > 
> 
> Yeah, it seems there is no bad side effect to show  only specified range of extents
> and keep all the same behavior is also good for testing. I can post a fix patch for
> this but before that let us to wait some feedback from maintainers and experts.

generic/473 is marked as broken by commit 715eac1a9e66 ("generic/47[23]:
remove from auto/quick groups").

Thanks,
Eryu
