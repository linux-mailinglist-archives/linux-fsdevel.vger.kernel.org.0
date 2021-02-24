Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C041324379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhBXSD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 13:03:57 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17121 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhBXSDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:03:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1614174536; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=lQA+AVARawNZN5g5lvnFLqJf8kRleEwbjlh6mbvAyuTffxCh2lJWvgCCcZ4XZqlk3hwPjkPRS0i1lji5PXUwEWtq9IRf2AiKfgdNTF9Kl/HtUEEpQCPis0KUydfcv/gAzRJX4rFGrR5/0j0fVttU4N+d/IVBOvkQRaY7IupRKU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1614174536; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=5dfC4UIBlDAD3j+p2vozEcResPOP6jwjIjKI5EdeBoQ=; 
        b=n8lHeJLReVWQ/6WET57vc0rV5/oYX8jD9G7Cz0jXrEiB63AL+7bTpvUJwH8deP98909WWiblfyc+jZfPMtAKFelutvdUs/exN4wwGU5JY5En4qp0uuG2WzMYBv1kwrTQ+qCgcCfmgMKQ9HhwqrcwfAFYv3kNSIdVqIEgknfO79c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1614174536;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=5dfC4UIBlDAD3j+p2vozEcResPOP6jwjIjKI5EdeBoQ=;
        b=OmCmcOnkki8ji5gDD/ZVer72iFZwGTC5GPo5R9PqQvPgq1ueCqcmnzFAvKXluprM
        ilkfR6DGR4e7JtCrGnCzGw8TrIwzrpkeSEZ17TCwNEP1doBfQG8zwa/FVR+4nLbjrBP
        qzXh/WijyLFGaqoL2vbUmZCGuZBiV4NVC66Y9Bsg=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1614174533227810.9043468053503; Wed, 24 Feb 2021 21:48:53 +0800 (CST)
Date:   Wed, 24 Feb 2021 21:48:53 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Eryu Guan" <eguan@linux.alibaba.com>
Cc:     "Su Yue" <l@damenly.su>, "guaneryu" <guaneryu@gmail.com>,
        "fstests" <fstests@vger.kernel.org>,
        "linux-btrfs" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-ext4" <linux-ext4@vger.kernel.org>,
        "linux-xfs" <linux-xfs@vger.kernel.org>
Message-ID: <177d44cb667.12f7afcae16893.3177469356061349445@mykernel.net>
In-Reply-To: <20210224133146.GE96449@e18g06458.et15sqa>
References: <20210223134042.2212341-1-cgxu519@mykernel.net>
 <4ki1rjgu.fsf@damenly.su>
 <177d33c0982.10b8858b515683.1169986601273192029@mykernel.net>
 <wnuxq0px.fsf@damenly.su>
 <177d3666a3c.e47042d016248.8805085013477614929@mykernel.net> <20210224133146.GE96449@e18g06458.et15sqa>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 21:31:46 Eryu Guan =
<eguan@linux.alibaba.com> =E6=92=B0=E5=86=99 ----
 > On Wed, Feb 24, 2021 at 05:37:20PM +0800, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 17:22:35 Su Yu=
e <l@damenly.su> =E6=92=B0=E5=86=99 ----
 > >  >=20
 > >  > On Wed 24 Feb 2021 at 16:51, Chengguang Xu <cgxu519@mykernel.net>=
=20
 > >  > wrote:
 > >  >=20
 > >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 15:52:17 =
Su Yue <l@damenly.su> =E6=92=B0=E5=86=99=20
 > >  > >  ----
 > >  > >  >
 > >  > >  > Cc to the author and linux-xfs, since it's xfsprogs related.
 > >  > >  >
 > >  > >  > On Tue 23 Feb 2021 at 21:40, Chengguang Xu=20
 > >  > >  > <cgxu519@mykernel.net>
 > >  > >  > wrote:
 > >  > >  >
 > >  > >  > > It seems the expected result of testcase of "Hole + Data"
 > >  > >  > > in generic/473 is not correct, so just fix it properly.
 > >  > >  > >
 > >  > >  >
 > >  > >  > But it's not proper...
 > >  > >  >
 > >  > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > >  > > ---
 > >  > >  > >  tests/generic/473.out | 2 +-
 > >  > >  > >  1 file changed, 1 insertion(+), 1 deletion(-)
 > >  > >  > >
 > >  > >  > > diff --git a/tests/generic/473.out b/tests/generic/473.out
 > >  > >  > > index 75816388..f1ee5805 100644
 > >  > >  > > --- a/tests/generic/473.out
 > >  > >  > > +++ b/tests/generic/473.out
 > >  > >  > > @@ -6,7 +6,7 @@ Data + Hole
 > >  > >  > >  1: [256..287]: hole
 > >  > >  > >  Hole + Data
 > >  > >  > >  0: [0..127]: hole
 > >  > >  > > -1: [128..255]: data
 > >  > >  > > +1: [128..135]: data
 > >  > >  > >
 > >  > >  > The line is produced by `$XFS_IO_PROG -c "fiemap -v 0 65k"=20
 > >  > >  > $file |
 > >  > >  > _filter_fiemap`.
 > >  > >  > 0-64k is a hole and 64k-128k is a data extent.
 > >  > >  > fiemap ioctl always returns *complete* ranges of extents.
 > >  > >
 > >  > > Manual testing result in latest kernel like below.
 > >  > >
 > >  > > [root@centos test]# uname -a
 > >  > > Linux centos 5.11.0+ #5 SMP Tue Feb 23 21:02:27 CST 2021 x86_64=
=20
 > >  > > x86_64 x86_64 GNU/Linux
 > >  > >
 > >  > > [root@centos test]# xfs_io -V
 > >  > > xfs_io version 5.0.0
 > >  > >
 > >  > > [root@centos test]# stat a
 > >  > >   File: a
 > >  > >   Size: 4194304         Blocks: 0          IO Block: 4096=20
 > >  > >   regular file
 > >  > > Device: fc01h/64513d    Inode: 140         Links: 1
 > >  > > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/=
=20
 > >  > > root)
 > >  > > Access: 2021-02-24 16:33:20.235654140 +0800
 > >  > > Modify: 2021-02-24 16:33:25.070641521 +0800
 > >  > > Change: 2021-02-24 16:33:25.070641521 +0800
 > >  > >  Birth: -
 > >  > >
 > >  > > [root@centos test]# xfs_io -c "pwrite 64k 64k" a
 > >  > > wrote 65536/65536 bytes at offset 65536
 > >  > > 64 KiB, 16 ops; 0.0000 sec (992.063 MiB/sec and 253968.2540=20
 > >  > > ops/sec)
 > >  > >
 > >  > > [root@VM-8-4-centos test]# xfs_io -c "fiemap -v 0 65k" a
 > >  > > a:
 > >  > >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
 > >  > >    0: [0..127]:        hole               128
 > >  > >    1: [128..135]:      360..367             8   0x1
 > >  > >
 > >  >=20
 > >  > Sorry, my carelessness. I only checked btrfs implementation but=20
 > >  > xfs
 > >  > and ext4 do return the change you made.
 > >  >=20
 > >=20
 > > Yeah, it seems there is no bad side effect to show  only specified ran=
ge of extents
 > > and keep all the same behavior is also good for testing. I can post a =
fix patch for
 > > this but before that let us to wait some feedback from maintainers and=
 experts.
 >=20
 > generic/473 is marked as broken by commit 715eac1a9e66 ("generic/47[23]:
 > remove from auto/quick groups").
 >=20

I got it, thanks Eryu!


