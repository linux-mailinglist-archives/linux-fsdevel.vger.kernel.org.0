Return-Path: <linux-fsdevel+bounces-32933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15919B0DE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33C7282988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADB20EA3A;
	Fri, 25 Oct 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="szr5fSlr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223220C324;
	Fri, 25 Oct 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883307; cv=none; b=PPYQTt9EXPPDULj3vaCwtqHUofldBCqOMLNFv3npPrzJfNLSi9DIaNWiZZyNzPtNbbyTu9FtDv6eEhc+uljmbppeKFz5P+I+0igk+mCctIPqufRQl6QiLFe2nf6GOs2o3RicYc3CpiaOOcmkQ427FM7Cc1XLka7n1HKuIAj50Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883307; c=relaxed/simple;
	bh=Q5cv4ejlLyAbdSN8ZyGuvmkbB6tsTETOyhlhXchnkWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qH5dMIQcPWKMUSH+TKH+kqvc9eTO5lu/3twYPw0vER2PkAbhrslL9iS4w64jn0AYqDD2/XflOGLNH9INEJ7bP3tiggCxK8lhoz6iErwGxQxjdM7EuBeDmVfwwsoUDy+ohPVV0EoDXQDZXNKiOqjpP0GeTRzW2XKGd/GrPD3CbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=szr5fSlr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MRoCCleCfQ7M0+2tbcltkNRpZIWLteR4MiwF9XEsQNw=; b=szr5fSlrr7ASR2VAYzQ1IxmZlu
	laRujFw1Qper+7lBPqjJ2UrDfQfd3qiYBCW7ISRqwWINwj3xVbg9BQYGsDWv1VJGwS1b37hclztha
	dD1M3EHk0Ie6M+1jRwp0CwMXuxiqN8zM8W+CsLd9JJAShwzHhlli2v/X1iIv/oFqgLbg4Sm3bszXF
	wCGVjT0iqsmN6z2tuY+k5C8QzEC/20Cigkiuie3Ef5UJFdO6xtxjFMnBqMpeb9fqMW2/lloeXkTH9
	HjVT8eCelqfss4CN9O4AwvYrLl6wLwqEaOK6OlKE2peyr5oQoejK+0v1D1qcBy6MLnipEeTXclVEB
	xpPPDq3g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfb-00000005XB0-1qEg;
	Fri, 25 Oct 2024 19:08:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/10] Convert ecryptfs to use folios
Date: Fri, 25 Oct 2024 20:08:10 +0100
Message-ID: <20241025190822.1319162-1-willy@infradead.org>
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

v2:
 - Switch from 'rc' to 'err' in ecryptfs_read_folio
 - Use folio_end_read() in ecryptfs_read_folio
 - Remove kernel-doc warnings that 0day warned about
 - R-b tags from Pankaj

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

 fs/ecryptfs/crypto.c          |  35 +++++----
 fs/ecryptfs/ecryptfs_kernel.h |   9 +--
 fs/ecryptfs/mmap.c            | 136 ++++++++++++++--------------------
 fs/ecryptfs/read_write.c      |  50 ++++++-------
 4 files changed, 105 insertions(+), 125 deletions(-)

-- 
2.43.0


