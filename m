Return-Path: <linux-fsdevel+bounces-62651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F9B9B5EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6AF2E5C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C37D32ED5E;
	Wed, 24 Sep 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5ugq89D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEF32ED3B;
	Wed, 24 Sep 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737289; cv=none; b=tweDffNOFEzZYnBSyP3uUIFMXxFntvjtuK5oQ1ZFjSozG0dqbd/xU3Qu9GMhioAtlpl9OYAxueoy0d9ly285Onlesaej3bMWGb92RNrEWOUL/XZx5jcxdr1HDiNB5gKy2OIPD5xPD9kyy/tz2zEk1jXS0Zjtsp5Q7gd3MCI4LS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737289; c=relaxed/simple;
	bh=y8mQUt4ubFTAVWBVPJkBIXoCbxxWsnY4tR7mdmIz2dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWr/2xqAHqcU+r0XXU2+EA5y09usaa/4zn0gYHGPjqoZPjWIV6Y5vNi4ubfqfY8eFsNfAGjU2jlct8pI4SgS+zc+x8HI2xFnSg/QZQoq028vLXql3OonE/zr7s5byDDTWRLDUR7mGgqfcGe85p7itgU/Olr2Q1V9vo1Eojnuu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5ugq89D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40352C116C6;
	Wed, 24 Sep 2025 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737289;
	bh=y8mQUt4ubFTAVWBVPJkBIXoCbxxWsnY4tR7mdmIz2dw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k5ugq89DFkIZmTD+MpdsVYZv2uT7V36QDH7Q6PjEktbZdu6C5rzxvWwn4vhPpBx6R
	 dANpB7fpxZu9xI04BTXLxwSH/QfKewruITyXxQzQplMkCb++e0U1GcLVbtvl2sh2pb
	 5P1zyyCcKDXGjRKBNwLrwfgVcxOJZVj+RA57J9IHTNik598Q3+diZgmb6Fa8AgwMpI
	 UR3g2sU35vR9I5MBr9y52Oti4ILikQBUCY0agKsxtGQitc2cX/bpJXaoqeustSai6P
	 /w14ciTAQGZQP3IQj2lCznMU8P+8m9PmeU8jGNuCBemrHgffj0YHzElKhVjh29iA2h
	 /KxtrDappDyqw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:19 -0400
Subject: [PATCH v3 33/38] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-33-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=y8mQUt4ubFTAVWBVPJkBIXoCbxxWsnY4tR7mdmIz2dw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMRFMBL+ANAxN5ItGjhz42F8p5Mc2UeHG9yU
 Wit4EpL5P+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEQAKCRAADmhBGVaC
 FV+FEADQSdYQLXkEmAWO3LOSqlsKm339R0KT6cgxDOQrWGJZErkbBMdhPj4djM0yExQpnuvEOef
 s2Z8xgcOKTQOXUxVDricbqkOZDclGm0dElZSQHwz5XbQLjT072t7g+K+ik39fGL5flzG2MvNg6o
 jXZD+4GQkkdBcriP3/1psugz/kaiLc+R4OEI8NrV5Em+vYPT3GgHUS14w/IBVqJO4QAH7YFUsRA
 dXDpvA7B6PPZRWCHbmfUwFGdVyRQSheV8FlnsNVdupcEKUWvHGN9GJeLaWrO+vPX3RYDZZ9OKgH
 hrlazePROVsoSqb2YGhttR79VTm+ihUem+GuyS1PM/CO6wz61dvV2p0UyE2l5vxpV6e9g5q5Rro
 Q/ObliBTbeQBSl9oluq50IFm5hbQj0uNd+BsEmniwFlKCi4v1/kT16KHKc2gRqy2SyLwSINdviT
 dzk13dXEBOq7/ScehuvnCWG13mvRDw7LsdboScW9FXraTZ/Hh61vbhxP5YHhK/0jdBLp9gaGhWz
 sCXmo1kdT6GeBrwagmZDT8Pbpk8UoVeEIj6K9RICqn1B4OkHrAgxyq39N+SiHZxJSTFYGSrrweH
 rEQ0bSiXHHeRK7ycSZa1ylYIemvAJVQP6XbugW93x4R7hM4E9VE+fXNkHvxlnf0qNIaqqKkjvjz
 VFOdITkXPU44SqQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The current fattr4 encoder requires a svc_fh in order to encode the
filehandle. This is not available in a CB_NOTIFY callback. Add a a new
"fhandle" field to struct nfsd4_fattr_args and copy the filehandle into
there from the svc_fh. CB_NOTIFY will populate it via other means.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1db2bd974bfa9d899f590f4b4e869115ab73aff6..822a9d47dd88df579e4f57f04dd6737653f71c94 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2561,7 +2561,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+				   const struct knfsd_fh *fh_handle)
 {
 	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
 }
@@ -2924,6 +2924,7 @@ struct nfsd4_fattr_args {
 	struct svc_fh		*fhp;
 	struct svc_export	*exp;
 	struct dentry		*dentry;
+	struct knfsd_fh		fhandle;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -3129,7 +3130,7 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, &args->fhandle);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -3678,19 +3679,23 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (err)
 			goto out_nfserr;
 	}
-	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
-	    !fhp) {
-		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
-		status = nfserr_jukebox;
-		if (!tempfh)
-			goto out;
-		fh_init(tempfh, NFS4_FHSIZE);
-		status = fh_compose(tempfh, exp, dentry, NULL);
-		if (status)
-			goto out;
-		args.fhp = tempfh;
-	} else
-		args.fhp = fhp;
+
+	args.fhp = fhp;
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID))) {
+		if (!args.fhp) {
+			tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
+			status = nfserr_jukebox;
+			if (!tempfh)
+				goto out;
+			fh_init(tempfh, NFS4_FHSIZE);
+			status = fh_compose(tempfh, exp, dentry, NULL);
+			if (status)
+				goto out;
+			args.fhp = tempfh;
+		}
+		if (args.fhp)
+			fh_copy_shallow(&args.fhandle, &args.fhp->fh_handle);
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.51.0


