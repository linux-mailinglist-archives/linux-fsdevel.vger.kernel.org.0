Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE001F9629
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgFOMN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgFOMNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:13:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506FC061A0E;
        Mon, 15 Jun 2020 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TlGwNzeUV5SdPQdMXQTZE0wOboZa+pqgldScyQb3lYk=; b=R/8vJ0kaupTtFA7vm44e95YJSf
        2lHoDQbLTSdYcQrFbG42XLO52ZQcIlOP2li/9rkRD6XWWwJwBuZVuGcB+4vxYC8AiOrV+tfnCfcKY
        Vcy53UEFZ4ewPWBs9gmBjIxI+13GOiZYXgzgzF6rqJ4PbLd3qGxLVtRfQ+U2NgbzuhFo/4LiCdHoA
        h63M0qShCyWfl5jDpQapGOndZl2a9yGtMwu7WEyFyqdAWqmCrA/M/6+NVQRgKTBarhzae8xLAGhWs
        GOZOeynjzOj61ziv0S+SGCB5mNj53/z8sV+mMOI8xNwWZIocZl4t1b3maeA0ajsIZkgmfz25JLykO
        vps/Hsnw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknzL-000724-QC; Mon, 15 Jun 2020 12:13:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 07/13] fs: remove __vfs_write
Date:   Mon, 15 Jun 2020 14:12:51 +0200
Message-Id: <20200615121257.798894-8-hch@lst.de>
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

Fold it into the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 9d50d3cec017d8..f81e15c95f576c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -488,17 +488,6 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	return ret;
 }
 
-static ssize_t __vfs_write(struct file *file, const char __user *p,
-			   size_t count, loff_t *pos)
-{
-	if (file->f_op->write)
-		return file->f_op->write(file, p, count, pos);
-	else if (file->f_op->write_iter)
-		return new_sync_write(file, p, count, pos);
-	else
-		return -EINVAL;
-}
-
 /* caller is responsible for file_start_write/file_end_write */
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
@@ -516,7 +505,12 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	p = (__force const char __user *)buf;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	ret = __vfs_write(file, p, count, pos);
+	if (file->f_op->write)
+		ret = file->f_op->write(file, p, count, pos);
+	else if (file->f_op->write_iter)
+		ret = new_sync_write(file, p, count, pos);
+	else
+		ret = -EINVAL;
 	set_fs(old_fs);
 	if (ret > 0) {
 		fsnotify_modify(file);
@@ -554,19 +548,23 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 		return -EFAULT;
 
 	ret = rw_verify_area(WRITE, file, pos, count);
-	if (!ret) {
-		if (count > MAX_RW_COUNT)
-			count =  MAX_RW_COUNT;
-		file_start_write(file);
-		ret = __vfs_write(file, buf, count, pos);
-		if (ret > 0) {
-			fsnotify_modify(file);
-			add_wchar(current, ret);
-		}
-		inc_syscw(current);
-		file_end_write(file);
+	if (ret)
+		return ret;
+	if (count > MAX_RW_COUNT)
+		count =  MAX_RW_COUNT;
+	file_start_write(file);
+	if (file->f_op->write)
+		ret = file->f_op->write(file, buf, count, pos);
+	else if (file->f_op->write_iter)
+		ret = new_sync_write(file, buf, count, pos);
+	else
+		ret = -EINVAL;
+	if (ret > 0) {
+		fsnotify_modify(file);
+		add_wchar(current, ret);
 	}
-
+	inc_syscw(current);
+	file_end_write(file);
 	return ret;
 }
 
-- 
2.26.2

