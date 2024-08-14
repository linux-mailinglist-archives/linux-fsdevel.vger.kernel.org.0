Return-Path: <linux-fsdevel+bounces-25959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD3952303
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F37B23B2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B071BF30F;
	Wed, 14 Aug 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qBS5+BPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308EB679
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665569; cv=none; b=ZAV66M6Cd8HviodFLBSoXCCz55YRLm7Nwj0n/eXny8mE25tQmbMgN0tiTIbOc1NrF6tjFtETiIcTdoupTkTFc5F+Zc7SMSb+fJhJM7QUXN7v0q6wD+4A0O/ILuYzHHv15DLF7G3+Fpo+0Vz5ZHCgriaou42BTUzkhzGFTGAPzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665569; c=relaxed/simple;
	bh=ODr34g63mKW5U5KO+JL+OS7XtHmIXw3jQiurk/qw56U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmMiQJEPaYnWX9H8swczEAuaDXM+tIqmGuFtzeo6da1u7p5m0fakNzmc6oXmXMC2dHhoiXqgWWscReilKAHqFljJb+OaFMG+QGU8Zfu2CEbsCGloVCu0iKSrVVQoGxcdR2wJtf6m6LvC9Upgjd1temwnB60QDsNCzDubDwaMhm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qBS5+BPF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2htqNeW12YiZCg0oFZHJYYAzv3at8noFM0U063pem/Q=; b=qBS5+BPFJokDCTQHBm/5lFCzUc
	1CSH2Ker5yGkPgyAy3/7pQv0aGGWzQU3iwq+Dpl6OU/wgOqM/Mcg4gkSG12mjMYHmww4DiLYIE/BE
	A5/3GeELMog1vmNNyIWezq2/HDUMWcM3le18ZDqzcK4yFJB3AmfVyh/YiMLSH281ZR95OSyl1d2Q+
	sJfzcB4PLM78rrfcbTQKRxCySgmUVqjZ13gZVeZkqcKx1gFzNHIiuiBs6yqCrs58SVldVpSWE1jVl
	5G0nzprf573B5k9XAOP1PTZAPYg9wtKl2/PsjCuyXva4gVJhHd6R6BMhQ5AgMhuNRD99cX/D0S4bf
	pWmiADRw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seK9Q-0000000130S-1pXG;
	Wed, 14 Aug 2024 19:59:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Finish converting jffs2 to folios
Date: Wed, 14 Aug 2024 20:59:11 +0100
Message-ID: <20240814195915.249871-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series applies on top of fs-next.  I suggest it goes through
Christian's tree.  After applying these two patches, there are no more
references to 'struct page' in jffs2.  I obviously haven't tested it at
all beyond compilation.

Matthew Wilcox (Oracle) (2):
  jffs2: Convert jffs2_do_readpage_nolock to take a folio
  jffs2: Use a folio in jffs2_garbage_collect_dnode()

 fs/jffs2/file.c | 24 +++++++++++-------------
 fs/jffs2/gc.c   | 25 ++++++++++++-------------
 2 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.43.0


