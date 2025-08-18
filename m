Return-Path: <linux-fsdevel+bounces-58169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43259B2A7B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742651BA23B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43AC322545;
	Mon, 18 Aug 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2O53Bp0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876431E115;
	Mon, 18 Aug 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524423; cv=none; b=NWAu0BddLGTZizKra9x9zhdWW2XiiCkmlD6SmpPPaNmCx8/8AmieWlUS+5csOmN3eoyKIS7gKji7rL3tbUFIKltHC4qDKTvl48RBCZHkxfyMJ+NFZX2SC5irLDXHIDXKzXi0YNy2cNO8vclwXJlKwse8VzODf7pg3OJZF8Pn+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524423; c=relaxed/simple;
	bh=8nIojMQm2ypYmC9hdDff95GxIbCA8jCk0PdU0t7NsGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re+GypXoeDqXvE1X59/ZrmGuJz8EvnCnqZHmOmL/j3E3zFLUUggEXBDbJQaaPZ6TOXTmHsdbg+AP50Zo15+PHjsBluWM8DNSRrhCtvUq4O0DUqbumNP9iE6jlNQSyBaTDCedkPn7JnEHkPJRyW4rTAHBoP/HSO+3YtvYuO16KbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2O53Bp0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898A5C4CEF1;
	Mon, 18 Aug 2025 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524422;
	bh=8nIojMQm2ypYmC9hdDff95GxIbCA8jCk0PdU0t7NsGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2O53Bp0tQreXjOfaL5yrDl+a1dykpEpzOi27T7SoKOKOkKBkyb8gLjtyzx7n5o6Wk
	 08CWHZ9nE4jTEGzlo3x4LUC0WvuEtU8dQQvIUTYmgz+3P+N2DmjW9c/Usxq7/ZgxL7
	 mz4YzWIAoFiPZok7ql0F23GdZYMAOeoKsdOt/rJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 435/515] cifs: Fix collect_sample() to handle any iterator type
Date: Mon, 18 Aug 2025 14:47:01 +0200
Message-ID: <20250818124515.174262128@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit b63335fb3d32579c5ff0b7038b9cc23688fff528 ]

collect_sample() is used to gather samples of the data in a Write op for
analysis to try and determine if the compression algorithm is likely to
achieve anything more quickly than actually running the compression
algorithm.

However, collect_sample() assumes that the data it is going to be sampling
is stored in an ITER_XARRAY-type iterator (which it now should never be)
and doesn't actually check that it is before accessing the underlying
xarray directly.

Fix this by replacing the code with a loop that just uses the standard
iterator functions to sample every other 2KiB block, skipping the
intervening ones.  It's not quite the same as the previous algorithm as it
doesn't necessarily align to the pages within an ordinary write from the
pagecache.

Note that the btrfs code from which this was derived samples the inode's
pagecache directly rather than the iterator - but that doesn't necessarily
work for network filesystems if O_DIRECT is in operation.

Fixes: 94ae8c3fee94 ("smb: client: compress: LZ77 code improvements cleanup")
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/compress.c | 71 ++++++++++++----------------------------
 1 file changed, 21 insertions(+), 50 deletions(-)

diff --git a/fs/smb/client/compress.c b/fs/smb/client/compress.c
index 766b4de13da7..db709f5cd2e1 100644
--- a/fs/smb/client/compress.c
+++ b/fs/smb/client/compress.c
@@ -155,58 +155,29 @@ static int cmp_bkt(const void *_a, const void *_b)
 }
 
 /*
- * TODO:
- * Support other iter types, if required.
- * Only ITER_XARRAY is supported for now.
+ * Collect some 2K samples with 2K gaps between.
  */
-static int collect_sample(const struct iov_iter *iter, ssize_t max, u8 *sample)
+static int collect_sample(const struct iov_iter *source, ssize_t max, u8 *sample)
 {
-	struct folio *folios[16], *folio;
-	unsigned int nr, i, j, npages;
-	loff_t start = iter->xarray_start + iter->iov_offset;
-	pgoff_t last, index = start / PAGE_SIZE;
-	size_t len, off, foff;
-	void *p;
-	int s = 0;
-
-	last = (start + max - 1) / PAGE_SIZE;
-	do {
-		nr = xa_extract(iter->xarray, (void **)folios, index, last, ARRAY_SIZE(folios),
-				XA_PRESENT);
-		if (nr == 0)
-			return -EIO;
-
-		for (i = 0; i < nr; i++) {
-			folio = folios[i];
-			npages = folio_nr_pages(folio);
-			foff = start - folio_pos(folio);
-			off = foff % PAGE_SIZE;
-
-			for (j = foff / PAGE_SIZE; j < npages; j++) {
-				size_t len2;
-
-				len = min_t(size_t, max, PAGE_SIZE - off);
-				len2 = min_t(size_t, len, SZ_2K);
-
-				p = kmap_local_page(folio_page(folio, j));
-				memcpy(&sample[s], p, len2);
-				kunmap_local(p);
-
-				s += len2;
-
-				if (len2 < SZ_2K || s >= max - SZ_2K)
-					return s;
-
-				max -= len;
-				if (max <= 0)
-					return s;
-
-				start += len;
-				off = 0;
-				index++;
-			}
-		}
-	} while (nr == ARRAY_SIZE(folios));
+	struct iov_iter iter = *source;
+	size_t s = 0;
+
+	while (iov_iter_count(&iter) >= SZ_2K) {
+		size_t part = umin(umin(iov_iter_count(&iter), SZ_2K), max);
+		size_t n;
+
+		n = copy_from_iter(sample + s, part, &iter);
+		if (n != part)
+			return -EFAULT;
+
+		s += n;
+		max -= n;
+
+		if (iov_iter_count(&iter) < PAGE_SIZE - SZ_2K)
+			break;
+
+		iov_iter_advance(&iter, SZ_2K);
+	}
 
 	return s;
 }
-- 
2.50.1




