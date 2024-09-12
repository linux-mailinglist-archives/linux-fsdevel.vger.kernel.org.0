Return-Path: <linux-fsdevel+bounces-29158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0884976853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD901F2217A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AEA1A265A;
	Thu, 12 Sep 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB0NNUCO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666F1A0BDE;
	Thu, 12 Sep 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141923; cv=none; b=pFBSzDDkgdrPUEnj1G/g7Cm8wvzrzbzZM2+Om7DCVIIuxepb2lZoHaxPPjTs+yv3pYJSSQa+dUmao56FgUvBBjnRp8yMF1vUhh3C6xUJa/JskKgojZeBcYvl1ukjkgAo93eaWDvZtB3hu0sJmUmqRWCtJDY9nPTFE0PSgbs9dO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141923; c=relaxed/simple;
	bh=MaANVgVe5S3ilmcrKj5Qeten3VAHX48thlxzUCq1dAw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7Rul0GRjR89JJwLrW4mwM3k3E+zngG+Yl3lvfJ29sMLkSH2mjuIrEPlcbI64RKywMihBpDzdIEhyu8ayUFkC/LaZirKNu1xE0dDbSLwX56fdOiRKl7vDjQgQL6UljuK8H9jInAo7tB+v7Babh2htfSm4nIUWfjIfREnJZL3Prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB0NNUCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB005C4CEC3;
	Thu, 12 Sep 2024 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726141922;
	bh=MaANVgVe5S3ilmcrKj5Qeten3VAHX48thlxzUCq1dAw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AB0NNUCOU6aOruESAt3gWo5L3dXTtKJatM+mgcc59FtA6RzmyCLjto/gvFtBNcp3I
	 GO/F8OeMZZL3QQDdeSl9EOmStJbAtSciWlBD6/u5NEenRUvGa9T+p76PMJgkhHQvjT
	 AETz+MXXh+HsKrDogxEG8F/k7KNxeUlOojCXYEp5qXINmluGXUVoJoooCvmkx8Bw8K
	 t7jHyLxbliYZ01MDcGsAGO7oAxGNKp8Ig8CHYh0Dm5Pe3igAxHRgRnSoTaYUdx0MgG
	 CgdLvDJQuVpA6BC8vqup9rg26pcSvPTyc+oI8SIFjQKpETFpwLSetPlHWlXU9MFgF/
	 KM+YgDBoqXljQ==
Message-ID: <f4f6d39fbe5d30c5a2d1623d8b9c22e3dee636a8.camel@kernel.org>
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Benjamin Coddington
	 <bcodding@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Amir Goldstein
 <amir73il@gmail.com>,  Neil Brown <neilb@suse.de>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>, Andreas Gruenbacher <agruenba@redhat.com>, Mark Fasheh
 <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Alexander Ahring Oder Aring <aahringo@redhat.com>,
  linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 gfs2@lists.linux.dev,  ocfs2-devel@lists.linux.dev
Date: Thu, 12 Sep 2024 07:51:59 -0400
In-Reply-To: <20240912-akkreditieren-montag-8e935460169d@brauner>
References: <cover.1726083391.git.bcodding@redhat.com>
	 <f798d5225cc52ec227b4458f3313f1908c471984.camel@kernel.org>
	 <20240912-akkreditieren-montag-8e935460169d@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 13:32 +0200, Christian Brauner wrote:
> On Thu, Sep 12, 2024 at 07:08:07AM GMT, Jeff Layton wrote:
> > On Wed, 2024-09-11 at 15:42 -0400, Benjamin Coddington wrote:
> > > Last year both GFS2 and OCFS2 had some work done to make their lockin=
g more
> > > robust when exported over NFS.  Unfortunately, part of that work caus=
ed both
> > > NLM (for NFS v3 exports) and kNFSD (for NFSv4.1+ exports) to no longe=
r send
> > > lock notifications to clients.
> > >=20
> > > This in itself is not a huge problem because most NFS clients will st=
ill
> > > poll the server in order to acquire a conflicted lock, but now that I=
've
> > > noticed it I can't help but try to fix it because there are big advan=
tages
> > > for setups that might depend on timely lock notifications, and we've
> > > supported that as a feature for a long time.
> > >=20
> > > Its important for NLM and kNFSD that they do not block their kernel t=
hreads
> > > inside filesystem's file_lock implementations because that can produc=
e
> > > deadlocks.  We used to make sure of this by only trusting that
> > > posix_lock_file() can correctly handle blocking lock calls asynchrono=
usly,
> > > so the lock managers would only setup their file_lock requests for as=
ync
> > > callbacks if the filesystem did not define its own lock() file operat=
ion.
> > >=20
> > > However, when GFS2 and OCFS2 grew the capability to correctly
> > > handle blocking lock requests asynchronously, they started signalling=
 this
> > > behavior with EXPORT_OP_ASYNC_LOCK, and the check for also trusting
> > > posix_lock_file() was inadvertently dropped, so now most filesystems =
no
> > > longer produce lock notifications when exported over NFS.
> > >=20
> > > I tried to fix this by simply including the old check for lock(), but=
 the
> > > resulting include mess and layering violations was more than I could =
accept.
> > > There's a much cleaner way presented here using an fop_flag, which wh=
ile
> > > potentially flag-greedy, greatly simplifies the problem and grooms th=
e
> > > way for future uses by both filesystems and lock managers alike.
> > >=20
> > > Criticism welcomed,
> > > Ben
> > >=20
> > > Benjamin Coddington (4):
> > >   fs: Introduce FOP_ASYNC_LOCK
> > >   gfs2/ocfs2: set FOP_ASYNC_LOCK
> > >   NLM/NFSD: Fix lock notifications for async-capable filesystems
> > >   exportfs: Remove EXPORT_OP_ASYNC_LOCK
> > >=20
> > >  Documentation/filesystems/nfs/exporting.rst |  7 -------
> > >  fs/gfs2/export.c                            |  1 -
> > >  fs/gfs2/file.c                              |  2 ++
> > >  fs/lockd/svclock.c                          |  5 ++---
> > >  fs/nfsd/nfs4state.c                         | 19 ++++---------------
> > >  fs/ocfs2/export.c                           |  1 -
> > >  fs/ocfs2/file.c                             |  2 ++
> > >  include/linux/exportfs.h                    | 13 -------------
> > >  include/linux/filelock.h                    |  5 +++++
> > >  include/linux/fs.h                          |  2 ++
> > >  10 files changed, 17 insertions(+), 40 deletions(-)
> > >=20
> >=20
> > Thanks for fixing this up, Ben!
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> It might be a bit late for v6.12 so I would stuff this into a branch for
> v6.13. Sound ok?

Ok. I figured Chuck would take this set, but I guess it is more VFS-y.

I think this is reasonably safe though, so if Ben needs it before then,
we could pull it in sooner.
--=20
Jeff Layton <jlayton@kernel.org>

