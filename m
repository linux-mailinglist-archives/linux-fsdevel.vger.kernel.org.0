Return-Path: <linux-fsdevel+bounces-71588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA70CC9F07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 242C4302858E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 00:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D9D242D7B;
	Thu, 18 Dec 2025 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/yKrYt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A923EA82
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019542; cv=none; b=KvdALqb4AGoE3rRkKKK005+l+D5mANajw+CP3ELpR/SUbTOd1y5XpxxgPkrMZhAkMvhDgCX+M0TE9i9/jqybohmvnGBDSVMLwrzMlAaDd+YoyDeMYjsY3W9wChVjVOTpER9XHv3S6tjIyhLEmvLTj64AAW43V2dSLfwBJNzM+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019542; c=relaxed/simple;
	bh=NzJPmFMLogKy3D3qYmfDe7YMBODF/8CZUsAhKYaciUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syNX4rqI6JFfMau8c9W8PmN4KbEcJ4CgUxFvf5OF4r8bGvA/Fh76+Y3d5uyKsmCyeGSsJh5Q8jq0yaXkY7bS7kFFh6C4j3UI2Vol3rcwYRCNVdeTmyKjfDSDVIIqFb0NN4/uWy9kE5IJTeU3RNyTTlsLDFK2nmA1ViCsKYVrlaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/yKrYt5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766019537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FLWdrmcOXEsn7JZI2AfrrHLsKmuHiuoeH/04si3RGkU=;
	b=m/yKrYt5HoWNtJeA+j0Hu6aLAMgMu5AjYG/IguQGaktUvPC9JVFLH5YTW/m41v4Hw1xukx
	+aY+Y1OcgfnlcYm7X4kxfHQ8JEeRiheY9gAK4XdGIq8wJsz/y+03u4JQdkVV61P4CctyzD
	thnzVrGb6eGQf7nMKPFxWbONYzedpgY=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Meta kernel team <kernel-team@meta.com>,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: [PATCH] lib/buildid: use __kernel_read() for sleepable context
Date: Wed, 17 Dec 2025 16:58:18 -0800
Message-ID: <20251218005818.614819-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For the sleepable context, convert freader to use __kernel_read()
instead of direct page cache access via read_cache_folio(). This
simplifies the faultable code path by using the standard kernel file
reading interface which handles all the complexity of reading file data.

At the moment we are not changing the code for non-sleepable context
which uses filemap_get_folio() and only succeeds if the target folios
are already in memory and up-to-date. The reason is to keep the patch
simple and easier to backport to stable kernels.

Syzbot repro does not crash the kernel anymore and the selftests run
successfully.

In the follow up we will make __kernel_read() with IOCB_NOWAIT work for
non-sleepable contexts. In addition, I would like to replace the
secretmem check with a more generic approach and will add fstest for the
buildid code.

Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 lib/buildid.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index aaf61dfc0919..e7e258532720 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/fs.h>
 #include <linux/secretmem.h>
 
 #define BUILD_ID 3
@@ -37,6 +38,29 @@ static void freader_put_folio(struct freader *r)
 	r->folio = NULL;
 }
 
+/*
+ * Data is read directly into r->buf. Returns pointer to the buffer
+ * on success, NULL on failure with r->err set.
+ */
+static const void *freader_fetch_sync(struct freader *r, loff_t file_off, size_t sz)
+{
+	ssize_t ret;
+	loff_t pos = file_off;
+	char *buf = r->buf;
+
+	do {
+		ret = __kernel_read(r->file, r->buf, sz, &pos);
+		if (ret <= 0) {
+			r->err = ret ?: -EIO;
+			return NULL;
+		}
+		buf += ret;
+		sz -= ret;
+	} while (sz > 0);
+
+	return r->buf;
+}
+
 static int freader_get_folio(struct freader *r, loff_t file_off)
 {
 	/* check if we can just reuse current folio */
@@ -46,20 +70,9 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
 	freader_put_folio(r);
 
-	/* reject secretmem folios created with memfd_secret() */
-	if (secretmem_mapping(r->file->f_mapping))
-		return -EFAULT;
-
+	/* only use page cache lookup - fail if not already cached */
 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
 
-	/* if sleeping is allowed, wait for the page, if necessary */
-	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
-		filemap_invalidate_lock_shared(r->file->f_mapping);
-		r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
-					    NULL, r->file);
-		filemap_invalidate_unlock_shared(r->file->f_mapping);
-	}
-
 	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
 		if (!IS_ERR(r->folio))
 			folio_put(r->folio);
@@ -97,6 +110,16 @@ const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
 		return r->data + file_off;
 	}
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (secretmem_mapping(r->file->f_mapping)) {
+		r->err = -EFAULT;
+		return NULL;
+	}
+
+	/* use __kernel_read() for sleepable context */
+	if (r->may_fault)
+		return freader_fetch_sync(r, file_off, sz);
+
 	/* fetch or reuse folio for given file offset */
 	r->err = freader_get_folio(r, file_off);
 	if (r->err)
-- 
2.47.3


