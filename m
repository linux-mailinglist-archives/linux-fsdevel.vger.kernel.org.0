Return-Path: <linux-fsdevel+bounces-39260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED35A11E84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5F33AC391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC22419E8;
	Wed, 15 Jan 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TEcVQuCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC82416AD;
	Wed, 15 Jan 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934444; cv=none; b=AFlORFpWqAsISXaYxb5UYWm8/bDDCbKCBp/7XcbkD3ESfzFm2Sq0FBOFZSCypixavM24WZQtTmgeoAbhOAwj6+wP5GuEOfTpy5URh/vMQOQc/gctuBb/8FKXblMWWK2HvYNpGIrsLoE5um2modhAvrgQik/YglsIK3ZN4L+y6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934444; c=relaxed/simple;
	bh=qR093yDhuLESpr8M4pLPhZWyQX6Hk9TUAiBtJ1tsrdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYE2y8mZKWGLmZJNf12MBxSXDhLg4hHSeEKsDL+q+hru9W1kXH2iCu//4o2oJBlpEC5qFTwDQTTMqFg6rjcsXTrUHN6rHpnEzAzd4Ks6icrSn9nQWx6MhMVQ4ExT3SJajZxItKuL02qoeKXPuXLziW5fvdNgQnrJX6eCMvvDMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TEcVQuCB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ExehWvHtv/dE+gm9ctBRtigxAXDYJyzO6NdGxVTaePM=; b=TEcVQuCBrtuxpbbGwt6sZya1tu
	euTd+T6inBKAGmmi2u3vsBYnZAMN42UtOxfDQbtcaQY+y4YlogzvG+ik5Z3fK6g6hWY49bOafbOGk
	vYdwQHhIbCq2HxTzWHQGstbvvu89Yi2f69H3/1xE/Fn9b+KU1Y6SQaOx2LceSGdunyhOdkRsM3AzS
	G7csU4LgFummki3Fw0E7K67xdCtq2vdgxq/ySgQI3gw6PknJIX9ZvLOdLEOHL6gwIQQaVX4S8hhHH
	b36fAJWyXzTQg04kE6Ul4Kyp3COkQxOz8WXCC+hGiLF920+djQ7z6tvkROeYhQcp5aEeqce5gIpzN
	bTUGT7TA==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzc-0000000BOhl-3P8y;
	Wed, 15 Jan 2025 09:47:21 +0000
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
Subject: [PATCH 6/8] dcache: use lockref_init for d_lockref
Date: Wed, 15 Jan 2025 10:46:42 +0100
Message-ID: <20250115094702.504610-7-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dcache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b4d5e9e1e43d..1a01d7a6a7a9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	/* Make sure we always see the terminating NUL character */
 	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
 
-	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
-	spin_lock_init(&dentry->d_lock);
+	lockref_init(&dentry->d_lockref, 1);
 	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
-- 
2.45.2


