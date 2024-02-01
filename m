Return-Path: <linux-fsdevel+bounces-9932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A2B8463B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB29B1C25F68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40247A53;
	Thu,  1 Feb 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rQ2iWEln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC941757
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827573; cv=none; b=DHOhwrbzmsCPIMPnBZoHiGe2XvXLi8tlKleBfV+Rc4HGWbC5B2InEqf75R0ADajAz4JOI1LeEynsE2DM2aH2pf/MPSg7qUuPmIZcs4QmP5cNG3bzfxSdXXI1qsBwnZMZVaRa+tJExFSJwT6if2eK+G7uZOAtS8k1h1IKl2rn60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827573; c=relaxed/simple;
	bh=oaQj9gf4JdYLJtRLQLozfm/9zhtDtKtm3zPlEiCcgFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTAPLIceybxKcfNbWlbH2URMZ2vpRQy7oe1s3OyVOi92I01zUVLW/NTyimuqPSgHPuzSs14DnZxZ7VOrD+IreXhPSANkv3tyX8VrArEsFGGXebytHJ57HfOHTFUJpYVWVroYPKkt5hM6Jzjzo5PFphYsCBxmoYK8MhjrpHtaCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rQ2iWEln; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=uY3jkLhiexqL48YQijgmCwLqm6c2z6t+bClzCpkyU7w=; b=rQ2iWEln8n9Ge2PpI2MGKpDmwJ
	m/DaYU9WGf/I51onKklH4m2c45fiUau1/e0myVrOr7GDa0DJ1bwB7RdOiUb5vfiHDS6WZG8cm1J+5
	k//vsahdLH9ZYY7rtRAqTirr1krwDRNGOSOihisU1QdX6XqxoqPC7I9JSZSqynkyzAzGVfItccFO0
	9BtW1iLhEiVmNsg8xRPSUOa2nH09XhyD/mzbdUktI7Iujx0sVNey6RaL3kTZ+0T3rw/6Tmq2pfpZZ
	F3ck80KwQT8btBxb0ITHF01YFE5a/EmY2nE+EG9ly7qrjfUbHpU/2QoedyhRzj5XLlsFtzzDBjL+C
	k/Qy4wYw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfos-0000000H17v-41vt;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/13] JFS folio conversion
Date: Thu,  1 Feb 2024 22:45:49 +0000
Message-ID: <20240201224605.4055895-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset removes uses of struct page from the I/O paths of JFS.
write_begin and write_end are still passed a struct page, but they convert
to a folio as their first thing.  The logmgr still uses a struct page,
but I think that's one we actually don't want to convert since it's
never inserted into the page cache.

I've included the removal of i_blocks_per_page() in this series as JFS
is the last user.

Tested with xfstests; some failures observed, but they don't seem to be
related to these patches.  I haven't tried with PAGE_SIZE > 4kB, so the
MPS_PER_PAGE > 1 paths are untested.

Matthew Wilcox (Oracle) (13):
  jfs: Convert metapage_read_folio to use folio APIs
  jfs: Convert metapage_writepage to metapage_write_folio
  jfs: Convert __get_metapage to use a folio
  jfs: Convert insert_metapage() to take a folio
  jfs; Convert release_metapage to use a folio
  jfs: Convert drop_metapage and remove_metapage to take a folio
  jfs: Convert dec_io to take a folio
  jfs; Convert __invalidate_metapages to use a folio
  jfs: Convert page_to_mp to folio_to_mp
  jfs: Convert inc_io and mp_anchor to take a folio
  jfs: Convert force_metapage to use a folio
  jfs: Change metapage->page to metapage->folio
  fs: Remove i_blocks_per_page

 fs/jfs/jfs_logmgr.c     |   2 +-
 fs/jfs/jfs_metapage.c   | 298 ++++++++++++++++++++--------------------
 fs/jfs/jfs_metapage.h   |  16 +--
 include/linux/pagemap.h |   6 -
 4 files changed, 155 insertions(+), 167 deletions(-)

-- 
2.43.0


