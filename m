Return-Path: <linux-fsdevel+bounces-22446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8004391732D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349D2285115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9E17E8F4;
	Tue, 25 Jun 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWuC7465"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A012EBEA;
	Tue, 25 Jun 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350291; cv=none; b=BMbP3XlzYGRtEXvd8/m9qTPkrBJphwz9miE53A1QWbzaM8l91UrTuTETwHaK/D29kemqekzVaVVlhGfUeM9MYodJl17ypI4imn8VWGw4hASEOOywwWg/4foqNnRpr2j3Jwjv5fwztDuLQdvxYoyH3/Pt2gzLzcLicG577V+gq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350291; c=relaxed/simple;
	bh=MN/6sbthfCvnEuz2t4Z5JxC1B94Jjw9AVBzLgolfwGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgPaC5gkZ/2ofmZVM+nffxqJjwyBt5nTeU3gUAKKEDd+KXTNttcLoKRRuizHVrwK4xlMbjKbp3CHKWLZQbqFRxGOjLRcQfGTjsBH/BBnIBt4nh76X7g4q+AJvhEgPNy7TxIY64mucjuu1udjyZ5lNgIQ+zE/5v3ABGzbYq9XtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nWuC7465; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=HSabSrNFRZHizvvunEpo3g6TInUOBm4hVSaIQdn2sPw=; b=nWuC7465LT24E5YYe86QiCLmYc
	B/NRNX+trjDC0/SzIE6VRwcfPfKH37iACwEi5dbkawFkdYcwlRpfEdrDZEhCOaO+7JQA1ZVMGtH38
	EjgfRv81Vce2QfGvCQ39iWp2DX3wZzjDD8q4VktO1VYz1v8jJeOHjXC03WPfCNs0AyFcF2khTgGNW
	zfvC1R++3xy5+PjajC9kcz6TNbEa4W9n0WersQFS3c9sMsr350nttYKi7CHssNDbXOx8c+k/KG9Be
	ZI7aq5bYTdL5sOReNitfGdPFQml8ZllLqL1zFs6cHOq2EvR5/WzUAjUBX8g2OUeapzEjAdNu7Q9/T
	fBp98qfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMDYD-0000000BXYE-4BGy;
	Tue, 25 Jun 2024 21:18:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: [PATCH v2 0/5] Rosebush, a new hash table
Date: Tue, 25 Jun 2024 22:17:55 +0100
Message-ID: <20240625211803.2750563-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rosebush is a resizing, scalable, cache-aware, RCU optimised hash table.

v2 has switched to fixed sized buckets.  That considerably simplifies
the code and removes the dilemma about whether to grow the bucket or
grow the table.  The layout of the bucket has changed to place all the
hashes at the start of the bucket, optimising lookups (as it improves
the chances that the hash we're looking for will be found in the first
cacheline).

Other changes:

 - Added rbh_destroy()
 - When we split a bucket, we now create two new buckets instead of
   only creating one and leaving the other one to be reallocated later
 - Added rbh_dump() to help debugging
 - Buildable in userspace as part of the radix tree testsuite
 - Dcache conversion

I suspect the dcache conversion probably doesn't work with detached
dentries.  But it should be good enough for someone to run a performance
benchmark ...

v1 can be found at
https://lore.kernel.org/all/20240222203726.1101861-1-willy@infradead.org/

This patch set can be found at
http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/rosebush
aka
git://git.infradead.org/users/willy/pagecache.git rosebush

Matthew Wilcox (Oracle) (5):
  tools: Add kernel stubs needed for rosebush
  rosebush: Add new data structure
  rosebush: Add test suite
  tools: Add support for running rosebush tests in userspace
  dcache: Convert to use rosebush

 Documentation/core-api/index.rst         |   1 +
 Documentation/core-api/rosebush.rst      | 121 +++++
 MAINTAINERS                              |   8 +
 fs/dcache.c                              | 152 ++----
 include/linux/rosebush.h                 |  62 +++
 lib/Kconfig.debug                        |   3 +
 lib/Makefile                             |   3 +-
 lib/rosebush.c                           | 654 +++++++++++++++++++++++
 lib/test_rosebush.c                      | 140 +++++
 tools/include/linux/compiler.h           |   4 +
 tools/include/linux/compiler_types.h     |   2 +
 tools/include/linux/rosebush.h           |   1 +
 tools/include/linux/spinlock.h           |   2 +
 tools/include/linux/stddef.h             |   3 +
 tools/testing/radix-tree/.gitignore      |   1 +
 tools/testing/radix-tree/Makefile        |   6 +-
 tools/testing/radix-tree/kunit/test.h    |  20 +
 tools/testing/radix-tree/linux/kernel.h  |   2 +
 tools/testing/radix-tree/linux/vmalloc.h |  14 +
 tools/testing/radix-tree/rosebush.c      |  36 ++
 20 files changed, 1135 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/core-api/rosebush.rst
 create mode 100644 include/linux/rosebush.h
 create mode 100644 lib/rosebush.c
 create mode 100644 lib/test_rosebush.c
 create mode 100644 tools/include/linux/rosebush.h
 create mode 100644 tools/include/linux/stddef.h
 create mode 100644 tools/testing/radix-tree/kunit/test.h
 create mode 100644 tools/testing/radix-tree/linux/vmalloc.h
 create mode 100644 tools/testing/radix-tree/rosebush.c

-- 
2.43.0


