Return-Path: <linux-fsdevel+bounces-39262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C0A11E87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2943ADED9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6B24224E;
	Wed, 15 Jan 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4i06VkcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9E241A16;
	Wed, 15 Jan 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934448; cv=none; b=fVF3E30UVACxc4SPa/2Xiu2ZvBIki9/iBRa2fUuUA0qdMldZygS8JALd+n27l0XU0jGEgbD4sXeRv6HhDKdnS7iWVPB+pvgARl+c6z1mjwUfaD/339QnKj1xxhKIH7ZtgiNAWxMSYOiQVlEhSaNLGahAHVWtMg+CzNlSQGV1NsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934448; c=relaxed/simple;
	bh=KpwZLymFawxvtkG9c0dF+EwKcjQ6kkYvXIu+z8ws6F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGKh12v79bf9p3frFVMVTwVGG8JgdHypyCXvZHqoXXztTeA12eoyYsJm/+2C77wuaTe4/aKJaX3RvSOkluGUiqCMNoy1NjCozf71AFva4gr2cMLwpdSmDgnHV1l4hiVivE/6BOJssXHGRaJ55Xh/HWpNVP9uPUKefrtf4vei2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4i06VkcB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZxUBne0G/XLQFQ1URg54UYUl7/jIy/7Nitz9EvG+UdI=; b=4i06VkcBgTv80wC9jlhm43uqnO
	SaUx2axJyzLuuZJGQBiyDXV1vofYcQjlFJnj7cYgeDFqyQaOtE5mVpKa6/qZTddTupg0T1sA/B3YG
	JviSj4bfuy/TLsuAjQqWzp7SOi3Zk4BHMjOg8n67V+ZXWNY9DPskD2bD/phwb8U2LD7s3AXPmluve
	tHoCxb6OG6SMmfrLMJ7fFdxATHVOA3ESfbSqTewWczUs5t/bY2lGj73c90AY3V4PbkLYmMBe84NnL
	ycArGN4LQ16VZXaTzElrFip+NrifMaEI3704kr0Q6o1QnSRxRZcUq416AhTrt5OZ+TqCSxQcIlKmm
	5CxTkYLw==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzh-0000000BOjb-31T0;
	Wed, 15 Jan 2025 09:47:26 +0000
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
Subject: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Date: Wed, 15 Jan 2025 10:46:44 +0100
Message-ID: <20250115094702.504610-9-hch@lst.de>
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
 fs/gfs2/quota.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 72b48f6f5561..58bc5013ca49 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -236,8 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 		return NULL;
 
 	qd->qd_sbd = sdp;
-	qd->qd_lockref.count = 0;
-	spin_lock_init(&qd->qd_lockref.lock);
+	lockref_init(&qd->qd_lockref, 0);
 	qd->qd_id = qid;
 	qd->qd_slot = -1;
 	INIT_LIST_HEAD(&qd->qd_lru);
-- 
2.45.2


