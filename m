Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473C12AE3EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 00:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbgKJXUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 18:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJXUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:20:40 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3009C0613D1;
        Tue, 10 Nov 2020 15:20:38 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kccw8-0037gG-Nt; Tue, 10 Nov 2020 23:20:28 +0000
Date:   Tue, 10 Nov 2020 23:20:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201110232028.GX3576660@ZenIV.linux.org.uk>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110213511.GW3576660@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:35:11PM +0000, Al Viro wrote:
> On Tue, Nov 10, 2020 at 09:32:53PM +0000, Al Viro wrote:
> 
> > AFAICS, not all callers want that semantics, but I think it's worth
> > a new primitive.  I'm not saying it should be a prereq for your
> > series, but either that or an explicit iov_iter_revert() is needed.
> 
> Seeing that it already went into mainline, it needs a followup fix.
> And since it's not -stable fodder (AFAICS), I'd rather go with
> adding a new primitive...

Any objections to the following?

Fix seq_read_iter() behaviour on full pipe

generic_file_splice_read() will purge what we'd left in pipe in case
of error; it will *not* do so in case of short write, so we must make
sure that reported amount of data stored by ->read_iter() matches the
reality.

It's not a rare situation (and we already have it open-coded in at least
one place), so let's introduce a new primitive - copy_to_iter_full().
Similar to copy_from_iter_full(), it returns true if we had been able
to copy everything we'd been asked to and false otherwise.  Iterator
is advanced only on success.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 3b20e21604e7..233d790ea301 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -209,7 +209,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* if not empty - flush it first */
 	if (m->count) {
 		n = min(m->count, size);
-		if (copy_to_iter(m->buf + m->from, n, iter) != n)
+		if (!copy_to_iter_full(m->buf + m->from, n, iter))
 			goto Efault;
 		m->count -= n;
 		m->from += n;
@@ -274,7 +274,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	}
 	m->op->stop(m, p);
 	n = min(m->count, size);
-	if (copy_to_iter(m->buf, n, iter) != n)
+	if (!copy_to_iter_full(m->buf, n, iter))
 		goto Efault;
 	copied += n;
 	m->count -= n;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..388c05e371ad 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -138,6 +138,18 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 }
 
 static __always_inline __must_check
+bool copy_to_iter_full(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (likely(check_copy_size(addr, bytes, true))) {
+		size_t n = _copy_to_iter(addr, bytes, i);
+		if (likely(n == bytes))
+			return true;
+		iov_iter_revert(i, n);
+	}
+	return false;
+}
+
+static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(!check_copy_size(addr, bytes, false)))
diff --git a/include/net/udp.h b/include/net/udp.h
index 295d52a73598..91d1a2998a2d 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -390,14 +390,7 @@ static inline bool udp_skb_is_linear(struct sk_buff *skb)
 static inline int copy_linear_skb(struct sk_buff *skb, int len, int off,
 				  struct iov_iter *to)
 {
-	int n;
-
-	n = copy_to_iter(skb->data + off, len, to);
-	if (n == len)
-		return 0;
-
-	iov_iter_revert(to, n);
-	return -EFAULT;
+	return copy_to_iter_full(skb->data + off, len, to) ? 0 : -EFAULT;
 }
 
 /*
