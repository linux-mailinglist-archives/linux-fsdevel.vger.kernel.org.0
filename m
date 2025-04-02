Return-Path: <linux-fsdevel+bounces-45529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95CA791BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BA13B268A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C0623BD00;
	Wed,  2 Apr 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ScTsTzt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33223CF07
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606018; cv=none; b=Kcb4sDUmiTPfcY7YqBWnrGv5/Hu7sabwHEuWTERwAdx+S0WL6rgprEyj2c1U4Bqhr4MjzciLzUHy27+bKa1q6xZwFLY9bdG7OmwwVrirQUt+ti83F66pX5rHJajO6pTYVMyZ5o8ze5FlxMbDyL7Nq+LlQtnwwL5z9LYBr9DlVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606018; c=relaxed/simple;
	bh=1G0eHkvvi5FloOalxtCNhZ/TtjwzmESAXqqd3Vhx6Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMC8Ckl23/tOA+LAY/63OnPf5r9Pu+A1b2dttKgRfztZpV0llwvGhb3KrOStIGMQzsVd6kllEgkh0Fj0L5sQzP4bXQrFfTvHqtbu+6dVBopA+KxCRTdSVFNfEnlfHeWTgC5sOV7tj/uxg7enu41m0cMlolNfUPqE8rqmd9iwrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ScTsTzt7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JrWfZHYaL1LB2CfV3wA6B/ZV3xONYPAnicrYvr7FKzI=; b=ScTsTzt7A9KqbWcH+wfjuvFyEF
	p8UcTNQSyVSGqkHBnpx/RaVrlyhPH+97A0cB4uZrbN6Dvn0Z8imW2i5xQORC+EaVlmOalg8rgX8ou
	uetEj7BIdtEiE/cxYdPeQTYYeG3cmuWHI7sfzF/tIPEGBnW3WN00BLf4VXN5yt5+A/6xqjcGyg+GU
	jt8bImdTOgS7baV2zVD+5+m6ad6mvjOqnmCur8NpI695S0vEumnhOZpMU12g58CZwD2m0tVjtWmqb
	fw0qhf/pRz+i/hH9RYkdaUUcpAKy1IZ1oK12wPWuh29tYSlOtLHULMclZ8PvKTunXEEWiUpwTGHCC
	fyG6Fnrg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZW-00000009gs5-484m;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/9] Remove aops->writepage
Date: Wed,  2 Apr 2025 15:59:54 +0100
Message-ID: <20250402150005.2309458-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have just one filesystm (vboxsf) left which implements ->writepage.
This patchset converts it to writepages then removes all the callers
of ->writepage.

v1: https://lore.kernel.org/linux-mm/20250307135414.2987755-1-willy@infradead.org/
v2:
 - Added ttm patch
 - Remove f2fs patches as they were merged
 - Add 9p patch
 - Add warning in migration code about aops which set writepages but not
   migrate_folio

Matthew Wilcox (Oracle) (9):
  9p: Add a migrate_folio method
  vboxsf: Convert to writepages
  migrate: Remove call to ->writepage
  writeback: Remove writeback_use_writepage()
  shmem: Add shmem_writeout()
  i915: Use writeback_iter()
  ttm: Call shmem_writeout() from ttm_backup_backup_page()
  mm: Remove swap_writepage() and shmem_writepage()
  fs: Remove aops->writepage

 Documentation/admin-guide/cgroup-v2.rst   |  2 +-
 Documentation/filesystems/fscrypt.rst     |  2 +-
 Documentation/filesystems/locking.rst     | 54 +-------------------
 Documentation/filesystems/vfs.rst         | 39 ++++-----------
 block/blk-wbt.c                           |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 32 +++---------
 drivers/gpu/drm/ttm/ttm_backup.c          |  8 +--
 fs/9p/vfs_addr.c                          |  1 +
 fs/buffer.c                               |  4 +-
 fs/vboxsf/file.c                          | 47 +++++++++---------
 include/linux/fs.h                        |  1 -
 include/linux/shmem_fs.h                  |  7 +--
 mm/migrate.c                              | 60 +++--------------------
 mm/page-writeback.c                       | 28 +----------
 mm/page_io.c                              |  3 +-
 mm/shmem.c                                | 33 ++++++-------
 mm/swap.h                                 |  4 +-
 mm/swap_state.c                           |  1 -
 mm/swapfile.c                             |  2 +-
 mm/vmscan.c                               | 29 ++++++-----
 20 files changed, 101 insertions(+), 258 deletions(-)

-- 
2.47.2


