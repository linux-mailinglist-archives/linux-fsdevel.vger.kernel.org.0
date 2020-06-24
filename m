Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38F82078A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404915AbgFXQOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404848AbgFXQOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:14 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB664C061795;
        Wed, 24 Jun 2020 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8oAca2Sh96a0lCcV3gNnPlvoMT0ySVT+lMAbT/xWciU=; b=nBbrQgnEbdvEu49QwFYpJ6VjdR
        UVgVTE+cKNKYvuJivPfNHCHsKYdeeYKcn+IjVuZARmA85D0mqjXqBqJ3hnc/kaPkIdyn9iaf40n/j
        9jRqaOSuZKteN8JxmI0FayUzcm8safEhLRWVhdd+8rnVzl9B9lOHRKa9fyLqVJjXYb94J6IMASXrc
        Yd6wZZapzuwx/fTz7+CI/4RmKhb5hTPyw2BUjEqJUgHzO7dCBBvk17HY24pGsKo84GG7IODOkujV/
        LJUqY1qvdnD8z+3Jggqihr830f33dUmAAk5KM7o4Nu+p8SQnEMHIGC/CPJ+/7apgkl1IjYxRCFo5d
        amxyaHDg==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo820-0005yk-5f; Wed, 24 Jun 2020 16:13:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 09/14] fs: add a __kernel_read helper
Date:   Wed, 24 Jun 2020 18:13:30 +0200
Message-Id: <20200624161335.1810359-10-hch@lst.de>
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

This is the counterpart to __kernel_write, and skip the rw_verify_area
call compared to kernel_read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    | 23 +++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index bd46c959799e97..cc8e0b4f3cd697 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -430,6 +430,29 @@ ssize_t __vfs_read(struct file *file, char __user *buf, size_t count,
 		return -EINVAL;
 }
 
+ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
+{
+	mm_segment_t old_fs = get_fs();
+	ssize_t ret;
+
+	if (WARN_ON_ONCE(!(file->f_mode & FMODE_READ)))
+		return -EINVAL;
+	if (!(file->f_mode & FMODE_CAN_READ))
+		return -EINVAL;
+
+	if (count > MAX_RW_COUNT)
+		count =  MAX_RW_COUNT;
+	set_fs(KERNEL_DS);
+	ret = __vfs_read(file, (void __user *)buf, count, pos);
+	set_fs(old_fs);
+	if (ret > 0) {
+		fsnotify_access(file);
+		add_rchar(current, ret);
+	}
+	inc_syscr(current);
+	return ret;
+}
+
 ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	mm_segment_t old_fs;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea746..22cbe7b2e91994 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3033,6 +3033,7 @@ extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, lo
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
+ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
-- 
2.26.2

