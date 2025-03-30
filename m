Return-Path: <linux-fsdevel+bounces-45289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5DA758CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 08:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F7116CBFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 06:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D712189F36;
	Sun, 30 Mar 2025 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wLMgxrFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B841487ED;
	Sun, 30 Mar 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743317268; cv=none; b=HyjhoVCB3dTql5aU9WLCXQzSPHBFHPlHaIxfoqKQ6/Sq9rksFivvnZueLvTAV5clWYfUhPVce8bUeD/M7TazKGyTIlUj6nXBS0tPgA7K1fooHSPchj7K9e+oAZH5moIPrzGOXdCIyNWH5mFvJBIVV5HeOemLnHfZ4/tXreGNzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743317268; c=relaxed/simple;
	bh=S0yYGnICLAFP8vO8D9NkY4L3AoBOC/H7qrYdcLOST3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uuia6p9V9uRgdkaap1d+XTEjHMsw4peurTV6x1c3yxU1aivK7ShWOftH2+CXZF1V6eMlnDrPSzhzhKofAH/rrY55uCPIEy2rcVWWmSLIS6ELfQATIHF8TKhL82NZGq1RFGqqcY0MCbqNk/XBIusGKvqMBj695zOQEjOJlxiBFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wLMgxrFk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=onIgRtrD6Nz7xiHJP06V1b9T8bhfAqun/9iFQD7ExnE=; b=wLMgxrFkz6RqAFPXNuvnYeq12f
	5bSya1Py6vwHH0CVpx39eIsb6/UXSOBGCbMJW8R6L3ndD9p9F2thqCvw/1YMqFLbvqJG0ty5TXQV+
	JEiBumJAXM5KdYy5/BZpf2aijL5v1+dl+AN0TOGqrkmdrJiCLHggSJgUPTiSaGMCBhrohClOwL1N/
	NB8V+OmymtA4tru3MvjmAqAFqEVOmXc2pEskzexy7e9GKR2n85+03P5rxLFrlrY+2vFKlOMLy12n/
	gxpQhvAGP1EDtkbjD80PuOEW51KMtKo+50LGKQDA/lj1QobP65W4CjrzqEinA5wxs4JTdgrK3KGlZ
	eXsohaEw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tymSJ-0000000Fre8-1xZf;
	Sun, 30 Mar 2025 06:47:39 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	dave@stgolabs.net,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 0/3] mm: move migration work around to buffer-heads
Date: Sat, 29 Mar 2025 23:47:29 -0700
Message-ID: <20250330064732.3781046-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We have an eye-sore of a spin lock held during page migration which
was added for a ext4 jbd corruption fix for which we have no clear
public corruption data. We want to remove the spin lock on mm/migrate
so to help buffer-head filesystems embrace large folios, since we
can cond_resched() on large folios on folio_mc_copy(). I've managed
to reproduce a corruption by just removing the spinlock and stressing
ext4 with generic/750, a corruption happens after 3 hours.

The spin lock was added to help ext4 jbd and other users of
buffer_migrate_folio_norefs(), so the block device cache and nilfs2.
This does the work to move the heuristic needed to avoid page migration
to back to the buffere-head code on __find_get_block_slow() and only
to users of buffer_migrate_folio_norefs(). I have ran generic/750 over
20 hours and don't see the corruption issue.

I've also ran this patchset against all the following ext4 profiles on
all fstests tests and have found no regression, I've published the
baseline based on linux-next tag next-20250328 onto kdevops [0]. For
further sanity I've also tested this patchset against blktests as well
and found no regressions.

ext4-defaults
ext4-1k
ext4-2k
ext4-4k
ext4-bigalloc16k-4k
ext4-bigalloc32k-4k
ext4-bigalloc64k-4k
ext4-bigalloc1024k-4k
ext4-bigalloc2048k-4k
ext4-advanced-features

[0] https://github.com/linux-kdevops/kdevops/commit/3ecd638e67b14162b76b733a120e6e1b55698cc9

Luis Chamberlain (3):
  mm/migrate: add might_sleep() on __migrate_folio()
  fs/buffer: avoid races with folio migrations on
    __find_get_block_slow()
  mm/migrate: avoid atomic context on buffer_migrate_folio_norefs()
    migration

 fs/buffer.c  | 9 +++++++++
 mm/migrate.c | 6 +++---
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.47.2


