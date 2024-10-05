Return-Path: <linux-fsdevel+bounces-31073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F9999196A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0D81C214D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683A158DCA;
	Sat,  5 Oct 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKoXf4g1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942A1798C;
	Sat,  5 Oct 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152598; cv=none; b=lQuudAeLEWKKsyfj81UOxY6bfMI4OTaa9qgcXJy76+XAtQFUVO9jc4BXGiQnPIatfa07KW3c199bz7vwmD8OT7a9hgZaMIeOGelwyoKmfQX7pwlSnXG7v2SbdM9JAZ/XYQSlzplt/IAL6YcFYZnb7Sp4a0tDr1Ybhta2eEGcl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152598; c=relaxed/simple;
	bh=qGVH1TMDE+WuK4Trs/T84+3p5LZa0vPPSBge2vrZqBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPV+BOrDFOHZE0X5gaEpit+WKKZ6V62Rou/3M9+0pu/+G9rtmhYjbWJLtoJ+JvHohl75FcabQRH4zMOn04jnO4XMM96MTA3SEtqMQQ2GjBgKVBJfl7Oh0YwOUofvyKU/Xnf+MpedQakEWu/Paiq0SVhhRjHmRcKwdFOdLDBZdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QKoXf4g1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=klTV4lguVyPl1noGd/4YHVIsSEUTx1B2eZYX5PJoSJY=; b=QKoXf4g1hpsqF7YpqtNBXNmLH4
	1guyh9zglvKKwfkF5011v4DAb3D2ietKkgyU67ZllrMp2yoWd3bAGXykl8T8zQRJdyj5qSDVZpbgi
	28Y7xLnSS3B6ZOKEpRSO4DcPt4SwWOEbNrX4iFUpVgmJ3ECUWTtM9fjqAKRmMUNkt8WZ9aTFp/bqA
	7JkTpD8BmnrKXlKpy9/Nr8dGtsNp9jRncycPVjUksteih5xL5tdxjVvwcA0Ue/lVdbFunF/frWEkB
	e0iz71Wa8vNHWII4qPDN5lVlUre59Lx7laz9w8uRTtiRzd6/1vr8Tj2IIqm0mhbQ8zjiolEpb7cKV
	Z4eWrzLg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx9Qr-0000000DNyP-3xRi;
	Sat, 05 Oct 2024 18:23:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Random netfs folio fixes
Date: Sat,  5 Oct 2024 19:23:02 +0100
Message-ID: <20241005182307.3190401-1-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few minor fixes; nothing earth-shattering.

Matthew Wilcox (Oracle) (3):
  netfs: Remove call to folio_index()
  netfs: Fix a few minor bugs in netfs_page_mkwrite()
  netfs: Remove unnecessary references to pages

 fs/netfs/buffered_read.c     |  8 +++----
 fs/netfs/buffered_write.c    | 41 ++++++++++++++++++------------------
 include/trace/events/netfs.h |  2 +-
 3 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.43.0


