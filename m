Return-Path: <linux-fsdevel+bounces-69923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71398C8BEB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 21:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E99B358374
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48338340DB0;
	Wed, 26 Nov 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VVpB0lSc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vnalrjlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125122F83AC;
	Wed, 26 Nov 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764190293; cv=none; b=l2d1VHwSmfAf6ICmdTkmAOszPsRbHYJFdliq5U7Tf+QtxFAQrPYN+/rjLGsXDqFfSkdYoHIeHo+1Ib4eSEIDV98fJtuIfFkaZ2BGKWKNVvpjWDG4BV4KJHQXQstqnIwlTBcaF8d4uL0V4AT6wjtNkI8tGIB0LKxT6j6jWOhnZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764190293; c=relaxed/simple;
	bh=AKpy2VI1xw8KKWkaVooHuxoKcUKA0T55/4LqDmNkEBg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=H6SPdr95FCnVxXjF3aJgip4yVKWpHmxun0jgN2+zqFuxwnXNLGyLciKVhmPmeQHDrWvrcLOcgZ73HPVzard0q0DfWZeJHZZqXfF77xoWgOQTprMxLgPYT3lpf4bA5FRNf2QhOCBEckSHJ2eu1opbYtO1xmwUC0imlQJZcAVLjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VVpB0lSc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vnalrjlR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 116781D0008E;
	Wed, 26 Nov 2025 15:51:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 26 Nov 2025 15:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1764190289; x=1764276689; bh=yl+eQEMN8QMEUq91pZnkP+ILRrdhioI3CRA
	AUiLxEfM=; b=VVpB0lScxy+qrjv9V6gfyM2sQ0S+3nYKq5BIbAkyaoMCUYKUJMx
	Lq5KpC+ERZlk6l7cGURBQZfTGXSw4udnUj5JZ5UOKNe9VsbVIsJGg2+/fy/WWSCz
	SdjHAVNxQpPEx96awjSiQ8yxnN8ysTxN8i9wIp650idZBcaXH6jItsgnStGLrowG
	QJez7XtGlXXLsMO/J6PX10pBb6cZrzznu6zxGkMOdMM8qqRlWQo9hgg/bxE0CctR
	ziQvXYYCGsQhcxmywD/xsTaom8Ybdbt2Kzlkl41CHud0lF99vrHls34yXLdpuAGH
	pUIx0H2LkzbF/G1gh5eJXUiUQquBSjRqlPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764190289; x=
	1764276689; bh=yl+eQEMN8QMEUq91pZnkP+ILRrdhioI3CRAAUiLxEfM=; b=v
	nalrjlR9nF9tPOR1PqZ7mXTBJYGT7jK7VBOodSS7XwhCul+mh7qO1F1zKWHFaVEA
	y/iqYnPOR5cTKdHJc34lDXdJCMRhUL+B4n8xq0uP7X4fTrHyNMUzbPnnyb1lvsRV
	SIK+pAJgZhMCLie+7MUc3Ek8FjzFnRaa6UtQlWsQ+UJ3aX09aN2kg7MnR4UaCJI9
	vnXnbbA2aFfivd6efyZJ/ySODMFJ/FEwnqjgC6CQxfeDZY0EHGt2VY5789GWjdC5
	qJSZfQ10CsH/C6KRfxiBIDWm3VFVmg6Cd9NSMYlDrLRGVSorOatJkkn5hAn2oEfq
	QbFq/Cr1aV40gzvKW0Q/g==
X-ME-Sender: <xms:UWgnaXm-qG30pr1bf-e7n_GuhlhVB2zdd8IqqdlredIwiAmubkvJwA>
    <xme:UWgnaS-hhPzNaz5wEOvtsR8INmIlCJ4tfeSYIP9RMOD9HUwSlNL7AREq4vU7qqthZ
    sXwyQ_5iVJhBZsM-tgduX3js5Wl6tWt4DBhZhwxnwhmbMWZ9w>
X-ME-Received: <xmr:UWgnadLoNdBAzYTvl1LECQuXGEQda_kA3omadsadRHUczaHfNIo-EfSYzTReMfskzhSNYl3OTi06QN7LMxpEiTWuHfWoIKeNJvc5EZlRfzDd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    dquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehovg
    dqlhhkpheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvghtfhhssehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepohhlihhvvghrrdhsrghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:UWgnafhLIyYo-qt4Ew6KgmiVuZA-bQhJG6dDfUn5Uj6v_pJD0KEtQg>
    <xmx:UWgnaR9K2IgAvytgn9_q0VtN3YIa4sOw88anH0BElMIGrJc49URaFw>
    <xmx:UWgnacMIsTKdiu5fb4TaB5X6rXlDAcfiCqNPxiHAP9XSnq_VUv4Wdg>
    <xmx:UWgnadD37WkBza8NleHzBpQvjJf6k2G2e8HWzgn516kMUKlLHRg7dQ>
    <xmx:UWgnaVTG0esH90Mvi84aoRci8-WbsHUjgp5sHliwd7s5zbZaawHb-W4G>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 15:51:26 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "kernel test robot" <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [VFS/nfsd/cachefiles/ovl] 7ab96df840:
 WARNING:at_fs/dcache.c:#umount_check
In-reply-to:
 <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>
References: <202511252132.2c621407-lkp@intel.com>,
 <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>,
 <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>
Date: Thu, 27 Nov 2025 07:51:18 +1100
Message-id: <176419027888.634289.8284458326359928729@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 26 Nov 2025, Amir Goldstein wrote:
> On Wed, Nov 26, 2025 at 11:42=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > On Tue, Nov 25, 2025 at 09:48:18PM +0800, kernel test robot wrote:
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:
> > >
> > > commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefiles/=
ovl: add start_creating() and end_creating()")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > >
> > > [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d6=
4f5]
> >
> > Neil, can you please take a look at this soon?
> > I plan on sending the batch of PRs for this cycle on Friday.
> >
> > >
> > > in testcase: filebench
> > > version: filebench-x86_64-22620e6-1_20251009
> > > with following parameters:
> > >
> > >       disk: 1SSD
> > >       fs: ext4
> > >       fs2: nfsv4
> > >       test: ratelimcopyfiles.f
> > >       cpufreq_governor: performance
> > >
>=20
> Test is copying to nfsv4 so that's the immediate suspect.
> WARN_ON is in unmount of ext4, but I suspect that nfs
> was loop mounted for the test.
>=20
> FWIW, nfsd_proc_create() looks very suspicious.
>=20
> nfsd_create_locked() does end_creating() internally (internal API change)
> but nfsd_create_locked() still does end_creating() regardless.

Thanks for looking at this Amir.  That omission in nfsproc.c is
certainly part of the problem but not all of it.
By skipping the end_creating() there, we avoid a duplicate unlock, but
also lose a dput() which we need.  Both callers of nfsd_create_locked()
have the same problem.
I think this should fix it.  The resulting code is a bit ugly but I can
fix that with the nfsd team once this gets upstream.

(FYI nfsd_proc_create() is only used for NFSv2 and as it was an nfsv4 test,
 that could wouldn't have been run)

Thanks,
NeilBrown

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 28f03a6a3cc3..481e789a7697 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -407,6 +407,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		/* File doesn't exist. Create it and set attrs */
 		resp->status =3D nfsd_create_locked(rqstp, dirfhp, &attrs, type,
 						  rdev, newfhp);
+		/* nfsd_create_locked() unlocked the parent */
+		dput(dchild);
+		goto out_write;
 	} else if (type =3D=3D S_IFREG) {
 		dprintk("nfsd:   existing %s, valid=3D%x, size=3D%ld\n",
 			argp->name, attr->ia_valid, (long) attr->ia_size);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 145f1c8d124d..4688f3fd59e2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1633,16 +1633,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fh=
p,
 		return nfserrno(host_err);
=20
 	err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
-	/*
-	 * We unconditionally drop our ref to dchild as fh_compose will have
-	 * already grabbed its own ref for it.
-	 */
 	if (err)
 		goto out_unlock;
 	err =3D fh_fill_pre_attrs(fhp);
 	if (err !=3D nfs_ok)
 		goto out_unlock;
 	err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
+	/* nfsd_create_locked() unlocked the parent */
+	dput(dchild);
 	return err;
=20
 out_unlock:

