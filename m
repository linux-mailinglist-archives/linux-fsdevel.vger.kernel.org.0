Return-Path: <linux-fsdevel+bounces-27314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81AE960267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AEF1F22EE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D6155C9A;
	Tue, 27 Aug 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T1mP+OC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E873A1C4;
	Tue, 27 Aug 2024 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741498; cv=none; b=pzlxrFVBHprjmaFop5f4KRd3JrOY08LTeyuKktJCwZ1UXQuFaU8ZHJ6pShF8UBkZbbYjUbYkwWqQl5DAyzX/uTRFXzT+KIVvivyPHL7sJRojBuIx59ZCPDzK49p35V+MNqHomnLs43aUFVC0NeudwoCQ03UPAIERWQEDKPnWEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741498; c=relaxed/simple;
	bh=rOo2NxP2pTdwjbOUifV5uf6WjDmc6V9X7z35uyGqPdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VafuAAbj9W+IkkxM/V/LnV43Xj4bgrMKnFED0HrMozQmyk4x3LxY65TUnXQ5yrdNezDGvX8NigbbfMt5QzA8ZzEga6g1kxgXxGm+eV3oJEeSwtDITXrCzMjqPHnONuOgsKS/j5/E2fTsimBzrXfId1/GjToNtComc/S2mg1ab9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T1mP+OC1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zMuI4AlzPiw69VELJGR7bipT5idXuxdPfDreEdpi1d8=; b=T1mP+OC1A+7/+81uDYUNTQ/FTx
	Xm3kv28mLohaeGqJqshAcidu9H0Zw5inZ45XvYuHDA2pKW/Eh6U5fDkGhfARVR/Mv53pfn1dY2Fr5
	T7Hh4m5q7xsclm/heJifUl6YO9obiw3LcXqzwDRk7H0WvVaNQ8ehHjgjEm+PsGnP22ALb6Yrr4Ep+
	ger7gf8EACsJ6r+BEFLFzMd7iVz+wCegoDFco1fe63luy2fMuHDtPXrMq/+QtGGo4VXnTHjc/DiAK
	YUVZYsPTPar/drA+lJvsSEP6Rf3vu13qkHwZbXfNkbUhi6tdJUpu0WJIGaElDm4yc0O7jZXxj/8S+
	2MT4SzJw==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siq3A-0000000A6CD-1hKF;
	Tue, 27 Aug 2024 06:51:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/6] ext4: remove tracing for FALLOC_FL_NO_HIDE_STALE
Date: Tue, 27 Aug 2024 08:50:46 +0200
Message-ID: <20240827065123.1762168-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827065123.1762168-1-hch@lst.de>
References: <20240827065123.1762168-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

FALLOC_FL_NO_HIDE_STALE can't make it past vfs_fallocate (and if the
flag does what the name implies that's a good thing as it would be
highly dangerous).  Remove the dead tracing code for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/ext4.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc5e9b7b2b44e7..156908641e68f1 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -91,7 +91,6 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 #define show_falloc_mode(mode) __print_flags(mode, "|",		\
 	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
 	{ FALLOC_FL_PUNCH_HOLE,		"PUNCH_HOLE"},		\
-	{ FALLOC_FL_NO_HIDE_STALE,	"NO_HIDE_STALE"},	\
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
 	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
 
-- 
2.43.0


