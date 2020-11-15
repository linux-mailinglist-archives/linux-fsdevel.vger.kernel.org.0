Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C932B3A99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgKOXiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 18:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKOXiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 18:38:21 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CCCC0613CF;
        Sun, 15 Nov 2020 15:38:20 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keRb4-006roW-2J; Sun, 15 Nov 2020 23:38:14 +0000
Date:   Sun, 15 Nov 2020 23:38:14 +0000
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
Message-ID: <20201115233814.GT3576660@ZenIV.linux.org.uk>
References: <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
 <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
 <20201115214125.GA317@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115214125.GA317@Ryzen-9-3900X.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 02:41:25PM -0700, Nathan Chancellor wrote:
> Hi Al,
> 
> Apologies for the delay.
> 
> On Sun, Nov 15, 2020 at 03:53:55PM +0000, Al Viro wrote:
> > On Sat, Nov 14, 2020 at 08:50:00PM +0000, Al Viro wrote:
> > 
> > OK, I think I understand what's going on.  Could you check if
> > reverting the variant in -next and applying the following instead
> > fixes what you are seeing?
> 
> The below diff on top of d4d50710a8b46082224376ef119a4dbb75b25c56 does
> not fix my issue unfortunately.

OK...  Now that I have a reproducer[1], I think I've sorted it out.
And yes, it had been too subtle for its own good ;-/

[1] I still wonder what the hell in the userland has come up with the
idea of reading through a file with readv(), each time with 2-element
iovec array, the first element covering 0 bytes and the second one - 1024.
AFAICS, nothing is systemd git appears to be _that_ weird...  Makes for
a useful testcase, though...

Anyway, could you test this replacement?

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 3b20e21604e7..c0dfe2861b35 100644
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
@@ -208,34 +210,32 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	}
 	/* if not empty - flush it first */
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
+	/* we need at least one non-empty record in the buffer */
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
+	// the iterator at least once.
 	while (1) {
 		size_t offs = m->count;
 		loff_t pos = m->index;
@@ -259,11 +262,9 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
 		if (seq_has_overflowed(m) || err) {
@@ -273,16 +274,14 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -291,9 +290,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 Enomem:
 	err = -ENOMEM;
 	goto Done;
-Efault:
-	err = -EFAULT;
-	goto Done;
 }
 EXPORT_SYMBOL(seq_read_iter);
 
