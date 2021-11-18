Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180D1455B24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 13:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbhKRMFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 07:05:36 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25338 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344448AbhKRMFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:05:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637236931; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bZVxYJi0GXYiwCO2rXzdqqOg4hRGvuKp3EkulAhJbRBBqu7+lA4Q2IRMesUxOg9INANVL2Jby9rOvpvo5qmUoIxCQvH0mW/0BaHQHSAR1E6QVWBKoWysY6hf039YXMAGR74Q4h4PG3zalCo6drBGs8MLAcXQHzBdQPmCvw7zjlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637236931; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=Y6BPbHIHriYcSC5lqSGuZfKO7cE3sFnfSFuULERfxDo=; 
        b=Sa3GsYunZQYwdNbLT+nNSnahAo49fCLOX13MZLHzZYGQ7lLOQVcR3ewdt7qxTn78mlHWAHGAkDuNdbZJZCE37OvHc74m7sJ3HIVHqIM7vADmK4skCxmRhLjMxQSeGP4QN8WzQvCuKcMCC9dATof5v6F764FqPw1eNiM6IGN0P+c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637236931;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Y6BPbHIHriYcSC5lqSGuZfKO7cE3sFnfSFuULERfxDo=;
        b=DtWcHE6wSt5Q5+7PhKddaS049SyNvkc+h2ynLrTPBcPZu/dwDVq+NsZoIp4m6EKd
        Cy++DZjhMhWuIJ2x7trAaOmknT8kDEawkUc1u2mLquKNrWd3ymDbl0h/+govL1+vsD2
        2acvm+J+xe4DGtzckooEb+dOqabpXrivMdJSnUnI=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1637236929649649.289272221152; Thu, 18 Nov 2021 20:02:09 +0800 (CST)
Date:   Thu, 18 Nov 2021 20:02:09 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
In-Reply-To: <20211118112315.GD13047@quack2.suse.cz>
References: <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net> <20211118112315.GD13047@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-11-18 19:23:15 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 18-11-21 14:32:36, Chengguang Xu wrote:
 > >=20
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-11-17 14:11:29 Cheng=
guang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > >  >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-11-16 20:35:55 Mi=
klos Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  >  > On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@mykernel.ne=
t> wrote:
 > >  >  > >
 > >  >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 21:34:=
19 Miklos Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  >  > >  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykerne=
l.net> wrote:
 > >  >  > >  > >  > However that wasn't what I was asking about.  AFAICS -=
>write_inode()
 > >  >  > >  > >  > won't start write back for dirty pages.   Maybe I'm mi=
ssing something,
 > >  >  > >  > >  > but there it looks as if nothing will actually trigger=
 writeback for
 > >  >  > >  > >  > dirty pages in upper inode.
 > >  >  > >  > >  >
 > >  >  > >  > >
 > >  >  > >  > > Actually, page writeback on upper inode will be triggered=
 by overlayfs ->writepages and
 > >  >  > >  > > overlayfs' ->writepages will be called by vfs writeback f=
unction (i.e writeback_sb_inodes).
 > >  >  > >  >
 > >  >  > >  > Right.
 > >  >  > >  >
 > >  >  > >  > But wouldn't it be simpler to do this from ->write_inode()?
 > >  >  > >  >
 > >  >  > >  > I.e. call write_inode_now() as suggested by Jan.
 > >  >  > >  >
 > >  >  > >  > Also could just call mark_inode_dirty() on the overlay inod=
e
 > >  >  > >  > regardless of the dirty flags on the upper inode since it s=
houldn't
 > >  >  > >  > matter and results in simpler logic.
 > >  >  > >  >
 > >  >  > >
 > >  >  > > Hi Miklos=EF=BC=8C
 > >  >  > >
 > >  >  > > Sorry for delayed response for this, I've been busy with anoth=
er project.
 > >  >  > >
 > >  >  > > I agree with your suggesion above and further more how about j=
ust mark overlay inode dirty
 > >  >  > > when it has upper inode? This approach will make marking dirti=
ness simple enough.
 > >  >  >=20
 > >  >  > Are you suggesting that all non-lower overlay inodes should alwa=
ys be dirty?
 > >  >  >=20
 > >  >  > The logic would be simple, no doubt, but there's the cost to wal=
king
 > >  >  > those overlay inodes which don't have a dirty upper inode, right=
? =20
 > >  >=20
 > >  > That's true.
 > >  >=20
 > >  >  > Can you quantify this cost with a benchmark?  Can be totally syn=
thetic,
 > >  >  > e.g. lookup a million upper files without modifying them, then c=
all
 > >  >  > syncfs.
 > >  >  >=20
 > >  >=20
 > >  > No problem, I'll do some tests for the performance.
 > >  >=20
 > >=20
 > > Hi Miklos,
 > >=20
 > > I did some rough tests and the results like below.  In practice,  I do=
n't
 > > think that 1.3s extra time of syncfs will cause significant problem.
 > > What do you think?
 >=20
 > Well, burning 1.3s worth of CPU time for doing nothing seems like quite =
a
 > bit to me. I understand this is with 1000000 inodes but although that is
 > quite a few it is not unheard of. If there would be several containers
 > calling sync_fs(2) on the machine they could easily hog the machine... T=
hat
 > is why I was originally against keeping overlay inodes always dirty and
 > wanted their dirtiness to at least roughly track the real need to do
 > writeback.
 >=20

Hi Jan,

Actually, the time on user and sys are almost same with directly excute syn=
cfs on underlying fs.
IMO, it only extends syncfs(2) waiting time for perticular container but no=
t burning cpu.
What am I missing?


Thanks,
Chengguang


 >=20
 > > Test bed: kvm vm=20
 > > 2.50GHz cpu 32core
 > > 64GB mem
 > > vm kernel  5.15.0-rc1+ (with ovl syncfs patch V6)
 > >=20
 > > one millon files spread to 2 level of dir hierarchy.
 > > test step:
 > > 1) create testfiles in ovl upper dir
 > > 2) mount overlayfs
 > > 3) excute ls -lR to lookup all file in overlay merge dir
 > > 4) excute slabtop to make sure overlay inode number
 > > 5) call syncfs to the file in merge dir
 > >=20
 > > Tested five times and the reusults are in 1.310s ~ 1.326s
 > >=20
 > > root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m1.310s
 > > user    0m0.000s
 > > sys     0m0.001s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m1.326s
 > > user    0m0.001s
 > > sys     0m0.000s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m1.321s
 > > user    0m0.000s
 > > sys     0m0.001s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m1.316s
 > > user    0m0.000s
 > > sys     0m0.001s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-merge/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m1.314s
 > > user    0m0.001s
 > > sys     0m0.001s
 > >=20
 > >=20
 > > Directly run syncfs to the file in ovl-upper dir.
 > > Tested five times and the reusults are in 0.001s ~ 0.003s
 > >=20
 > > [root@VM-144-4-centos test]# time ./syncfs a
 > > syncfs success
 > >=20
 > > real    0m0.002s
 > > user    0m0.001s
 > > sys     0m0.000s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m0.003s
 > > user    0m0.001s
 > > sys     0m0.000s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m0.001s
 > > user    0m0.000s
 > > sys     0m0.001s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m0.001s
 > > user    0m0.000s
 > > sys     0m0.001s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m0.001s
 > > user    0m0.000s
 > > sys     0m0.001s
 > > [root@VM-144-4-centos test]# time ./syncfs ovl-upper/create-file.sh=20
 > > syncfs success
 > >=20
 > > real    0m0.001s
 > > user    0m0.000s
 > > sys     0m0.001
 > >=20
 > >=20
 > >=20
 > >=20
 > >=20
 > >=20
 > --=20
 > Jan Kara <jack@suse.com>
 > SUSE Labs, CR
 >=20
