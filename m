Return-Path: <linux-fsdevel+bounces-71840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E1CD72AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 21:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ABBC30161DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 20:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50633EB02;
	Mon, 22 Dec 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nZJflpUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417EB33EAF2
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437179; cv=none; b=kz1QZ9DeepF01I0IMi5qcDP0R9J2btAZ4QvbBo8dRyK7TbgqnmfxTMrQSVnqJeROGMx+li7cyLLNlIhQbVr3LjzYRih3RjwK4FIcYAI7mhSEMfsH9FKjNiXlJ/kCeS1zrJEJ1LoetI+Y+bYtjj+lA8Ni6dg55gOgSOO46JVjlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437179; c=relaxed/simple;
	bh=kMdCxkht18x9bBbqK0FNo64KlMe+2ekZS483yWEVYHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiZDYHp6nC/SIARDsGG4SUziSOaRD9XKrrARe6UqDIyfIpfNdyAaHu/3peB8qV3r2a3RqtSAnyqmgJp1jRH99uPrxzLf0P7pyEhhcppwed2UCML989UoMDnAYaqGEq7xCyJM34AFxiA4Y3bNDKHWhCbT93Mk6Pgj1yhzESl+b7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nZJflpUs; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766437166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mZ/UtThSWtPu4Oy8X58uMB22wy61L0gvY9PyQceVLTU=;
	b=nZJflpUsEdvMGyI7nb87aSCrQNiiKJayQuZfosbzlkuNU26egktK+1mOkpm5W8jBaedN5p
	SgVxLaZHZTNPGYMxoXL5rfR/0lFkBVZYkoct5EWYXyt0vb6a4NwF8xZnD7ZSgyt7SvkBOq
	KFA2NzPlh3c/fN8xZlPev1flXkvW/pk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH bpf v3] lib/buildid: use __kernel_read() for sleepable context
Date: Mon, 22 Dec 2025 12:58:59 -0800
Message-ID: <20251222205859.3968077-1-shakeel.butt@linux.dev>
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
Changes since v2:
- Single call to __kernel_read instead of looping (Matthew Wilcox).

Changes since v1:
- Fix handling of buf in freader_fetch_sync as pointed out by Andrii.

 lib/buildid.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index aaf61dfc0919..818331051afe 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/fs.h>
 #include <linux/secretmem.h>
 
 #define BUILD_ID 3
@@ -46,20 +47,9 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
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
@@ -97,6 +87,24 @@ const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
 		return r->data + file_off;
 	}
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (secretmem_mapping(r->file->f_mapping)) {
+		r->err = -EFAULT;
+		return NULL;
+	}
+
+	/* use __kernel_read() for sleepable context */
+	if (r->may_fault) {
+		ssize_t ret;
+
+		ret = __kernel_read(r->file, r->buf, sz, &file_off);
+		if (ret != sz) {
+			r->err = (ret < 0) ? ret : -EIO;
+			return NULL;
+		}
+		return r->buf;
+	}
+
 	/* fetch or reuse folio for given file offset */
 	r->err = freader_get_folio(r, file_off);
 	if (r->err)
-- 
2.47.3


