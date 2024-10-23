Return-Path: <linux-fsdevel+bounces-32670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A1E9ACC47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7417B210AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603E1BDA8F;
	Wed, 23 Oct 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9czwW9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421EF1AAE00
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693747; cv=none; b=Vd+CZsmkaYxujWOgdQkxoqUA52Q1IDZdDO3bMAwo+8aRTNyPaiW/Z/+sMSrWo1Svkpn/Hzg2bY/Gr0Fbcfuye/f2PtqATJUmyndhT3eF7JJdM5T+GD0eTJ2ZFykXSEqtzkgDi33neC6Dk3GahhLOtzCt9QB3OX4/jnQQ0kLAk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693747; c=relaxed/simple;
	bh=Tu8ecogdCdvt2J0mJBiKRPfQ+w1yLZPbr87RxntHYwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c/Cw15stnOZNPAIIJho5XAiDScaMIqx2MtEpS2wtTu2vasEF4pNlI8pHRAwmfKJhW3AeiI+ugdM378dPr4DZc2KzTjd+/OseVq9nmyH1UH6q4zaMrWAZKenuJqHhUMl+t2A0IhEpbZKihqTZ1NvQwaz8qHc/StBNsuK49QnLxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9czwW9x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729693744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e7NVJ2YYlWVkHDgXUttFCV5Utvw2Dli9IBctxz9RysU=;
	b=X9czwW9xnvxwQg0vLkyNbKZ2hLslnGw8IeaybhiBTkr2FWaZvPOZSZ8P2PMbQhp2ljFY70
	uLq8NtSShMTa3dl8ynklYqOtBAXeXJvvsFSzP9Dz0RZcO5Ur+VAFYQLAFBebRkRqc1FLSW
	18kyhourMxy1aVfuMKvuyNnieIv4uMI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-SzzrWgHYPEKYrBQDQHWclA-1; Wed,
 23 Oct 2024 10:29:02 -0400
X-MC-Unique: SzzrWgHYPEKYrBQDQHWclA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B36BB1955EA5;
	Wed, 23 Oct 2024 14:29:01 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.135])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 182F519560AE;
	Wed, 23 Oct 2024 14:29:00 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH] iomap: elide zero range flush from partial eof zeroing
Date: Wed, 23 Oct 2024 10:30:29 -0400
Message-ID: <20241023143029.11275-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

iomap zero range performs a pagecache flush upon seeing unwritten
extents with dirty pagecache in order to determine accurate
subranges that require direct zeroing. This is to support an
optimization where clean, unwritten ranges are skipped as they are
already zero on-disk.

Certain use cases for zero range are more sensitive to flush latency
than others. The kernel test robot recently reported a regression in
the following stress-ng workload on XFS:

  stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64

This workload involves a series of small, strided, write extending
writes. On XFS, this produces a pattern of allocating post-eof
speculative preallocation, converting preallocation to unwritten on
zero range calls, dirtying pagecache over the converted mapping, and
then repeating the sequence again from the updated EOF. This
basically produces a sequence of pagecache flushes on the partial
EOF block zeroing use case of zero range.

To mitigate this problem, special case the EOF block zeroing use
case to prefer zeroing over a pagecache flush when the EOF folio is
already dirty. This brings most of the performance back by avoiding
flushes on write and truncate extension operations, while preserving
the ability for iomap to flush and properly process larger ranges.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi iomap maintainers,

This is an incremental optimization for the regression reported by the
test robot here[1]. I'm not totally convinced this is necessary as an
immediate fix, but the discussion on that thread was enough to suggest
it could be. I don't really love the factoring, but I had to play a bit
of whack-a-mole between fstests and stress-ng to restore performance and
still maintain behavior expectations for some of the tests.

On a positive note, exploring this gave me what I think is a better idea
for dealing with zero range overall, so I'm working on a followup to
this that reworks it by splitting zero range across block alignment
boundaries (similar to how something like truncate page range works, for
example). This simplifies things by isolating the dirty range check to a
single folio on an unaligned start offset, which lets the _iter() call
do a skip or zero (i.e. no more flush_and_stale()), and then
unconditionally flush the aligned portion to end-of-range. The latter
flush should be a no-op for every use case I've seen so far, so this
might entirely avoid the need for anything more complex for zero range.

In summary, I'm posting this as an optional and more "stable-worthy"
patch for reference and for the maintainers to consider as they like. I
think it's reasonable to include if we are concerned about this
particular stress-ng test and are Ok with it as a transient solution.
But if it were up to me, I'd probably sit on it for a bit to determine
if a more practical user/workload is affected by this, particularly
knowing that I'm trying to rework it. This could always be applied as a
stable fix if really needed, but I just don't think the slightly more
invasive rework is appropriate for -rc..

Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-xfs/202410141536.1167190b-oliver.sang@intel.com/

 fs/iomap/buffered-io.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index aa587b2142e2..8fd25b14d120 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1372,6 +1372,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	loff_t written = 0;
+	bool eof_zero = false;
 
 	/*
 	 * We must zero subranges of unwritten mappings that might be dirty in
@@ -1391,12 +1392,23 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	 * triggers writeback time post-eof zeroing.
 	 */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
-		if (*range_dirty) {
+		/* range is clean and already zeroed, nothing to do */
+		if (!*range_dirty)
+			return length;
+
+		/* flush for anything other than partial eof zeroing */
+		if (pos != i_size_read(iter->inode) ||
+		   (pos % i_blocksize(iter->inode)) == 0) {
 			*range_dirty = false;
 			return iomap_zero_iter_flush_and_stale(iter);
 		}
-		/* range is clean and already zeroed, nothing to do */
-		return length;
+		/*
+		 * Special case partial EOF zeroing. Since we know the EOF
+		 * folio is dirty, prefer in-memory zeroing for it. This avoids
+		 * excessive flush latency on frequent file size extending
+		 * operations.
+		 */
+		eof_zero = true;
 	}
 
 	do {
@@ -1415,6 +1427,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 		offset = offset_in_folio(folio, pos);
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
+		if (eof_zero && length > bytes)
+			length = bytes;
 
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
-- 
2.46.2


