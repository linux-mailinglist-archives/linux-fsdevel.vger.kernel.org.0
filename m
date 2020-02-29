Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C948B174839
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgB2Q7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 11:59:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgB2Q7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=um491tknGMwvuRborSIu7y3JlDzepuilcVoKSXsG30w=; b=UgzyFTYZAfjIol3CC/Zuiy2xEt
        Dka6bj5QqokLzbK3VNd2Nnq1raig+a5gaZjJFH8+13BKlH3LlcK5zP3Sx/b1blVJWa1ekp7lLlqk8
        HgOeOrvYAmNCReEXA5rTw6gTnIWx0JfMLsXQJ1pShDs9UEeoDPL+uxH3eTyx3TM/VaO65i9qWlY4C
        hvrw1ovPLibARNpfnH5+znYI5vgklPacIqmPdmaEXywdE2CGhnlrrVaaTkPgzQj6jd7WD8PdBpORi
        0NIuUr6kzHU+lEF/cYtAy4x8mP+LHbaQ0KdJOclWrO9qtAJrKhViB3j3YhkrQFSmJKsvub/HuvirP
        tEaMQtSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j85SJ-0006Pp-Cx; Sat, 29 Feb 2020 16:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] seq_file: Remove m->version
Date:   Sat, 29 Feb 2020 08:59:09 -0800
Message-Id: <20200229165910.24605-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200229165910.24605-1-willy@infradead.org>
References: <20200229165910.24605-1-willy@infradead.org>
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

