Return-Path: <linux-fsdevel+bounces-50764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73024ACF55F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB33A1893FD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFB278156;
	Thu,  5 Jun 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0E8xWDP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE619D06A
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144635; cv=none; b=Qc46WuDSh4V6UWiwEuALL/E63Ia4FSrpO4KiyjQ1yvqW12+S1P6jAEgW9r07ZqFDkPHIkB5dPMS0P71d6Z2pJR1sGSXyOLt0kHIqJADyOhfns6tD+TjTeoEObTdfiS0BVq267fjWt2NMFJLRsc+hplckqX7cejLlEs5lhOCnmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144635; c=relaxed/simple;
	bh=rzGHRJvqy/BBiSMtVetnQmA1h+ea2G/lgh1dxA9gNO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQewVxmyzXSZw7LlMusgxh15r2LiWJBSLisrxkSTiN69H5onIhhPIJWSilLfn8nsme20VtlLzjAcJ3FNRfB461s+7162bjmYDdVMf5YZ362UGQBTakVYbw4rNtj6LpO1CBh0WSvIlgo01zlfrT4EXRabjzRyEgI9KJi57dD8KLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0E8xWDP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EoX7XR7J0u5HTsNSFCTHL4yND2pXpga4e+oQ9c14p10=;
	b=K0E8xWDPhxZVoeyPISAPwAsVh8l88GMO+hv+4/sqyJWkHu3U5LdfnZi5xyzV1I9ntMqTvA
	zJAIfQcvLhNbx3bD46yGixNbgBFpeE97c6+w2t77dOuC55f5DG2FskmKXKHvNj5ylEajnL
	3TdjoolPJCmMb6RP3WNT2DmAnEv6X60=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-FEWLSOEYN529DZZ8DpnCFg-1; Thu,
 05 Jun 2025 13:30:29 -0400
X-MC-Unique: FEWLSOEYN529DZZ8DpnCFg-1
X-Mimecast-MFC-AGG-ID: FEWLSOEYN529DZZ8DpnCFg_1749144628
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B40C1800378;
	Thu,  5 Jun 2025 17:30:28 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3036130002C0;
	Thu,  5 Jun 2025 17:30:27 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] iomap: zero range folio batch support
Date: Thu,  5 Jun 2025 13:33:50 -0400
Message-ID: <20250605173357.579720-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi all,

Here's a first real v1 of folio batch support for iomap. This initially
only targets zero range, the use case being zeroing of dirty folios over
unwritten mappings. There is potential to support other operations in
the future: iomap seek data/hole has similar raciness issues as zero
range, the prospect of using this for buffered write has been raised for
granular locking purposes, etc.

The one major caveat with this zero range implementation is that it
doesn't look at iomap_folio_state to determine whether to zero a
sub-folio portion of the folio. Instead it just relies on whether the
folio was dirty or not. This means that spurious zeroing of unwritten
ranges is possible if a folio is dirty but the target range includes a
subrange that is not.

The reasoning is that this is essentially a complexity tradeoff. The
current use cases for iomap_zero_range() are limited mostly to partial
block zeroing scenarios. It's relatively harmless to zero an unwritten
block (i.e. not a correctness issue), and this is something that
filesystems have done in the past without much notice or issue. The
advantage is less code and this makes it a little easier to use a
filemap lookup function for the batch rather than open coding more logic
in iomap. That said, this can probably be enhanced to look at ifs in the
future if the use case expands and/or other operations justify it.

WRT testing, I've tested with and without a local hack to redirect
fallocate zero range calls to iomap_zero_range() in XFS. This helps test
beyond the partial block/folio use case, i.e. to cover boundary
conditions like full folio batch handling, etc. I recently added patch 7
in spirit of that, which turns this logic into an XFS errortag. Further
comments on that are inline with patch 7.

Thoughts, reviews, flames appreciated.

Brian

v1:
- Dropped most prep patches from previous version (merged separately).
- Reworked dirty folio lookup to use find_get_entry() loop (new patch
  for filemap helper).
- Misc. bug fixes, code cleanups, comments, etc.
- Added (RFC) prospective patch for wider zero range test coverage.
RFCv2: https://lore.kernel.org/linux-fsdevel/20241213150528.1003662-1-bfoster@redhat.com/
- Port onto incremental advance, drop patch 1 from RFCv1.
- Moved batch into iomap_iter, dynamically allocate and drop flag.
- Tweak XFS patch to always trim zero range on EOF boundary.
RFCv1: https://lore.kernel.org/linux-fsdevel/20241119154656.774395-1-bfoster@redhat.com/

Brian Foster (7):
  iomap: move pos+len BUG_ON() to after folio lookup
  filemap: add helper to look up dirty folios in a range
  iomap: optional zero range dirty folio processing
  xfs: always trim mapping to requested range for zero range
  xfs: fill dirty folios on zero range of unwritten mappings
  iomap: remove old partial eof zeroing optimization
  xfs: error tag to force zeroing on debug kernels

 fs/iomap/buffered-io.c       | 103 ++++++++++++++++++++++++-----------
 fs/iomap/iter.c              |   6 ++
 fs/xfs/libxfs/xfs_errortag.h |   4 +-
 fs/xfs/xfs_error.c           |   3 +
 fs/xfs/xfs_file.c            |  21 +++++--
 fs/xfs/xfs_iomap.c           |  38 ++++++++++---
 include/linux/iomap.h        |   4 ++
 include/linux/pagemap.h      |   2 +
 mm/filemap.c                 |  42 ++++++++++++++
 9 files changed, 176 insertions(+), 47 deletions(-)

-- 
2.49.0


