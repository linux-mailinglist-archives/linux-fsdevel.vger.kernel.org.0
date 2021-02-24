Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ABD32394A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 10:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhBXJRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 04:17:39 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25305 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233427AbhBXJRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1614158188; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=FxQ9+njD8BI+w4IsRFrbyodzDlxedvroizBe6xmI0aRo8PXPHtHufHTx3MvrbJjapalK5mT1vozqjl1hFs3SNfiAnvLjG2qZSbXSlZ8DNUeVa2Y0LeFoz3zbifrM+cIy+S8MLCXHkun9UTWW/qAslHheoL1aFI8920ZzdyRHmdU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1614158188; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=o0fTyu9G7rUFQ/OGzxoVzPpUOsLKeXJKJVGoEv++MPM=; 
        b=Xr6QmbCX/yZdKNtTsTVA/QcZVZ6PEM7oXw0VyawctekgxxfLG9Z7bd8Uq7cjin0l4Q+D+hu/+JAXSuek2Bm6kQuI8rpT0+eDLEiMcE2N3vRQ+Q4G0u4IkkrvkCJORSFuXGaoyQY7i1/vbYowLViwjDtReL/AKaGN/WuTnGiHAd8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1614158188;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=o0fTyu9G7rUFQ/OGzxoVzPpUOsLKeXJKJVGoEv++MPM=;
        b=a33ekXQ+rFtOCjV0llSSmqK94Te6QLAySW1vxcN2rx5wFMz07X9ZPVVO+mmKOupE
        V+xc9tOeHXI0k3xf1MLs+bKSpAxY5510o2EQjAflU5A4Eo490oFSMYZf9bSI6C4avv4
        Ft5VVfeeeGqXa1D+HzT/2BVEnans3qJJN1/dx/LE=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1614158186224958.4758690489913; Wed, 24 Feb 2021 17:16:26 +0800 (CST)
Date:   Wed, 24 Feb 2021 17:16:26 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Su Yue" <l@damenly.su>
Cc:     "guaneryu" <guaneryu@gmail.com>,
        "fstests" <fstests@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-ext4" <linux-ext4@vger.kernel.org>,
        "linux-xfs" <linux-xfs@vger.kernel.org>,
        "linux-btrfs" <linux-btrfs@vger.kernel.org>
Message-ID: <177d35346ec.11233c59d16029.4880134583713959983@mykernel.net>
In-Reply-To: <177d33c0982.10b8858b515683.1169986601273192029@mykernel.net>
References: <20210223134042.2212341-1-cgxu519@mykernel.net> <4ki1rjgu.fsf@damenly.su> <177d33c0982.10b8858b515683.1169986601273192029@mykernel.net>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 16:51:03 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 15:52:17 Su Yue =
<l@damenly.su> =E6=92=B0=E5=86=99 ----
 >  >=20
 >  > Cc to the author and linux-xfs, since it's xfsprogs related.
 >  >=20
 >  > On Tue 23 Feb 2021 at 21:40, Chengguang Xu <cgxu519@mykernel.net>=20
 >  > wrote:
 >  >=20
 >  > > It seems the expected result of testcase of "Hole + Data"
 >  > > in generic/473 is not correct, so just fix it properly.
 >  > >
 >  >=20
 >  > But it's not proper...
 >  >=20
 >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >  > > ---
 >  > >  tests/generic/473.out | 2 +-
 >  > >  1 file changed, 1 insertion(+), 1 deletion(-)
 >  > >
 >  > > diff --git a/tests/generic/473.out b/tests/generic/473.out
 >  > > index 75816388..f1ee5805 100644
 >  > > --- a/tests/generic/473.out
 >  > > +++ b/tests/generic/473.out
 >  > > @@ -6,7 +6,7 @@ Data + Hole
 >  > >  1: [256..287]: hole
 >  > >  Hole + Data
 >  > >  0: [0..127]: hole
 >  > > -1: [128..255]: data
 >  > > +1: [128..135]: data
 >  > >
 >  > The line is produced by `$XFS_IO_PROG -c "fiemap -v 0 65k" $file |=20
 >  > _filter_fiemap`.
 >  > 0-64k is a hole and 64k-128k is a data extent.
 >  > fiemap ioctl always returns *complete* ranges of extents.

Finally, I found btrfs returns *complete* rangne of extents but xfs/ext4 do=
es not. :-/


[root@VM-89-226-centos /test]# xfs_io -c "fiemap 0 65k" a
a:
        0: [0..127]: hole
        1: [128..255]: 24576..24703
[root@VM-89-226-centos /test]# xfs_io -c "fiemap 0 128k" a
a:
        0: [0..127]: hole
        1: [128..255]: 24576..24703



 >=20
 > Manual testing result in latest kernel like below.
 >=20
 > [root@centos test]# uname -a
 > Linux centos 5.11.0+ #5 SMP Tue Feb 23 21:02:27 CST 2021 x86_64 x86_64 x=
86_64 GNU/Linux
 >=20
 > [root@centos test]# xfs_io -V
 > xfs_io version 5.0.0
 >=20
 > [root@centos test]# stat a
 >   File: a
 >   Size: 4194304         Blocks: 0          IO Block: 4096   regular file
 > Device: fc01h/64513d    Inode: 140         Links: 1
 > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
 > Access: 2021-02-24 16:33:20.235654140 +0800
 > Modify: 2021-02-24 16:33:25.070641521 +0800
 > Change: 2021-02-24 16:33:25.070641521 +0800
 >  Birth: -
 > =20
 > [root@centos test]# xfs_io -c "pwrite 64k 64k" a
 > wrote 65536/65536 bytes at offset 65536
 > 64 KiB, 16 ops; 0.0000 sec (992.063 MiB/sec and 253968.2540 ops/sec)
 >=20
 > [root@VM-8-4-centos test]# xfs_io -c "fiemap -v 0 65k" a
 > a:
 >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
 >    0: [0..127]:        hole               128
 >    1: [128..135]:      360..367             8   0x1
 >   =20
 > [root@centos test]# xfs_io -c "fiemap -v 0 128k" a
 > a:
 >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
 >    0: [0..127]:        hole               128
 >    1: [128..255]:      360..487           128   0x1
 >=20
 >=20
 >  >=20
 >  > You may ask why the ending hole range is not aligned to 128 in=20
 >  > 473.out. Because
 >  > fiemap ioctl returns nothing of querying holes. xfs_io does the=20
 >  > extra
 >  > print work for holes.
 >  >=20
 >  > xfsprogs-dev/io/fiemap.c:
 >  > for holes:
 >  >  153     if (lstart > llast) {
 >  >  154         print_hole(0, 0, 0, cur_extent, lflag, true, llast,=20
 >  >  lstart);
 >  >  155         cur_extent++;
 >  >  156         num_printed++;
 >  >  157     }
 >  >=20
 >  > for the ending hole:
 >  >   381     if (cur_extent && last_logical < range_end)
 >  >   382         print_hole(foff_w, boff_w, tot_w, cur_extent, lflag,=20
 >  >   !vflag,
 >  >   383                BTOBBT(last_logical), BTOBBT(range_end));
 >  >=20
 >  > >  Hole + Data + Hole
 >  > >  0: [0..127]: hole
 >  > >  1: [128..255]: data
 >  >=20
 >=20
