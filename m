Return-Path: <linux-fsdevel+bounces-56252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1CFB14F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5321A17570D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7027E054;
	Tue, 29 Jul 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DiIpcvR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28A27874A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800828; cv=none; b=G7xdi6lng8KUjsko2TpqdAiR5dvqyksHPPlI3wk0DkTGwRKkUoGm/ucGkgJcLApdVCzOVoyucfCxH4uot+kpKb0buZpkGWCQPS26U08C0bO47ZF1mopaFRItJ3yuinM+4Gsj4mk8KYOAHXuISmZ58nQg8XSDusEQpHsZrgbH3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800828; c=relaxed/simple;
	bh=585UtF0aO/k9pFshpDX/gQ4n9Ullc3gGvN/k1NMAuyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DYnrOhxOzctaipszujx0Sa9L4VENxoci0q6PKQc01Rgt0w/N16QTitZb2h7izCASgkt0yN1PPPSm6AznF/czs28t/zW7V+Y3QAAwa/19v8dfmkjonPfh2g+F/tYbnhbSzTWDqAGyyBjYqowL4bruROMTC3bhjzpnOq55rY0cmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DiIpcvR+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250729145339epoutp030daa9e3134ba851349f7f21d72182d52~WwI2p3g6I0455404554epoutp03a
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250729145339epoutp030daa9e3134ba851349f7f21d72182d52~WwI2p3g6I0455404554epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753800819;
	bh=DbirSvKALNxFCk7MtMRlz5k6WwZQ4HzXBOibkG9V7Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiIpcvR+geTJxq1gqUVHpH4FIduQDuL41o69gd+VOnNDGEmDd1WZlhjEHnNYIM3Ve
	 VPpbOfIUsNAekAAQ0vYwKVHS5j61yPZdwvqdBVtu02MLBpSZD+sO7ic9nTj3TjsJD+
	 jFw3KRfF96bXgUcTnYPvL9pvOaWw49NgWe3fzRLA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250729145339epcas5p3eb10268ec8f73c2dda00db80120a0ce0~WwI2K_Lkr2794627946epcas5p3M;
	Tue, 29 Jul 2025 14:53:39 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bryyp0xxJz3hhT4; Tue, 29 Jul
	2025 14:53:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250729145337epcas5p42503c4faf59756ac1f3d23423821f73b~WwI0TWyAt1516915169epcas5p4B;
	Tue, 29 Jul 2025 14:53:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729145335epsmtip2b9d08a757b2bce7bd0db60814af42482~WwIy0AlJQ0270502705epsmtip20;
	Tue, 29 Jul 2025 14:53:35 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 3/5] fs: add a write stream field to the inode
Date: Tue, 29 Jul 2025 20:21:33 +0530
Message-Id: <20250729145135.12463-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729145135.12463-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250729145337epcas5p42503c4faf59756ac1f3d23423821f73b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145337epcas5p42503c4faf59756ac1f3d23423821f73b
References: <20250729145135.12463-1-joshi.k@samsung.com>
	<CGME20250729145337epcas5p42503c4faf59756ac1f3d23423821f73b@epcas5p4.samsung.com>

Prepare for supporting per-inode write streams.
Part of the existing 32-bit hole is used for the new field.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/inode.c         | 1 +
 include/linux/fs.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..bb1a9a043b32 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -250,6 +250,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	atomic_set(&inode->i_writecount, 0);
 	inode->i_size = 0;
 	inode->i_write_hint = WRITE_LIFE_NOT_SET;
+	inode->i_write_stream = 0;
 	inode->i_blocks = 0;
 	inode->i_bytes = 0;
 	inode->i_generation = 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b1d514901bf8..3c41ce0f641c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -725,7 +725,8 @@ struct inode {
 
 	/* Misc */
 	u32			i_state;
-	/* 32-bit hole */
+	u8			i_write_stream;
+	/* 24-bit hole */
 	struct rw_semaphore	i_rwsem;
 
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
-- 
2.25.1


