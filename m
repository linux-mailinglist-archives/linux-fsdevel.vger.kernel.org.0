Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3A456A16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 07:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhKSGQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 01:16:04 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25388 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhKSGQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 01:16:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637302367; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=UXGCPyCFz7tX85MFg1C4SMtYUakVegGcvK+ghlkQjHF+VwkA5beSLtJXqRcn6WDT2hy4iaWAUUlJq072BFx3tBJjTh1RtLNbqmVIRK0Qm5rTbBuNhmW/KPBq3Ih4Gz3oUOjosomMGSJlau8lOK/pDh2xDJQsSq2c0u06ZLwKdIE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637302367; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=FLpxUbOA32yB5Ph7jXFqI32bQbbWaYa3uHakj/Rxv4g=; 
        b=ktF0zglxtGdmzO0UNpTLDXrHNret0srQEFDkxxOeUbZxc5vlAYcZv931tZaq/Y0WjZDzMItuA6UovKgBjsUWTQR8sFcr6mqVHzzF7VazQKcE62uuVaDkfkJTpuOYNxwBxmBASnjpg8t9N/c7+AmSp1uDLRfMbhuwBLxJy7V4McI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637302367;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=FLpxUbOA32yB5Ph7jXFqI32bQbbWaYa3uHakj/Rxv4g=;
        b=XYdTETk+2zIVRC7GCNrTojZ2HsNemupRizkV8gAMU67hOBo5GcHdIEUl7IB8nL+w
        7INnhueTlim8Q1tgkqUGfSA0OVqqS4hHbqgqLtHrDwqxEezVec9dgdZcRwSPTSBljj+
        1AnQEuCuRL6scwz7KDN2rAskOe/Bpx11+YPLxKTk=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1637302366244693.5069430140323; Fri, 19 Nov 2021 14:12:46 +0800 (CST)
Date:   Fri, 19 Nov 2021 14:12:46 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
In-Reply-To: <20211118164349.GB8267@quack2.suse.cz>
References: <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
 <20211118112315.GD13047@quack2.suse.cz>
 <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net> <20211118164349.GB8267@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-11-19 00:43:49 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 18-11-21 20:02:09, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-11-18 19:23:15 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Thu 18-11-21 14:32:36, Chengguang Xu wrote:
 > >  > >=20
 > >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-11-17 14:11:29 =
Chengguang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > >  > >  >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-11-16 20:35:=
55 Miklos Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  > >  >  > On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@mykern=
el.net> wrote:
 > >  > >  >  > >
 > >  > >  >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 2=
1:34:19 Miklos Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  > >  >  > >  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@my=
kernel.net> wrote:
 > >  > >  >  > >  > >  > However that wasn't what I was asking about.  AFA=
ICS ->write_inode()
 > >  > >  >  > >  > >  > won't start write back for dirty pages.   Maybe I=
'm missing something,
 > >  > >  >  > >  > >  > but there it looks as if nothing will actually tr=
igger writeback for
 > >  > >  >  > >  > >  > dirty pages in upper inode.
 > >  > >  >  > >  > >  >
 > >  > >  >  > >  > >
 > >  > >  >  > >  > > Actually, page writeback on upper inode will be trig=
gered by overlayfs ->writepages and
 > >  > >  >  > >  > > overlayfs' ->writepages will be called by vfs writeb=
ack function (i.e writeback_sb_inodes).
 > >  > >  >  > >  >
 > >  > >  >  > >  > Right.
 > >  > >  >  > >  >
 > >  > >  >  > >  > But wouldn't it be simpler to do this from ->write_ino=
de()?
 > >  > >  >  > >  >
 > >  > >  >  > >  > I.e. call write_inode_now() as suggested by Jan.
 > >  > >  >  > >  >
 > >  > >  >  > >  > Also could just call mark_inode_dirty() on the overlay=
 inode
 > >  > >  >  > >  > regardless of the dirty flags on the upper inode since=
 it shouldn't
 > >  > >  >  > >  > matter and results in simpler logic.
 > >  > >  >  > >  >
 > >  > >  >  > >
 > >  > >  >  > > Hi Miklos=EF=BC=8C
 > >  > >  >  > >
 > >  > >  >  > > Sorry for delayed response for this, I've been busy with =
another project.
 > >  > >  >  > >
 > >  > >  >  > > I agree with your suggesion above and further more how ab=
out just mark overlay inode dirty
 > >  > >  >  > > when it has upper inode? This approach will make marking =
dirtiness simple enough.
 > >  > >  >  >=20
 > >  > >  >  > Are you suggesting that all non-lower overlay inodes should=
 always be dirty?
 > >  > >  >  >=20
 > >  > >  >  > The logic would be simple, no doubt, but there's the cost t=
o walking
 > >  > >  >  > those overlay inodes which don't have a dirty upper inode, =
right? =20
 > >  > >  >=20
 > >  > >  > That's true.
 > >  > >  >=20
 > >  > >  >  > Can you quantify this cost with a benchmark?  Can be totall=
y synthetic,
 > >  > >  >  > e.g. lookup a million upper files without modifying them, t=
hen call
 > >  > >  >  > syncfs.
 > >  > >  >  >=20
 > >  > >  >=20
 > >  > >  > No problem, I'll do some tests for the performance.
 > >  > >  >=20
 > >  > >=20
 > >  > > Hi Miklos,
 > >  > >=20
 > >  > > I did some rough tests and the results like below.  In practice, =
 I don't
 > >  > > think that 1.3s extra time of syncfs will cause significant probl=
em.
 > >  > > What do you think?
 > >  >=20
 > >  > Well, burning 1.3s worth of CPU time for doing nothing seems like q=
uite a
 > >  > bit to me. I understand this is with 1000000 inodes but although th=
at is
 > >  > quite a few it is not unheard of. If there would be several contain=
ers
 > >  > calling sync_fs(2) on the machine they could easily hog the machine=
... That
 > >  > is why I was originally against keeping overlay inodes always dirty=
 and
 > >  > wanted their dirtiness to at least roughly track the real need to d=
o
 > >  > writeback.
 > >  >=20
 > >=20
 > > Hi Jan,
 > >=20
 > > Actually, the time on user and sys are almost same with directly excut=
e syncfs on underlying fs.
 > > IMO, it only extends syncfs(2) waiting time for perticular container b=
ut not burning cpu.
 > > What am I missing?
 >=20
 > Ah, right, I've missed that only realtime changed, not systime. I'm sorr=
y
 > for confusion. But why did the realtime increase so much? Are we waiting
 > for some IO?
 >=20

There are many places to call cond_resched() in writeback process,
so sycnfs process was scheduled several times.

Thanks,
Chengguang



