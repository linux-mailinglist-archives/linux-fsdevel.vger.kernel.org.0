Return-Path: <linux-fsdevel+bounces-27838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B417C964687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78CE1C233B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24E1B29B1;
	Thu, 29 Aug 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXSQTtAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFE1B1D7E;
	Thu, 29 Aug 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938022; cv=none; b=RBlRq7HU1LOsL58PxIZLpUhT9ahaKpE8Xc+gUoogPJlADdQtgxaP3b8AizG8Eu5MKixkedHMqCzoyhvc0YIuzpIExb2tloN8VEU1UcBEFzINRkkxKPb9aKzmLhMfmqZWIMg2BqNTswZXDGirVsRNAqgHKs3EuD/07QZwG/jVCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938022; c=relaxed/simple;
	bh=pVaH1LHqhdQGUFEAQ7AUGt94Yn7itEwch5SjAslcLWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBrTDNPiBjHpHALimGjiPOctVke7JHWCZv4AQ3h1ftSfDrT8ynFhi7lqAnlPWe1WYPIgTx6LnEUbFd0e2DySrOmthbOR47OmZ1NNkBwjY2+O7YDoCGYO1M+kLlq9NMkUDWE+lCSogW/gjlEQKgHSlnwz3dfeReGbkYaZVHDCMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXSQTtAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973D5C4CECA;
	Thu, 29 Aug 2024 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938022;
	bh=pVaH1LHqhdQGUFEAQ7AUGt94Yn7itEwch5SjAslcLWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZXSQTtAMW3s3v5hD8FpaNzbUYsx6fnCvUqsWjOI8yeDmMaasYr6wIVrWLFAHXJ6ub
	 vUlMFV/tZfgYV+5f1zMdHSdZNYQUkPb4lXUDysxM0gkNYXcEoKkjrD+jwHI+5FQDGi
	 9ltPiC4iV4yt1ckxLccm287cgqIarLD0qgBJ+AL7IfmtPh2IkKNnDbyv2xNG+YHHqO
	 xWiRa/8yDzPp/iraGRkilpo6VPXVeaP1OnCB+vkb2EUha4dPc2yTT0lNohPmPpa0s9
	 /NxvYBSKGG27z41MIDQhx+b3J30tVyAoSMCXsST6b7R7Oehjz2RwGo/jQWvDBeTx46
	 yYGQxWj8vsskw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:45 -0400
Subject: [PATCH v3 07/13] nfsd: fix reported change attr on a write
 delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-7-271c60806c5d@kernel.org>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
In-Reply-To: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pVaH1LHqhdQGUFEAQ7AUGt94Yn7itEwch5SjAslcLWU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcXlKGLUObjKw7MftfDofvktAwCy2viFC5hn
 YwULaJq1umJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 FWHPD/4iUbrED2lUz4EZc+7rrCLF0oz1vmu3SmI2Cv398d5UaPXw2JMOy9jNhIsYDqGWXezHMB3
 CJzAQe0zzdlUrNKoXxS4khOSdOaYM2Yzg/CWKN0zc1MaxCmw8UaARPC6FCFjVJYYBxI5eWI13WD
 QSYwuHnwxE5O7kW4QK9TTsu6UXGpW83w2pQpzrJFsT6iS8Hgl1+viG6OZZxIvHAPUd/LOafBil/
 cSvLjQ9JZ61EVgE5DU0NfEcKw9udMJENKnREDJfq4FFk12zxDIQ4pqfK4nsA3QIRHtbub6s5fzT
 aEjkRfptwVGOhzOEeR0SS0fjZE04cUfcOgxtY7XxGRCRV5jyyNIXpD3QDntIVWmFhEhfZ519ddG
 Or4JowxCUYDqJZrwvEkCYwT3fRDh4xjfXNwBKYn2hINcumHB0ugt3P3xfQPd3XORxBVWhcJaVpY
 exB+uiSrk9CSnBU7+l4JOZDlQQT5YO2XrUSuqa15nztsUz3xQ6TpkeFRICFfzPgEe9K2gP3OYEG
 NDPVadUtTFGLaGCXrmSrF2oIJrgMVLwSxpCyCb3Ool4qnwLDhh6aYbLY8VScuJfSt4DS6ugxa/J
 VKwiN9V3bbOh9B981Rqde9BtCrWooUu0ax83rXy8XUgx1myyO1E0Urgg7Behtjmyj4cJtLp/cop
 JK7emeqGkmG0Mdg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If there's a write deleg outstanding and there are no writes yet from
the client, we'll currently just report the old, original change attr.

RFC 8881, section 10.4.3 describes a way to report the change attribute.

When there are no writes from the client yet, but the reported change
attribute in a CB_GETATTR indicates that the file has been modified,
then report the initial change attr + 1.

Once there have been writes from the client, use the value in the inode
instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ccaee73de72b..a9827bb8a2f0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2928,6 +2928,7 @@ struct nfsd4_fattr_args {
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
+	u64			change_attr;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	void			*context;
 	int			contextlen;
@@ -3027,7 +3028,6 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 					 const struct nfsd4_fattr_args *args)
 {
 	const struct svc_export *exp = args->exp;
-	u64 c;
 
 	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
 		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
@@ -3038,9 +3038,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 			return nfserr_resource;
 		return nfs_ok;
 	}
-
-	c = nfsd4_change_attribute(&args->stat, d_inode(args->dentry));
-	return nfsd4_encode_changeid4(xdr, c);
+	return nfsd4_encode_changeid4(xdr, args->change_attr);
 }
 
 static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
@@ -3562,12 +3560,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	err = vfs_getattr(&path, &args.stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
 			  AT_STATX_SYNC_AS_STAT);
+	args.change_attr = nfsd4_change_attribute(&args.stat, d_inode(dentry));
 	if (dp) {
 		struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 
-		if (ncf->ncf_file_modified)
+		if (ncf->ncf_file_modified) {
 			args.stat.size = ncf->ncf_cur_fsize;
-
+			/* If there have been no changes, report the initial cinfo + 1 */
+			if (args.change_attr == ncf->ncf_initial_cinfo)
+				args.change_attr = ncf->ncf_initial_cinfo + 1;
+		}
 		nfs4_put_stid(&dp->dl_stid);
 	}
 	if (err)

-- 
2.46.0


