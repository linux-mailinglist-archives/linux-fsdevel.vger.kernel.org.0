Return-Path: <linux-fsdevel+bounces-53846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2325AF813D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C371BC6A47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21132F2C7D;
	Thu,  3 Jul 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EeDRafEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964D239099
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570713; cv=none; b=JGS4U1jEhpZ545KDWVF2x0CJUHYW5onQ9JaYhz0dKSnBJK+oSwrQUIKaWrVJ7Url0sMcBUKBjBuZqxRpRNpku1PEMuWdFGMXiG1Tn//mJNqGeMxS9HYnXpAhk5+rELchU/Pu3+wMP80G31uiUyPLoFtIp9p1gDuYkICYrq0UF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570713; c=relaxed/simple;
	bh=ntzu9a6qPFj/9ZVdI01uTyS0g1jB6pvO4eOAtRohW7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/LEawaOvahWcQiK2Tt3W3Fd/M6bktNe8NRztc7y2z0BJlWQvJ+HNzPeYPNJQ/VJBQ+jv/x3e4WrtxwpILpFG1xNZl+nQao4/zZY5lN/0JG7rDotjqvJwFHYWkgPhcY9gi+2qgdwAZ6CXCT18D8gGbyXye784+Va8lhPoq3c8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EeDRafEN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=m3fWScTG3mTiuS3Uze4vX+CZq3wRMYiEijITCysYhGM=; b=EeDRafENYMuPBNXVcQkPmWG3wR
	wsti73/3/1qPSPrzJ+Zqxop5wbr+xu99UjV6Kas+J6DOTjskqkAsNVw1autP4dVr9b8o57VDiOqNl
	skaEZrQjZEvXG61cJhoGAokEK7bWBdFyShmVqw09rithKx9LAFrdpRM/1okqTME1x+HJVre7dm999
	mXYYwrjxtUx/dsstoNr+stAJ5j5EHPQARvQtbtvpEt/TUZxnxfFTGaQ7HLysiC7VlWcK9+kTcP/Mi
	kbK1OyFVlDHiEJTZiKUhG0k+7i4x6Ok/P1QLOuyQ+JXLpm7o5WNXiao9Tinhj2809dXAbI0SbTba4
	Nj9aDF0A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXPYK-0000000EBev-3h0K;
	Thu, 03 Jul 2025 19:25:00 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/1] Baby steps towards removing fuse_launder_folio
Date: Thu,  3 Jul 2025 20:24:55 +0100
Message-ID: <20250703192459.3381327-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In looking at removing ->launder_folio() altogether, I noticed that
FUSE relies on it to write back dirty folios by calling
invalidate_inode_pages2() or invalidate_inode_pages2_range() directly.
I have formed an opinion that neither of these APIs should be exported
to modules; modules should be forced to use filemap_invalidate_pages()
instead.  It's more efficient because it does the writeback all-at-once.

There are other filesystems which use those APIs (notably btrfs), so
they're not going away immediately, but I thought I'd get some feedback
on this step before I go any further.

Matthew Wilcox (Oracle) (1):
  fuse: Use filemap_invalidate_pages()

 fs/fuse/dax.c   | 16 ++++------------
 fs/fuse/dir.c   | 12 +++++++-----
 fs/fuse/file.c  | 16 +++++-----------
 fs/fuse/inode.c | 17 +++++------------
 4 files changed, 21 insertions(+), 40 deletions(-)

-- 
2.47.2


