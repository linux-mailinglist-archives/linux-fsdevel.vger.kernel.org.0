Return-Path: <linux-fsdevel+bounces-54839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474EB03F75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C631705D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA7253F15;
	Mon, 14 Jul 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjM3mmzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2425394B
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499045; cv=none; b=Gb2LXfn49ARA8e35CkE+tfE6jb3f/D+VyUTneG3sTl944QMDwrpEzNl41buJcH47n7IV+EBgbgy6Cs6uyWB+icdzusDIbF6Uavh/GUpUMUtWk9n7vyqGwuV0L3hNU90vowJwZdTwtyro3h/20bs1huLe9uHqmy1JU6YC2x0/oCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499045; c=relaxed/simple;
	bh=u10l7zbbOG9Vv8UYt2vZekrnU8dbA5t+Od3qjX+ujH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iv5u6hIfrHi8WMVzY5f1FY/o2inWsmxWrJKYBClC291VBqu5g+g7dtOZArIwyelgKYn6xq/cWg8SdVhU4vm4Ry7CHWE7Qp7vQjpUbQ4spVbK+sYiS94brAvlb6pwlDOnRZGsWvp6xsNquqeXPGhwaf/Z4MQb01jiewPkKMXGrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjM3mmzb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KlBvYnebHWg9yfMm9FRqjKUgLvZWXQmRZ1jBjtp9YmQ=;
	b=FjM3mmzbmF2Yr9G0S9Iu5r0L9qTkk5Tinux55nfCJo8q86aBKWt+UaiJg/+6mhmjt65k3R
	ddRomMxRWdsf/LlUP74XUEBiyVcXpVeadZC6ruawWBKXU0NQE1+ob8dOPI+vnkuYksNtwm
	dThaBBtCc9tB9ubjXrobUZEBEz39Ix8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-69SVysUkMhWiao__4ygubg-1; Mon,
 14 Jul 2025 09:17:19 -0400
X-MC-Unique: 69SVysUkMhWiao__4ygubg-1
X-Mimecast-MFC-AGG-ID: 69SVysUkMhWiao__4ygubg_1752499037
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4B8C1800268;
	Mon, 14 Jul 2025 13:17:17 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 675FF180045B;
	Mon, 14 Jul 2025 13:17:16 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v2 0/7] iomap: zero range folio batch support
Date: Mon, 14 Jul 2025 09:20:52 -0400
Message-ID: <20250714132059.288129-1-bfoster@redhat.com>
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

v2:
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
  iomap: move pos+len BUG_ON() to after folio lookup
  iomap: optional zero range dirty folio processing
  xfs: always trim mapping to requested range for zero range
  xfs: fill dirty folios on zero range of unwritten mappings
  iomap: remove old partial eof zeroing optimization
  xfs: error tag to force zeroing on debug kernels

 fs/iomap/buffered-io.c       | 116 +++++++++++++++++++++++++----------
 fs/iomap/iter.c              |   6 ++
 fs/xfs/libxfs/xfs_errortag.h |   4 +-
 fs/xfs/xfs_error.c           |   3 +
 fs/xfs/xfs_file.c            |  21 +++++--
 fs/xfs/xfs_iomap.c           |  38 +++++++++---
 include/linux/iomap.h        |   4 ++
 include/linux/pagemap.h      |   2 +
 mm/filemap.c                 |  58 ++++++++++++++++++
 9 files changed, 205 insertions(+), 47 deletions(-)

-- 
2.50.0


