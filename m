Return-Path: <linux-fsdevel+bounces-37695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E499F5CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B159F160575
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13454146590;
	Wed, 18 Dec 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Voh8Sf3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF336CDAF;
	Wed, 18 Dec 2024 02:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488793; cv=none; b=faAZWCocS4eh4ZqdGQkB8zUrjeN6TuQraM0rGd2Rht6cfPM8Hz7y5ahmi14f65FoukjQye9SR2JdLbxLKsgQvAAd4PSm78FEKRbxdfnwFDmCkta7RrmxTfSsZrQujuhgeMayHCPHf9ZNL4jai8cPHAkoBNVTsMFO1wJj19aK33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488793; c=relaxed/simple;
	bh=9dBXmKcgLQirHI2iYSo1wb5jOOk6jjcxYvTobhrvo9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjqnPubtocCYqoWmhHoxnxxgmEVNtBP7oh4e+g5yJEVW8Cx2/7iWHuYNYO78tlsxOEivhzIaEbDXL9Sv7Qnxs/5Az81j66eVyHjOSuJEQg3ERUMVNYpz70jH9BnoaYVdRGedzcGOR5he/nQ7sAN0ZO2OQeLRhjeA8zejAkeBVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Voh8Sf3h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zQboEwj/BnkbLUHNu4i0H6IOdbozIVeO6wUMyrdIBHI=; b=Voh8Sf3hO5qNkjoK4kIPOmOgEK
	KymmqwZVrqKkrljZN2JeD/OQLToc1A8LNRhRuBTBcPfbdAjjEzWuJ0LI2x9XlHWHr0WNa/9gP3bmK
	zd/YOrMgYy0ipBfnPr2D5RvFIFhc+nIZlwXW24TC/hW1DZnmuFQJQHv9RyMQLlhXUmtieqhNiet0b
	CyRsUC2rLKtSQBiFM6gspK2m69dbsrPc6kP2MdZISh3XhokfJdRGmnOFlJBIu4h3mH1CigDN/cOY2
	ckLuHCIjOl51/DOGdhElWBRqoxI49t8/r5R74GfUuj6zq5qeTQDZOPnD3dIda6xFV7Jn/oknafRHJ
	IFScGQ0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjlc-0000000FOFQ-0omO;
	Wed, 18 Dec 2024 02:26:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 0/5] fs/buffer: strack reduction on async read
Date: Tue, 17 Dec 2024 18:26:21 -0800
Message-ID: <20241218022626.3668119-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

This splits up a minor enhancement from the bs > ps device support
series into its own series for better review / focus / testing.
This series just addresses the reducing the array size used and cleaning
up the async read to be easier to read and maintain.

Changes on this series from the RFC v2:

  - Fixes the loop by ensuring we bump counts on continue as noted by
    Matthew Wilcox
  - new patch to simplify the loop by using bh_offset()
  - bike shed love on comments
  - Testing: tested on ext4 and XFS with fstests, with no regressions found
    after willy's suggested loop fix on continue. I'm however running a new
    set of tests now after a rebase onto v6.13-rc3 and a bit of patch ordering
    and the addition of bh_offset(). Prelimimary tests however show no
    issues.

[0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org

Luis Chamberlain (5):
  fs/buffer: move async batch read code into a helper
  fs/buffer: simplify block_read_full_folio() with bh_offset()
  fs/buffer: add a for_each_bh() for block_read_full_folio()
  fs/buffer: add iteration support for block_read_full_folio()
  fs/buffer: reduce stack usage on bh_read_iter()

 fs/buffer.c | 221 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 160 insertions(+), 61 deletions(-)

-- 
2.43.0


