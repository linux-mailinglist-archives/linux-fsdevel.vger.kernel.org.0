Return-Path: <linux-fsdevel+bounces-17010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E748A616C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F14B20F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37118E02;
	Tue, 16 Apr 2024 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vzqEmEA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CD17996;
	Tue, 16 Apr 2024 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237479; cv=none; b=pl21IvVXLrNB6FNyiWli7vOY288TAZbN/otrYcfTGlUw830aOyXug4/mucBpnC83VrA8RhjqyUrHL+cfBCp1ucz5WWsbJob+gjMXmPXodv9mdHcXLIjYQcmoiN3vaRETPjFJrArH1JuGu1CpsWzxdZ6u4Ju+wCWQmbBohth1bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237479; c=relaxed/simple;
	bh=3yRYUK6iTm3jRWrQYWhBNslPYeu1hmf3DgF3zdmlook=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aE6Co8gR1BQUs8BDVXIsAqVn3v8U/pyHsTLXK/y/dOctQhKHg7HTF6KHbcy9sYc29VHUybPvR+Jer6s87c09+0nmRMbaJrBQbEuCf5JLJjhsunzsJ+9Eo9glQMg0YjPjlaJ2Ol0KXUJTtiZGCSdslEctoUAjI+LNgA0ZGH8+VTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vzqEmEA+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=TJa4QBEyJTbiP+HABEeWYvxnQOlVjhxyKNwMNJcVUz0=; b=vzqEmEA+OR3lH4U4gvCx+0plf3
	Tso8cV7OjL/Bt7T3sReTOqazJOu++E6ArchiqH30FYh9IL+97IURMJXhutTjVAW8cGyUnj36+UVKn
	JmhRvwC3sNytAFTQzFiw+0RU5gnWMvKwxVBusLCIYneU/TPo26MiS24gFjPG3B3RphsbZRzYqFo0g
	/FtGtWVP28B5FVUTSrpWVgOWIfc0MF0WrwhObo5DfQLhJtJWBycNfKFguCBUvcGICQPtaazI6G2wJ
	uBNJdHoWZtcKmM5sReaBWuGQQr8aUxA0r/e8EkiLJWKKhx4BZ46+ycNgAQFktWBwengYvitus/Vqa
	CA1xvv+A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKV-0000000H6as-3T60;
	Tue, 16 Apr 2024 03:17:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 0/8] Improve buffer head documentation
Date: Tue, 16 Apr 2024 04:17:44 +0100
Message-ID: <20240416031754.4076917-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn buffer head documentation into its own document, and make many
general improvements to the docs.  Obviously there is much more that
could be done.  Tested with make htmldocs.

v3:
 - More feedback from Randy & Pankaj
v2:
 - Incorporate feedback from Randy & Pankaj
 - Add docs for brelse() and bforget()
 - Improve bdev_getblk() docs

Matthew Wilcox (Oracle) (8):
  doc: Improve the description of __folio_mark_dirty
  buffer: Add kernel-doc for block_dirty_folio()
  buffer: Add kernel-doc for try_to_free_buffers()
  buffer: Fix __bread and __bread_gfp kernel-doc
  buffer: Add kernel-doc for brelse() and __brelse()
  buffer: Add kernel-doc for bforget() and __bforget()
  buffer: Improve bdev_getblk documentation
  doc: Split buffer.rst out of api-summary.rst

 Documentation/filesystems/api-summary.rst |   3 -
 Documentation/filesystems/index.rst       |   1 +
 fs/buffer.c                               | 165 +++++++++++++---------
 include/linux/buffer_head.h               |  48 +++++--
 mm/page-writeback.c                       |  14 +-
 5 files changed, 145 insertions(+), 86 deletions(-)

-- 
2.43.0


