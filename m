Return-Path: <linux-fsdevel+bounces-17061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C98A7253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC51F2336E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EEF13442E;
	Tue, 16 Apr 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ec3HBoeR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9613442C;
	Tue, 16 Apr 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288557; cv=none; b=kCnDAzwNUuzccSkYHRWO1qF3xNGPqxa2zlbMpLNuQ4DXuKrb5ptEoSI92KgMwK/7f0MTf6S1J11LgiKlSjcl3a0OcEpdOS8shIxSHKxoUz34xTJfPEcziPHaqlUDpCfr9HixWlsz+FaCRysmzTCPqu9AleJaJwnzc8N0kzZOkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288557; c=relaxed/simple;
	bh=k2bGE8uwqko1AnkxR7CUiDTLaasMCrYqTVbD4mqEwpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njGmImx7o0J5VlsvKDx+GVyd/tr+EXR3bIgxrtDfdFlnwwUdhTIElKfIPANCRX22xFxn49OW3hfKiST1pp4bnLZsZps+FSw4tupNeA88i+RH6JQp0Q1+PvcffSuvbYmgnpvEOZS4jVav75ifkdNHnf1EgEVeEB97/Q01HlsegWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ec3HBoeR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0OSCt55dEgQI34uVmdcmd0uCwqm2BfTW6RA1K8oXs6M=; b=Ec3HBoeRP5MSyxL2qtm9WatSvo
	duWukmhM2rb27oQ/9grZ3vlFlrUkhPmc3Y5km7Nz17EtW2F/1nfdD00WRUg4vNODST3OdStaT4zfv
	u3CI0c4d+kckk3iy03KXy/bqpAeTmPg2DIeAs6KvNhgojbon1EctzjNXvRwhEPepwgfKfhhUyUFWX
	81THB+WZqaX9vXfFhgiAQe/Cerupe4rWSQck26ltQ/zUXa/VfGy60TuUbl2gk7spsVbfurnxO5sfG
	EKAwsgBD90OHXafQjgXepzx9wYZ//WNTxrzXN7qZG2QQP0alcPI9HnIBoY2/en15v1RTlu6pAES42
	bTVBzQ6g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwmcE-000000011eP-2rhX;
	Tue, 16 Apr 2024 17:29:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] Convert ext4's mballoc to use folios
Date: Tue, 16 Apr 2024 18:28:53 +0100
Message-ID: <20240416172900.244637-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These pages are stored in the page cache, so they're really folios.
Convert the whole file from pages to folios.

Matthew Wilcox (Oracle) (5):
  ext4: Convert bd_bitmap_page to bd_bitmap_folio
  ext4: Convert bd_buddy_page to bd_buddy_folio
  ext4: Convert ext4_mb_init_cache() to take a folio
  ext4: Convert ac_bitmap_page to ac_bitmap_folio
  ext4: Convert ac_buddy_page to ac_buddy_folio

 fs/ext4/mballoc.c | 230 +++++++++++++++++++++++-----------------------
 fs/ext4/mballoc.h |   8 +-
 2 files changed, 121 insertions(+), 117 deletions(-)

-- 
2.43.0


