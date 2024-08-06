Return-Path: <linux-fsdevel+bounces-25175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9ED94989E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EBFB222D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E013C677;
	Tue,  6 Aug 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxQxQcHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BE18D64E;
	Tue,  6 Aug 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973903; cv=none; b=aqRdxaTtESttOQGkWj0WdXT/VKoCovcEpmsBOFDW/+ZKCwJ5kTiKWWykwon4jFh1I9C1dJ8BZN4F4kZoj7Pbtb5UgmhH5tNeJqApdxGwTc79jqkMh53PTbChyJ5SliemQZ24Q2lh3gLC2quqlFkg4XlHyskjuMSyGeQZzVdxdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973903; c=relaxed/simple;
	bh=oG07c9KX6QbomdUrRgyTsPU+1ShddmwxrrSiLeHEu6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkjCLfnqW7dERrmvo6PA6IpoG6HTBzNxo5inmg0dm1HFuWL48neW4FYp6Z6P+IjKI81DqswglpQHFYb9fHROErZ+PgAVbq3vjuvT8QGYy2iFPtq/zOisGlH8UbkZ6QJTyCnKQ2tWRX3AAD3bzSnCRIszdMNq6v+GQkCteuIo7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxQxQcHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2B6C32786;
	Tue,  6 Aug 2024 19:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722973902;
	bh=oG07c9KX6QbomdUrRgyTsPU+1ShddmwxrrSiLeHEu6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sxQxQcHBfUIJswLw4dtYboeD2hgx0UoPNNDq/poTSRp/leZtgUqM8BPlSqFZqgeGK
	 iMaztn1ZbOExlh3MVdTYwPKFkkopqyP2xrPd/vsCKhuTw0PUdGT7UE0MoMl04q6foG
	 6TrZEavlH25cIxXpB4YyzJn/T9GoQFuRdydeAW7mg7mcsfwhFlJ0NPRAi6fqk9e2Id
	 40tEZIAK1aRqKlDMAkAin6YX5qGVDaDVJKzsWF0rw4EU+ZHOv7HgHhULAnybV2BPVq
	 TB5h0BwCb6dlog+5RXyF7QOMZgPQgLYzJa0N6xHz+mKZmDnwyYg2DGbvnWvvx5AVoX
	 lqPaRUVt8TEyQ==
Message-ID: <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Aug 2024 15:51:35 -0400
In-Reply-To: <20240806-openfast-v2-1-42da45981811@kernel.org>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIg
 UCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1
 oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOT
 tmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+
 9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPc
 og7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/
 WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EB
 ny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9
 KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTi
 CThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XR
 MJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 10:32 -0400, Jeff Layton wrote:
> Today, when opening a file we'll typically do a fast lookup, but if
> O_CREAT is set, the kernel always takes the exclusive inode lock. I
> assume this was done with the expectation that O_CREAT means that we
> always expect to do the create, but that's often not the case. Many
> programs set O_CREAT even in scenarios where the file already exists.
>=20
> This patch rearranges the pathwalk-for-open code to also attempt a
> fast_lookup in certain O_CREAT cases. If a positive dentry is found, the
> inode_lock can be avoided altogether, and if auditing isn't enabled, it
> can stay in rcuwalk mode for the last step_into.
>=20
> One notable exception that is hopefully temporary: if we're doing an
> rcuwalk and auditing is enabled, skip the lookup_fast. Legitimizing the
> dentry in that case is more expensive than taking the i_rwsem for now.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Here's a revised patch that does a fast_lookup in the O_CREAT codepath
> too. The main difference here is that if a positive dentry is found and
> audit_dummy_context is true, then we keep the walk lazy for the last
> component, which avoids having to take any locks on the parent (just
> like with non-O_CREAT opens).
>=20
> The testcase below runs in about 18s on v6.10 (on an 80 CPU machine).
> With this patch, it runs in about 1s:
>=20
> =C2=A0#define _GNU_SOURCE 1
> =C2=A0#include <stdio.h>
> =C2=A0#include <unistd.h>
> =C2=A0#include <errno.h>
> =C2=A0#include <fcntl.h>
> =C2=A0#include <stdlib.h>
> =C2=A0#include <sys/wait.h>
>=20
> =C2=A0#define PROCS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 70
> =C2=A0#define LOOPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 500000
>=20
> static int openloop(int tnum)
> {
> 	char *file;
> 	int i, ret;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	ret =3D asprintf(&file, "./tes=
tfile%d", tnum);
> 	if (ret < 0) {
> 		printf("asprintf failed for proc %d", tnum);
> 		return 1;
> 	}
>=20
> 	for (i =3D 0; i < LOOPS; ++i) {
> 		int fd =3D open(file, O_RDWR|O_CREAT, 0644);
>=20
> 		if (fd < 0) {
> 			perror("open");
> 			return 1;
> 		}
> 		close(fd);
> 	}
> 	unlink(file);
> 	free(file);
> 	return 0;
> }
>=20
> int main(int argc, char **argv) {
> 	pid_t kids[PROCS];
> 	int i, ret =3D 0;
>=20
> 	for (i =3D 0; i < PROCS; ++i) {
> 		kids[i] =3D fork();
> 		if (kids[i] > 0)
> 			return openloop(i);
> 		if (kids[i] < 0)
> 			perror("fork");
> 	}
>=20
> 	for (i =3D 0; i < PROCS; ++i) {
> 		int ret2;
>=20
> 		if (kids[i] > 0) {
> 			wait(&ret2);
> 			if (ret2 !=3D 0)
> 				ret =3D ret2;
> 		}
> 	}
> 	return ret;
> }
> ---
> Changes in v2:
> - drop the lockref patch since Mateusz is working on a better approach
> - add trailing_slashes helper function
> - add a lookup_fast_for_open helper function
> - make lookup_fast_for_open skip the lookup if auditing is enabled
> - if we find a positive dentry and auditing is disabled, don't unlazy
> - Link to v1: https://lore.kernel.org/r/20240802-openfast-v1-0-a1cff2a330=
63@kernel.org
> ---
> =C2=A0fs/namei.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++---------
> =C2=A01 file changed, 53 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 1e05a0f3f04d..2d716fb114c9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3518,6 +3518,47 @@ static struct dentry *lookup_open(struct nameidata=
 *nd, struct file *file,
> =C2=A0	return ERR_PTR(error);
> =C2=A0}
> =C2=A0
> +static inline bool trailing_slashes(struct nameidata *nd)
> +{
> +	return (bool)nd->last.name[nd->last.len];
> +}
> +
> +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int ope=
n_flag)
> +{
> +	struct dentry *dentry;
> +
> +	if (open_flag & O_CREAT) {
> +		/* Don't bother on an O_EXCL create */
> +		if (open_flag & O_EXCL)
> +			return NULL;
> +
> +		/*
> +		 * FIXME: If auditing is enabled, then we'll have to unlazy to
> +		 * use the dentry. For now, don't do this, since it shifts
> +		 * contention from parent's i_rwsem to its d_lockref spinlock.
> +		 * Reconsider this once dentry refcounting handles heavy
> +		 * contention better.
> +		 */
> +		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> +			return NULL;
> +	}
> +
> +	if (trailing_slashes(nd))
> +		nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> +
> +	dentry =3D lookup_fast(nd);

Self-NAK on this patch. We have to test for IS_ERR on the returned
dentry here. I'll send a v3 along after I've retested it.

> +
> +	if (open_flag & O_CREAT) {
> +		/* Discard negative dentries. Need inode_lock to do the create */
> +		if (dentry && !dentry->d_inode) {
> +			if (!(nd->flags & LOOKUP_RCU))
> +				dput(dentry);
> +			dentry =3D NULL;
> +		}
> +	}
> +	return dentry;
> +}
> +
> =C2=A0static const char *open_last_lookups(struct nameidata *nd,
> =C2=A0		=C2=A0=C2=A0 struct file *file, const struct open_flags *op)
> =C2=A0{
> @@ -3535,28 +3576,31 @@ static const char *open_last_lookups(struct namei=
data *nd,
> =C2=A0		return handle_dots(nd, nd->last_type);
> =C2=A0	}
> =C2=A0
> +	/* We _can_ be in RCU mode here */
> +	dentry =3D lookup_fast_for_open(nd, open_flag);
> +	if (IS_ERR(dentry))
> +		return ERR_CAST(dentry);
> +
> =C2=A0	if (!(open_flag & O_CREAT)) {
> -		if (nd->last.name[nd->last.len])
> -			nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> -		/* we _can_ be in RCU mode here */
> -		dentry =3D lookup_fast(nd);
> -		if (IS_ERR(dentry))
> -			return ERR_CAST(dentry);
> =C2=A0		if (likely(dentry))
> =C2=A0			goto finish_lookup;
> =C2=A0
> =C2=A0		if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
> =C2=A0			return ERR_PTR(-ECHILD);
> =C2=A0	} else {
> -		/* create side of things */
> =C2=A0		if (nd->flags & LOOKUP_RCU) {
> +			/* can stay in rcuwalk if not auditing */
> +			if (dentry && audit_dummy_context())
> +				goto check_slashes;
> =C2=A0			if (!try_to_unlazy(nd))
> =C2=A0				return ERR_PTR(-ECHILD);
> =C2=A0		}
> =C2=A0		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> -		/* trailing slashes? */
> -		if (unlikely(nd->last.name[nd->last.len]))
> +check_slashes:
> +		if (trailing_slashes(nd))
> =C2=A0			return ERR_PTR(-EISDIR);
> +		if (dentry)
> +			goto finish_lookup;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>=20
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240723-openfast-ac49a7b6ade2
>=20
> Best regards,

--=20
Jeff Layton <jlayton@kernel.org>

