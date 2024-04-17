Return-Path: <linux-fsdevel+bounces-17173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F68A89F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E51C21A10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FBC172787;
	Wed, 17 Apr 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuI7rYMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171171474DB;
	Wed, 17 Apr 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373791; cv=none; b=B6HaZkl5CcP7sgbC8tYeIELPv6c3DhccRN+zXGmVGq5+79SMBjefy8vFdPpnKQAeOd1SgCEf3+bGFCxcX+dcsQzOWc4xn8ZImuvx2z1+Yx7zPm+rrv9pMV1O1CEw6AFDw+U9i0XuQzl6cxMYRRvFpZhN9fcxAcjTBLjecvvcFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373791; c=relaxed/simple;
	bh=DW6JlRAmz29yAGaJgq0ObRQBK8QgVwlYF9/qzwutMf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sm3gxOgpPaSyzGhHHUoQQoRI98WgNpJVSpDyXq9fsS1JYZqHzWFwO8cjYecZ1TaDSamWwcmzagRadh3t9o1YgSX9LzNQ9k4islM2Gj0qkSs9TGyAEj73v7wfmOlSo4OoV0nAqw0/rsZD+rH1tXnMwzW5/7jvaxQaqbig6csgy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NuI7rYMy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=TPcTRvYAVJvGgWEdC2RwuYPJ3+0NOl/B/leUs9Y+eBA=; b=NuI7rYMyF+HL0+DIMRpSoi6qzq
	a/F9/pomwaBUleC8MR0T8CaqmA1RJWGkn2FNHqHZJfVNMHxDwCtfly3xlwU3nF/weI8+Ik0dBubMU
	nUWXS84uDBgun0FOfN5QC9M6oDyKDE6V1/8OUDXN8QXI6l+tROhL7qXTj67SDCwFVLfPsbA9O3YFJ
	2r0DLdR/Eu5k5FvYmXPu6M9niy5sJQ+rXbbr1KcCtRnan+UIC8DxJT3QfjuUAT7hD7gp8JMVSNN/l
	gH7G6AK5/640TOL5xfIklWdpWGYPP2N1RzI+0J7DQA0OyOqjjqnScY8BBOCJ83631ldIN2SfsWwTM
	IzbULjFA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n5-00000003LN2-0LHc;
	Wed, 17 Apr 2024 17:09:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/10] ntfs3: Convert (most of) ntfs3 to use folios
Date: Wed, 17 Apr 2024 18:09:28 +0100
Message-ID: <20240417170941.797116-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm not making any attempt here to support large folios.  This is just
to remove uses of the page-based APIs.  There are still a number of
places in ntfs3 which use a struct page, but this is a good start on
the conversions.

Matthew Wilcox (Oracle) (10):
  ntfs3: Convert ntfs_read_folio to use a folio
  ntfs3: Convert ntfs_write_begin to use a folio
  ntfs3: Convert attr_data_read_resident() to take a folio
  ntfs3: Convert ntfs_write_end() to work on a folio
  ntfs3: Convert attr_data_write_resident to use a folio
  ntfs3: Convert attr_make_nonresident to use a folio
  ntfs3: Convert reading $AttrDef to use folios
  ntfs3: Use a folio to read UpCase
  ntfs3: Remove inode_write_data()
  ntfs3: Remove ntfs_map_page and ntfs_unmap_page

 fs/ntfs3/attrib.c       | 65 +++++++++++++---------------------
 fs/ntfs3/inode.c        | 77 +++++++++++++----------------------------
 fs/ntfs3/ntfs_fs.h      | 21 ++---------
 fs/ntfs3/super.c        | 43 ++++++++++++-----------
 include/linux/highmem.h | 31 +++++++++++++++++
 5 files changed, 104 insertions(+), 133 deletions(-)

-- 
2.43.0


