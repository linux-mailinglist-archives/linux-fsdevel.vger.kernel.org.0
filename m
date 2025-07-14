Return-Path: <linux-fsdevel+bounces-54881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE0B048AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA91A1A62D9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419342376FF;
	Mon, 14 Jul 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsJQdDH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C0367
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525468; cv=none; b=Sr3VFTKv9B1Xt+gvXh63+sEMpS+T4PIZaOldsMRROH3qikUZEWWr9IFmuRDDd+nxJgu2en2+06aD42OgYxgit/6+m+18/eInK4HBCVvmWiHgHSm/q2f7sFJRGt9WYNQ9RpItUM1bcHXdSEmYUN2JWK0O1i9jW6KM2Xj9m5Yrt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525468; c=relaxed/simple;
	bh=voykzDpSuL387gKCyFUz65DI4G0L9N0JoDpIKInEhLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AHU2YabgX2uR+B5qnxrRBwLeARfGzjzOC0eBK9n+lLyuZqdJcLOe7QQ1PJSD8SVpFw+vWIgB58tOOKA/A2OTnYUxX1WMbbRLJvk/HJZb/5tX/1FCFTE4mlOxWSfUVb6UE7EobHFW7rRIuyQSYlG4U1PKKab1Xo0uDWL3FBYLxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsJQdDH2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752525465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=trJ6g1WWyOPJeGz5HdfWeO4sEcYlcpzvrMPenqjlHKs=;
	b=fsJQdDH2hEzvF8hVr0smx7VI8tus0K49b+VNhkwL3DhWB45SD2jqmXeC3jwL4BZPWYJhyp
	FnJ0r/a4enATDJGxbys/FrIx6fzyP3QjJNNphYirAmkhRY02rb6ohU5u7DLqGewYseabVA
	FurkCgs7kbNfu/p502zOhKNJzQd7pe0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-RT4CSNFSMESwR0FQXDYLZQ-1; Mon,
 14 Jul 2025 16:37:43 -0400
X-MC-Unique: RT4CSNFSMESwR0FQXDYLZQ-1
X-Mimecast-MFC-AGG-ID: RT4CSNFSMESwR0FQXDYLZQ_1752525462
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBC941956094;
	Mon, 14 Jul 2025 20:37:41 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.43])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15BF919560B2;
	Mon, 14 Jul 2025 20:37:38 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v3 0/7] iomap: zero range folio batch support
Date: Mon, 14 Jul 2025 16:41:15 -0400
Message-ID: <20250714204122.349582-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi all,

Quick update.. This series was held up by testing work on my end. I
don't have the custom test to go along with patch 7 yet, but hch was
asking for updates, I have vacation looming, and realistically I wasn't
going to get to that beforehand. So I'm posting v2 without the
additional test and reviewers can decide if/how to proceed in the
meantime. Either way, I'll pick up where this leaves off.

Zero range is still obviously functionally testable. We just don't yet
have the enhanced coverage I was hoping for via the errortag knobs.
There are also a couple small fstests failures related to to tests that
explicitly expect unwritten extents in cases where this now decides to
perform zeroing (generic/009, xfs/242). I don't consider these
functional regressions, but the tests need to be fixed up to accommodate
behavior. Again, I'll get back to this stuff either way, it's just going
to be a couple weeks or so at least at this point. Thanks.

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

v3:
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

 fs/iomap/buffered-io.c       | 116 +++++++++++++++++++++++++----------
 fs/iomap/iter.c              |   6 ++
 fs/xfs/libxfs/xfs_errortag.h |   4 +-
 fs/xfs/xfs_error.c           |   3 +
 fs/xfs/xfs_file.c            |  26 ++++++--
 fs/xfs/xfs_iomap.c           |  38 +++++++++---
 include/linux/iomap.h        |   4 ++
 include/linux/pagemap.h      |   2 +
 mm/filemap.c                 |  58 ++++++++++++++++++
 9 files changed, 210 insertions(+), 47 deletions(-)

-- 
2.50.0


