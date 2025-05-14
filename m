Return-Path: <linux-fsdevel+bounces-48991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B368AB7283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376B33A9469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EAD280337;
	Wed, 14 May 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hwX8VH8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA91991DD;
	Wed, 14 May 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242800; cv=none; b=QWEIvtxaOHfNemQAIPUdvqs6X4Oyp0cXAHqxxZUEdqBC0XKmUWsT3Lf27OFf6JXgDF2ChWEnPIrzprZNJqaQw5E2m/8heWYcwRMsqtH5JdJ3E7C48StVUv1RuRe0QF+Bx5AKhwnVKZ+/0p2HZcydbcczJa8ppgy/U5GwYswZkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242800; c=relaxed/simple;
	bh=enA6D7FBN9/BT6cSuEnSaPqLSg83ibA3ObXGUIyQ5n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLR3wL+rBytEyZaX9M95+nh/iDXFgQ11MgKY/cMkhRbTOi1bgyu/USIanIlSE0eEKJNgwprDgh+R98y59TojtbBdZrHqZk3gSwEZaZ7JJwvrmQ8aN3Cxh9Hvd0K74ZAXqcTUCemUbLWlSRlc2jeZr7G7VGpHzzeSYQPj8TabhkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hwX8VH8g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+273IOvShaKNM026nVUVqQx7SwpKST0yxcxx7ye9MVs=; b=hwX8VH8gFAHxnSsYitle7oa0Dm
	l2KecbC1UWDqBPE3mHwVfluMBTKgv6YblQ/dRo/OPxrgVvbKAaovC4YTn66J0CGBDkqluEb3TFVQ+
	jDmSO8KNauWHHiYQXFfZ6E5CoAkLz5mpBZgMILOvTlotjxQQeYz3OWkNxKoSe/7jNPRUxa7YD2LfU
	fOedLeLksFqyJi22ZAFkkuEZJWJwL0EWxFP2YIsHqFBLzZyBWfn+hcSV0Ikl7BPRCZWde6jRZOBNb
	6h/WrbbTu28rUgYTZy6FFgtnc3KLNVqWvsuSIeag+je+wIMgx56aLcu2mzjDarE7S5TVmsNFitXfH
	Meqk8GnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFfR-0000000CbCb-1NOD;
	Wed, 14 May 2025 17:13:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Use folios for symlinks in the page cache
Date: Wed, 14 May 2025 18:13:11 +0100
Message-ID: <20250514171316.3002934-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE already uses folios for its symlinks.  Mirror that conversion in
the generic code and the NFS code.  That lets us get rid of a few
folio->page->folio conversions in this path, and some of the few
remaining users of read_cache_page() / read_mapping_page().

If anyone's concerned about all the extra lines in the diffstat, it's
documentation that I've added.

Matthew Wilcox (Oracle) (3):
  fs: Convert __page_get_link() to use a folio
  nfs: Use a folio in nfs_get_link()
  fs: Pass a folio to page_put_link()

 fs/fuse/dir.c    |  2 +-
 fs/namei.c       | 48 ++++++++++++++++++++++++++++++++++++------------
 fs/nfs/symlink.c | 20 ++++++++++----------
 3 files changed, 47 insertions(+), 23 deletions(-)

-- 
2.47.2


