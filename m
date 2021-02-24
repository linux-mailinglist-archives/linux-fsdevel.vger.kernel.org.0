Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5732399C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 10:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhBXJih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 04:38:37 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25316 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232563AbhBXJi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:38:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1614159441; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=HDh4Z45Hc6qnqIj38eBC6lHv/pvRBYzvWKgoJskrlSqn9AM1iw/7NSPVMZaHKTnbvsp7u1CjU7OwjumSE3I8XbTu/w/Tne+FJpw30EJf3RM5fEKeKfD3X/dat2a2pjUZHHClMszmIuDkjEUh49eGWdz7x+c6eOVYBnuY/db8yFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1614159441; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=09h0ZbKKodi5aTH6k3A5KFGM6v9Ogm9E16PIeeLiaDg=; 
        b=T4/erASbQCzhBUDcoOFuZSUSMPRbm15pbpqFuhqJvh3U23JeW/4Rce0cMcoyX1g4TO83ayLRs1iA5E2P9IOHmp+HJY4qPUrFdZ4iWROcZ/Xow0/jQfN/gANXi98Odp/iEquy4UfjgNZZFI34ujQ/vrIlhbNQzsU9wx0WP3hBT6k=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1614159441;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=09h0ZbKKodi5aTH6k3A5KFGM6v9Ogm9E16PIeeLiaDg=;
        b=agRG+FwV1PXE4l2kRf1XDtXomSoK9rTLrnorAQt2s19u0Nmup10d90mMcg3w1gmu
        UTrVjw0ZIqGR8jsK7iSND1Ad5sRaBjvtuFXAxaiH4GReLKNm2f8PNSEGp6s2+55xQuy
        /KSvS2VRp6bw4IDJp5u/ShR4fcupgeSacmlKCd84=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1614159440447655.9358186061675; Wed, 24 Feb 2021 17:37:20 +0800 (CST)
Date:   Wed, 24 Feb 2021 17:37:20 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Su Yue" <l@damenly.su>
Cc:     "guaneryu" <guaneryu@gmail.com>,
        "fstests" <fstests@vger.kernel.org>,
        "linux-btrfs" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-ext4" <linux-ext4@vger.kernel.org>,
        "linux-xfs" <linux-xfs@vger.kernel.org>
Message-ID: <177d3666a3c.e47042d016248.8805085013477614929@mykernel.net>
In-Reply-To: <wnuxq0px.fsf@damenly.su>
References: <20210223134042.2212341-1-cgxu519@mykernel.net>
 <4ki1rjgu.fsf@damenly.su>
 <177d33c0982.10b8858b515683.1169986601273192029@mykernel.net> <wnuxq0px.fsf@damenly.su>
Subject: Re: [PATCH] generic/473: fix expectation properly in out file
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 17:22:35 Su Yue <l@=
damenly.su> =E6=92=B0=E5=86=99 ----
 >=20
 > On Wed 24 Feb 2021 at 16:51, Chengguang Xu <cgxu519@mykernel.net>=20
 > wrote:
 >=20
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 15:52:17 Su Yu=
e <l@damenly.su> =E6=92=B0=E5=86=99=20
 > >  ----
 > >  >
 > >  > Cc to the author and linux-xfs, since it's xfsprogs related.
 > >  >
 > >  > On Tue 23 Feb 2021 at 21:40, Chengguang Xu=20
 > >  > <cgxu519@mykernel.net>
 > >  > wrote:
 > >  >
 > >  > > It seems the expected result of testcase of "Hole + Data"
 > >  > > in generic/473 is not correct, so just fix it properly.
 > >  > >
 > >  >
 > >  > But it's not proper...
 > >  >
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > > ---
 > >  > >  tests/generic/473.out | 2 +-
 > >  > >  1 file changed, 1 insertion(+), 1 deletion(-)
 > >  > >
 > >  > > diff --git a/tests/generic/473.out b/tests/generic/473.out
 > >  > > index 75816388..f1ee5805 100644
 > >  > > --- a/tests/generic/473.out
 > >  > > +++ b/tests/generic/473.out
 > >  > > @@ -6,7 +6,7 @@ Data + Hole
 > >  > >  1: [256..287]: hole
 > >  > >  Hole + Data
 > >  > >  0: [0..127]: hole
 > >  > > -1: [128..255]: data
 > >  > > +1: [128..135]: data
 > >  > >
 > >  > The line is produced by `$XFS_IO_PROG -c "fiemap -v 0 65k"=20
 > >  > $file |
 > >  > _filter_fiemap`.
 > >  > 0-64k is a hole and 64k-128k is a data extent.
 > >  > fiemap ioctl always returns *complete* ranges of extents.
 > >
 > > Manual testing result in latest kernel like below.
 > >
 > > [root@centos test]# uname -a
 > > Linux centos 5.11.0+ #5 SMP Tue Feb 23 21:02:27 CST 2021 x86_64=20
 > > x86_64 x86_64 GNU/Linux
 > >
 > > [root@centos test]# xfs_io -V
 > > xfs_io version 5.0.0
 > >
 > > [root@centos test]# stat a
 > >   File: a
 > >   Size: 4194304         Blocks: 0          IO Block: 4096=20
 > >   regular file
 > > Device: fc01h/64513d    Inode: 140         Links: 1
 > > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/=20
 > > root)
 > > Access: 2021-02-24 16:33:20.235654140 +0800
 > > Modify: 2021-02-24 16:33:25.070641521 +0800
 > > Change: 2021-02-24 16:33:25.070641521 +0800
 > >  Birth: -
 > >
 > > [root@centos test]# xfs_io -c "pwrite 64k 64k" a
 > > wrote 65536/65536 bytes at offset 65536
 > > 64 KiB, 16 ops; 0.0000 sec (992.063 MiB/sec and 253968.2540=20
 > > ops/sec)
 > >
 > > [root@VM-8-4-centos test]# xfs_io -c "fiemap -v 0 65k" a
 > > a:
 > >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
 > >    0: [0..127]:        hole               128
 > >    1: [128..135]:      360..367             8   0x1
 > >
 >=20
 > Sorry, my carelessness. I only checked btrfs implementation but=20
 > xfs
 > and ext4 do return the change you made.
 >=20

Yeah, it seems there is no bad side effect to show  only specified range of=
 extents
and keep all the same behavior is also good for testing. I can post a fix p=
atch for
this but before that let us to wait some feedback from maintainers and expe=
rts.

Thanks,
Chengguang


 >=20
 > > [root@centos test]# xfs_io -c "fiemap -v 0 128k" a
 > > a:
 > >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
 > >    0: [0..127]:        hole               128
 > >    1: [128..255]:      360..487           128   0x1
 > >
 > >
 > >  >
 > >  > You may ask why the ending hole range is not aligned to 128=20
 > >  > in
 > >  > 473.out. Because
 > >  > fiemap ioctl returns nothing of querying holes. xfs_io does=20
 > >  > the
 > >  > extra
 > >  > print work for holes.
 > >  >
 > >  > xfsprogs-dev/io/fiemap.c:
 > >  > for holes:
 > >  >  153     if (lstart > llast) {
 > >  >  154         print_hole(0, 0, 0, cur_extent, lflag, true,=20
 > >  >  llast,
 > >  >  lstart);
 > >  >  155         cur_extent++;
 > >  >  156         num_printed++;
 > >  >  157     }
 > >  >
 > >  > for the ending hole:
 > >  >   381     if (cur_extent && last_logical < range_end)
 > >  >   382         print_hole(foff_w, boff_w, tot_w, cur_extent,=20
 > >  >   lflag,
 > >  >   !vflag,
 > >  >   383                BTOBBT(last_logical),=20
 > >  >   BTOBBT(range_end));
 > >  >
 > >  > >  Hole + Data + Hole
 > >  > >  0: [0..127]: hole
 > >  > >  1: [128..255]: data
 > >  >
 >=20
 >=20
