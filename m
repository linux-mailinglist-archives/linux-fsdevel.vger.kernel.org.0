Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61568188E0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 20:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCQTcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 15:32:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39701 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQTc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:32:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id h6so6908457wrs.6;
        Tue, 17 Mar 2020 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87R7ZZi7NQyiEUU6RgzITGKZd1KvjxPY9U+w9OVjGpQ=;
        b=Y0OOHHl+Qdc/0Q9l15Ho+69A+yKW8ocW48UbZhKhwCKIe6kSO/wWwBhSv8g1SrcgIo
         NFkEb3p0iBaRyfQSIl07hTPnBCownJtQbziJkfCP2cVyiIPdaNRTG7QcQZANHfz54Xrc
         oFDHaLvCb4b7przupJMoxQm6kdJSyuEINuPSJGbBT7lLpLbiDR2KhDeOxvE54lfSabQL
         beeOnd5m++aYaPPLUhcOYbhuBoTkYbGmFCLREMd7nXi06D6/QvyufLSGkUcKwJbMCIxY
         HrEKYX2KoZbas6fEwlMqBAE1+whC26twAjqOZ7dH//RSc0HTvNnetH8CeDJR5/Z7srBa
         6PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87R7ZZi7NQyiEUU6RgzITGKZd1KvjxPY9U+w9OVjGpQ=;
        b=gjUWuSqr67l0TlYug+HcmfqtgJQXhIrXKNMbDwVmH9rOWoQGGAeFiVE6wKVFzTcAxt
         biz72FcLzWjCsGEHdOHslaaXSrMzKZaeMtGb1MIqfoylcqNfVkKkCoFmJz8c14hwyGKy
         ZgFDVqVkNyivNeBna5xId+y7z3hPfzvGWTCrCnBNKwAc+rnOIBcqPQydWiqV2qx+QiFJ
         9PhIzTJUTAxaDNsSHFA3Rbx+eXv5JdJ6Got7K4Vm5AYLvtVdN0X3nhMsceY8GN+l1X/N
         Llk7WD/SNcplN/Q9yBl+o0SjmZSJ3jRVfptX0QGRbX8P36OYpXlH3Q+20XV2qhJRi2Ft
         ChuA==
X-Gm-Message-State: ANhLgQ3TmnZlW3kFrRKCg79eVGKPehHNKcjxz+ZL9MgoqFOb9E01yECZ
        8RrnECH04GshlC0vuRGhZA==
X-Google-Smtp-Source: ADFU+vvK9jJj5EXaKRlLWpStr34inD+bY6H/SGtK5gnUpY8GVbBY9v8S0OVBNCvZ4mPDvjrPyYEC5w==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr669701wrm.124.1584473544891;
        Tue, 17 Mar 2020 12:32:24 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id t1sm5946323wrq.36.2020.03.17.12.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 12:32:24 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com
Subject: [PATCH 4/5] seq_file: remove m->version
Date:   Tue, 17 Mar 2020 22:32:00 +0300
Message-Id: <20200317193201.9924-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317193201.9924-1-adobriyan@gmail.com>
References: <20200317193201.9924-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The process maps file was the only user of version (introduced back
in 2005).  Now that it uses ppos instead, we can remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/seq_file.c            | 28 ----------------------------
 include/linux/seq_file.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034a929b..79781ebd2145 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -67,13 +67,6 @@ int seq_open(struct file *file, const struct seq_operations *op)
 	// to the lifetime of the file.
 	p->file = file;
 
-	/*
-	 * Wrappers around seq_open(e.g. swaps_open) need to be
-	 * aware of this. If they set f_version themselves, they
-	 * should call seq_open first and then set f_version.
-	 */
-	file->f_version = 0;
-
 	/*
 	 * seq_files support lseek() and pread().  They do not implement
 	 * write() at all, but we clear FMODE_PWRITE here for historical
@@ -94,7 +87,6 @@ static int traverse(struct seq_file *m, loff_t offset)
 	int error = 0;
 	void *p;
 
-	m->version = 0;
 	m->index = 0;
 	m->count = m->from = 0;
 	if (!offset)
@@ -160,26 +152,12 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 
 	mutex_lock(&m->lock);
 
-	/*
-	 * seq_file->op->..m_start/m_stop/m_next may do special actions
-	 * or optimisations based on the file->f_version, so we want to
-	 * pass the file->f_version to those methods.
-	 *
-	 * seq_file->version is just copy of f_version, and seq_file
-	 * methods can treat it simply as file version.
-	 * It is copied in first and copied out after all operations.
-	 * It is convenient to have it as  part of structure to avoid the
-	 * need of passing another argument to all the seq_file methods.
-	 */
-	m->version = file->f_version;
-
 	/*
 	 * if request is to read from zero offset, reset iterator to first
 	 * record as it might have been already advanced by previous requests
 	 */
 	if (*ppos == 0) {
 		m->index = 0;
-		m->version = 0;
 		m->count = 0;
 	}
 
@@ -190,7 +168,6 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 		if (err) {
 			/* With prejudice... */
 			m->read_pos = 0;
-			m->version = 0;
 			m->index = 0;
 			m->count = 0;
 			goto Done;
@@ -243,7 +220,6 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 		m->buf = seq_buf_alloc(m->size <<= 1);
 		if (!m->buf)
 			goto Enomem;
-		m->version = 0;
 		p = m->op->start(m, &m->index);
 	}
 	m->op->stop(m, p);
@@ -287,7 +263,6 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 		*ppos += copied;
 		m->read_pos += copied;
 	}
-	file->f_version = m->version;
 	mutex_unlock(&m->lock);
 	return copied;
 Enomem:
@@ -313,7 +288,6 @@ loff_t seq_lseek(struct file *file, loff_t offset, int whence)
 	loff_t retval = -EINVAL;
 
 	mutex_lock(&m->lock);
-	m->version = file->f_version;
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -329,7 +303,6 @@ loff_t seq_lseek(struct file *file, loff_t offset, int whence)
 				/* with extreme prejudice... */
 				file->f_pos = 0;
 				m->read_pos = 0;
-				m->version = 0;
 				m->index = 0;
 				m->count = 0;
 			} else {
@@ -340,7 +313,6 @@ loff_t seq_lseek(struct file *file, loff_t offset, int whence)
 			file->f_pos = offset;
 		}
 	}
-	file->f_version = m->version;
 	mutex_unlock(&m->lock);
 	return retval;
 }
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 5998e1f4ff06..0d434bc4a779 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -21,7 +21,6 @@ struct seq_file {
 	size_t pad_until;
 	loff_t index;
 	loff_t read_pos;
-	u64 version;
 	struct mutex lock;
 	const struct seq_operations *op;
 	int poll_event;
-- 
2.25.0

