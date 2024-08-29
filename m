Return-Path: <linux-fsdevel+bounces-27742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F7A9637E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C431C2288A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6C22EF2;
	Thu, 29 Aug 2024 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM6zvsrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848761C2BD;
	Thu, 29 Aug 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895775; cv=none; b=Fhc2Ru83BYTxOjT7q4G0MDV6Q0ohEWMbpwypKMSNaAsRapJA0HUcHsou+DqeAjHcPhspBlfdEuxh/vTdsmX+CWfR8UcEGlc28yEMpxfVLmqdCiuG7R66R7nCeIDWjhoyGBZZYoeOLMfMVgVC5ryeatm/CjzJIyLMeta0dw7CwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895775; c=relaxed/simple;
	bh=Jlt8EVQdRsjiLY48VJvh9wiJx/tZo663SljN9jPTUDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJdKTZFykwTbCJ4S9HhmDKfon/SK+AUetkVcKhpe0UCmTqUeSQKyEil5LCnHVS3VoGuon5bsYikwuXaRyBcG48dJyoF9y60vy5RDSNZWD6XIn+Ydf5knuqBt2ucfWZBGvzfObcya+x7M/OHMk9CdtlgQJyeTg3f4dXJ2KFYvbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM6zvsrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FACC4CEC0;
	Thu, 29 Aug 2024 01:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724895775;
	bh=Jlt8EVQdRsjiLY48VJvh9wiJx/tZo663SljN9jPTUDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cM6zvsrqtNyc1X2qKF2gO3/VMVJR0hLh3ttog1l4CawgIEEbQBbkh9BMC/772jtH9
	 ZdCSNea93kQSrOAbBUtmYeHOY/yyqnH4kZ0Q0gpc/74YTgGMgRQYTfadlCeXE2Lz0l
	 Krga3YbVnKK2bBz86IooFZZLjcTA8y8ZKpUVLXcllZc57ij9SpkK6+vklCHpCXXkSC
	 lgsT81YExXk4CbatUItkDiIOhNaoQnFjl7v5Sc2DgbfCBvKaUc13rpN99FJEnTbWp2
	 8zyzLdlb3qIvAk0WvmxfSp0EoqfLrmCMCcEeOG/KfSnpMCrhKPOwTlMdoUVKnGr36m
	 qdojceRGs7j9Q==
Date: Wed, 28 Aug 2024 21:42:53 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 00/25] nfs/nfsd: add support for LOCALIO
Message-ID: <Zs_SHZXnn0xyVQYY@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>

On Wed, Aug 28, 2024 at 09:03:55PM -0400, Mike Snitzer wrote:
> These latest changes are available in my git tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> 
> I _think_ I addressed all of v13's very helpful review comments.
> Special thanks to Neil and Chuck for their time and help!
> 
> And hopefully I didn't miss anything in the changelog below.

As it happens, a last minute rebase that I did just before sending out
v14 caused me to send out 2 stale patches:
[PATCH v14 09/25] nfsd: add nfsd_file_acquire_local()
[PATCH v14 25/25] nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst

I will reply to each patch with a correct v14.5 for each.

Sorry for the confusion.

Here is the incremental diff that shows what was missing in v14:

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index 4b6d63246479..5d652f637a97 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -120,12 +120,13 @@ FAQ
    using RPC, beneficial?  Is the benefit pNFS specific?
 
    Avoiding the use of XDR and RPC for file opens is beneficial to
-   performance regardless of whether pNFS is used. However adding a
-   requirement to go over the wire to do an open and/or close ends up
-   negating any benefit of avoiding the wire for doing the I/O itself
-   when we´re dealing with small files. There is no benefit to replacing
-   the READ or WRITE with a new open and/or close operation that still
-   needs to go over the wire.
+   performance regardless of whether pNFS is used. Especially when
+   dealing with small files its best to avoid going over the wire
+   whenever possible, otherwise it could reduce or even negate the
+   benefits of avoiding the wire for doing the small file I/O itself.
+   Given LOCALIO's requirements the current approach of having the
+   client perform a server-side file open, without using RPC, is ideal.
+   If in the future requirements change then we can adapt accordingly.
 
 7. Why is LOCALIO only supported with UNIX Authentication (AUTH_UNIX)?
 
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index e636d2a1e664..46a7f9b813e5 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -32,10 +32,8 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	int		access;
 	struct svc_fh	fh;
 
-	if (rqstp->rq_vers == 4)
-		fh_init(&fh, NFS3_FHSIZE);
-	else
-		fh_init(&fh, NFS_FHSIZE);
+	/* must initialize before using! but maxsize doesn't matter */
+	fh_init(&fh,0);
 	fh.fh_handle.fh_size = f->size;
 	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export = NULL;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 49468e478d23..eca577cf3263 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -290,9 +290,6 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			fhp->fh_use_wgather = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
 			goto out;
-		break;
-	case 0:
-		WARN_ONCE(1, "Uninitialized file handle");
 	}
 
 	return 0;

