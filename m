Return-Path: <linux-fsdevel+bounces-23403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED9992BDB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233841F26485
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5319D060;
	Tue,  9 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CS6lryfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1218FDBD
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537399; cv=none; b=g+C726KxQsb+pUY4S20T1H/MfHq25ONtZGeOnUXgIlWvZhrF2qmdERQ/Lyp6I+HzbStaLOAS8zShRAAN8rn3DXPnReUWaSn+nckiXT8/gzz0DdGWJkmenOBEzd/RpLHmKNKQybzLrvPEt92CfYm9Z6zNF7AjKmul5m6IX8IHPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537399; c=relaxed/simple;
	bh=EHFO4COxVI/ItaBgjkAazCvGv2dOd647NACB3GTx0sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mESj3sL4J1glr4t1fpkCFWeNO+tq7gBxmeRZ9ZNs0FPBMfPjz/N56a2pimpf3ttP8OxUzJpKSdEKpNaYpR8qkERMer6iUvy8wew346Mqp+URURDPIsXyH5My1IyQAXE4047q6r2SvsnO2n6RDsSFnw3DHd+pAThzjyQfaB5Z2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CS6lryfd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=r5U8ow87LniB6MbykTphy9Sv/XESyJIsi3mqF5DOjXY=; b=CS6lryfdVP/jxt0ZCV0rFAVEzp
	kblr57CEEugMug1L9U+97rR7/All7v0gGZVFF04QEWmrwi7Y7LeGA2ApDI2jW3FdFOc0lLOLH33lf
	m8H8g8NdH70nHHHk3KNccZ8RySTL0xFZkVyKyeuULqpYOqJo0okR1c0GY7QHVKYpGmfH2M4HMgD/x
	Ixy6nj1n9rh+mBRnqdQLKBbvFgX/sYol/0rWAMCyK2Dd0bw+mVrQQFXbS7oB1Erhy+AGuWvoNIj8J
	Cowa6WF2sICpIZbsOGKRgcB2Hu7iCfy6Yu7sH9Cha3FGYCFhARrvXqwUiC8LAdy5XtigOEm5fQi/B
	We4OCJ8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCN9-00000007zrq-19Gr;
	Tue, 09 Jul 2024 15:03:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/7] Convert sysv directory handling to folios
Date: Tue,  9 Jul 2024 16:03:05 +0100
Message-ID: <20240709150314.1906109-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series mirrors the changes to ext2 directory handling.
It's a bit simpler than the UFS one from yesterday as sysv was already
converted to kmap_local.  Again, compile tested only.

Matthew Wilcox (Oracle) (7):
  sysv: Convert dir_get_page() to dir_get_folio()
  sysv: Convert sysv_find_entry() to take a folio
  sysv: Convert sysv_set_link() and sysv_dotdot() to take a folio
  sysv: Convert sysv_delete_entry() to work on a folio
  sysv: Convert sysv_make_empty() to use a folio
  sysv: Convert sysv_prepare_chunk() to take a folio
  sysv: Convert dir_commit_chunk() to take a folio

 fs/sysv/dir.c   | 158 +++++++++++++++++++++++-------------------------
 fs/sysv/itree.c |   4 +-
 fs/sysv/namei.c |  32 +++++-----
 fs/sysv/sysv.h  |  20 +++---
 4 files changed, 105 insertions(+), 109 deletions(-)

-- 
2.43.0


