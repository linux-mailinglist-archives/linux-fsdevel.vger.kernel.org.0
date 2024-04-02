Return-Path: <linux-fsdevel+bounces-15872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AEE895401
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EB11C233A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380488288D;
	Tue,  2 Apr 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q71FZxN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649127FBA2
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062557; cv=none; b=ZOVJ4KtmLY5402YLKlNgBvd/uLQbvhnmnv6Ztjoazhe/wkCxeWXuf26Jq2Diebrcgi50eDzMTjBo1jsH29bWfcm6s7iniwi7FTZ3vh5H5WTWldY8TjdsTm9GX4cGG6jkngLOIqRS1kaKMpm6Twu5RBOG3subui5ttrlYfB0GC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062557; c=relaxed/simple;
	bh=CnPlyaDBkHALGVASURDaFj0khPVMCDAmwQaSX2f3JUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmGDwA3yawGmyXCTc4IRL/ygAmqEqUzZd2Nya+Um+jg7GfQLpJFDaVC40WrIgTQ7Ce5XugrZi/ADTxRykGyugA3ytSxSnhFxh7MLAeKggYavObv4zHy8XbTANsrdtXqP+buHQ54uPZlFWoxd+Pg2earkXcCVPAMLXYvVs5MrOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q71FZxN9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712062554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mcxjCOywRtLdiEcHC2fGLUZpoWNnKmQE4MNGQaUK4kg=;
	b=Q71FZxN9B3JZ/IPykD1XFZr/FK/bH9VulHF6EByjtpN8mQR8L/LhgmOaucNTUIwCk2k1XD
	sK67yXsZIVtybEerscWwGUdcmVAuT0T2AsBdNqtE3jwnvNHcAPK6y/tJunisqY5tk/vMrC
	y2srb6zzu/K5nn7gO7x9hK38tCgkWd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-jrB5cRd5NSepbRcVx10PBw-1; Tue, 02 Apr 2024 08:55:43 -0400
X-MC-Unique: jrB5cRd5NSepbRcVx10PBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57030881F00;
	Tue,  2 Apr 2024 12:55:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3917D3C21;
	Tue,  2 Apr 2024 12:55:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v1 0/3] mm/gup: consistently call it GUP-fast
Date: Tue,  2 Apr 2024 14:55:13 +0200
Message-ID: <20240402125516.223131-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Some cleanups around function names, comments and the config option of
"GUP-fast" -- GUP without "lock" safety belts on.

With this cleanup it's easy to judge which functions are GUP-fast specific.
We now consistently call it "GUP-fast", avoiding mixing it with "fast GUP",
"lockless", or simply "gup" (which I always considered confusing in the
ode).

So the magic now happens in functions that contain "gup_fast", whereby
gup_fast() is the entry point into that magic. Comments consistently
reference either "GUP-fast" or "gup_fast()".

Based on mm-unstable from today. I won't CC arch maintainers, but only
arch mailing lists, to reduce noise.

Tested on x86_64, cross compiled on a bunch of archs.

RFC -> v1:
* Rebased on latest mm/mm-unstable
* "mm/gup: consistently name GUP-fast functions"
 -> "internal_get_user_pages_fast()" -> "gup_fast_fallback()"
 -> "undo_dev_pagemap()" -> "gup_fast_undo_dev_pagemap()"
 -> Fixup a bunch more comments
* "mm/treewide: rename CONFIG_HAVE_FAST_GUP to CONFIG_HAVE_GUP_FAST"
 -> Take care of RISCV

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org

David Hildenbrand (3):
  mm/gup: consistently name GUP-fast functions
  mm/treewide: rename CONFIG_HAVE_FAST_GUP to CONFIG_HAVE_GUP_FAST
  mm: use "GUP-fast" instead "fast GUP" in remaining comments

 arch/arm/Kconfig       |   2 +-
 arch/arm64/Kconfig     |   2 +-
 arch/loongarch/Kconfig |   2 +-
 arch/mips/Kconfig      |   2 +-
 arch/powerpc/Kconfig   |   2 +-
 arch/riscv/Kconfig     |   2 +-
 arch/s390/Kconfig      |   2 +-
 arch/sh/Kconfig        |   2 +-
 arch/x86/Kconfig       |   2 +-
 include/linux/rmap.h   |   8 +-
 kernel/events/core.c   |   4 +-
 mm/Kconfig             |   2 +-
 mm/filemap.c           |   2 +-
 mm/gup.c               | 215 +++++++++++++++++++++--------------------
 mm/internal.h          |   2 +-
 mm/khugepaged.c        |   2 +-
 16 files changed, 127 insertions(+), 126 deletions(-)

-- 
2.44.0


