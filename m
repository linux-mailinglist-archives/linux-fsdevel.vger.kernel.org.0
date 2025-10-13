Return-Path: <linux-fsdevel+bounces-63940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A796BD246A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EACE64EA9FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCC2FD7CA;
	Mon, 13 Oct 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b="CFaoHXW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 1.mo548.mail-out.ovh.net (1.mo548.mail-out.ovh.net [178.32.121.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C192FD1DD;
	Mon, 13 Oct 2025 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.121.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347473; cv=none; b=s+6LARaLBNq90M+9eQg+y8DXkBJHtGawdj2PkrGGXSYWCupR1VtT8KwOQk3E9HN8VsOZz+9IbkQ+j7khPz3LwmHYouSWdF3CEfEbSyQpaRe8nmbEZcjcRcYXYmuoMn367zFL2m31M+sR5keeuxQ4glKZuIl0+c1/U+HzCJ6DGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347473; c=relaxed/simple;
	bh=EcvIYqpxXVs74deUpvzxwCX4JFDID7emVlC9DjXPN+o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aILCdUiBpFoFqxPTvxZPrb7kkSzd9ArjiGQXiFOUWHPAjySeFKUkibZcOnfJpxMI232oSNSOgh3UvcfgKzZmFxm6ntjoyAoTrfOoc2LrsneFXqtBgSFyj/Oo2zj+eKucrKHM6aJJn524SSk5ENrT814nrFwi+s1ZZuY/WmNUdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=kaod.org; dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b=CFaoHXW6; arc=none smtp.client-ip=178.32.121.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaod.org
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.167])
	by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4clX3t70bmz6T2W;
	Mon, 13 Oct 2025 09:24:26 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 13 Oct
 2025 11:24:26 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-100R00301b14842-4837-44df-a1a2-391d696616a0,
                    2350DB3D6D8EEE81184BB942758C035E74337293) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 13 Oct 2025 11:24:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
CC: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, "Dominique
 Martinet" <asmadeus@codewreck.org>, <qemu-devel@nongnu.org>, "Eric Van
 Hensbergen" <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
	<v9fs@lists.linux.dev>, =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>,
	<linux-security-module@vger.kernel.org>, Jan Kara <jack@suse.cz>, "Amir
 Goldstein" <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, "Al
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <20251013112424.6b93659c@bahia>
In-Reply-To: <3061192.c3ltI2prpg@silver>
References: <aMih5XYYrpP559de@codewreck.org>
	<20250917.Eip1ahj6neij@digikod.net>
	<f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
	<3061192.c3ltI2prpg@silver>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 8df15119-2886-4617-99ba-e1d56fd5bb4d
X-Ovh-Tracer-Id: 14216175175088118148
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFx9wyKcRj7cqz7kuCitc0YOsdQGyZ7gTu+k8QCdN2UJaD/m4wfwf1TeZmtMFCwCQ696qaFLNhv1ArnJmBfVFKJ+i7oA431WUslbGABZCqTVFAKGVxscwZrJ8RQC6y31uoYWkhoYG8j1m9X8oNs+EckM0OSwLjUfHiMXTFS24TxAo2EfmhJtZlyJ4Dtm/dWqFb1K56tG84CerG+rp+ZmA4oDfQA+AouTmvQapBdTeMH6fkCu4MmX6/A66nRgN+AOh1Lstzx1CwH4GuXZ+lEHbAsdebqtlV16xLxgVdCQBGU9+uJb+xgKUtx8vfyIesl93n2b7HgHFtDuS/UwhW7/K5LRRXv53T8tqoT/0fu1eb/nUa+d+zoCcMCTJwu83LMXsyNHXMxmaKHxMg9OUURZ7U4NhvLcN+5d71bj/MGmNnhz4+9VaoAdRhD3UUNxWR4Z5ke1SoSSRgUrPZLnigMzA/CthSqTqBBW3JOMMKRtDv8cKfx4rRbw0pH7f3An4dXm3W/ZjaPaqzJd0Fe0DBZ8Sny3wUdgJVaEvJnqPulObp7BG/pVdis2Asa051JFC1MEUkPHaFRqtxyBga+CKW6bn6ZIauf1lSsFcOV2GXjhrwONjMW6zCdEwdAUL5ZTrd5qdgr1n6PLJeeSHOARekpx4jgFkloNsXfl5ws9X3xNwQ41g
DKIM-Signature: a=rsa-sha256; bh=3jYn4YNdYeG7LGg6VH5k0ps8cSfN4dyFLHQu/RiM+CA=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760347468; v=1;
 b=CFaoHXW6Z73qEnS7Th3BC/jjekF9fuMpiinSF6+z/QkpY7i3AjzwirMEkgzFjSc59jHECDZa
 hwJ5VjY5xLbpSpNTyMkiuhX7u5bAx2yqmo37Q5z0INncZt4wsA1g5/q4VRgvP1DDgjRuPgIR46h
 folX5IoxVTxfWuQPtJ06cYQ2wjGbmAPnb0g5Y9U0n4WN8qgngb+sMCgCDdLbP2AOewtXrO6FTL8
 rJdptJBWetpuXMJPf2JcKpe7CIZkGlIlYXItLR4m7ySh/5a253WPCKAzIHVffwlHKuqj8Iqx4la
 1KBREK2vWIxZEOD3zLlkPG2lUkHQcTym5Guwn5unVGXdg==

On Mon, 29 Sep 2025 15:06:59 +0200
Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> On Sunday, September 21, 2025 6:24:49 PM CEST Tingmao Wang wrote:
> > On 9/17/25 16:00, Micka=C3=ABl Sala=C3=BCn wrote:
> [...]
>=20
> Hi Greg,
>=20

Hi Christian,

> I'd appreciate comments from your side as well, as you are much on longer=
 on
> the QEMU 9p front than me.
>=20
> I know you won't have the time to read up on the entire thread so I try to
> summarize: basically this is yet another user-after-unlink issue, this ti=
me on
> directories instead of files.
>=20

Thread that never landed in my mailbox actually and it is quite
hard to understand the root problem with the content of this
e-mail actually ;-)

> > So I did some quick debugging and realized that I had a wrong
> > understanding of how fids relates to opened files on the host, under QE=
MU.
> > It turns out that in QEMU's 9p server implementation, a fid does not
> > actually correspond to any opened file descriptors - it merely represen=
ts
> > a (string-based) path that QEMU stores internally.  It only opens the
> > actual file if the client actually does an T(l)open, which is in fact
> > separate from acquiring the fid with T(l)walk.  The reason why renaming
> > file/dirs from the client doesn't break those fids is because QEMU will
> > actually fix those paths when a rename request is processed - c.f.
> > v9fs_fix_fid_paths [1].
>=20
> Correct, that's based on what the 9p protocols define: a FID does not exa=
ctly
> translate to what a file handle is on a local system. Even after acquirin=
g a
> new FID by sending a Twalk request, subsequently client would still need =
to
> send a Topen for server to actually open that file/directory.
>=20
> And yes, QEMU's 9p server "fixes" the path string of a FID if it was moved
> upon client request. If the move happened on host side, outside of server=
's
> knowledge, then this won't happen ATM and hence it would break your use
> case.
>=20
> > It turns out that even if a guest process opens the file with O_PATH, t=
hat
> > file descriptor does not cause an actual Topen, and therefore QEMU does
> > not open the file on the host, and later on reopening that fd with anot=
her
> > mode (via e.g. open("/proc/self/fd/...", O_RDONLY)) will fail if the fi=
le
> > has moved on the host without QEMU's knowledge.  Also, openat will fail=
 if
> > provided with a dir fd that "points" to a moved directory, regardless of
> > whether the fd is opened with O_PATH or not, since path walk in QEMU is
> > completely string-based and does not actually issue openat on the host =
fs
> > [2].
>=20
> I don't think the problem here is the string based walk per se, but rather
> that the string based walk always starts from the export root:
>=20
> https://github.com/qemu/qemu/blob/4975b64efb5aa4248cbc3760312bbe08d6e7163=
8/hw/9pfs/9p-local.c#L64
>=20
> I guess that's something that could be changed in QEMU such that the walk
> starts from FID's fs point, as the code already uses openat() to walk rel=
ative
> to a file descriptor (for security reasons actually), Greg?
>=20

Yes this was introduced for security reasons. In a nutshell, the idea is
to *not* follow symlinks in any element of the path being opened. It thus
naturally starts at the export root for which we have an fd.

> That alone would still not fix your use case though: things being moved on
> host side. For this to work, it would require to already have a fd open on
> host for the FID. This could be done by server for each FID as you sugges=
ted,
> or it could be done by client by opening the FID.
>=20

Can you elaborate on the "things being move on host side" ? With
an example of code that breaks on the client side ?

> Also keep in mind: once the open file descriptor limit on host is exhaust=
ed,
> QEMU is forced to close older open file desciptors to keep the QEMU proce=
ss
> alive. So this might still break what you are trying to achieve there.
>=20

Correct.

> Having said that, I wonder whether it'd be simpler for server to track for
> file tree changes (inotify API) and fix the pathes accordingly for host
> side changes as well?
>=20

The problem is how to have the guest know about such changes, e.g. in
order to invalidate a stale cache entry. 9P doesn't provide any way for
host->client notification.

> /Christian
>=20
>=20

Cheers,

--=20
Greg

