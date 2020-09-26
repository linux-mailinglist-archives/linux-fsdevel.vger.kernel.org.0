Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0F279772
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 09:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgIZHEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 03:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgIZHEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:04:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E205C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7DYbE5rSDH2SbBsr0roKEy5D4WXojJ2FblFU2zyIEL0=; b=oMKLnmELB9VIuJQQdcol3XCtt8
        jpKn2rrmlm4p47jh065193innZPsRLgTJhK8lE6E+SbwFICzsGnU47SrDetRcAl7pcKsEilL7i0lW
        vyfMaoRRHleTZ+xdA5YoHlVfl11lgYe+UxGLIo0nTC35FXXSInJPNq5NTJk+emJKXQf5+DZiJ5L7T
        OjT7Mhf5w3/TES/qYZ+XopHvcONpu+P9qCPWHkPOkYhQZvpD2uLexS3HUl7Pxrp6Sr9zslpwwHO1B
        qYKDgj5KQ63+9fLDb6+i0ty7BHQ6IKh2jSM7CuETx7aMqJUyVEaSAReZx4+FwNk55LB9bASXIzezY
        4T0vB0aA==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4FZ-0003w3-Lg; Sat, 26 Sep 2020 07:04:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] fs: remove KSTAT_QUERY_FLAGS
Date:   Sat, 26 Sep 2020 09:04:01 +0200
Message-Id: <20200926070401.11816-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926070401.11816-1-hch@lst.de>
References: <20200926070401.11816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KSTAT_QUERY_FLAGS expands to AT_STATX_SYNC_TYPE, which itself already
is a mask.  Remove the double name, especially given that the prefix
is a little confusing vs the normal AT_* flags.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/stat.c            | 8 ++++----
 include/linux/stat.h | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 8acc4b14ac24c9..dacecdda2e7967 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL(generic_fillattr);
  * @path: file to get attributes from
  * @stat: structure to return attributes in
  * @request_mask: STATX_xxx flags indicating what the caller wants
- * @query_flags: Query mode (KSTAT_QUERY_FLAGS)
+ * @query_flags: Query mode (AT_STATX_SYNC_TYPE)
  *
  * Get attributes without calling security_inode_getattr.
  *
@@ -71,7 +71,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 
 	memset(stat, 0, sizeof(*stat));
 	stat->result_mask |= STATX_BASIC_STATS;
-	query_flags &= KSTAT_QUERY_FLAGS;
+	query_flags &= AT_STATX_SYNC_TYPE;
 
 	/* allow the fs to override these if it really wants to */
 	/* SB_NOATIME means filesystem supplies dummy atime value */
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(vfs_getattr_nosec);
  * @path: The file of interest
  * @stat: Where to return the statistics
  * @request_mask: STATX_xxx flags indicating what the caller wants
- * @query_flags: Query mode (KSTAT_QUERY_FLAGS)
+ * @query_flags: Query mode (AT_STATX_SYNC_TYPE)
  *
  * Ask the filesystem for a file's attributes.  The caller must indicate in
  * request_mask and query_flags to indicate what they want.
@@ -171,7 +171,7 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
-		      KSTAT_QUERY_FLAGS))
+		      AT_STATX_SYNC_TYPE))
 		return -EINVAL;
 
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 56614af83d4af5..fff27e60381412 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -19,8 +19,6 @@
 #include <linux/time.h>
 #include <linux/uidgid.h>
 
-#define KSTAT_QUERY_FLAGS (AT_STATX_SYNC_TYPE)
-
 struct kstat {
 	u32		result_mask;	/* What fields the user got */
 	umode_t		mode;
-- 
2.28.0

