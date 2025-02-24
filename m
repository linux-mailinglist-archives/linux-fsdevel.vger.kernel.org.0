Return-Path: <linux-fsdevel+bounces-42488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA4A42AAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3833AD41B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262F326659D;
	Mon, 24 Feb 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nej1ZHYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D94264FAA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420341; cv=none; b=YzsLym6jc4wAMLM81BufKeBMsOMOdON7PsZhhC3LTYSgrT0P3BnjuC6uxJ6NQ42EftkBuXMmP2IRtJo0ZVcZIFR3Vjz/w4X7i/PcZ1K159GW8QXV8ZX/AAIBVKWWlNpQq8RjWTV0C2giDGj8XOjQdrnnbXMnyLCnAvr5HrV1gPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420341; c=relaxed/simple;
	bh=TieKIXDw2Qv9I+HwGJ6auwMXGgJiU+Po1efih52t/rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyVMDaTiivQvFtCazi/pCFkZlPAsrSA+5m+YeZUQscNOIJDtGEdWcRQ0hl5ysZ+1JZD53i6gWKYLrzwSHHA6AOlVJm9bSh1W/0CIFF8iRLnJ+s8h4rWKiWiCsF7p3IGGB8QM6uv9MYyBA6U8lUxEows89TCaA9XXqaeQslnsgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nej1ZHYI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=2aBo+OgrQ7gQuzyYOviO+wQ5u2zMGRzhyX0+c/T085I=; b=Nej1ZHYIxs9e6JrnOE0sA9gX1D
	/KpL7++E8TBAMzIvpk+Rg0wIvMxvcLZpzNqeU4gqLqpNrRANIFu0brQwx3Xbw557mMmTeylHk8w8I
	cJEwm767JsDm/+WimAfN9xfr/R5nL3ukw3ZpVsNxizrgosMoYrRUZ6OJlgZ1sdmw0s9KaqDfRObHV
	EiufFBdtIBbIfAFfockHH20hFkcCZEbue9PvuVfaoBty9Q93dDKB30bFxu/RJih0XLQaCjddjRfzz
	u9PFEE2wU2NaBRR4wiB6fiASWDEDrRr6uFkU78m9SjAZV+aVggU3chiObFmtbj1PzEPYHFiU4tcfq
	dqChkmSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082fk-0wGC;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
Date: Mon, 24 Feb 2025 18:05:20 +0000
Message-ID: <20250224180529.1916812-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
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


