Return-Path: <linux-fsdevel+bounces-51596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44368AD9320
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 18:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2053D1BC2BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B583E1E8338;
	Fri, 13 Jun 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDtFz1Cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC951E1DE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833217; cv=none; b=mNpcUmSvN4dyZOjJRzz95EBHzc0dqHb5taLlJAZ2dWwC1x3+qzc7aJtq9c9i47SWL7ZKAHGphVVtnrbsa5zqdtbcNGh75NPkhbMjvUgsBNwyk53c6WNTG+cuzBdesOuvfEVZgV+aSD7Fiu92jv1bBL28HekKXYUBaqkjcSPeI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833217; c=relaxed/simple;
	bh=eyaf2aDXrPXPDBn94R26oxikW4dALpx8sr3+SS0MeLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkshvEuz+zk2+GVAxDxScgDESRn3HRc9xN8sRbcTk1sbrbkFQnM4gv8Oj2VFFVxrDh2T7DX3QNEiIMc8vOcC3xItdyikjPx49i00zZw2/0CKvxVGm2ei/UX/OP+FWBlMUz6tQ/DRYwxQuK1iQS8BcuzOF/uxZLgTBsil4aK9OrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qDtFz1Cw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9j2F0QSwe0k12riPOHz1cCXCeKN0G5yzhSjs0op5PzY=; b=qDtFz1CwSZOu8F9BskRcTH8n1F
	l2CuLLH8IxJar8zDct5xrfGfnpsPlaikgHi9ajVr+PGBs8F+QdMNhFgecQxyLWARrPrEg1fGvSzsh
	hsGLUdbo9CJZ1mE9pxLkIJz2/tPJrs3v3F1njOKkqYn/baKIUgXzRgfZ61kBcn6TA2PuLWFoT/TCg
	ydI1gcjFNAw8++Zunzbv4aJfcpZEQmrks6DYFjQUdtxqXIJbJ8HJTTfcdaQ0AK/Fg7lD+bTfNkEW2
	Coo9a9+bSHAQV5ozzft6PLeLOMMgQxJUDoF05C+Ts0eaDwNmYBy9trxpf1pMIIXirrxHVxaT6Tbj9
	x1o6pfbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ7YF-0000000DAjr-2mJ3;
	Fri, 13 Jun 2025 16:46:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH 0/2] Use folios for fuse readdir cache
Date: Fri, 13 Jun 2025 17:46:42 +0100
Message-ID: <20250613164646.3139481-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page cache stores folios, not pages.  While there's no need to use
large folios for this cache (nor advantage, I suspect), using a folio
here gets rid of about ten calls to compound_head() and some uses of
deprecated APIs.  This patch set is only compile-tested.

Matthew Wilcox (Oracle) (2):
  fuse: Use a folio in fuse_add_dirent_to_cache()
  fuse: Use a folio in fuse_readdir_cached()

 fs/fuse/readdir.c | 57 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

-- 
2.47.2


