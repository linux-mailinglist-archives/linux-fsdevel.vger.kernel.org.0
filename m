Return-Path: <linux-fsdevel+bounces-51035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCEBAD20F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5466D3A86A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9425CC74;
	Mon,  9 Jun 2025 14:35:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tempest.elijah.cs.cmu.edu (tempest.elijah.cs.cmu.edu [128.2.210.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25452F37;
	Mon,  9 Jun 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.2.210.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479749; cv=none; b=Hhz5Nh4bIDnYm7JVnudl/E6zBvTsgPCxPPjyjgnN2Iw3Wi2aG5vZAONjHymnwDzjszD3i8ia38OLo1Zy18136+t0H0ly449JJXQBXyblzQ8cAlFzd77OqbE1LcoT1wdVDq850fBLSXu8MzNfBMnWix7w8KWb2aC8IQAd5EFKoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479749; c=relaxed/simple;
	bh=jqGRLWTTrqw42sFBNIxIr68z0GOeWt6gFzTavBE/PGk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aRE7nec2RCuts617N9nu4XWl68gBcIc7XlhKE9NQIaWMighr2aC+WjnwdzS5OpxltX436EaHc3Xc0pSXuqRepTG3TGny45hEaNIeANzRBe5ktqEiTGuRAxlWslrVDvj+SXk9KposMO4CKGRASFteY4lEr61mDAWLxmCCX9FN2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=cs.cmu.edu; arc=none smtp.client-ip=128.2.210.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.cmu.edu
Received: from [127.0.0.1] (unknown [172.26.8.30])
	by tempest.elijah.cs.cmu.edu (Postfix) with ESMTPSA id F0F5A180130C;
	Mon,  9 Jun 2025 10:35:44 -0400 (EDT)
Date: Mon, 09 Jun 2025 10:35:36 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, David Howells <dhowells@redhat.com>,
 Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Carlos Maiolino <cem@kernel.org>
CC: linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] coda: use iterate_dir() in coda_readdir()
In-Reply-To: <20250608230952.20539-4-neil@brown.name>
References: <20250608230952.20539-1-neil@brown.name> <20250608230952.20539-4-neil@brown.name>
Message-ID: <7DCEE406-F27B-4120-BD7A-B0A5E9028FAF@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

That change is probably good=2E

The Coda user space always writes directory data to a file, so the normal =
path always uses coda_venus_readdir=2E

The iterate_dir code was afaik mostly used while developing the original k=
ernel module during the Linux-2=2E1 era=2E It was using a trivial user spac=
e helper that would simply re-export an existing filesystem subtree=2E Sort=
 of like a bind mount before bind mounts existed=2E

Jan

On June 8, 2025 7:37:25 PM EDT, NeilBrown <neil@brown=2Ename> wrote:
>The code in coda_readdir() is nearly identical to iterate_dir()=2E
>Differences are:
> - iterate_dir() is killable
> - iterate_dir() adds permission checking and accessing notifications
>
>I believe these are not harmful for coda so it is best to use
>iterate_dir() directly=2E  This will allow locking changes without
>touching the code in coda=2E
>
>Signed-off-by: NeilBrown <neil@brown=2Ename>
>---
> fs/coda/dir=2Ec | 12 ++----------
> 1 file changed, 2 insertions(+), 10 deletions(-)
>
>diff --git a/fs/coda/dir=2Ec b/fs/coda/dir=2Ec
>index ab69d8f0cec2=2E=2Eca9990017265 100644
>--- a/fs/coda/dir=2Ec
>+++ b/fs/coda/dir=2Ec
>@@ -429,17 +429,9 @@ static int coda_readdir(struct file *coda_file, stru=
ct dir_context *ctx)
> 	cfi =3D coda_ftoc(coda_file);
> 	host_file =3D cfi->cfi_container;
>=20
>-	if (host_file->f_op->iterate_shared) {
>-		struct inode *host_inode =3D file_inode(host_file);
>-		ret =3D -ENOENT;
>-		if (!IS_DEADDIR(host_inode)) {
>-			inode_lock_shared(host_inode);
>-			ret =3D host_file->f_op->iterate_shared(host_file, ctx);
>-			file_accessed(host_file);
>-			inode_unlock_shared(host_inode);
>-		}
>+	ret =3D iterate_dir(host_file, ctx);
>+	if (ret !=3D -ENOTDIR)
> 		return ret;
>-	}
> 	/* Venus: we must read Venus dirents from a file */
> 	return coda_venus_readdir(coda_file, ctx);
> }

