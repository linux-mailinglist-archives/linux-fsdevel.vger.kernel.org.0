Return-Path: <linux-fsdevel+bounces-58175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2937B2AAB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8406E6C84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351832A3D0;
	Mon, 18 Aug 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZOr8yDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807A183CC3;
	Mon, 18 Aug 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526156; cv=none; b=OenkqdJ6LZSVmpVN9cIfR4wzq/rrMXdSAFmkvzMNmODXqd81eAySd48i3x3cfrYxGUkoHAuWjJQ1KRIaPx4Q4flK6NMw53uX195xnU9TqGrvfUgmOJ4K1i6VN84ZfpupuKcv1nvgW6Um9s9TsNblPudkQsQCjxz6L1EBrSdjLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526156; c=relaxed/simple;
	bh=uHinza1r+FpZd8ytjP/XxB+mSOCXk6ERC6D6cWYInzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr+hOzzFx2YMeL7+dh1CZJXWXJyGz+MmC6jpFsYo7LkMuPKX7impdPnSjQOvR6i45mljlf+ZxGD0tczvijr8YBwmJtkL7u582aviCPyHC5V7SxcznqKP3sLIeoojGYtcHoF7dGkOyIN4XxHd7tWncPXMiXmuvmhnI8JKJSsEJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZOr8yDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB37C4CEEB;
	Mon, 18 Aug 2025 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526155;
	bh=uHinza1r+FpZd8ytjP/XxB+mSOCXk6ERC6D6cWYInzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZOr8yDaUHvgYX8ah4JQBs//GDwRmbVQs3+++Z5Hm1qpdF79/A6K/gzcniX1ETLB6
	 NcHb+i78dAijQ8rjaMPrINM3xKDP5s3427lPKZlZeV0f6jW7FhDIj2evPzOh/boGDw
	 F9uqduLCEj+9WJunRsGYfhP3+XRaER7FExGRIMGE=
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
Subject: [PATCH 6.16 474/570] cifs: Fix collect_sample() to handle any iterator type
Date: Mon, 18 Aug 2025 14:47:41 +0200
Message-ID: <20250818124524.148858735@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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




