Return-Path: <linux-fsdevel+bounces-70541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3682C9E05A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 08:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27D43A248D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312429AAFD;
	Wed,  3 Dec 2025 07:08:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50478280018;
	Wed,  3 Dec 2025 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745719; cv=none; b=K5kXVyjXU2RMe2wW3LhC5AjLF7qA/+f/R9AJzt3phqJbm1XJuN4gV4SosLo37VJLa/VryPppk7AuXwUJmG2zG0azpqX8Zwc9sw66ffPCDVrolTOwVNeU9nZIpWO4z4sgIMPULi3KnpNpH9xnE6oir9HCJ5kCdhut+TvA+zIFQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745719; c=relaxed/simple;
	bh=kS7PLRaGvhWYYFenhSb7EHUzpStqNfldbLpS48rcnNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kl76rhc7ZlFnN4Xy248BIjSOfI4Q63c0YYWet3pvG6DQB+eRSyEY17JSE0K3pbw4EFtbMCJWNcttPRLt62wlobM0DgriZf3FIauVmM4UaJw+U567l5WCLTxs6onzPFh1ft5uwMp3LWN4Bl+DoXq2POWLGO8ahZXuq1ulMBykpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowACXJ9rn4S9pfdECAw--.1851S2;
	Wed, 03 Dec 2025 15:08:25 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] fs: exfat: Fix corrupted error code handling in exfat_find_empty_entry()
Date: Wed,  3 Dec 2025 15:08:13 +0800
Message-ID: <20251203070813.1448-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXJ9rn4S9pfdECAw--.1851S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4DXr45AF1kuFWxGw43GFg_yoWDArg_CF
	40qr1Uury2vF4fZrsrGw4akFZa9a1rWr47XF4Utrnruas8Jr4fJF1DXrn8A3Wjkr4fGFn8
	u34vyrWfKa4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUUZXo5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYFA2kvyOxNzgABss

exfat_find_empty_entry() stores the return value of
exfat_alloc_cluster() in an unsigned int. When
exfat_alloc_cluster() returns a negative errno, it is
converted to a large positive value, which corrupts
error propagation to the caller.

Change the type of ret to int so that negative errno
values are preserved.

Fixes: 5f2aa075070c ("exfat: add inode operations")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 fs/exfat/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index f5f1c4e8a29f..f2a87ecd79f9 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -304,8 +304,8 @@ static int exfat_find_empty_entry(struct inode *inode,
 		struct exfat_chain *p_dir, int num_entries,
 		struct exfat_entry_set_cache *es)
 {
-	int dentry;
-	unsigned int ret, last_clu;
+	int dentry, ret;
+	unsigned int last_clu;
 	loff_t size = 0;
 	struct exfat_chain clu;
 	struct super_block *sb = inode->i_sb;
-- 
2.50.1.windows.1


