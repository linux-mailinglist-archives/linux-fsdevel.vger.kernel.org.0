Return-Path: <linux-fsdevel+bounces-71132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52670CB6552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A85330220C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A094314A6A;
	Thu, 11 Dec 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4AH/VHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9093148A0;
	Thu, 11 Dec 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466518; cv=none; b=KGK/Ls7os49h81zwsD/x1q3GaqNnUsy03R5dZ2TlDeV5fecdJG0rHD5fq0EiSxEY5MWkYseanrm5+Gv24WSNKZa+VG8zWd3i+eUrYwUWmyFl1E2tEWiS2mk0D5vS6I5t+Eb0J4PUIByfuCxOXqHoHtjiLAyrxMi9LXj/XBJhsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466518; c=relaxed/simple;
	bh=cBQ7OwxCQJmyRnBB78Msff46NnL6E68T38nm8NO24nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXfwGuKHwXAe/RQFDnJeKd5zSQibNXwddvJMk0fVc32Iu2SB0I+kznuGb3VmbFERw431mY1x568x3Dux1m+wEX2y8X2sdAcDvvRD+j7LcGt3ioMaEutUAESSmQDMcAv7IyPDOqjSJgPggh4xVN1iw+beUcN4Y0uAiRZRkvfGSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4AH/VHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61525C16AAE;
	Thu, 11 Dec 2025 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466518;
	bh=cBQ7OwxCQJmyRnBB78Msff46NnL6E68T38nm8NO24nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4AH/VHTRJQ2E11//4xXPtHcDqYx6hvHuGFjclBd+irtPAI7C1nNdhc1dyWMjnW00
	 OXeCbztIERWLDCzlxhb6txxL6UGHnCczW9FC7FhdR0rkdAGd2EhKGP9ZT2oT6RGaid
	 N6DgberopwgdLk/w4u4ynLdtTbSzKgN3HTJTjSZ1owilOgEFYoP1nRqnXXFohTwl9k
	 t5z7PRFM8rzq0JH0KeXjs5rlmXSXqSmpS6IitF1bHPLakO2vnOCf/covPTLFNMmNKY
	 JXqTgX4lLENYAB9XUcXHjer+nD5SrJ6V5d0xhFO1dyKayhUOWz1mJfoSLy2hXWAZqX
	 sM8HmWJH6cTUw==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 6/6] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
Date: Thu, 11 Dec 2025 10:21:16 -0500
Message-ID: <20251211152116.480799-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211152116.480799-1-cel@kernel.org>
References: <20251211152116.480799-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Replace the hard-coded values for the NFSv4 case_insensitive and
case_preserving attributes with dynamic values retrieved from the
underlying filesystem via vfs_get_case_info().

This allows NFSv4 clients to discover the actual case sensitivity
behavior of exported filesystems, including per-directory settings
for filesystems like ext4 with casefold support.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 67bb9c0b9fcb..0c51d390d995 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2933,6 +2933,8 @@ struct nfsd4_fattr_args {
 	u32			rdattr_err;
 	bool			contextsupport;
 	bool			ignore_crossmnt;
+	bool			case_insensitive;
+	bool			case_preserving;
 };
 
 typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
@@ -3131,6 +3133,18 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_case_insensitive(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, args->case_insensitive);
+}
+
+static __be32 nfsd4_encode_fattr4_case_preserving(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, args->case_preserving);
+}
+
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
@@ -3482,8 +3496,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_ACLSUPPORT]		= nfsd4_encode_fattr4_aclsupport,
 	[FATTR4_ARCHIVE]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_CANSETTIME]		= nfsd4_encode_fattr4__true,
-	[FATTR4_CASE_INSENSITIVE]	= nfsd4_encode_fattr4__false,
-	[FATTR4_CASE_PRESERVING]	= nfsd4_encode_fattr4__true,
+	[FATTR4_CASE_INSENSITIVE]	= nfsd4_encode_fattr4_case_insensitive,
+	[FATTR4_CASE_PRESERVING]	= nfsd4_encode_fattr4_case_preserving,
 	[FATTR4_CHOWN_RESTRICTED]	= nfsd4_encode_fattr4__true,
 	[FATTR4_FILEHANDLE]		= nfsd4_encode_fattr4_filehandle,
 	[FATTR4_FILEID]			= nfsd4_encode_fattr4_fileid,
@@ -3669,8 +3683,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (err)
 			goto out_nfserr;
 	}
-	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
-	    !fhp) {
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID |
+			    FATTR4_WORD0_CASE_INSENSITIVE |
+			    FATTR4_WORD0_CASE_PRESERVING)) && !fhp) {
 		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
 		status = nfserr_jukebox;
 		if (!tempfh)
@@ -3682,6 +3697,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = tempfh;
 	} else
 		args.fhp = fhp;
+	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
+			   FATTR4_WORD0_CASE_PRESERVING)) {
+		status = nfsd_get_case_info(args.fhp, &args.case_insensitive,
+					    &args.case_preserving);
+		if (status != nfs_ok)
+			goto out;
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
-- 
2.52.0


