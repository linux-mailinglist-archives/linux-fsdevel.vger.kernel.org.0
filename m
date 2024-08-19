Return-Path: <linux-fsdevel+bounces-26289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104DE9572CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04AD284909
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D51898F0;
	Mon, 19 Aug 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kegi7j+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3A189517;
	Mon, 19 Aug 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091476; cv=none; b=N+uRLAbhDEu2/DQGwp7wCPL7nK8cnhvKVqEUMVHt0Om7Y0GrzGeppSaAMPS0+P1/xCwgoX9MYq/aM+wdGrPGNKFm6qQwr0rsdfgj9j063qafrQ+G0V3r4bb0C7GvxpPRjZxaNA5aDkQWVWblKHrCFADt/DSmdBoxEz2BPtDXDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091476; c=relaxed/simple;
	bh=UKCjVhygcTf0F6+tr/Rm6lVEtvk5t+MoIGPRMLHRf0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9xude6Btn5cFu+43dBuQRKYm97JRV3qDGwQwrxPiDMh5gqn+5jZMaZDE7OKwtBdcwTOcnr+pX+MtCdu0Lmg89aSQlvXZXMWYUxhC3nhxcBO8IEr66S4+5Y8IzXWC0Ud5WAgSTU0J8Kb5dC0iP4XvXOI1hg8nDJ6HOm/PIsUMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kegi7j+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B25C4AF11;
	Mon, 19 Aug 2024 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091475;
	bh=UKCjVhygcTf0F6+tr/Rm6lVEtvk5t+MoIGPRMLHRf0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kegi7j+J+yVtai8IFiJa2JFICr5hdhIObLFGBOK2IPKxlZupRllmAwGmYVVAMhnSf
	 BM+0V8N2M57vCesxzW7HVIbP5vInRwFOhiZ1vtOJAOvZWLEpv48fxd1tg42q9nHwGk
	 SUFeCPs3JUySlLfc/nKg9A7KIcRlKa6/i5ouI8SZwCrap77DtEuluL3uEKpqrnr8YW
	 7CKoGqydVLDiHdFO4tVcKwkFDS3HM0lOGFtt8QY5Y9d3j7f2kvz+MPb/EhazS1X0dV
	 snbFgEFCVN3BlfSxpTPUIQ3DCb+8xZEa65nv5ZxlQUdSVtz5sFojS76EWQyj5tx2FJ
	 Ed6I/Ij2Ak7xg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 03/24] nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
Date: Mon, 19 Aug 2024 14:17:08 -0400
Message-ID: <20240819181750.70570-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminates duplicate functions in various files to allow for
additional callers.

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 ------
 fs/nfs/nfs4xdr.c                       | 13 -------------
 include/linux/nfs_xdr.h                | 20 +++++++++++++++++++-
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 39ba9f4208aa..d4d551ffea7b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2086,12 +2086,6 @@ static int ff_layout_encode_ioerr(struct xdr_stream *xdr,
 	return ff_layout_encode_ds_ioerr(xdr, &ff_args->errors);
 }
 
-static void
-encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void
 ff_layout_encode_ff_iostat_head(struct xdr_stream *xdr,
 			    const nfs4_stateid *stateid,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 971305bdaecb..6bf2d44e5d4e 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -972,11 +972,6 @@ static __be32 *reserve_space(struct xdr_stream *xdr, size_t nbytes)
 	return p;
 }
 
-static void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
 	WARN_ON_ONCE(xdr_stream_encode_opaque(xdr, str, len) < 0);
@@ -4406,14 +4401,6 @@ static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
 	return 0;
 }
 
-static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
-{
-	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0))
-		return -EIO;
-	return 0;
-}
-
 static int decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	return decode_opaque_fixed(xdr, stateid, NFS4_STATEID_SIZE);
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 45623af3e7b8..5e93fbfb785a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1853,6 +1853,24 @@ struct nfs_rpc_ops {
 	void	(*disable_swap)(struct inode *inode);
 };
 
+/*
+ * Helper functions used by NFS client and/or server
+ */
+static inline void encode_opaque_fixed(struct xdr_stream *xdr,
+				       const void *buf, size_t len)
+{
+	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
+}
+
+static inline int decode_opaque_fixed(struct xdr_stream *xdr,
+				      void *buf, size_t len)
+{
+	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
+	if (unlikely(ret < 0))
+		return -EIO;
+	return 0;
+}
+
 /*
  * Function vectors etc. for the NFS client
  */
@@ -1866,4 +1884,4 @@ extern const struct rpc_version nfs_version4;
 extern const struct rpc_version nfsacl_version3;
 extern const struct rpc_program nfsacl_program;
 
-#endif
+#endif /* _LINUX_NFS_XDR_H */
-- 
2.44.0


