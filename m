Return-Path: <linux-fsdevel+bounces-71690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83592CCDA01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 22:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D5030C0837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15D22D8DB0;
	Thu, 18 Dec 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J66Awytj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368F32570E
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091381; cv=none; b=JZyqGx+uM7SmA9EiIon7otFb5rZn43uXBVi2swl/EbLnzP3HiNGeWWomQGoOqRnp1JfSG1js6adXAE5Pbj5qFtp3Lra2CnW0a0sPrliWrT8YIrg/HcPvVhbCbXRPYIHNhNUjZQPLg/2geva7tuymyA52EehC7e44XiA3X0KZWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091381; c=relaxed/simple;
	bh=c6pCC0uNJAWdd4fao39X0vYPTeUC9jxy7Iq5vliz+E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBiCRShRTWVwQy526rtv183O7dYeImQ3X6/eRBlgxHQfekOWZcV0SdIZ+70u4AfZm2sChnftvppRF8QJwjVh7k1UXqACo55gI/OZ15QJjoeMeLmfwaae4345rHEOvuBMRdgG0HNWVxnJjgl2zfzVouPnra/HOsoLI4y4y5KsRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J66Awytj; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766091365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C7WJGFzPgQgbOew4Nik7yqwK94tl6F+VcxmeN5CTI3c=;
	b=J66Awytj8ygIwxw+zjd2Kmu4idD3ts6dRYW5m49ISTg/x8/eNiIojqqsx++kq2/NFN31aV
	gNPB7Yore+WyDHhO4VdU/Qf39r3vGjshg2M6t4VmpUw/OorBr9Ts+xAl73gRYKZ9pJMOmY
	+v2WbzeYvGdxJV/tSfYchwRoKuZniuw=
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
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH bpf v2] lib/buildid: use __kernel_read() for sleepable context
Date: Thu, 18 Dec 2025 12:55:05 -0800
Message-ID: <20251218205505.2415840-1-shakeel.butt@linux.dev>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---

Changes since v1:
- Fix handling of buf in freader_fetch_sync as pointed out by Andrii.

 lib/buildid.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index aaf61dfc0919..93b3a06e7f7a 100644
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
+		ret = __kernel_read(r->file, buf, sz, &pos);
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


