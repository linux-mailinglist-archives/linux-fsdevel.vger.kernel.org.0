Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFF1F964B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgFOMOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgFOMN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:13:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5C1C061A0E;
        Mon, 15 Jun 2020 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VBVeuzuM0P2q7W7ljlXXpDeFT/LdXFSEK3FuQYaqgbw=; b=cE84tygumZOTSk2LdOM0spcCKt
        h0fdezrVYR70UorfbR2STjeuuNJx0mibOd3HntKUaw8UYL1v+oHSsAzuaZNgOPDBKlNtUZxpn6NMi
        A5FtaDTwAbPmExJgOxJ1YZsasH3kb6cmLgl5NmLGAwFkY2xUuRgBuVusurSTe+YejKlNGsPQV3PSz
        dFwxqVAQhdVWSQC6rToszDj6EifTUtdZsSNBwu98fgxYgau2H7K5+podse+cgEXcJiWBwAjZmM9UL
        /cgW9z7pFcu6KfZUHJTKf3lEtgi1dTdpcB3Aw2hCcQgqEhyt9bD0nb869ecwvg/EythVDYR58lK2l
        xDGs//4Q==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknzP-00072p-68; Mon, 15 Jun 2020 12:13:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 08/13] fs: don't change the address limit for ->write_iter in __kernel_write
Date:   Mon, 15 Jun 2020 14:12:52 +0200
Message-Id: <20200615121257.798894-9-hch@lst.de>
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

If we write to a file that implements ->write_iter there is no need
to change the address limit if we send a kvec down.  Implement that
case, and prefer it over using plain ->write with a changed address
limit if available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index f81e15c95f576c..4fb7966f023526 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -491,8 +491,6 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 /* caller is responsible for file_start_write/file_end_write */
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs;
-	const char __user *p;
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_WRITE))
@@ -500,18 +498,29 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	p = (__force const char __user *)buf;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->write)
-		ret = file->f_op->write(file, p, count, pos);
-	else if (file->f_op->write_iter)
-		ret = new_sync_write(file, p, count, pos);
-	else
+	if (file->f_op->write_iter) {
+		struct kvec iov = { .iov_base = (void *)buf, .iov_len = count };
+		struct kiocb kiocb;
+		struct iov_iter iter;
+
+		init_sync_kiocb(&kiocb, file);
+		kiocb.ki_pos = *pos;
+		iov_iter_kvec(&iter, WRITE, &iov, 1, count);
+		ret = file->f_op->write_iter(&kiocb, &iter);
+		if (ret > 0)
+			*pos = kiocb.ki_pos;
+	} else if (file->f_op->write) {
+		mm_segment_t old_fs = get_fs();
+
+		set_fs(KERNEL_DS);
+		ret = file->f_op->write(file, (__force const char __user *)buf,
+				count, pos);
+		set_fs(old_fs);
+	} else {
 		ret = -EINVAL;
-	set_fs(old_fs);
+	}
 	if (ret > 0) {
 		fsnotify_modify(file);
 		add_wchar(current, ret);
-- 
2.26.2

