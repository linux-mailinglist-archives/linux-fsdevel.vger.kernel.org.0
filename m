Return-Path: <linux-fsdevel+bounces-43297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E625EA50CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35987189312D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041222571BD;
	Wed,  5 Mar 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/b1r7ll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77218DF73
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207660; cv=none; b=MEi522beAr+LvsDlk0JVT4RrsYZohsk9z78lEoi+HLlvwp51gUHk73gIrjDa/imKfg0nIjgkvPBHkHU2F/97bgw5dgRZRRNK6enkMoNQz7a38JDccbMFkvFqfQ37FP2YqK8uwN+dAoCgIPlSichF0dGwCGPFsi89h0sW3DqCDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207660; c=relaxed/simple;
	bh=CZwRZM0JGepXYBodsXzTH0tXQB27XfMl4/9vli8r314=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RB5ggB9Ubm2ZQWIpo6WDGCSMOEPg5hSoyQVOP84PokRIco+Yq4Q6e00/MJeqobJ9H8AzBXqQNTTUtzPZ1g9+WlarEmW/nhwEEbo2FuOnckAdbc+GLTgRDPjViSyh7uLO0CROsYLmOvAq6gmuXGmhvH3EZ0lfVuKU2Gi9ETwou3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W/b1r7ll; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=tJpuebJhSuz4wsfowZF8peK48yQJiiHPMRRBEl8mVqA=; b=W/b1r7llv8Nty+1s6XGHKA+Cty
	jSJHx3GRs3e1cUnpQeQw7lUMYzuan1kOUG1IEY7xJh2Lied8+51cpWdbS2ePFdGsfewRq3fv0Kkiy
	gQHm1hWDC+vh0l9lh4hTdJhzdywaEHNxpqYinwZoZ7wFNvFPeqirxLF7TZjey03nyQgwXCd4JCoak
	/4ItZREXWtVQNLeA8sbXWF6dULam8xICWnVQGaiVo3AGPX4YHfiDUDkU8cjHVEtgd2s7AVNfa5xtg
	rtwIqEGxlkLnCD2R50KXQiQtg3Td4F8ZwON0a/m7IZeReyC7T6LTIOg21oZGYa1hThrYgaHFkNicJ
	yuTYYj2g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveT-00000006Bmw-05S8;
	Wed, 05 Mar 2025 20:47:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 2/9] orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
Date: Wed,  5 Mar 2025 20:47:26 +0000
Message-ID: <20250305204734.1475264-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Attempting to build orangefs with W=1 currently reports errors like:

In file included from ../fs/orangefs/protocol.h:287,
                 from ../fs/orangefs/waitqueue.c:16:
../fs/orangefs/orangefs-debug.h:86:18: error: ‘num_kmod_keyword_mask_map’ defined but not used [-Werror=unused-const-variable=]

Move num_kmod_keyword_mask_map, s_kmod_keyword_mask_map and
struct __keyword_mask_s to orangefs-debugfs.c which is the only file
they're used in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/orangefs-debug.h   | 43 ----------------------------------
 fs/orangefs/orangefs-debugfs.c | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/orangefs/orangefs-debug.h b/fs/orangefs/orangefs-debug.h
index 6e079d4230d0..d4463534cec6 100644
--- a/fs/orangefs/orangefs-debug.h
+++ b/fs/orangefs/orangefs-debug.h
@@ -43,47 +43,4 @@
 #define GOSSIP_MAX_NR                 16
 #define GOSSIP_MAX_DEBUG              (((__u64)1 << GOSSIP_MAX_NR) - 1)
 
-/* a private internal type */
-struct __keyword_mask_s {
-	const char *keyword;
-	__u64 mask_val;
-};
-
-/*
- * Map all kmod keywords to kmod debug masks here. Keep this
- * structure "packed":
- *
- *   "all" is always last...
- *
- *   keyword     mask_val     index
- *     foo          1           0
- *     bar          2           1
- *     baz          4           2
- *     qux          8           3
- *      .           .           .
- */
-static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {
-	{"super", GOSSIP_SUPER_DEBUG},
-	{"inode", GOSSIP_INODE_DEBUG},
-	{"file", GOSSIP_FILE_DEBUG},
-	{"dir", GOSSIP_DIR_DEBUG},
-	{"utils", GOSSIP_UTILS_DEBUG},
-	{"wait", GOSSIP_WAIT_DEBUG},
-	{"acl", GOSSIP_ACL_DEBUG},
-	{"dcache", GOSSIP_DCACHE_DEBUG},
-	{"dev", GOSSIP_DEV_DEBUG},
-	{"name", GOSSIP_NAME_DEBUG},
-	{"bufmap", GOSSIP_BUFMAP_DEBUG},
-	{"cache", GOSSIP_CACHE_DEBUG},
-	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
-	{"xattr", GOSSIP_XATTR_DEBUG},
-	{"init", GOSSIP_INIT_DEBUG},
-	{"sysfs", GOSSIP_SYSFS_DEBUG},
-	{"none", GOSSIP_NO_DEBUG},
-	{"all", GOSSIP_MAX_DEBUG}
-};
-
-static const int num_kmod_keyword_mask_map = (int)
-	(ARRAY_SIZE(s_kmod_keyword_mask_map));
-
 #endif /* __ORANGEFS_DEBUG_H */
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index f52073022fae..f7095c91660c 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -44,6 +44,49 @@
 #include "protocol.h"
 #include "orangefs-kernel.h"
 
+/* a private internal type */
+struct __keyword_mask_s {
+	const char *keyword;
+	__u64 mask_val;
+};
+
+/*
+ * Map all kmod keywords to kmod debug masks here. Keep this
+ * structure "packed":
+ *
+ *   "all" is always last...
+ *
+ *   keyword     mask_val     index
+ *     foo          1           0
+ *     bar          2           1
+ *     baz          4           2
+ *     qux          8           3
+ *      .           .           .
+ */
+static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {
+	{"super", GOSSIP_SUPER_DEBUG},
+	{"inode", GOSSIP_INODE_DEBUG},
+	{"file", GOSSIP_FILE_DEBUG},
+	{"dir", GOSSIP_DIR_DEBUG},
+	{"utils", GOSSIP_UTILS_DEBUG},
+	{"wait", GOSSIP_WAIT_DEBUG},
+	{"acl", GOSSIP_ACL_DEBUG},
+	{"dcache", GOSSIP_DCACHE_DEBUG},
+	{"dev", GOSSIP_DEV_DEBUG},
+	{"name", GOSSIP_NAME_DEBUG},
+	{"bufmap", GOSSIP_BUFMAP_DEBUG},
+	{"cache", GOSSIP_CACHE_DEBUG},
+	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
+	{"xattr", GOSSIP_XATTR_DEBUG},
+	{"init", GOSSIP_INIT_DEBUG},
+	{"sysfs", GOSSIP_SYSFS_DEBUG},
+	{"none", GOSSIP_NO_DEBUG},
+	{"all", GOSSIP_MAX_DEBUG}
+};
+
+static const int num_kmod_keyword_mask_map = (int)
+	(ARRAY_SIZE(s_kmod_keyword_mask_map));
+
 #define DEBUG_HELP_STRING_SIZE 4096
 #define HELP_STRING_UNINITIALIZED \
 	"Client Debug Keywords are unknown until the first time\n" \
-- 
2.47.2


