Return-Path: <linux-fsdevel+bounces-26464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D7959A88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7E8281F89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC691B5EBF;
	Wed, 21 Aug 2024 11:24:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E23165EEB;
	Wed, 21 Aug 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239494; cv=none; b=EL4tuxGiaNHpeb15Neb+5MTjd/alaia9ZuqUV+dkkftJ5CYKEcxPqfT1lqYmLUcdl78Bi+Yh36St1Jyf/hLXwAqhHwwS2xt2nzUuOTPbA3fKsv6ysCaZqTv1llJocV0fyihIb8u2EqMTiO6BAa7NWfPAncxXtBVpEb/SzVm26LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239494; c=relaxed/simple;
	bh=0Oa6GA6RXoiqPHaf6R9MMDIqIwy5sj0l1kCiHUBrnIg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXKgFG5Gu5t1ZCQPbsL7YOpVzQDowFwLHYL8UP+7wI91xBenkT5FjstYIir+hbStXM05WsvBv/fZ6B0wYvKjh2VDpcvENElrNdVxU9bORnu1m8SeJjq/QaqvZAiX+zhtyZrc4tyDMU9jyijD8Sl/gdh76IQiiiYfXqGEWTarIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47LBN62v099503;
	Wed, 21 Aug 2024 19:23:06 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WpkL80Wdzz2K6x7r;
	Wed, 21 Aug 2024 19:16:32 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 21 Aug 2024 19:23:04 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Theodore Ts'o"
	<tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH 1/1] fs: ext4: Don't use CMA for buffer_head
Date: Wed, 21 Aug 2024 19:22:54 +0800
Message-ID: <20240821112254.624814-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 47LBN62v099503

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

cma_alloc() keep failed in our system which thanks to a jh->bh->b_page
can not be migrated out of CMA area as the jh has one cp_transaction
pending on it. We solve this by launching jbd2_log_do_checkpoint forcefully
somewhere. Since journal is common mechanism to all JFSs and
cp_transaction has a little fewer opportunity to be launched, this patch
would like to have buffer_head of ext4 not use CMA pages.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..4422246851fe 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -869,7 +869,11 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (nowait)
 		return sb_find_get_block(inode->i_sb, map.m_pblk);
 
+#ifndef CONFIG_CMA
 	bh = sb_getblk(inode->i_sb, map.m_pblk);
+#else
+	bh = sb_getblk_gfp(inode->i_sb, map.m_pblk, 0);
+#endif
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
-- 
2.25.1


