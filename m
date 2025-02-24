Return-Path: <linux-fsdevel+bounces-42487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214FBA42AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2DB3AF1A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C8266191;
	Mon, 24 Feb 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itPMgfGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080E264FAA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420338; cv=none; b=BE9UW2bC8lLbdpWtj0L889NRcifTbdXZpTTIQsNZk42MWz2OIGfaWXQ9IT1vzXo5/T8hr+MNoAPbdpDCLDxO5GIrfJ2iFwtfZu0TzNthUzeW0d8EnUJmU1v0Xjgh2uRZyfaiV4t9y/Cl7HNs8jrN/01ioHkDc454BoOyPVIqaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420338; c=relaxed/simple;
	bh=p0SFsAfXsclUHzsaN7xFfvC5hpBpJsLbRKzzLIsjRIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NEag8WOkeFvjPLjNtfKHhE3zscmgZy8u0/dNd3IuAZ/WozPKPl6yJ3Z5kT9bc3BHiieuGmyswBNpy6PUDNG0p/22dbW44mM0lShGbyKq3yjqMI4+XNYJLq2P+TZ2HrT0ciAOWRA5PZxh9wWEtG5IPXltJ65MTokknt6Kq+dXWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=itPMgfGT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8g+q63ay2kAXgmI5em7Y9qOZSbhuKYQxcHRmh2hx2Cw=; b=itPMgfGTCv1xRJ1LULjD4bWsNr
	/T8VgGZv508huzPy3rQolK9Q53ivsZYq8eS5Q9LxZyTbD3ifcSJyk3O2X1x2+pAxwukVLV+q+mkOQ
	xcz5pVTU7Pgy5Ughk2x+DKZWgFMsjCf3HIYm+ifixIKapPyL452nD+eYQKT2XkkNO0aLR2WoilNvs
	5LybmUb/E3Tc0YF2j9gsUfeiC/jq/A5/DHej2C37OGZb2GY8SZa+tMzIgJzD72hq1JNObU8zyXNm9
	7+Bt0REYVjkPmBMRmktkad2QWmP5N8dvu1dDFj4LIfuo/7oqPDymGJe8kGAy3uTGOQz3VQYq/+4ej
	nZZWxdlA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082fe-04wX;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] Orangefs fixes for 6.15
Date: Mon, 24 Feb 2025 18:05:18 +0000
Message-ID: <20250224180529.1916812-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The start of this was the removal of orangefs_writepage(), but it
quickly spiralled out of hand.  The first patch is an actual bug fix.
I haven't tagged it for backport, as I don't think we really care about
32-bit systems any more, but feel free to add a cc to stable.

Patches 2 and 3 are compilation fixes for warnings which aren't enabled
by default.

Patches 4-9 are improvements which simplify orangefs or convert it
from pages to folios.  There is still a little use of 'struct page'
in orangefs, but it's not in the areas that deal with the page cache.

Matthew Wilcox (Oracle) (9):
  orangefs: Do not truncate file size
  orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
  orangefs: make open_for_read and open_for_write boolean
  orangefs: Remove orangefs_writepage()
  orangefs: Convert orangefs_writepage_locked() to take a folio
  orangefs: Pass mapping to orangefs_writepages_work()
  orangefs: Unify error & success paths in orangefs_writepages_work()
  orangefs: Simplify bvec setup in orangefs_writepages_work()
  orangefs: Convert orangefs_writepages to contain an array of folios

 fs/orangefs/file.c             |   4 +-
 fs/orangefs/inode.c            | 149 ++++++++++++++-------------------
 fs/orangefs/orangefs-debug.h   |  43 ----------
 fs/orangefs/orangefs-debugfs.c |  43 ++++++++++
 include/linux/mm_types.h       |   6 +-
 include/linux/nfs_page.h       |   2 +-
 include/linux/page-flags.h     |   6 +-
 7 files changed, 116 insertions(+), 137 deletions(-)

-- 
2.47.2


