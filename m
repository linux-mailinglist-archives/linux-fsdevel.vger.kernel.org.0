Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D9B4554D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 07:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbhKRGgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 01:36:00 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25348 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242471AbhKRGf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:35:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637217158; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=d1IrYCNIj9SkyeIVVSglY4xMuL0Rj0Hjlamqxo/gUwJpTeqy/ujtZWB60SNLamtTv4vGLAcFU96WxA1XzRTfoBC4pW/JvoPb3gJ3EAUI0KO3A1aT7bsg1CrZmLv/+G//e2vhdAnFRFSY48Rhb/Um7sHlBxSZuDxbkr8Vz6DXiz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637217158; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=I16gwzIv8R/3GEj8b0TWgpmaTFGaJb8h/2DbwGmHah0=; 
        b=B6ytNwtzoYxgF0N2v6av6+SmNTozZ+VEaYSP6mlXyvrz7fgJNWAgsFW/EmRTTxRn+zyb5DXYjrfeEqPcLRK3u4KIpvYhQwG+66YqF/tMrOKPYVe3THEvMXtH+2Ykc4N570mk8lwf6nCnfMMApMRn0pSHt/K09dAazc/8+O9AR24=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637217158;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=I16gwzIv8R/3GEj8b0TWgpmaTFGaJb8h/2DbwGmHah0=;
        b=TdCDwZG18xLg0/zzNQstud87z/WEf+LMU8gOY0Ag8vmnxWs2symU4wd3PLDl6sJo
        0VFufr8SjkUDRvbCvv4PjlpvKGYU2s0W9LFNyqPwCkJXUGbjMQblQXe7GbhxanMY4wN
        cg9sXnzS7JFPZDw5xmRrJq+AZex6nNSIir4PhswU=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1637217156451682.8448541267007; Thu, 18 Nov 2021 14:32:36 +0800 (CST)
Date:   Thu, 18 Nov 2021 14:32:36 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
In-Reply-To: <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com> <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net> <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com> <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-11-17 14:11:29 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-11-16 20:35:55 Miklos =
Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 >  > On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
 >  > >
 >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 21:34:19 Mi=
klos Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 >  > >  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net=
> wrote:
 >  > >  > >  > However that wasn't what I was asking about.  AFAICS ->writ=
e_inode()
 >  > >  > >  > won't start write back for dirty pages.   Maybe I'm missing=
 something,
 >  > >  > >  > but there it looks as if nothing will actually trigger writ=
eback for
 >  > >  > >  > dirty pages in upper inode.
 >  > >  > >  >
 >  > >  > >
 >  > >  > > Actually, page writeback on upper inode will be triggered by o=
verlayfs ->writepages and
 >  > >  > > overlayfs' ->writepages will be called by vfs writeback functi=
on (i.e writeback_sb_inodes).
 >  > >  >
 >  > >  > Right.
 >  > >  >
 >  > >  > But wouldn't it be simpler to do this from ->write_inode()?
 >  > >  >
 >  > >  > I.e. call write_inode_now() as suggested by Jan.
 >  > >  >
 >  > >  > Also could just call mark_inode_dirty() on the overlay inode
 >  > >  > regardless of the dirty flags on the upper inode since it should=
n't
 >  > >  > matter and results in simpler logic.
 >  > >  >
 >  > >
 >  > > Hi Miklos=EF=BC=8C
 >  > >
 >  > > Sorry for delayed response for this, I've been busy with another pr=
oject.
 >  > >
 >  > > I agree with your suggesion above and further more how about just m=
ark overlay inode dirty
 >  > > when it has upper inode? This approach will make marking dirtiness =
simple enough.
 >  >=20
 >  > Are you suggesting that all non-lower overlay inodes should always be=
 dirty?
 >  >=20
 >  > The logic would be simple, no doubt, but there's the cost to walking
 >  > those overlay inodes which don't have a dirty upper inode, right? =20
 >=20
 > That's true.
 >=20
 >  > Can you quantify this cost with a benchmark?  Can be totally syntheti=
c,
 >  > e.g. lookup a million upper files without modifying them, then call
 >  > syncfs.
 >  >=20
 >=20
 > No problem, I'll do some tests for the performance.
 >=20

Hi Miklos,

I did some rough tests and the results like below.
In practice,  I don't think that 1.3s extra time of syncfs will cause signi=
ficant problem.
What do you think?



Test bed: kvm vm=20
2.50GHz cpu 32core
64GB mem
vm kernel  5.15.0-rc1+ (with ovl syncfs patch V6)

one millon files spread to 2 level of dir hierarchy.
test step:
1) create testfiles in ovl upper dir
2) mount overlayfs
3) excute ls -lR to lookup all file in overlay merge dir
4) excute slabtop to make sure overlay inode number
5) call syncfs to the file in merge dir

Tested five times and the reusults are in 1.310s ~ 1.326s

root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
syncfs success

real    0m1.310s
user    0m0.000s
sys     0m0.001s
[root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
syncfs success

real    0m1.326s
user    0m0.001s
sys     0m0.000s
[root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
syncfs success

real    0m1.321s
user    0m0.000s
sys     0m0.001s
[root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
syncfs success

real    0m1.316s
user    0m0.000s
sys     0m0.001s
[root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
syncfs success

real    0m1.314s
user    0m0.001s
sys     0m0.001s


Directly run syncfs to the file in ovl-upper dir.
Tested five times and the reusults are in 0.001s ~ 0.003s

[root@VM-144-4-centos test]# time ./syncfs a
syncfs success

real    0m0.002s
user    0m0.001s
sys     0m0.000s
[root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
syncfs success

real    0m0.003s
user    0m0.001s
sys     0m0.000s
[root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
syncfs success

real    0m0.001s
user    0m0.000s
sys     0m0.001s
[root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
syncfs success

real    0m0.001s
user    0m0.000s
sys     0m0.001s
[root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
syncfs success

real    0m0.001s
user    0m0.000s
sys     0m0.001s
[root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
syncfs success

real    0m0.001s
user    0m0.000s
sys     0m0.001






