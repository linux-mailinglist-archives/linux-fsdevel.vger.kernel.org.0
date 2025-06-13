Return-Path: <linux-fsdevel+bounces-51607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C32AD94F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFCC1BC2218
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AE242D64;
	Fri, 13 Jun 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vLYXQ2yR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54223E356;
	Fri, 13 Jun 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841636; cv=none; b=L+8Hq/lI0CfmSDf+pY4jH5QqC4tPQzxcVsSlV3d8/PGzdrelRaX+71/y4y5c5lNzQ3MTDnJU3S54Ki2rYiCF0Xmw5LQh+oBN2awdcM3/MnVn3V9F8WlpaDWC8t0x7O4QEkkmzrs2OoJtRrb4UJNgiT3dhFObKnTXSW9IV6zphEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841636; c=relaxed/simple;
	bh=woAnzfeo2usrH+ECo0TcH5ll6A/TUaO8fXTop/gMWcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPsWx2DfWyYgSrUlWbdU+jwIBc7BBF4JUNwaL/h6S9ClhMbrROy/E4e4N5wWY9p94lyhO14zWROTUIPQgmRoZzqca5JYKsue8kh/PZjr0ULtfTW85peLUa2n0P28LHqYBBhKxguIdByedyFgy9ubyY6zXA3jzcHN2ExOgGzEn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vLYXQ2yR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=OfTvMij9fpfRbdnOI9voSIMhMfD/jMEqOZlTcFs5hyQ=; b=vLYXQ2yRsufaN1GT5IzuO7DN6g
	T3xsI/BWdIZv2E1P+U9GPqIXV6uKs8cu474jTwlkiLES/9jZTPVeaqDRInvzsc2pIgQN8n6QhEidR
	JJQJk1LXd0yAJwO+kkwI1aUvLVNIM8DlaprDdIAe5faEH7HGem1R6Um5OYbLC9yqwW0u9a9u9v2DO
	IXR9RHSja+tN93ewVlmWB9Zbcw4/AIQHE8s1k+r40JN3DFW3KXpAFyFNgNuQ8M8xkA9aG1UrmdWZ3
	fr7cZzpueYJHETYHg2FNGSJQGlO8k14yFgmCBzl9NK9HelW84cNqbmmFIMljBdg2RGhT0OHCqsH8X
	75h8qWaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ9k3-0000000DHsX-01X3;
	Fri, 13 Jun 2025 19:07:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Folio conversions in extent-io-tests
Date: Fri, 13 Jun 2025 20:06:59 +0100
Message-ID: <20250613190705.3166969-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extent-io-tests is the last user of find_lock_page() in my tree, so
let's convert these two functions.  test_find_delalloc() is quite a big
function, so I split the conversion up.  We could combine these two
patches if anyone has a strong opinion.  There's no more use of 'struct
page' in extent-io-tests after this.  Compile tested only.

Matthew Wilcox (Oracle) (3):
  btrfs: Convert test_find_delalloc() to use a folio
  btrfs: Convert test_find_delalloc() to use a folio, part two
  btrfs: Simplify dump_eb_and_memory_contents()

 fs/btrfs/tests/extent-io-tests.c | 89 +++++++++++++++-----------------
 1 file changed, 43 insertions(+), 46 deletions(-)

-- 
2.47.2


