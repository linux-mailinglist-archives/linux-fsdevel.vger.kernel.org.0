Return-Path: <linux-fsdevel+bounces-56997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97221B1DA2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7C81AA3BD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6782673AA;
	Thu,  7 Aug 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSwiX6+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29732264630
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577804; cv=none; b=KSobs/8m/892205/GLIvCD7O8gNZX04BpmF4CMNKUwjnlqwNheF65oIDqrfMmvy6gmOk4o0jDCdc5+m942sF2Fd+5qVAXnzw1kBp/NLVASUJlZRxJA90FEFKS6aIQOYOYLBGGSPdlVEXNLbD3yOenylTw7jc1WDtkg5z9Rs0uao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577804; c=relaxed/simple;
	bh=9FRo2jbvE8wjL2UFRBDRwgcTW8rfMHgjyDCxCHA9WDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2OPW34blBRMzevu1+w3GgIigpbimdbFx5a2wgDydRXClcYZXIW5x+0sGoguXo4B52RRGvXkSOOaRRWMAlOycwHDuACNuBWdaCSl+rbhFeIWrj21RRXbmwA44irin8zH3peo1aOyFz0QaCzeGNSeyZ10dKkNYrZcpkYGOSsqSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSwiX6+a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754577801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=72xM8cfk7cqW6yETU8RQTaHJlsVsZhPXqGL0jRvFS9s=;
	b=eSwiX6+a1ciVpkoOFyCPgFv5b458Ki0wmKMw1VoswVyg2FHRj2g71wZcVPFuNdWFZJtXaT
	t5kmFNakuZE7OnVFNcc1tjsjurSbPqM/TzkfgLJh7vdkh3sjl5VfxqCgf66vBaw34smWMi
	YEfBa8SCX9g00Yvj/nx6trSprST++5E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-L9x5TAzvNrmc6sc4ftewPA-1; Thu,
 07 Aug 2025 10:43:18 -0400
X-MC-Unique: L9x5TAzvNrmc6sc4ftewPA-1
X-Mimecast-MFC-AGG-ID: L9x5TAzvNrmc6sc4ftewPA_1754577797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 121071800292;
	Thu,  7 Aug 2025 14:43:17 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FF02180035C;
	Thu,  7 Aug 2025 14:43:15 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v4 0/7] iomap: zero range folio batch support
Date: Thu,  7 Aug 2025 10:47:03 -0400
Message-ID: <20250807144711.564137-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi all,

No code changes in v4. I've fixed up a commit log description and added
the remaining review tags. I've also cooked up the fstest to go with
patch 7 and will post that shortly.

Otherwise there's been some discussion on v3 with Zhang Yi about some
outstanding issues with the ext4 on iomap work that is under
development, but I think we've agreed that those things are ext4
specific and can be addressed in a followup series. So that is my plan
for next steps.

Brian

--- Original cover letter ---

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

v4:
- Update commit log description in patch 3.
- Added remaining R-b tags.
v3: https://lore.kernel.org/linux-fsdevel/20250714204122.349582-1-bfoster@redhat.com/
- Update commit log description in patch 2.
- Improve comments in patch 7.
v2: https://lore.kernel.org/linux-fsdevel/20250714132059.288129-1-bfoster@redhat.com/
- Move filemap patch to top. Add some comments and drop export.
- Drop unnecessary BUG_ON()s from iomap_write_begin() instead of moving.
- Added folio mapping check to batch codepath, improved comments.
v1: https://lore.kernel.org/linux-fsdevel/20250605173357.579720-1-bfoster@redhat.com/
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
  filemap: add helper to look up dirty folios in a range
  iomap: remove pos+len BUG_ON() to after folio lookup
  iomap: optional zero range dirty folio processing
  xfs: always trim mapping to requested range for zero range
  xfs: fill dirty folios on zero range of unwritten mappings
  iomap: remove old partial eof zeroing optimization
  xfs: error tag to force zeroing on debug kernels

 fs/iomap/buffered-io.c       | 117 +++++++++++++++++++++++++----------
 fs/iomap/iter.c              |   6 ++
 fs/xfs/libxfs/xfs_errortag.h |   4 +-
 fs/xfs/xfs_error.c           |   3 +
 fs/xfs/xfs_file.c            |  26 ++++++--
 fs/xfs/xfs_iomap.c           |  38 +++++++++---
 include/linux/iomap.h        |   4 ++
 include/linux/pagemap.h      |   2 +
 mm/filemap.c                 |  58 +++++++++++++++++
 9 files changed, 210 insertions(+), 48 deletions(-)

-- 
2.50.1


