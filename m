Return-Path: <linux-fsdevel+bounces-39261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD02A11E85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59963ADB1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EC241A0A;
	Wed, 15 Jan 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2i2h1J9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921272419EA;
	Wed, 15 Jan 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934445; cv=none; b=Sa/zBpeIq4+mjLEPDdnh/5CcEIjASp04SVMJRxA/ao7Cp5vQLiVHV8KBs1OWJCOkPep/7ttSsMIeIySI/i/c3Pb+WF56qGVvTcQVgQKB05eTWSykYukJrkdx7cgpRx/iB4kQdhTUVsnODCtQrUJ9V9TMWXQhZSkIeoLYMRhQLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934445; c=relaxed/simple;
	bh=KiyXs8tJMrR7Nul27PjQn4qNHqrjKqhAR+bmlc26GME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKsvqDupoMItKYVpSYV6m5W2MdC9M3SxHInAi0P0O+5jkX6ZBx5kLG8vTXHCPKOx5ZX7swjMFgzn4THIcldveDXHAMEW19dlTUFStY1TaTgYqX+OZGka1hqe3M3LcObKB3BTXCn0zPKsL9S5hEuI+h7mPs7kLTmHX/OhqX4Ic/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2i2h1J9W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=easVSrQ5eMjG5N5DCivClgnlxU07C0jtlUyU9+xSgOg=; b=2i2h1J9Wdt8M088Q+u5JEaevWW
	cig673kf18t+fTojaEjdQziAxcx+drGWauAClKDHT/UuGsaAC5jUPljm6lj3FiI/ZT2R+fnfrFosl
	T/5m9TTME/hTxgWyO2chfKfuxJJk9ibiNysBmGHOlUY9yFzH+A9P3g0yHcWmORuBvaVpV2gXZGa/H
	8qHYA9jBGMk5O7uN7N2ZELltAQ+wZQeN01nT+lGegyy9gNmRjAC3Sd3BsGsIBpfeg5mvQVojnpVRs
	jZ5PmkdpTl2fBcXol1sj7Hb2I5UxZph9NH5rpTLu/MJjIf4WjiDW09ksJ1wFvJXTJMv0O7ArCMqEq
	Hbdh76Ag==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzf-0000000BOiV-15i5;
	Wed, 15 Jan 2025 09:47:23 +0000
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
Subject: [PATCH 7/8] erofs: use lockref_init for pcl->lockref
Date: Wed, 15 Jan 2025 10:46:43 +0100
Message-ID: <20250115094702.504610-8-hch@lst.de>
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
 fs/erofs/zdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 19ef4ff2a134..254f6ad2c336 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -747,8 +747,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
-	spin_lock_init(&pcl->lockref.lock);
-	pcl->lockref.count = 1;		/* one ref for this request */
+	lockref_init(&pcl->lockref, 1); /* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.45.2


