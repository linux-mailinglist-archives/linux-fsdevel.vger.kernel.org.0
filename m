Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F282621756E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGGRs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgGGRsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA906C061755;
        Tue,  7 Jul 2020 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8oAca2Sh96a0lCcV3gNnPlvoMT0ySVT+lMAbT/xWciU=; b=SGBT2hXuirr0IaFti3lia9tSRU
        VweNIjq3OrAr2hK/vno0vV+HxxOmSpcmqkNEbPWnvWFYBR1Hr9srSkkQnOHCv4NViyNQtXY3DeDi8
        SzPd1dWGgRq1ZgN0uoWxPQMt69bZXzMnxdgpkTV6a1n8KmzCjdFPHNSovZBeantiOow4m6xcubRT/
        Frd//4rP24Zf9GPiJo+yqR4k0bGEsBgw9J+d5QKNSPUJLJ/L1xoNykfvJIofZNqn8zAhZIrQNygjV
        o5dgGljCjpSRBn+hbyV5ijuqsyaCDIsNv3YY9VyBDxWieholZd9mVfoBAPxZ7C3SV4UBv/iEiySD1
        8z20ql8A==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhV-0003IQ-Rs; Tue, 07 Jul 2020 17:48:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/23] fs: add a __kernel_read helper
Date:   Tue,  7 Jul 2020 19:47:47 +0200
Message-Id: <20200707174801.4162712-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
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

