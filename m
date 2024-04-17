Return-Path: <linux-fsdevel+bounces-17147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D48A86ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FC31C2178C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB7F146D4A;
	Wed, 17 Apr 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EvcoMQvg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450F13C3EF
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366261; cv=none; b=l/IO6a9tUIy52RiYBj7/IGQo3hMrB+uc2Sv9tTS2BrLzEuHB23/+JDObMr5GR2FpAU+TT6jCn7JApZGtXv+p/9T6DgprP17+HyilBWLo81y29C374zz6Qu+UQP6OWBLkQiX5WK4z2aY5sOODJpEEhgiH+haFeAO5F0HkyTyolro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366261; c=relaxed/simple;
	bh=nxbtKlsgGpt8ywgA5Meynybou2q8X5JzuNiz/JWfJuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3hSl98PloCtoUo9g6WuYkKDN4olfnhGAy7MCF0i7cDHQ/eQxKXqrdf9RfngZHZQUvZ7DexJZjUlk2ILfgd94xevyCwHOAjpP9lPj084Cwi4UGxysuDNWcmF6nIQl0V+O22O40+GZplSMe54YogUgnaKKEvUwOqfmgUfEr4IRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EvcoMQvg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wLcRZ7Yg6bjpaszNEHLWMsObCvYT0+nAKFBKzsKRfag=; b=EvcoMQvgBWxR/eZlX0YvROP4/O
	/dx3vxPXHunSD7XkFwrZ1om6F3hW31fcdpk3wb5bCKO/lTkq5oWw0WklqeuqpBLYYr1wDfk36SSBw
	YskebRc/2dLpwdN+qDRVBMQ51I1bOtCrQTHYdgzQE0G4/QnjKeU0hyS2rMxh1+gtHKdZ7CqXM/KAf
	JMbPTEj67pkHMrPHitABwp+02UE4NU3Vq2TEm1GoAG8aF2ilue3i7WuaI9/5hrLWFMdtG6H1Ok429
	gzdCS3JbfmCwxH91+XQCD7giIl7dCUyHq5hz2NbO/jz4sJVlLRNQfIL9cE5s6IHNJtikBA4z4aoLS
	qSVeHJhA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pd-000000039sV-3wYT;
	Wed, 17 Apr 2024 15:04:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] Convert UDF to folios
Date: Wed, 17 Apr 2024 16:04:06 +0100
Message-ID: <20240417150416.752929-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm not making any attempt here to support large folios.  This is just to
remove uses of the page-based APIs.  Most of these places are for inline
data or symlinks, so it wouldn't be appropriate to use large folios
(unless we want to support bs>PS, which seems to be permitted by UDF,
although not widely supported).

Matthew Wilcox (Oracle) (7):
  udf: Convert udf_symlink_filler() to use a folio
  udf: Convert udf_write_begin() to use a folio
  udf: Convert udf_expand_file_adinicb() to use a folio
  udf: Convert udf_adinicb_readpage() to udf_adinicb_read_folio()
  udf: Convert udf_symlink_getattr() to use a folio
  udf: Convert udf_page_mkwrite() to use a folio
  udf: Use a folio in udf_write_end()

 fs/udf/file.c    | 20 +++++++--------
 fs/udf/inode.c   | 65 ++++++++++++++++++++++++------------------------
 fs/udf/symlink.c | 34 +++++++++----------------
 3 files changed, 54 insertions(+), 65 deletions(-)

-- 
2.43.0


