Return-Path: <linux-fsdevel+bounces-50145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90429AC8850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93C61BA0C38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB01B2116FE;
	Fri, 30 May 2025 06:41:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A501F875C;
	Fri, 30 May 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587295; cv=none; b=eKGFB2qr1eiVFF5tVaT0s0x4lYD7WJk17iYA6RwpUdvPgq6eCuTVZvmcVKT+5GMbMjrv2GYQhcVP1Jwex+7Ebti9IhD3GCIYl5mEmCiZG1i2NLWvKY1vhRkGWMwag+RhQeNATrQdWOUgBWUtFV3fPhR9RtM/SiLtb8sg0BKAn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587295; c=relaxed/simple;
	bh=AzkiQ828DV4XLZ6VyD5QO+z/Z/+95N+AS5+m2bCmBYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhHFhzrOk1KqWfc2QL9dv79YmvB6us0RWL87NPwNb+mMLb5ajB8Etla9N1n8AgHUnwW1J/QgLHVmiOj2AFEAXY4LGYWwIm/oqd7zGLwl2hnuHu2sJrqFm3oCAUph58qBiw8Jg2r/+ip8dZkJ4Rjh//oPgdjs62TXNqEaZ4lhEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7tth2QSYzYQtH1;
	Fri, 30 May 2025 14:41:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6C6C31A0F9D;
	Fri, 30 May 2025 14:41:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8PUzlo_wXRNw--.6893S8;
	Fri, 30 May 2025 14:41:31 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 4/5] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
Date: Fri, 30 May 2025 14:28:57 +0800
Message-ID: <20250530062858.458039-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8PUzlo_wXRNw--.6893S8
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7Zw48GFykGrWDtFW5Wrg_yoW8Xryrp3
	Z3CFy8G3yrWw4v9a18Ww42qr18Ka1kGF4UuFWfJw15XF9xZryxKrsFq34fAa4rtFWft34q
	qF4Yyry5C3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The calculation of journal credits in ext4_meta_trans_blocks() should
include pextents, as each extent separately may be allocated from a
different group and thus need to update different bitmap and group
descriptor block.

Fixes: 0e32d8617012 ("ext4: correct the journal credits calculations of allocating blocks")
Reported-by:: Jan Kara <jack@suse.cz>
Closes: https://lore.kernel.org/linux-ext4/nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1818a2a7ba8f..e7de2fafc941 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6184,7 +6184,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 	int ret;
 
 	/*
-	 * How many index and lead blocks need to touch to map @lblocks
+	 * How many index and leaf blocks need to touch to map @lblocks
 	 * logical blocks to @pextents physical extents?
 	 */
 	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
@@ -6193,7 +6193,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 	 * Now let's see how many group bitmaps and group descriptors need
 	 * to account
 	 */
-	groups = idxblocks;
+	groups = idxblocks + pextents;
 	gdpblocks = groups;
 	if (groups > ngroups)
 		groups = ngroups;
-- 
2.46.1


