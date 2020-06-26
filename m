Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208AD20B425
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFZPFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 11:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgFZPFE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:05:04 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E30A207D8;
        Fri, 26 Jun 2020 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593183903;
        bh=HztJ6MY43b9+CVBHrSPJo4PI69VY3WSGWtOj3srifL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZcIj6qw3UJsh+lMLdCvLJ5NTlIaTcCHE7uPFUQBy4FCkF5zMJ+T70aIPXG5HrqUT
         0+gDhee6PCefMuIQiuCxiYybsdv6BNt/IgQbDSQ/WRpV78CvtkMa6nYhVmlOeWUDPy
         aKqyXxBtmNAjRzVW/2FAFYy1yrrR2mTa6ANC89ys=
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, andres@anarazel.de
Subject: [fsinfo PATCH v2 2/3] vfs: allow fsinfo to fetch the current state of s_wb_err
Date:   Fri, 26 Jun 2020 11:04:59 -0400
Message-Id: <20200626150500.565417-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626150500.565417-1-jlayton@kernel.org>
References: <20200626150500.565417-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Add a new "error_state" struct to fsinfo, and teach the kernel to fill
that out from sb->s_wb_err. There are two fields:

wb_error_last: the most recently recorded errno for the filesystem

wb_error_cookie: this value will change vs. the previously fetched
                 value if a new error was recorded since it was last
		 checked. Callers should treat this as an opaque value
		 that can be compared to earlier fetched values.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/fsinfo.c                 | 11 +++++++++++
 include/uapi/linux/fsinfo.h | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 18b533b79cea..2934e05328ed 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -274,6 +274,16 @@ static int fsinfo_generic_seq_read(struct path *path, struct fsinfo_context *ctx
 	return m.count + 1;
 }
 
+static int fsinfo_generic_error_state(struct path *path,
+				      struct fsinfo_context *ctx)
+{
+	struct fsinfo_error_state *es = ctx->buffer;
+
+	es->wb_error_cookie = errseq_scrape(&path->dentry->d_sb->s_wb_err);
+	es->wb_error_last = es->wb_error_cookie & MAX_ERRNO;
+	return sizeof(*es);
+}
+
 static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
@@ -286,6 +296,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_SOURCE,		fsinfo_generic_mount_source),
 	FSINFO_STRING	(FSINFO_ATTR_CONFIGURATION,	fsinfo_generic_seq_read),
 	FSINFO_STRING	(FSINFO_ATTR_FS_STATISTICS,	fsinfo_generic_seq_read),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_ERROR_STATE,	fsinfo_generic_error_state),
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index af681b2e0e7e..72b0e7207a8a 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -27,6 +27,7 @@
 #define FSINFO_ATTR_SOURCE		0x09	/* Superblock source/device name (string) */
 #define FSINFO_ATTR_CONFIGURATION	0x0a	/* Superblock configuration/options (string) */
 #define FSINFO_ATTR_FS_STATISTICS	0x0b	/* Superblock filesystem statistics (string) */
+#define FSINFO_ATTR_ERROR_STATE		0x0c	/* Superblock writeback error state */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
@@ -332,4 +333,16 @@ struct fsinfo_afs_server_address {
 
 #define FSINFO_ATTR_AFS_SERVER_ADDRESSES__STRUCT struct fsinfo_afs_server_address
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_ERROR_STATE).
+ *
+ * Retrieve the error state for a filesystem.
+ */
+struct fsinfo_error_state {
+	__u32		wb_error_cookie;	/* writeback error cookie */
+	__u32		wb_error_last;		/* latest writeback error */
+};
+
+#define FSINFO_ATTR_ERROR_STATE__STRUCT struct fsinfo_error_state
+
 #endif /* _UAPI_LINUX_FSINFO_H */
-- 
2.26.2

