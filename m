Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2D72A5FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 09:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKDIcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 03:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDIcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:32:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4869C0613D3;
        Wed,  4 Nov 2020 00:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qwoS/ldP8oxvQDl6Sqqe37ZwIbpdpdCdtB8HHVc24Ec=; b=mW2BzPoSpKXihmEZAjG+QFYUSq
        FxvVTagg1vofgsm8BF/7KkBQ7l3d1jmMQgczWlH7qDchs9jHxDpZnICXCzTnTJGggq9w3CswT6OxL
        fhH++/i9oPy6VwJF0pAHTnwmN3LDlq3XhU0LkJhXLGqLSUaOW1sCu2wnkkQr6U+lwtMOsOiYsOlts
        C1ii/AwUYNxdaBrQkOmIUkL5PvqmfubpmufolrbHgY1KW6SEgZYGTwnK2zalqoRef7Yz31oiOQH7c
        ED6dX+dUDMZ3+zTUGfZmsX/wDvAWd0dyhnitn4t2L1VwS6y03itn4h6EIphfVpprP5N8jI6pUjgm0
        7a9DmqbQ==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaED5-0004OC-Qx; Wed, 04 Nov 2020 08:32:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] seq_file: add seq_read_iter
Date:   Wed,  4 Nov 2020 09:27:33 +0100
Message-Id: <20201104082738.1054792-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
References: <20201104082738.1054792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iov_iter based variant for reading a seq_file.  seq_read is
reimplemented on top of the iter variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/seq_file.c            | 45 ++++++++++++++++++++++++++++------------
 include/linux/seq_file.h |  1 +
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 31219c1db17de3..3b20e21604e74a 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/printk.h>
 #include <linux/string_helpers.h>
+#include <linux/uio.h>
 
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -146,7 +147,28 @@ static int traverse(struct seq_file *m, loff_t offset)
  */
 ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 {
-	struct seq_file *m = file->private_data;
+	struct iovec iov = { .iov_base = buf, .iov_len = size};
+	struct kiocb kiocb;
+	struct iov_iter iter;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, file);
+	iov_iter_init(&iter, READ, &iov, 1, size);
+
+	kiocb.ki_pos = *ppos;
+	ret = seq_read_iter(&kiocb, &iter);
+	*ppos = kiocb.ki_pos;
+	return ret;
+}
+EXPORT_SYMBOL(seq_read);
+
+/*
+ * Ready-made ->f_op->read_iter()
+ */
+ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(iter);
 	size_t copied = 0;
 	size_t n;
 	void *p;
@@ -158,14 +180,14 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	 * if request is to read from zero offset, reset iterator to first
 	 * record as it might have been already advanced by previous requests
 	 */
-	if (*ppos == 0) {
+	if (iocb->ki_pos == 0) {
 		m->index = 0;
 		m->count = 0;
 	}
 
-	/* Don't assume *ppos is where we left it */
-	if (unlikely(*ppos != m->read_pos)) {
-		while ((err = traverse(m, *ppos)) == -EAGAIN)
+	/* Don't assume ki_pos is where we left it */
+	if (unlikely(iocb->ki_pos != m->read_pos)) {
+		while ((err = traverse(m, iocb->ki_pos)) == -EAGAIN)
 			;
 		if (err) {
 			/* With prejudice... */
@@ -174,7 +196,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 			m->count = 0;
 			goto Done;
 		} else {
-			m->read_pos = *ppos;
+			m->read_pos = iocb->ki_pos;
 		}
 	}
 
@@ -187,13 +209,11 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	/* if not empty - flush it first */
 	if (m->count) {
 		n = min(m->count, size);
-		err = copy_to_user(buf, m->buf + m->from, n);
-		if (err)
+		if (copy_to_iter(m->buf + m->from, n, iter) != n)
 			goto Efault;
 		m->count -= n;
 		m->from += n;
 		size -= n;
-		buf += n;
 		copied += n;
 		if (!size)
 			goto Done;
@@ -254,8 +274,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	}
 	m->op->stop(m, p);
 	n = min(m->count, size);
-	err = copy_to_user(buf, m->buf, n);
-	if (err)
+	if (copy_to_iter(m->buf, n, iter) != n)
 		goto Efault;
 	copied += n;
 	m->count -= n;
@@ -264,7 +283,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	if (!copied)
 		copied = err;
 	else {
-		*ppos += copied;
+		iocb->ki_pos += copied;
 		m->read_pos += copied;
 	}
 	mutex_unlock(&m->lock);
@@ -276,7 +295,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	err = -EFAULT;
 	goto Done;
 }
-EXPORT_SYMBOL(seq_read);
+EXPORT_SYMBOL(seq_read_iter);
 
 /**
  *	seq_lseek -	->llseek() method for sequential files.
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 813614d4b71fbc..b83b3ae3c877f3 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -107,6 +107,7 @@ void seq_pad(struct seq_file *m, char c);
 char *mangle_path(char *s, const char *p, const char *esc);
 int seq_open(struct file *, const struct seq_operations *);
 ssize_t seq_read(struct file *, char __user *, size_t, loff_t *);
+ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 loff_t seq_lseek(struct file *, loff_t, int);
 int seq_release(struct inode *, struct file *);
 int seq_write(struct seq_file *seq, const void *data, size_t len);
-- 
2.28.0

