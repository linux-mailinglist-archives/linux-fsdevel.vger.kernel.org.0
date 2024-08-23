Return-Path: <linux-fsdevel+bounces-26962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54FE95D4F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEFE1C21D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1507119258E;
	Fri, 23 Aug 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyERu4wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0242A9F;
	Fri, 23 Aug 2024 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436869; cv=none; b=rerVaTRWchAXOUirK56Icaleh+aSfxHOZLwUFxZQr4i58K+TNcSprUuwyJScazE5FJ0T5FqGO9r5GkMX6sF4jAtf/lGsGkKfLN53pYIxlflYdYyJqRVA2Vz6VC+FLoi8vHiEh2b/qlJ0vKXB7BNvZRG9FljuHV6EVuma6V5Ej+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436869; c=relaxed/simple;
	bh=UKCjVhygcTf0F6+tr/Rm6lVEtvk5t+MoIGPRMLHRf0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2tIJcu0JFBVJlV4JHjhbqAbxXaKH3tB2ZPEOhSLFOYFnoJJ1bYj6sZftzD9rmftnhrUkpYPrNUKvYSSbYNyU2m3lfQTJi/uu06phZpHgIdme8lEMTyLKsF/KqjYOzzZ2MEDmyL9EFS4UNMAesk+xQcUV0FiRw1KkSSCUdD0uwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyERu4wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBB3C4AF11;
	Fri, 23 Aug 2024 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436869;
	bh=UKCjVhygcTf0F6+tr/Rm6lVEtvk5t+MoIGPRMLHRf0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyERu4wn9g9MQp4oBiKA/lKLqnaAEDHvwfC6knlZxSIMSDE8RPYbymnFU/ZIxTZnA
	 6Wn9ePwoTIc+q1/r/WDQUDBwKtJas1Ry0GsEvag84w4INxfqADVognLmp5s8BJwLdd
	 hxBsDPcBptUnocfGBzFp2ELmkPjT30rBFVsnh56CZ1htjI1bMPAICUXYQamMB+CVE+
	 DgaOCGlfn1iFImW+kZxw258QY/Xzp3cx17DhtAwnjD5rGN/p9ZTeTdb/iQdOpZxqXf
	 ic9JMQhlPSFx/ZfIH0+tIfX6tFKzkO6jTTuMnpn9a9KTtbw+h+OE4MOnUnXIDc24nV
	 DcV+BTogspIwg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 03/19] nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
Date: Fri, 23 Aug 2024 14:14:01 -0400
Message-ID: <20240823181423.20458-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
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


