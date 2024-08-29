Return-Path: <linux-fsdevel+bounces-27716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7B963754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF7F2838A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D9C33998;
	Thu, 29 Aug 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij1AZun/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580B224D6;
	Thu, 29 Aug 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893469; cv=none; b=RmQe1PqlVAvm5vyJmpNCxzI9jVFiqwdhrAkVKw30kY9/hAPAVjA541ztLhc+MaoEXfctb7IOywu12EvfMBG6u2Al/LbzRKynur8KtOw1KgLpbo1d7nbWK3H3DeVp0JMT7o0yZ7uxo2OwxZC1JWPSFoFw2SrSiUlT8A063vhl1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893469; c=relaxed/simple;
	bh=UKCjVhygcTf0F6+tr/Rm6lVEtvk5t+MoIGPRMLHRf0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhuLJa2ltkCP6JbotR61U6dABMbAUmL9VktSsC8XhGOuTREd6DCKxyIX20g5M/Spb0YCxMfN6dvi8qT2Vfee6h4Lwc/2pZiW2hpw3RL0+0W+eFx6MXa0b6KdyjRwm8klGugNm4E2Nj6zJnFuH9jvY1avPA4LNnqdTrfZzskn5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij1AZun/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402F2C4CEC2;
	Thu, 29 Aug 2024 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893469;
	bh=UKCjVhygcTf0F6+tr/Rm6lVEtvk5t+MoIGPRMLHRf0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ij1AZun/SbcdFvny9Nf0bwm403rY/+mbXOFzRWTjLqI0Idr0u6ejWVO1zrkdvbOIu
	 aLtQlcp8yBf90ZJfWvJrg/9bMncdOe2350s118up83HFlUefg00Vi1EjU6Z8J0HrSQ
	 cVVl4y8cExCFqYj/NqmAIuh4Xe4cf1sLQiwCKHcAtcPpdfx9kI7MqpAs20HU2CJbK4
	 vV2tcMoPa2rxQE5ZbqWYsWQ/pNCqr4vCe4i76Befx5O+soqZtto/R9t7owTRhrtFo5
	 YnvVA/yWcUJsjO5q3smS6admt5aPgsn2zUkDSYQCI4v6IdunwhZ7S29N5bSvPZJSqu
	 GRUJxIRmZ5OcA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 03/25] nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
Date: Wed, 28 Aug 2024 21:03:58 -0400
Message-ID: <20240829010424.83693-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
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


