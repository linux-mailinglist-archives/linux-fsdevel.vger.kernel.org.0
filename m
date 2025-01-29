Return-Path: <linux-fsdevel+bounces-40328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A3A22423
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BCB1882E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40471E1C1F;
	Wed, 29 Jan 2025 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nil8+TCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085518FDC5;
	Wed, 29 Jan 2025 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176281; cv=none; b=i8AcRNXD6kk9EsTzBSwUlvDf/dMTrT7XytDxwLZqbENpJybComgeeGL6dnZbqpmk327mhOWU/0A5AXZaCzoDoNhnVXbiRFve/HomO2185PODrvWSxuNM5MPptdjOAgxjT2jpTLqgtLASoehxyL4k+rtxQsMJAlvmx3HWEnruzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176281; c=relaxed/simple;
	bh=Ut+u/BkghibRCg6WC/EafaFzkHC5LZJoyj6kdsD537M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nxfrw7yQkes7lObsfN7+TV6hWcCRf+zA9XlgNcoIohxCYcBXioVSrHWItIla3436d8WKnXieiNbo5Zx3/bGYLulZA8dWcmoXoZTJQJnrGPO7uqsqz6YJQPGVva2OxUMO2Z0Tsj0jGaOPKaT92vN8EmcgOOS7XM1EaP9X4Mgv0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nil8+TCi; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OGdOG3Q9V4PrJNPGFlWOlSIJqfpT6i27AEwfO3lbbWQ=; b=nil8+TCiLuCxkyQ5sycHDYXRpW
	XzrknXAppAxQgkC6YQuF6dVMraOHJwKBCeGf39QSn5ns1MWBz0pZDKze+zNcRK8+dsV24qJgA/TDk
	nO7KLFpzPM7LgobaUyt4kcRy0tUvRKyUiLaFWBlU7P5+QPNWCwnMUtGuiM3JQsYZgdjRt0z1nHe4j
	1XuVshYkoC5bPw8f6Xs9k/lo4UCHWwzGGDF9Y1X+QvmEPiBa5O4pC3MNOHUM/uOVuixph9nX08kXO
	EVCZoJZyUSdVusv3r7w36Ki068nduW1WAvoCzpUf/FE94NhGFd+GHA2aylGaUh8x3yGJxoSiB9/U+
	UBzyqj9g==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tdD34-000ibk-UJ; Wed, 29 Jan 2025 19:44:32 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Teng Qin <tqin@jumptrading.com>
Subject: [RFC PATCH] fuse: fix race in fuse_notify_store()
Date: Wed, 29 Jan 2025 18:44:20 +0000
Message-ID: <20250129184420.28417-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace filesystems can push data for a specific inode without it being
explicitly requested.  This can be accomplished by using NOTIFY_STORE.  However,
this may race against another process performing different operations on the
same inode.

If, for example, there is a process reading from it, it may happen that it will
block waiting for data to be available (locking the folio), while the FUSE
server will also block trying to lock the same folio to update it with the inode
data.

The easiest solution, as suggested by Miklos, is to allow the userspace
filesystem to skip locked folios.

Link: https://lore.kernel.org/CH2PR14MB41040692ABC50334F500789ED6C89@CH2PR14MB4104.namprd14.prod.outlook.com
Reported-by: Teng Qin <tqin@jumptrading.com>
Originally-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

Instead of sending the usual 'ping' to the original thread, I've decided to
resend the patch as an RFC.

As I mentioned before, this is an attempt to forward port the original patch
from Miklos to the folios world.  Also, the same question:

if we fail to get a folio and need to skip it, 'this_num' needs to be
updated; but I'm not 100% sure if it's OK to use PAGE_SIZE in that case.

Obviously, libfuse will need to support this new NOWAIT flag (I can look at
that, of course).  But I was wondering if the NOTIFY_STORE behaviour
shouldn't *always* skip locked folios instead of doing it only when the flag
is set.

(By the way, I'm not sure if I'm using the 'Originally-by:' tag correctly;
I just want to make sure the authorship is preserved.  Please let me know if
that's not correct.)

Cheers,
-- 
Luis

 fs/fuse/dev.c             | 29 ++++++++++++++++++++++-------
 include/uapi/linux/fuse.h |  8 +++++++-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..9a0cd88a9bb9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1630,6 +1630,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	unsigned int num;
 	loff_t file_size;
 	loff_t end;
+	int fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
 
 	err = -EINVAL;
 	if (size < sizeof(outarg))
@@ -1645,6 +1646,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 	nodeid = outarg.nodeid;
 
+	if (outarg.flags & FUSE_NOTIFY_STORE_NOWAIT)
+		fgp_flags |= FGP_NOWAIT;
+
 	down_read(&fc->killsb);
 
 	err = -ENOENT;
@@ -1668,14 +1672,25 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		struct page *page;
 		unsigned int this_num;
 
-		folio = filemap_grab_folio(mapping, index);
-		err = PTR_ERR(folio);
-		if (IS_ERR(folio))
-			goto out_iput;
+		folio = __filemap_get_folio(mapping, index, fgp_flags,
+					    mapping_gfp_mask(mapping));
+		err = PTR_ERR_OR_ZERO(folio);
+		if (err) {
+			if (!(outarg.flags & FUSE_NOTIFY_STORE_NOWAIT))
+				goto out_iput;
+			page = NULL;
+			/* XXX */
+			this_num = min_t(unsigned int, num, PAGE_SIZE - offset);
+		} else {
+			page = &folio->page;
+			this_num = min_t(unsigned int, num,
+					 folio_size(folio) - offset);
+		}
 
-		page = &folio->page;
-		this_num = min_t(unsigned, num, folio_size(folio) - offset);
 		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		if (!page)
+			goto skip;
+
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, this_num, folio_size(folio));
@@ -1683,7 +1698,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		}
 		folio_unlock(folio);
 		folio_put(folio);
-
+skip:
 		if (err)
 			goto out_iput;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e9e78292d107..59725f89340e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -576,6 +576,12 @@ struct fuse_file_lock {
  */
 #define FUSE_EXPIRE_ONLY		(1 << 0)
 
+/**
+ * notify_store flags
+ * FUSE_NOTIFY_STORE_NOWAIT: skip locked pages
+ */
+#define FUSE_NOTIFY_STORE_NOWAIT	(1 << 0)
+
 /**
  * extension type
  * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
@@ -1075,7 +1081,7 @@ struct fuse_notify_store_out {
 	uint64_t	nodeid;
 	uint64_t	offset;
 	uint32_t	size;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_notify_retrieve_out {

