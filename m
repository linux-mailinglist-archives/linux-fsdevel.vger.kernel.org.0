Return-Path: <linux-fsdevel+bounces-23351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47C92AEC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CF228238F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136138F91;
	Tue,  9 Jul 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ALiUVvuE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1F12C46F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495837; cv=none; b=sgB7jCJsXvTtKclkiBm8WsDzVXyTU8A91JkM70p9q5FpD/zZReEUtuuc4lreheGlfP8Kdi7WSFOeSWWD1MN/LrS76jqkSldc5XK14gCAxGl5P57vHN2ipJ3lLr6sedUzbvIXw8QcjIzC6jzHc1rP9r5p7BFD9EoF0pZOaID0Eoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495837; c=relaxed/simple;
	bh=DvmtnJ2FYvnv1Zx1bRwWHBDSQZ3uELjfaougXl+V+xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFDnhxbQco7CrnwMIBD0oMhFOdGbT2PmtuvvT99WVGDV6x7+FxHjNMi5b+LuWTfPGNHC8nHOIJ1tNdTq7XEBB8DvX2b67QVKfi9H9U1yo4fwxxfPrPPvq5LayPZ2/sIYK0OW6g2hwaKBVI9mOBktRqEwEJo1JMBAisoF7tVLAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ALiUVvuE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JYDyuDCYx9FEkG3nJdi47/fwxznPHVIN3PSdVctfiZ0=; b=ALiUVvuErzi/K4m95CXqpxF177
	tOWszAVf78mHxkXfJb3OE3JHSP7FH2jRqnTQiAit2H2wUakIjjBKvL53a+ChUhA5RMIbAbnOF+624
	2m9WOItI8QpQ309RVdl5ko2b2qyF+XDlJkqh1V9SRxeNTV4A6U2BTSfKK5IvSOSXajiySR1eJ7qfq
	N9DnmYZNkPbZOgY/y65qCS8PCBkDHEzX/or+bkQd57HmNsrxCXsCsoQtg+fkUBQPvlD9d33kV/ohC
	Yi7+Aq1liswhaixwf/i3U4FDsyHPv9IknW5DQTocP/CmhIYb0usEVqEgFsAhnOG391Q12JQ2drcCK
	7tgZScCw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QSV-0k2U;
	Tue, 09 Jul 2024 03:30:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 00/10] Convert UFS directory handling to folios
Date: Tue,  9 Jul 2024 04:30:17 +0100
Message-ID: <20240709033029.1769992-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series mirrors the changes to ext2 directory handling.
It combines three distinct series of ext2 patches -- using kmap_local,
Al's refactoring of the xxx_get_page() interfaces and the folio patches,
and it does them in an order which is slightly more logical when you
know that you're going to be doing all three of those conversions.

Compile tested only.  I can't find a mkfs.ufs / mkfs.ffs.  I found a
Debian package called makefs, but couldn't figure out how to drive it
the way that fstests wants to.

Matthew Wilcox (Oracle) (10):
  ufs: Convert ufs_get_page() to use a folio
  ufs: Convert ufs_get_page() to ufs_get_folio()
  ufs: Convert ufs_check_page() to ufs_check_folio()
  ufs: Convert ufs_find_entry() to take a folio
  ufs: Convert ufs_set_link() and ufss_dotdot() to take a folio
  ufs: Convert ufs_delete_entry() to work on a folio
  ufs: Convert ufs_make_empty() to use a folio
  ufs: Convert ufs_prepare_chunk() to take a folio
  ufs; Convert ufs_commit_chunk() to take a folio
  ufs: Convert directory handling to kmap_local

 fs/ufs/dir.c   | 231 +++++++++++++++++++++++--------------------------
 fs/ufs/inode.c |   4 +-
 fs/ufs/namei.c |  39 ++++-----
 fs/ufs/ufs.h   |  20 +++--
 fs/ufs/util.h  |   6 +-
 5 files changed, 139 insertions(+), 161 deletions(-)

-- 
2.43.0


