Return-Path: <linux-fsdevel+bounces-38061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6789FB0AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 16:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED91C1882673
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1012D1F1;
	Mon, 23 Dec 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="noQuk3mg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC12E403;
	Mon, 23 Dec 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734967316; cv=none; b=OJNZPm025DTgX/b6IuKnMzQOj67kYbWjpdZVJn7LvMKNFLH6/fmBw+cpzQ9+Jp4wZXJP5vYXRKRXwE/WYy81O0HiPyChaM/H3V6worGTCE7psn79y6sWgSg2RKpWpVocTsVVq54/ocmYRlkYYSSJtAos2atZdnwEB464pzgPzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734967316; c=relaxed/simple;
	bh=Xhgzv4gpNO7A2eMEmmpQSfc/XkACFiDFJo09eMT+irg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BXgstLrRPbGozQP7QDKBAHhDGBJlNQmxnu3uVic7H9l2+yb2wcvwiut5CX4eCDFCcbBtVRS6AKcXbTd+nP02aev7BB2Aikw9LGZj5eCWP7xFJSR1fXY3m7/03D13OBG337ph6C5lJbzmSBE6JdQG+vRGVBKv5xLkfAsRaoFkzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=noQuk3mg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lwg3g
	4+HL4JSB54lIF6+JxnVXREtEMTD2+CvktDAyr4=; b=noQuk3mgM05mld4050sKw
	10+lO0zBJ9wzR0VSzk3lkf4SC0Czf2lwB1XfnfAtIYj1/D9s4Jftw2y/f5wTB66Y
	t7XhjvTGaVZJ3D7g7DShdYju54YKfbpM4+FqxyQCsQJqlLn00qRem8EQwYmSYTtQ
	azROUgJ0XVFofmDEtiHokQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnz1DOf2lnS9uyBA--.3065S4;
	Mon, 23 Dec 2024 23:21:03 +0800 (CST)
From: David Wang <00107082@163.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	akpm@linux-foundation.org,
	David Wang <00107082@163.com>
Subject: [PATCH] seq_file: add seq_check_showsize_overflow() to avoid real overflow
Date: Mon, 23 Dec 2024 23:20:45 +0800
Message-Id: <20241223152045.206401-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz1DOf2lnS9uyBA--.3065S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw4ruw4fKF4fKr48CF45Jrb_yoW3WFy7pF
	1ruanI9a18ZFW7Z34xArn8Gw15Xa18tayUGFZxCFWfJ34xtwsIqas5Gr1jgw45Gry0yw45
	XrZxG3s5G34jvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEJ5rnUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gq+qmdpcIa9mwABsT

Overflow happens when op->show() reaches buffer capacity, and when this
happens, the data fetched and printed is wasted for current show() and
needs to be fetched and printed again in next show(). Assuming each
show() yields data with size m, then for every `floor(seq_file->size/m)`
show() calls there will be one show() duplicated due to overflow. When
m is larger than half of seq_file->size, every show() will be duplicated
except the first one, this happens to /proc/interrupts when there are
hundreds of CPUs.

More than one duplicated/wasted show() for a single record happens when
the record size for show() is way too large, because seq_read() only
doubles buffer size and make a retry until no overflow happened.
For example, /proc/vmallocinfo yields huge size of
data with a *single* show() call, on one instance, the size is 424810
bytes, the buffer doubling process would make 8 rounds of retries to make
buffer large enough: (PAGE_SIZE=4096)*2*2*2*2*2*2*2=524288 > 424810,
meaning one read of /proc/vmallocinfo actually iterates the whole vm data
8 times.  Huge data yielded by one single show() also happens to
arch_show_interrupts() for /proc/interrupts when there are hundreds
of CPUs: on arch x86 with 256 CPUs, arch_show_interrupts() would yield
about 48436 bytes, which needs 5 round of data fetching:
4096*2*2*2*2=65536 > 48436.

The lack of information is the problem here, add an interface for caller
to register an *estimated* showsize before actually fetching/printing the
real data. Buffer size doubling calculation stop until reach the maximum
registered showsize, and when an overflow is expected, break out the
show() loop and copy the data to user buffer.

For example, show_interrupts() can use following code to check overflow
before fetching/printing interrupt counters

        /* nr_cpu+2 columns, each 10bytes wide */
	if (seq_check_showsize_overflow(p, (nr_cpu+2)*10))
		return -EOVERFLOW;

On a 1CPU vm, duplicate cpu interrupt data 256 times in show_interrupts()
and arch_show_interrupts() for /proc/interrupts,
timing for reads without seq_check_showsize_overflow():

	$ strace -T -e read cat /proc/interrupts  > /dev/null
	...
	read(3, "           CPU0       CPU0      "..., 131072) = 2828 <0.000078>
	read(3, "  1:          9          9      "..., 131072) = 2850 <0.000054>
	read(3, "  8:          0          0      "..., 131072) = 2849 <0.000072>
	read(3, "  9:          0          0      "..., 131072) = 2849 <0.000080>
	read(3, " 12:        144        144      "..., 131072) = 2850 <0.000075>
	read(3, " 16:          0          0      "..., 131072) = 2855 <0.000076>
	read(3, " 21:         14         14      "..., 131072) = 2848 <0.000077>
	read(3, " 22:         10         10      "..., 131072) = 2861 <0.000076>
	read(3, " 24:          1          1      "..., 131072) = 2882 <0.000073>
	read(3, " 25:          1          1      "..., 131072) = 2882 <0.000074>
	read(3, " 26:          1          1      "..., 131072) = 2882 <0.000074>
	read(3, " 27:          1          1      "..., 131072) = 2882 <0.000101>
	read(3, " 28:          1          1      "..., 131072) = 2882 <0.000064>
	read(3, " 29:          1          1      "..., 131072) = 2882 <0.000066>
	read(3, " 30:          1          1      "..., 131072) = 2882 <0.000065>
	read(3, " 31:          0          0      "..., 131072) = 2872 <0.000052>
	read(3, " 32:       3787       3787      "..., 131072) = 2871 <0.000049>
	read(3, " 33:          0          0      "..., 131072) = 2872 <0.000079>
	read(3, " 34:        127        127      "..., 131072) = 2873 <0.000073>
	read(3, " 35:        103        103      "..., 131072) = 2874 <0.000055>
	read(3, " 36:         32         32      "..., 131072) = 2866 <0.000051>
	read(3, " 38:        139        139      "..., 131072) = 2875 <0.000069>
	read(3, " 39:          0          0      "..., 131072) = 2872 <0.000067>
	read(3, " 40:         17         17      "..., 131072) = 2876 <0.000055>
	read(3, " 41:        105        105      "..., 131072) = 2876 <0.000194>
	read(3, "NMI:          0          0      "..., 131072) = 48436 <0.000874>
	read(3, "", 131072)                     = 0 <0.000013>

Adding up, totally 0.002736s.
And with seq_check_showsize_overflow() added in show_interrupts():

	$ strace -T -e read cat /proc/interrupts  > /dev/null
	...
	read(3, "           CPU0       CPU0      "..., 131072) = 2828 <0.000070>
	read(3, "  1:          9          9      "..., 131072) = 2850 <0.000040>
	read(3, "  8:          0          0      "..., 131072) = 2849 <0.000041>
	read(3, "  9:          0          0      "..., 131072) = 2849 <0.000040>
	read(3, " 12:        144        144      "..., 131072) = 2850 <0.000060>
	read(3, " 16:          0          0      "..., 131072) = 2855 <0.000042>
	read(3, " 21:         14         14      "..., 131072) = 2848 <0.000045>
	read(3, " 22:         10         10      "..., 131072) = 2861 <0.000044>
	read(3, " 24:          1          1      "..., 131072) = 2882 <0.000042>
	read(3, " 25:          1          1      "..., 131072) = 2882 <0.000042>
	read(3, " 26:          1          1      "..., 131072) = 2882 <0.000042>
	read(3, " 27:          1          1      "..., 131072) = 2882 <0.000042>
	read(3, " 28:          1          1      "..., 131072) = 2882 <0.000041>
	read(3, " 29:          1          1      "..., 131072) = 2882 <0.000036>
	read(3, " 30:          1          1      "..., 131072) = 2882 <0.000042>
	read(3, " 31:          0          0      "..., 131072) = 2872 <0.000041>
	read(3, " 32:        285        285      "..., 131072) = 2873 <0.000044>
	read(3, " 33:        238        238      "..., 131072) = 2874 <0.000044>
	read(3, " 34:        138        138      "..., 131072) = 2875 <0.000044>
	read(3, " 35:          0          0      "..., 131072) = 2872 <0.000042>
	read(3, " 36:       3856       3856      "..., 131072) = 2871 <0.000044>
	read(3, " 37:         32         32      "..., 131072) = 2866 <0.000066>
	read(3, " 39:          0          0      "..., 131072) = 2872 <0.000064>
	read(3, " 40:         22         22      "..., 131072) = 2876 <0.000066>
	read(3, " 41:        105        105      "..., 131072) = 2876 <0.000066>
	read(3, "NMI:          0          0      "..., 131072) = 48436 <0.000296>
	read(3, "", 131072)                     = 0 <0.000037>

Adding up, totally 0.001523s, a significant improvement comparing with 0.002736s.

Signed-off-by: David Wang <00107082@163.com>
---
 fs/seq_file.c            | 28 ++++++++++++++++++----------
 include/linux/seq_file.h | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 8bbb1ad46335..6e2f1ba2782b 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -228,21 +228,29 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (!p || IS_ERR(p))	// EOF or an error
 			break;
 		err = m->op->show(m, p);
-		if (err < 0)		// hard error
-			break;
-		if (unlikely(err))	// ->show() says "skip it"
-			m->count = 0;
-		if (unlikely(!m->count)) { // empty record
-			p = m->op->next(m, p, &m->index);
-			continue;
+		if (err != -EOVERFLOW) {
+			if (err < 0)		// hard error
+				break;
+			if (unlikely(err))	// ->show() says "skip it"
+				m->count = 0;
+			if (unlikely(!m->count)) { // empty record
+				p = m->op->next(m, p, &m->index);
+				continue;
+			}
+			if (!seq_has_overflowed(m)) // got it
+				goto Fill;
 		}
-		if (!seq_has_overflowed(m)) // got it
-			goto Fill;
 		// need a bigger buffer
 		m->op->stop(m, p);
 		kvfree(m->buf);
 		m->count = 0;
-		m->buf = seq_buf_alloc(m->size <<= 1);
+		do {
+			m->size <<= 1;
+			/* set 16MB as limit in case max_showsize goes wide */
+			if (m->size > (1 << 24))
+				goto Enomem;
+		} while (m->size <= m->max_showsize);
+		m->buf = seq_buf_alloc(m->size);
 		if (!m->buf)
 			goto Enomem;
 		p = m->op->start(m, &m->index);
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 2fb266ea69fa..64d02b770d9d 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -26,6 +26,7 @@ struct seq_file {
 	int poll_event;
 	const struct file *file;
 	void *private;
+	size_t max_showsize;
 };
 
 struct seq_operations {
@@ -52,6 +53,24 @@ static inline bool seq_has_overflowed(struct seq_file *m)
 	return m->count == m->size;
 }
 
+/**
+ * seq_check_showsize_overflow - check if the buffer *would* be overflowed
+ * @m: the seq_file handle
+ * @showsize: the number of bytes to be written to buffer in next show()
+ *
+ * If next show() would not fit in current buffer, no need to fetch
+ * and print it. The showsize should be estimated without actually
+ * fetching the data.
+ *
+ * Returns true if print the data of size showsize would cause buffer
+ * overflowed.
+ */
+static inline bool seq_check_showsize_overflow(struct seq_file *m, size_t showsize)
+{
+	m->max_showsize = max(m->max_showsize, showsize);
+	return m->count + showsize >= m->size;
+}
+
 /**
  * seq_get_buf - get buffer to write arbitrary data to
  * @m: the seq_file handle
-- 
2.39.2


