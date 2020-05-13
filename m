Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139261D0947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgEMG5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgEMG5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:57:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCD9C061A0C;
        Tue, 12 May 2020 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KaeJEwRFrws3Sr3qqEXI33NXZ5dPCgwGDFfFGJ19P54=; b=ddmpe0CnpS5hTGI3BvsktS/hjS
        +5N2t4yhisWNhSCpaQig9siB+HfCl1Yd/k+0mOW8gXepcJlQZt9ge4skfIu+IrRDoDIidW2QzZkpN
        vuloxdXC6+SFg9jbqWXt3lmYInuKOVrjpvTqI3/d/x+Jf90ccs1Cm5K5FtSx7ZVhxfUjaMazTwKhl
        Vh1ul/8U/6pCqz4Jg5r5HGPTmdkBIMs7dVLAP/fhFDrOiqLYvAgh3LPwYg5iu3x+QmFIXNNlH6GiV
        Ss32GP7NZOR4ZJvMuhGNGAewSvAZXihH5Yk/ZUUDdrUcObpvScwAEr/SOus5CyBV13zmwhsyWc3I4
        oIc33EGg==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYlKO-0003YE-Rp; Wed, 13 May 2020 06:57:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 07/14] fs: implement kernel_write using __kernel_write
Date:   Wed, 13 May 2020 08:56:49 +0200
Message-Id: <20200513065656.2110441-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513065656.2110441-1-hch@lst.de>
References: <20200513065656.2110441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate the two in-kernel write helpers to make upcoming changes
easier.  The only difference are the missing call to rw_verify_area
in kernel_write, and an access_ok check that doesn't make sense for
kernel buffers to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index f0768313ea010..abb84391cfbc5 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -499,6 +499,7 @@ static ssize_t __vfs_write(struct file *file, const char __user *p,
 		return -EINVAL;
 }
 
+/* caller is responsible for file_start_write/file_end_write */
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
 	mm_segment_t old_fs;
@@ -528,16 +529,16 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
 {
-	mm_segment_t old_fs;
-	ssize_t res;
+	ssize_t ret;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The cast to a user pointer is valid due to the set_fs() */
-	res = vfs_write(file, (__force const char __user *)buf, count, pos);
-	set_fs(old_fs);
+	ret = rw_verify_area(WRITE, file, pos, count);
+	if (ret)
+		return ret;
 
-	return res;
+	file_start_write(file);
+	ret =  __kernel_write(file, buf, count, pos);
+	file_end_write(file);
+	return ret;
 }
 EXPORT_SYMBOL(kernel_write);
 
-- 
2.26.2

