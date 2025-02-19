Return-Path: <linux-fsdevel+bounces-42099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A740A3C68B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E41E1796DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B192144D3;
	Wed, 19 Feb 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSPwCFi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89481A7264
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987301; cv=none; b=cFvtU3DaHMQE6+yRzPxto88nefd/DszEOd5mmzUYHioswVDeloVrNwQTfdkoP9w9ppU3skPwvJOJVzBAJgrB/7qv49Z7bFBPk/Nvafvh0MsjwRcUPo30XVuF/xcDlmfgJ6ny+P2z12sz8vFNh1dDOysXZnhIeOfH3wp3Psdvm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987301; c=relaxed/simple;
	bh=xG0L2swbpW3Pz4XEIRFnx1UbFBHfVeEEsPzNjm9prfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eepsrINYYjkklsFsB35iHvhJgg8hFk2tzrGzD9MWo0QwjLSCHt4ACVjmo2ybLEFHZ84GVUQI5cQkzjIk0HlFBNozWosaVHGfftXCmhvXOVbIqYVSV/WL3FkwuWfzBXdWRFZo2G1LLehGyfYizVNkLNZUYBt92yMpTqflFYq/dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSPwCFi+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hLIJ3v3ml7toyras9AOIJJI0QXeCL3LCa+ags1sL47E=;
	b=XSPwCFi+aaArpojWAHlr/t6qf9cfBwttgfuw/lEhSR5+xxF/6/lPUa4dYqpgejXW4FdYc5
	PBpu5H6Hc4P3/9GlziQiFLhkVHeEvldVs6tfsREtCvSMy6Jh74XGc7l6/Iy2IgtPWzLBm4
	txy1xPZrstQUhlDzYsBGFO902MO/gmg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-DkulQ59gPeaeLlSVAeCSmQ-1; Wed,
 19 Feb 2025 12:48:14 -0500
X-MC-Unique: DkulQ59gPeaeLlSVAeCSmQ-1
X-Mimecast-MFC-AGG-ID: DkulQ59gPeaeLlSVAeCSmQ_1739987293
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3262619783B4;
	Wed, 19 Feb 2025 17:48:13 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F74B1800265;
	Wed, 19 Feb 2025 17:48:11 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 00/12] iomap: incremental advance conversion -- phase 2
Date: Wed, 19 Feb 2025 12:50:38 -0500
Message-ID: <20250219175050.83986-1-bfoster@redhat.com>
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

Here's phase 2 of the incremental iter advance conversions. This updates
all remaining iomap operations to advance the iter within the operation
and thus removes the need to advance from the core iomap iterator. Once
all operations are switched over, the core advance code is removed and
the processed field is renamed to reflect that it is now a pure status
code.

For context, this was first introduced in a previous series [1] that
focused mainly on the core mechanism and iomap buffered write. This is
because original impetus was to facilitate a folio batch mechanism where
a filesystem can optionally provide a batch of folios to process for a
given mapping (i.e. zero range of an unwritten mapping with dirty folios
in pagecache). That is still WIP, but the broader point is that this was
originally intended as an optional mode until consensus that fell out of
discussion was that it would be preferable to convert over everything.
This presumably facilitates some other future work and simplifies
semantics in the core iteration code.

Patches 1-3 convert over iomap buffered read, direct I/O and various
other remaining ops (swap, etc.). Patches 4-9 convert over the various
DAX iomap operations. Finally, patches 10-12 introduce some cleanups now
that all iomap operations have updated iteration semantics.

Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-fsdevel/20250207143253.314068-1-bfoster@redhat.com/

v2:
- Push dax_iomap_iter() advance changes down into type specific helpers
  (new patch).
- Added patch for iomap_iter_advance_full() helper.
- Various minor cleanups.
v1: https://lore.kernel.org/linux-fsdevel/20250212135712.506987-1-bfoster@redhat.com/

Brian Foster (12):
  iomap: advance the iter directly on buffered read
  iomap: advance the iter on direct I/O
  iomap: convert misc simple ops to incremental advance
  dax: advance the iomap_iter in the read/write path
  dax: push advance down into dax_iomap_iter() for read and write
  dax: advance the iomap_iter on zero range
  dax: advance the iomap_iter on unshare range
  dax: advance the iomap_iter on dedupe range
  dax: advance the iomap_iter on pte and pmd faults
  iomap: remove unnecessary advance from iomap_iter()
  iomap: rename iomap_iter processed field to status
  iomap: introduce a full map advance helper

 fs/dax.c               | 111 ++++++++++++++++++++++-------------------
 fs/iomap/buffered-io.c |  80 ++++++++++++++---------------
 fs/iomap/direct-io.c   |  24 ++++-----
 fs/iomap/fiemap.c      |  21 ++++----
 fs/iomap/iter.c        |  43 +++++++---------
 fs/iomap/seek.c        |  16 +++---
 fs/iomap/swapfile.c    |   7 +--
 fs/iomap/trace.h       |   8 +--
 include/linux/iomap.h  |  16 ++++--
 9 files changed, 163 insertions(+), 163 deletions(-)

-- 
2.48.1


