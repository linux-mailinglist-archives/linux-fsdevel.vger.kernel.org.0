Return-Path: <linux-fsdevel+bounces-62648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B6B9B5A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26741BC1F56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6E32D5DE;
	Wed, 24 Sep 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUHRGFWC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8032CF62;
	Wed, 24 Sep 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737279; cv=none; b=tlCyhB9u1nDgN6IeNTf+Mi3U+l1A0f5naezT/rj9STLM1+pbzOBEQXjzkF2xQBXIgrfnP+Iy4KxMt69oGW6nJfb8yCCP/e0ogy6mPJz2BEpsxSiiCzrwS/HvTxtJZaSlj8qSGAwYAQZMLXnzDBnevO1RtSATs1HrbC8c3JsKW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737279; c=relaxed/simple;
	bh=Z3UMAzxGm3i4wJZpGYv0qnn3VbVaB61UVqmGkwfa8JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apfaYMUu2SbMcmgR7a/ye11GtGmYoawPP+rt8MKQZU7d15enfG1OKgrGDf7IOkTMFcGMsOgOKHYH+dVcnmesq1C2hpsS358T6kF0Gp8zdrHagTOmitYEHfIpXDTWiC+6ZOr1yCL9NhRvm2vC1rSEd1bl73YFkG/sg7c3EH56dVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUHRGFWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBF8C19421;
	Wed, 24 Sep 2025 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737279;
	bh=Z3UMAzxGm3i4wJZpGYv0qnn3VbVaB61UVqmGkwfa8JQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DUHRGFWCl7pJWEugoO/4mOtpq9EBWr/F23TkIp9V7KFk+cGAa1JMUv6peQDBAPM+8
	 FkbPDSCDiWUG6n12GYIMcjrtgN5d2WwuvyULFe22i3FVmVtBe2pcgROMX7TOvOvu1D
	 l+gP/gURUyW5GNZTO72LF3Ltxr2Cq+Ph1SVxDSAkbgJc+jAF/RAoexQrxVZUfWhv1v
	 ZB8Fl1yurJIFI9UTmAmWYw94hsElegtgrYu0wOT+z7bjlsW9oPuL/o10vfHas+u/LG
	 DHbkhhdzVlYE89+fO0GEfNH0mlCDsvFGSroQ3kU2sgI98A5xQQr+sQtxHy91/YYe0q
	 HYsdBsRYe9VlQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:16 -0400
Subject: [PATCH v3 30/38] nfsd: add helper to marshal a fattr4 from
 completed args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-30-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3503; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z3UMAzxGm3i4wJZpGYv0qnn3VbVaB61UVqmGkwfa8JQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMQRc16ykCn/Jr1MPeUXrGeEsBatqqAtUnDd
 jNHs3Yj46GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEAAKCRAADmhBGVaC
 FT/oD/0dnQZLbzhF4JYHcgCLeenPT5jeYRMBzGaLSyj/cRQ6+u2MPbzYfwt1jrPgKKf/Tnt/J+P
 xail/Qx1a2pID/Bcgg9Ucv/hM90x/VYICu8El2VUcNpmTfKQRrZE7LWsGtEUOBVA16oMKrGcl3/
 U6mp29V/FcaUlRYrB0KQPLItJvoQ6X9YHTZU6HzZ3t0Qo/SwigmxR91byXbswYqN0LpcJykmR+g
 zPLhldvdqw0R01bec7jyHfrg3YsiVQgcar6vUuCAUgvZP55tqgxfkiTHt1LBpUAP7vfL+ykCHpt
 lypFrJKMOTPj87tuJU5IZ9fudolAhCrWmqL/ODnCOjW2obTpjXzZE5j0Hct8ioDWQ56I5TW0EUE
 xRtM1ggeTeZ+G0ntOeD2FYYxfyO8YkVTaOHgCYy2JVjwkwRkFd16gTVpiPbaYSUzIrsEgOLuj8M
 9JdjfYIzbSGc2qPKthW0mTGMsNkgxgNKLvSMSHQBLdxmJIAqNC6gTL+oz3uA3Wl594ONPyprwpJ
 NWFhjcqH7qSN8InkWt6VipgujZGhJpFkod7bl4NU+3QnEAiNQe4J/ymrN0O6OyaZntHGa9Dsq2M
 nGs2Uvv7qGk4TXjgYSHsqY0+o4P1e2hrEH9/vcFbjuDezbIfNw2OCCRO72q/3JWOdRdQ25S5Ayl
 SNvcdcWYmvdLWSA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Break the loop that encodes the actual attr_vals field into a separate
function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4a40d5e07fa3343a9b645c3b267897a31491e8e9..9a463f9c8a67704d90d1551b7de59e4e89a2a81d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3565,6 +3565,22 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
 };
 
+static __be32
+nfsd4_encode_attr_vals(struct xdr_stream *xdr, u32 *attrmask, struct nfsd4_fattr_args *args)
+{
+	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
+	unsigned long bit;
+	__be32 status;
+
+	bitmap_from_arr32(attr_bitmap, attrmask, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
+	for_each_set_bit(bit, attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
+		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, args);
+		if (status != nfs_ok)
+			return status;
+	}
+	return nfs_ok;
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3575,7 +3591,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    struct dentry *dentry, const u32 *bmval,
 		    int ignore_crossmnt)
 {
-	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
 	struct nfs4_delegation *dp = NULL;
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
@@ -3590,7 +3605,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	unsigned long bit;
 
 	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
 	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
@@ -3710,27 +3724,22 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
 	/* attrmask */
-	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
-				      attrmask[2]);
+	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1], attrmask[2]);
 	if (status)
-		goto out;
+		return status;
 
 	/* attr_vals */
 	attrlen_offset = xdr->buf->len;
-	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT)))
-		goto out_resource;
-	bitmap_from_arr32(attr_bitmap, attrmask,
-			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
-	for_each_set_bit(bit, attr_bitmap,
-			 ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
-		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
-		if (status != nfs_ok)
-			goto out;
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT))) {
+		status = nfserr_resource;
+		goto out;
 	}
-	attrlen = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
-	write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, XDR_UNIT);
-	status = nfs_ok;
 
+	status = nfsd4_encode_attr_vals(xdr, attrmask, &args);
+	if (status == nfs_ok) {
+		attrlen = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
+		write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, XDR_UNIT);
+	}
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (args.context.context)
@@ -3747,9 +3756,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 out_nfserr:
 	status = nfserrno(err);
 	goto out;
-out_resource:
-	status = nfserr_resource;
-	goto out;
 }
 
 static bool

-- 
2.51.0


