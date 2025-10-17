Return-Path: <linux-fsdevel+bounces-64407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2BBE63B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 05:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FE4189C962
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 03:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD32F7464;
	Fri, 17 Oct 2025 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdLrCNOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F82F6197;
	Fri, 17 Oct 2025 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672786; cv=none; b=TyUpsU8QhGavTcVoNL1iXMdSUCgjn39PJt0O7ZPdA6TA4ggpzQ2OOKqH++LHZtOOxJkXR6jhkdKD2WRk1lXE8Ti248Il6w+L8Ou8kOyRZ8juNWy/FMKxujqp0hQK6IJ22zWnFGoa7+pWLQN7ZrpX6ErCyqXcrmg5xOTRY22urgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672786; c=relaxed/simple;
	bh=emqCO5RrJaSm1lxcu1lToBC5qmOO0qU74NWRvWTZa24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TihkcAwplyAozCY/mqnIlnq6FTCceCjT0LSL1Zc/s53mOsmUm4BCBoD73bNowCBpsTQEjoG0MOW8w6RmqWyaHHAHTqBDoeMxQeHw5VgYGIB+ykvR9FaWstdVd1BjcVsqFmmVVASuBgSd2VYO1Hgnd2KlDUaPMYQONh/m0dSLhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RdLrCNOh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K4A1fNA7jBkelNwgEEMa2038bA7E1kb77kUqqLoY588=; b=RdLrCNOhaq3CpPOvWZR3PLSpVT
	7fSHTcc7swz+B9JYH2j+PoouNvhYL5pPKiZIYmPZnQgIUk8c4sz93/0RSXVUArj//8077yQt96hs8
	IYOfv6BfVzizo1nrwmF8KiYAtkc4tiY5urOHqWMHc47asXMJtDbIUhNZnrP1FXLHSJUmrT0s6X35r
	2NWS7i9DeW288vw2ADQE8IuG2DrEBi8kepvke37dmpCLEdVN6ytRNWKL7YRpeYt4AxtTQmxZyFiOx
	CiZyTxgwz09xfYYlgDb/djgNlNKVN5Cdu4gUQ4OdkKl1R0UYvhWVCCjbwvp592mfyvmq7+1q4dWCS
	VJAOXCjw==;
Received: from 5-226-109-134.static.ip.netia.com.pl ([5.226.109.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9bQ3-00000006Ty9-0SSV;
	Fri, 17 Oct 2025 03:46:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	willy@infradead.org,
	dlemoal@kernel.org,
	hans.holmberg@wdc.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: allow file systems to increase the minimum writeback chunk size v2
Date: Fri, 17 Oct 2025 05:45:46 +0200
Message-ID: <20251017034611.651385-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

The relatively low minimal writeback size of 4MiB leads means that
written back inodes on rotational media are switched a lot.  Besides
introducing additional seeks, this also can lead to extreme file
fragmentation on zoned devices when a lot of files are cached relative
to the available writeback bandwidth.
							         
Add a superblock field that allows the file system to override the
default size, and set it to the zone size for zoned XFS.

Changes since v1:
 - covert the field to a long to match other related writeback code
 - cap the zone XFS writeback size to the maximum extent size
 - write an extensive comment about the tradeoffs of setting the value
 - fix a commit message typo

Diffstat:
 fs/fs-writeback.c         |   26 +++++++++-----------------
 fs/super.c                |    1 +
 fs/xfs/xfs_zone_alloc.c   |   28 ++++++++++++++++++++++++++--
 include/linux/fs.h        |    1 +
 include/linux/writeback.h |    5 +++++
 5 files changed, 42 insertions(+), 19 deletions(-)

