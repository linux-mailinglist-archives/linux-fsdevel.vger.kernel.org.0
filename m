Return-Path: <linux-fsdevel+bounces-31064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228E991922
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369981C21029
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD1158208;
	Sat,  5 Oct 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="READ5UbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A335231C92
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151346; cv=none; b=i0e56DsvIfHNE5ofH2d49En4psIXIydxl915dvLfFoX37ZDnTNzkFf/oaxDzuhARR/yTtc+j4ZqCz4cVmiHo6Q5dwk87dwRkd7KjfywXC77R6lBOfegxsfGoPqs5LBAgbBWZ9GbZ5P+G1eoNrabmcG1rx6C/3wZaKO0qPNYmcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151346; c=relaxed/simple;
	bh=jjrsTTXJmbTO6kBSBOWGuBNn/pnZRfYt89DGtRhdWfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GL0O6varQxWJPu6/2HTCagRBHrPfPRI5Ok2xvC3i065wBFW3FMCwALgwMeXS5FZ/5W+rj0xjFVBsPi9AAJgR6AVCla2CRn/ef+N16ztFwXXZV43E1JbrWY0D6rzVbopHJ6fsdFa3WReiy1trtDPxfLuR9cOggyTfdxOIIg+8ClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=READ5UbX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jgkuM0PchMsBcqomgPvP1AAmehuO97iNSoMNOzMX+W0=; b=READ5UbXuvChsuDwgMBYfoFtIu
	nMmeWQ/I6styJvwfRzhrt499diAvqeXLEL04L7NEaUsysMk4dYN2viEnJaojA1bAWQ63lJ+CdYgU7
	AXGoAvdNQ+b6LkSnkQSwK3wyywFWRS5RbnSb4Z3MjAE0qjUq47UwZCCHVygM9Xs/WQq1XUFb4pI4+
	WPB40Rw8BamtmJb2qINTuT02FXfH5tl2+sZJpVkmLlFPWT9+gja2i8pAa0qLCnG5YAvGYkA9fkvAl
	xH0UHk3beNPDrUnUVTbzMI7KGddLEzWc9bEygKuqMNYCtXYgeSqntEbGLr3gkAgnHFNXZqGeIAgYF
	1YfFSagA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx96f-0000000DLky-1AdW;
	Sat, 05 Oct 2024 18:02:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] UFS: Final folio conversions
Date: Sat,  5 Oct 2024 19:02:03 +0100
Message-ID: <20241005180214.3181728-1-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the last use of struct page I've been able to find in UFS.
All the hard work was done earlier; this is just passing in bh->b_folio
instead of bh->b_page.

Matthew Wilcox (Oracle) (5):
  ufs: Convert ufs_inode_getblock() to take a folio
  ufs: Convert ufs_extend_tail() to take a folio
  ufs: Convert ufs_inode_getfrag() to take a folio
  ufs: Pass a folio to ufs_new_fragments()
  ufs: Convert ufs_change_blocknr() to take a folio

 fs/ufs/balloc.c | 16 ++++++++--------
 fs/ufs/inode.c  | 30 ++++++++++++++----------------
 fs/ufs/ufs.h    |  8 ++++----
 3 files changed, 26 insertions(+), 28 deletions(-)

-- 
2.43.0


