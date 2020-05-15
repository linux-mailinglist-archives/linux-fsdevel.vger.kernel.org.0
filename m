Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0C1D4F12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgEONTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgEONRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B5C061A0C;
        Fri, 15 May 2020 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MTtXVuLp8PbOs9nK9zEtP3NahFAgQbfd5gfS3tX7ick=; b=QZ6yprN/MoKp+qDR36UMx8FPuH
        gvqXj7hUGEMsWEawbWxftZV5HrqHnOdjj00pK3UTFL3Y1swtmiPCgzsqwOzegyvOVZky9uuRPfgcu
        sxyf765znV4dC6Y7OPJktHckgRUWyTea/t/knTNQUXasgDHh8hrGovDafD101Iq400Fx1UOhhQDHu
        WcsVAX1k/u36MaQNunXwB0ySAPUoEXNkm6PbJNUPGuuaCPa2lGenlfybg6V2NRZDkf0z4cbVhdSAa
        pNJu1KTM8v/0dBzGBJVqF0Jul1ly33NfTKwvlDEKa0OiCJ8HyUXKv3lkN46t9nX6yyZKe+PLuNA0L
        AHf5Bz7w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCy-0005Xg-Q8; Fri, 15 May 2020 13:17:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/36] fs: Add a filesystem flag for large pages
Date:   Fri, 15 May 2020 06:16:27 -0700
Message-Id: <20200515131656.12890-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The page cache needs to know whether the filesystem supports pages >
PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h      | 1 +
 include/linux/pagemap.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 55c743925c40..777783c8760b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2241,6 +2241,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_LARGE_PAGES		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 36bfc9d855bb..c6db74b5e62f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -116,6 +116,11 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+static inline bool mapping_large_pages(struct address_space *mapping)
+{
+	return mapping->host->i_sb->s_type->fs_flags & FS_LARGE_PAGES;
+}
+
 void release_pages(struct page **pages, int nr);
 
 /*
-- 
2.26.2

