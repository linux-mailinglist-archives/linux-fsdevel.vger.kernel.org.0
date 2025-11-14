Return-Path: <linux-fsdevel+bounces-68435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26203C5C1D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 060F94EEAF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFB30146C;
	Fri, 14 Nov 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6vbiufQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451562FFDDF;
	Fri, 14 Nov 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110433; cv=none; b=jyIoWTTOB8Tm8tulEQzh1b9XbOtbV1CbV/aO/FrExX1d2uCmBiYmu2HG5bnidMBd5g35dsrajQwLafZszFIr6jL9Zh+d9J/zGkgUwVU1bdAfxYIflm7xHGaGun0EZsqQw//W1vsHkALgs0o6YFtRcPeUDvNbWBbvK2P6Jx1vz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110433; c=relaxed/simple;
	bh=ssk0rZZhSRHJxG/U1ahZGKzn76bRpJzS5FgN48xgYH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNe6HaqNPaiUnEZZ8Q1GkEB4YBSSVEt/asJOEyDUmlvJC4Rw0JVfREI/sApw+sHTD64+q+zVryAjjSlE7VvKOO3i6zkn7FgFY4hy5iduDdag0meV5ydnO4RQN6YgRoGiAntqkdSMDetlxr3WpmxMn+DFT19a0J8v6D2gFZ+P8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6vbiufQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C75C113D0;
	Fri, 14 Nov 2025 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763110433;
	bh=ssk0rZZhSRHJxG/U1ahZGKzn76bRpJzS5FgN48xgYH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6vbiufQBW7J+aMbNrdMWFyccc3es+js8HLWi55Q47JhyAcAXgzOdGo4sruvML3GZ
	 MAFhbYwE5GXhDI5g2I8irfZlewedp3Rbig63nOnarsweSMItstUm5ijQOaOVUw1VPX
	 vRhE1d8uH6IYGVqrNxc34eECqjiaLfv2mJNjWKvEd4TiuLVaayJfRl+cZXNCiOsXlG
	 RrvKdh9QEC4RmEcNVnq5Beh2wK/xr/BT5x6K1YyQfPHOFri6vxLi9mTnLsFlilxm4D
	 mncrFl/OUu4eCUjRQEtj45ZPeW+65m2JiLhf14H6i0tgdqceftgP+S3Qo72PzMF3xB
	 ag2M/NM5Y0VUQ==
Date: Fri, 14 Nov 2025 09:53:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 24/42] ovl: don't override credentials for
 ovl_check_whiteouts()
Message-ID: <20251114-gekennzeichnet-girokonten-806fb9e0ae6a@brauner>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-24-b35ec983efc1@kernel.org>
 <CAJfpegtrXoywfudc+x7tP_riDeSM2AGFwgGwWjdUa3UqQ85ndA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegtrXoywfudc+x7tP_riDeSM2AGFwgGwWjdUa3UqQ85ndA@mail.gmail.com>

On Fri, Nov 14, 2025 at 09:11:50AM +0100, Miklos Szeredi wrote:
> On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrote:
> >
> > The function is only called when rdd->dentry is non-NULL:
> >
> > if (!err && rdd->first_maybe_whiteout && rdd->dentry)
> >     err = ovl_check_whiteouts(realpath, rdd);
> >
> > | Caller                        | Sets rdd->dentry? | Can call ovl_check_whiteouts()? |
> > |-------------------------------|-------------------|---------------------------------|
> > | ovl_dir_read_merged()         | ✓ Yes (line 430)  | ✓ YES                           |
> > | ovl_dir_read_impure()         | ✗ No              | ✗ NO                            |
> > | ovl_check_d_type_supported()  | ✗ No              | ✗ NO                            |
> > | ovl_workdir_cleanup_recurse() | ✗ No              | ✗ NO                            |
> > | ovl_indexdir_cleanup()        | ✗ No              | ✗ NO                            |
> >
> > VFS layer (.iterate_shared file operation)
> >   → ovl_iterate()
> >       [CRED OVERRIDE]
> >       → ovl_cache_get()
> >           → ovl_dir_read_merged()
> >               → ovl_dir_read()
> >                   → ovl_check_whiteouts()
> >       [CRED REVERT]
> >
> > ovl_unlink()
> >   → ovl_do_remove()
> >       → ovl_check_empty_dir()
> >           [CRED OVERRIDE]
> >           → ovl_dir_read_merged()
> >               → ovl_dir_read()
> >                   → ovl_check_whiteouts()
> >           [CRED REVERT]
> >
> > ovl_rename()
> >   → ovl_check_empty_dir()
> >       [CRED OVERRIDE]
> >       → ovl_dir_read_merged()
> >           → ovl_dir_read()
> >               → ovl_check_whiteouts()
> >       [CRED REVERT]
> >
> > All valid callchains already override credentials so drop the override.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/readdir.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 1e9792cc557b..12f0bb1480d7 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -348,11 +348,7 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
> >
> >  static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data *rdd)
> >  {
> > -       int err = 0;
> >         struct dentry *dentry, *dir = path->dentry;
> > -       const struct cred *old_cred;
> > -
> > -       old_cred = ovl_override_creds(rdd->dentry->d_sb);
> 
> Myabe ovl_assert_override_creds()?

Yeah, I'm thinking about a follow-up series to this one to add a few
asserts in there.

