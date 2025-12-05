Return-Path: <linux-fsdevel+bounces-70749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2F4CA5E17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E225D30C24E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166DB2F2916;
	Fri,  5 Dec 2025 01:59:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED912E7624;
	Fri,  5 Dec 2025 01:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899975; cv=none; b=lteohwj7Vy3y1NQxMMD0Akg/wcrQZp0l/bUN78oCgNVK0rbTvhKMNJh4BaMM/5/bal/lMBmrRFin1ZwwnnLeLTU4ux55p2aW2Xoire2bggE6qp8twemgvcKbEr2IP8kdhM1rX26HsWf1/UgXWyd+p56wOCL/Y0QWceO+0DUI33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899975; c=relaxed/simple;
	bh=igXnTLTOSQsUl9e1Qa0eSB8nTOZYBJx3dheVeC6HltY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaIrl4A5jhRX9Ah9+sXwig8uvwtPob7P03XXzfG7HzVebH2SOR3XF9F6lOYr2nZCB4boqzjkvPdifHGO+9CezXwkEQXhDAQs1xWq76oriA6ObN9jJQ89xfF/jwlNFPY/khKwU3sV9Y3C9nMoEqB6hhqGafg5x8FYlvkJPJCutlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAD3i8t5PDJpV14eAw--.241S2;
	Fri, 05 Dec 2025 09:59:23 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] fs: exfat: improve error code handling in exfat_find_empty_entry()
Date: Fri,  5 Dec 2025 09:59:04 +0800
Message-ID: <20251205015904.1186-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20251203070813.1448-1-vulab@iscas.ac.cn>
References: <20251203070813.1448-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3i8t5PDJpV14eAw--.241S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF45AFW8CFW8JF1DCFyxuFg_yoWDArgEkr
	40qr1UWrW2vr1fArsrCr4ayF9I9a1rZw1UWFy3tFnrXF98trZ3XFyDXryDZF10kr1fAF1D
	ur1kZr1fKa4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8GA2kxoxnAEwACsw

Change the type of 'ret' from unsigned int to int in
exfat_find_empty_entry(). Although the implicit type conversion
(int -> unsigned int -> int) does not cause actual bugs in
practice, using int directly is more appropriate for storing
error codes returned by exfat_alloc_cluster().

This improves code clarity and consistency with standard error
handling practices.

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


