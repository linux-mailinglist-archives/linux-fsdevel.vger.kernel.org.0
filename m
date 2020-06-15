Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95A01F9635
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgFOMNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbgFOMNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:13:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41AC061A0E;
        Mon, 15 Jun 2020 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/uNGWMS6wsKEeNDbdq2MMYM/revZQnG+SE/ig1KbAgs=; b=kQj/YptZTgHtviYD8VY9pDaHTh
        Nth47/JWS6HPkOCKIBaXf+P0hgcO4QYIwlLm15PzHXiO8z3vDfVw2OZQfftIyksXcjksV6yZ9q0Kz
        zQPx0MsVBOuBNzzEYpYY/jP8yjvy8CDszcUkg6hJVpCabuI1zJ1tOw9U3oVn+aijjVm8Brck+zI8t
        yxLxbHcvW5Uj5T74opjNyhohAHs+gDyfJiHUQtXWs8f5Esfe5q3VXOv+tOtjkKBoXS6OdlLXsJ2PB
        XL4XVX0iMzkEKdQKWmdfmQpCM5qhGYqdDt3Cji/4SSbJXr/IYiiKx+PhQcHwCqo9jFV2EaaSNKFMH
        vBtD8CzA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknzY-00074R-9o; Mon, 15 Jun 2020 12:13:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 11/13] fs: implement kernel_read using __kernel_read
Date:   Mon, 15 Jun 2020 14:12:55 +0200
Message-Id: <20200615121257.798894-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615121257.798894-1-hch@lst.de>
References: <20200615121257.798894-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate the two in-kernel read helpers to make upcoming changes
easier.  The only difference are the missing call to rw_verify_area
in kernel_read, and an access_ok check that doesn't make sense for
kernel buffers to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 3364fdfc2982b4..e1c471982d6213 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -453,15 +453,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs;
-	ssize_t result;
+	ssize_t ret;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The cast to a user pointer is valid due to the set_fs() */
-	result = vfs_read(file, (void __user *)buf, count, pos);
-	set_fs(old_fs);
-	return result;
+	ret = rw_verify_area(READ, file, pos, count);
+	if (ret)
+		return ret;
+	return __kernel_read(file, buf, count, pos);
 }
 EXPORT_SYMBOL(kernel_read);
 
-- 
2.26.2

