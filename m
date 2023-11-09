Return-Path: <linux-fsdevel+bounces-2636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA137E735D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BC71F211ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA97374F1;
	Thu,  9 Nov 2023 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxWF7Uvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B59374E8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:06:26 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41744688
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EA2vdzmSDI5EwKrWk7HPBoWgZr1qpG6yziTSnHPxlgw=; b=oxWF7UvkLfHv6FZTgzSdZck4K9
	XqlJKnMqeo4LUyirRuj6nfujmkC+rO46A687CiRFum66FFlZ/uQbR9LEbUewtL34AKWyqDqqQzkN1
	MLSk0tNZyUAj83uDPrD1EXOluXSIDuAo16IhlcIUmJ1TSEsGoOtndzyjkALNXiptsyzXJjlr7F4d2
	z5IF3OnA99mWdSP6bKiqsBdeocrQUvXOk41YjbwEVXuZzTz4qwV5yXTLAhtf3P7U9jcZhyGeVrCbq
	iqeLnAhpHySs/SSZtXvfm+CoHHK8NJM7tVkU+u2uxH+56D8OF8HGjXKqKEJhIsLpa0YdR7s1BtS13
	u1cHHhLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1CE7-009Rvz-HZ; Thu, 09 Nov 2023 21:06:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/7] More buffer_head cleanups
Date: Thu,  9 Nov 2023 21:06:01 +0000
Message-Id: <20231109210608.2252323-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a left-over from last cycle.  The rest fix "obvious"
block size > PAGE_SIZE problems.  I haven't tested with a large block
size setup (but I have done an ext4 xfstests run).

v2:
 - Pick up R-b tags from Pankaj
 - Use div_u64() instead of a raw divide.  Thanks, i386.
 - Add a patch for __block_write_begin_int(), spotted by Ryusuke Konishi
 - That inspired the seventh patch which finally eliminates block_size_bits().

Matthew Wilcox (Oracle) (7):
  buffer: Return bool from grow_dev_folio()
  buffer: Calculate block number inside folio_init_buffers()
  buffer: Fix grow_buffers() for block size > PAGE_SIZE
  buffer: Cast block to loff_t before shifting it
  buffer: Fix various functions for block size > PAGE_SIZE
  buffer: Handle large folios in __block_write_begin_int()
  buffer: Fix more functions for block size > PAGE_SIZE

 fs/buffer.c | 130 +++++++++++++++++++++-------------------------------
 1 file changed, 53 insertions(+), 77 deletions(-)

-- 
2.42.0


