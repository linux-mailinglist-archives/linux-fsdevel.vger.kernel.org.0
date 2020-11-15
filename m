Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9132B35EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgKOPyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgKOPyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 10:54:13 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EFDC0613D1;
        Sun, 15 Nov 2020 07:54:13 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keKLj-006d9h-OI; Sun, 15 Nov 2020 15:53:55 +0000
Date:   Sun, 15 Nov 2020 15:53:55 +0000
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
Message-ID: <20201115155355.GR3576660@ZenIV.linux.org.uk>
References: <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
 <20201114205000.GP3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114205000.GP3576660@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 14, 2020 at 08:50:00PM +0000, Al Viro wrote:

OK, I think I understand what's going on.  Could you check if
reverting the variant in -next and applying the following instead
fixes what you are seeing?

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 3b20e21604e7..35667112bbd1 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -168,7 +168,6 @@ EXPORT_SYMBOL(seq_read);
 ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct seq_file *m = iocb->ki_filp->private_data;
-	size_t size = iov_iter_count(iter);
 	size_t copied = 0;
 	size_t n;
 	void *p;
@@ -208,16 +207,15 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
-			goto Done;
+		if (m->count)
+			goto Efault;
 	}
+	if (!iov_iter_count(iter))
+		goto Done;
 	/* we need at least one record in buffer */
 	m->from = 0;
 	p = m->op->start(m, &m->index);
@@ -249,6 +247,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	goto Done;
 Fill:
 	/* they want more? let's try to get some more */
+	/* m->count is positive and there's space left in iter */
 	while (1) {
 		size_t offs = m->count;
 		loff_t pos = m->index;
@@ -263,7 +262,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			err = PTR_ERR(p);
 			break;
 		}
-		if (m->count >= size)
+		if (m->count >= iov_iter_count(iter))
 			break;
 		err = m->op->show(m, p);
 		if (seq_has_overflowed(m) || err) {
@@ -273,12 +272,12 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 	}
 	m->op->stop(m, p);
-	n = min(m->count, size);
-	if (copy_to_iter(m->buf, n, iter) != n)
-		goto Efault;
+	n = copy_to_iter(m->buf, m->count, iter);
 	copied += n;
-	m->count -= n;
 	m->from = n;
+	m->count -= n;
+	if (m->count)
+		goto Efault;
 Done:
 	if (!copied)
 		copied = err;

