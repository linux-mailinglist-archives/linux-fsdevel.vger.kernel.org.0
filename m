Return-Path: <linux-fsdevel+bounces-39259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DC3A11E81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11D03A9AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FB22416B2;
	Wed, 15 Jan 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bR2RAmVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB62416A6;
	Wed, 15 Jan 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934442; cv=none; b=KFiihRYdI2nM4X7RJmgTzvYAuIPYXogX38FhtPT6kvMujhfuxgF5k8HLaoRRgETbmHXHPth1NrAixUikaiMYvMqvjRGBV70qTCuuAsDtD0D7rNHyhHn7Qtrq8Z9k6wgppC64GSti6+0YxsCXb8i89WgP717CQH/A5XIqJnfMkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934442; c=relaxed/simple;
	bh=HyjG5UK1y+Ssb9PWULtP3S6Vhrk48RBP4LyTbTPipzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFOWwwmGZ74p5P44TtEP/4ZEcj5GTQ7JWka4F/H5X6AC7RkSuXn/YUXeJjDJiB/M/ivtLhUdQBkXIHLR8lVHBpwi92GPYXKveM/fgTNQeYLtdHG4WSqT47kAvl9PBOXGxFfIs/Jh2StFQTqGarOUm2kCpkOd1emCRux6gUjMpSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bR2RAmVo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JfHT3r6a2waLQ1axcUyumnw0jeW+jo8FKvycKmaGzeY=; b=bR2RAmVoqBnTJJ2YjwFXzYJR3U
	wNZZV35kNGFHfNZacudPz7xszFWix1gdKTjZTPxLSeK97IE17UGtRGRAbDyvop3kJN1fEiKG72+Lu
	+l1bvKMfgmmQrz/ePRwV8qALTqndGRaXYkZaHSx3pw0iIS/ndhjU+BcpJbzbGylHRTMCW5h++FlyM
	GiAmCzdjcI7EbJiPk1juaqXkUHqh9nlnl1aM/xl1RmCrxxyayMfp5IlIpODjH2ZM8cRsdBda/LF6x
	+kCJ8v3jSLdDzzeAwwnFSYNuElC7/JQ91uitQkor/sC0XC+gtjoHpcSrnKFmFyxxfSJwwZ91tJ3Uo
	HzPkhZvA==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzza-0000000BOgI-1TUG;
	Wed, 15 Jan 2025 09:47:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	gfs2@lists.linux.dev
Subject: [PATCH 5/8] lockref: add a lockref_init helper
Date: Wed, 15 Jan 2025 10:46:41 +0100
Message-ID: <20250115094702.504610-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to initialize the lockdep, that is initialize the spinlock
and set a value.  Having to open code them isn't a big deal, but having
an initializer feels right for a proper primitive.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index f821f46e9fb4..c39f119659ba 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -34,6 +34,17 @@ struct lockref {
 	};
 };
 
+/**
+ * lockref_init - Initialize a lockref
+ * @lockref: pointer to lockref structure
+ * @count: initial count
+ */
+static inline void lockref_init(struct lockref *lockref, unsigned int count)
+{
+	spin_lock_init(&lockref->lock);
+	lockref->count = count;
+}
+
 void lockref_get(struct lockref *lockref);
 int lockref_put_return(struct lockref *lockref);
 bool lockref_get_not_zero(struct lockref *lockref);
-- 
2.45.2


