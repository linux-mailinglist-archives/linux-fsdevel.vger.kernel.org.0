Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3AE2B3AC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 01:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgKPAZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 19:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgKPAZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 19:25:19 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196ECC0613CF;
        Sun, 15 Nov 2020 16:25:19 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keSKX-006teB-7U; Mon, 16 Nov 2020 00:25:13 +0000
Date:   Mon, 16 Nov 2020 00:25:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201116002513.GU3576660@ZenIV.linux.org.uk>
References: <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
 <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
 <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk>
 <20201115235149.GA252@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115235149.GA252@Ryzen-9-3900X.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 04:51:49PM -0700, Nathan Chancellor wrote:
> Looks good to me on top of d4d50710a8b46082224376ef119a4dbb75b25c56,
> thanks for quickly looking into this!
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

OK... a variant with (hopefully) better comments and cleaned up
logics in the second loop (
                if (seq_has_overflowed(m) || err) {
                        m->count = offs;
                        if (likely(err <= 0))
                                break;
                }
replaced with
                if (err > 0) {          // ->show() says "skip it"
                        m->count = offs;
                } else if (err || seq_has_overflowed(m)) {
                        m->count = offs;
                        break;
                }
) follows.  I'm quite certain that it is an equivalent transformation
(seq_has_overflowed() has no side effects) and IMO it's slightly
more readable that way.  Survives local beating; could you check if
it's still OK with your testcase?  Equivalent transformation or not,
I'd rather not slap anyone's Tested-by: on a modified variant of
patch...

BTW, is that call of readv() really coming from init?  And if it
is, what version of init are you using?

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 3b20e21604e7..03a369ccd28c 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -168,12 +168,14 @@ EXPORT_SYMBOL(seq_read);
 ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct seq_file *m = iocb->ki_filp->private_data;
-	size_t size = iov_iter_count(iter);
 	size_t copied = 0;
 	size_t n;
 	void *p;
 	int err = 0;
 
+	if (!iov_iter_count(iter))
+		return 0;
+
 	mutex_lock(&m->lock);
 
 	/*
@@ -206,36 +208,34 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (!m->buf)
 			goto Enomem;
 	}
-	/* if not empty - flush it first */
+	// something left in the buffer - copy it out first
 	if (m->count) {
-		n = min(m->count, size);
-		if (copy_to_iter(m->buf + m->from, n, iter) != n)
-			goto Efault;
+		n = copy_to_iter(m->buf + m->from, m->count, iter);
 		m->count -= n;
 		m->from += n;
-		size -= n;
 		copied += n;
-		if (!size)
+		if (m->count)	// hadn't managed to copy everything
 			goto Done;
 	}
-	/* we need at least one record in buffer */
+	// get a non-empty record in the buffer
 	m->from = 0;
 	p = m->op->start(m, &m->index);
 	while (1) {
 		err = PTR_ERR(p);
-		if (!p || IS_ERR(p))
+		if (!p || IS_ERR(p))	// EOF or an error
 			break;
 		err = m->op->show(m, p);
-		if (err < 0)
+		if (err < 0)		// hard error
 			break;
-		if (unlikely(err))
+		if (unlikely(err))	// ->show() says "skip it"
 			m->count = 0;
-		if (unlikely(!m->count)) {
+		if (unlikely(!m->count)) { // empty record
 			p = m->op->next(m, p, &m->index);
 			continue;
 		}
-		if (m->count < m->size)
+		if (!seq_has_overflowed(m)) // got it
 			goto Fill;
+		// need a bigger buffer
 		m->op->stop(m, p);
 		kvfree(m->buf);
 		m->count = 0;
@@ -244,11 +244,14 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto Enomem;
 		p = m->op->start(m, &m->index);
 	}
+	// EOF or an error
 	m->op->stop(m, p);
 	m->count = 0;
 	goto Done;
 Fill:
-	/* they want more? let's try to get some more */
+	// one non-empty record is in the buffer; if they want more,
+	// try to fit more in, but in any case we need to advance
+	// the iterator once for every record shown.
 	while (1) {
 		size_t offs = m->count;
 		loff_t pos = m->index;
@@ -259,30 +262,27 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 					    m->op->next);
 			m->index++;
 		}
-		if (!p || IS_ERR(p)) {
-			err = PTR_ERR(p);
+		if (!p || IS_ERR(p))	// no next record for us
 			break;
-		}
-		if (m->count >= size)
+		if (m->count >= iov_iter_count(iter))
 			break;
 		err = m->op->show(m, p);
-		if (seq_has_overflowed(m) || err) {
+		if (err > 0) {		// ->show() says "skip it"
 			m->count = offs;
-			if (likely(err <= 0))
-				break;
+		} else if (err || seq_has_overflowed(m)) {
+			m->count = offs;
+			break;
 		}
 	}
 	m->op->stop(m, p);
-	n = min(m->count, size);
-	if (copy_to_iter(m->buf, n, iter) != n)
-		goto Efault;
+	n = copy_to_iter(m->buf, m->count, iter);
 	copied += n;
 	m->count -= n;
 	m->from = n;
 Done:
-	if (!copied)
-		copied = err;
-	else {
+	if (unlikely(!copied)) {
+		copied = m->count ? -EFAULT : err;
+	} else {
 		iocb->ki_pos += copied;
 		m->read_pos += copied;
 	}
@@ -291,9 +291,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 Enomem:
 	err = -ENOMEM;
 	goto Done;
-Efault:
-	err = -EFAULT;
-	goto Done;
 }
 EXPORT_SYMBOL(seq_read_iter);
 
