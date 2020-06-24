Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1352078A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404900AbgFXQOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404846AbgFXQOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:14 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C40C061796;
        Wed, 24 Jun 2020 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rF/h+g2aRvM7O684xTgcwq5WjNPNPSLZJBoCztHySj0=; b=YB66beWOM8rLRQIjm3q1TqZJBC
        vflHEfvmWfS43Nb8HKAhtLHQdK6g2/Unssp2DZGrYtBVMAgO+i7da/bCwoX5pxMNfUmSECCFYXPFt
        8VoeXBYA6E4KtmJaaiivhK3+YsuOGyG6IGO6HTfOolB2Yh4TlUb1rQkIxJN1CAqlj5fEXVhLIWl+A
        9Av9Oup4gxm7V/a2w3TiALvTA1dT352cwzmU8rRHU84XguyObJpzSQmNGpUgGruVAQ7H9CophvWTp
        1GRQrXzlzJ55RB4fv2qgulET3KsCT4P48Uj82dOR9TIxqug7D+a4axHIFBXvJlXzp3wElpvlLdL0M
        sayusasQ==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo822-0005z6-OR; Wed, 24 Jun 2020 16:13:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 11/14] fs: implement kernel_read using __kernel_read
Date:   Wed, 24 Jun 2020 18:13:32 +0200
Message-Id: <20200624161335.1810359-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161335.1810359-1-hch@lst.de>
References: <20200624161335.1810359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
index cc8e0b4f3cd697..a0a0b5d1d9249c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -455,15 +455,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
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

