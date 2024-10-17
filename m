Return-Path: <linux-fsdevel+bounces-32209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839D69A2649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F8B1C21BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E881DED4E;
	Thu, 17 Oct 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OO2bULY8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9781CBE8A;
	Thu, 17 Oct 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178234; cv=none; b=pLKEfesGvQbE5Xg+7hAcL3Eq3bjSqZq/rAD9APaLtSLQ9gwJtK5fAb0cFdbVsl0OXztqaX8Kpb1UEWzd4nmnyTgja7HUEtUPv6h3HGUD/RUliv84a6fT1wZnx1uh+YQs7wvTVAd0NV73wKTwpzfB7wUfDJC+xcPR+zqoYrXqMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178234; c=relaxed/simple;
	bh=E+F2EreOk+vVoVxEx7YqkqQtqJLpLtkI3JjcEozeZFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2uhVjzZrd4z1ZYfiwa1GHOD6tnXlk/DETThv5vhqK/3pRwQ5KLtbXcmM5xlllcmVe+RlD7HpJWA1Nv5ZiSg1EIszznns6yh+o7B5yrXh6Y5qhAUQY7fFQVB8PC1aQ5Aa/dJNGfkfz+VOSlfjGcH2JfYg3cOKilMKYcKCvAf7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OO2bULY8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NQKUoTsJIqSikKltWxDuMs/pO9gIjmSJ77EkpgpsTQQ=; b=OO2bULY8uV9JWXZYc2WxyAmFYc
	q4cGcJGMxYfRZa3kPG+vLufEH8ViWFropEnivkGRXLGtTMmd8llNU51KkJLy2xkaou94w2z7m6q4r
	ULiusbb71eJkdZq7/3btULCIlU2P5qR/hmpOGMLYNwue70Wry9cD2V3ygvQ+wCOGjaQMHIEfY3mWy
	/OVi4yzgLdnwbjTam20uf032s5gJDUDUAiRzrBEVs0yKzJ/WF7LCVoHtkGPjqNJEQlyzbioy/yHY4
	jfpvBEmrf6FxwzhaMCVMZRaodgrDoIde1Q/6gF7UlGgtwJZ6nZ/BPHpqIvNLE7NVOvlkaxf1sV36W
	8kkfOiFg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFS-0000000BNnD-2qId;
	Thu, 17 Oct 2024 15:17:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/10] Convert ecryptfs to use folios
Date: Thu, 17 Oct 2024 16:16:55 +0100
Message-ID: <20241017151709.2713048-1-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next step in the folio project is to remove page->index.  This
patchset does that for ecryptfs.  As an unloved filesystem, I haven't
made any effort to support large folios; this is just "keep it working".
I have only compile tested this, but since it's a straightforward
conversion I'm not expecting any problems beyond my fat fingers.

Matthew Wilcox (Oracle) (10):
  ecryptfs: Convert ecryptfs_writepage() to ecryptfs_writepages()
  ecryptfs: Use a folio throughout ecryptfs_read_folio()
  ecryptfs: Convert ecryptfs_copy_up_encrypted_with_header() to take a
    folio
  ecryptfs: Convert ecryptfs_read_lower_page_segment() to take a folio
  ecryptfs: Convert ecryptfs_write() to use a folio
  ecryptfs: Convert ecryptfs_write_lower_page_segment() to take a folio
  ecryptfs: Convert ecryptfs_encrypt_page() to take a folio
  ecryptfs: Convert ecryptfs_decrypt_page() to take a folio
  ecryptfs: Convert lower_offset_for_page() to take a folio
  ecryptfs: Pass the folio index to crypt_extent()

 fs/ecryptfs/crypto.c          |  30 ++++-----
 fs/ecryptfs/ecryptfs_kernel.h |   9 ++-
 fs/ecryptfs/mmap.c            | 113 ++++++++++++++--------------------
 fs/ecryptfs/read_write.c      |  50 +++++++--------
 4 files changed, 92 insertions(+), 110 deletions(-)

-- 
2.43.0


