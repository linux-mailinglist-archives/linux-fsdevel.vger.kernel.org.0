Return-Path: <linux-fsdevel+bounces-68914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CBC68339
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AC154F0E57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52D030F54A;
	Tue, 18 Nov 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mrCISs1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53278309EEB;
	Tue, 18 Nov 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454407; cv=none; b=UdT5WIwyfpkoRdE4ikOXcb8EUX9y/b9Zv9Sv8z/hA0EVXrKlsIeTF+HMwZoNoJpqVkYODijlabswTW3uSzPh/rVjVwBVz5L3hipc6qRUnGdA62YbXLmgFUyEFcJfNyUJffwARfuZ01J0PNineH8ksPdvJufQs+5Sxgp45BIMgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454407; c=relaxed/simple;
	bh=cTR2HfbxWKCzKckLSvc1kTIfiBdM++AQ4VcXTDmra74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSLVmpJvOZdsHJU8vbrU5ADqjIOSWWkhqZUgJKI/o5ANazPtSZGBOvmLB2Xk61aRWbtokNMut0jsrVeZE3HdHUUqT91niakjBAgXVKbVdi5sPzA4k8+wlTYQ/rWWH6t5LRZPl7gAzefHExSFxU6V0xn2A1/nvfS5gCC8zmO+GzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mrCISs1m; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Uv
	/YobMX5Vm4b7+G2HN+8lcF5mEX1FDlwqmc0s4H2ig=; b=mrCISs1mOW0g2yn7nG
	W1coujKxtfBSwOpk/YPeW9h1o8HslkQB5koGHKYIbip6IItPmAwR9OkvgWIYV38A
	Qt4+dmfTcYPwu7iEQ9ejdGXmI4cH39PU9SHcrwtUt6YQHWiR4d40Hg3s2AKNyM9d
	337uAKEpBBElaXuvoAHhOrK/o=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S7;
	Tue, 18 Nov 2025 16:25:46 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 5/7] exfat: improve exfat_find_last_cluster
Date: Tue, 18 Nov 2025 16:22:06 +0800
Message-ID: <20251118082208.1034186-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118082208.1034186-1-chizhiling@163.com>
References: <20251118082208.1034186-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UAryfCr15ZFy8Cw1xKrg_yoWkZFc_uw
	18KrykWryYyr1Syr1DC3yayFWSya1DZ3y8urW7tr9Fq3s8J397ZF4DXF9rurWjkrs7AF95
	Jr95Ar93Ga48ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb9mR5UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFB8KnWkcJbfcyQAAsu

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get support cache buffer head, let's apply it to
exfat_find_last_cluster.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 08f9a817af28..d980d17176c2 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -298,6 +298,7 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		unsigned int *ret_clu)
 {
+	struct buffer_head *bh = NULL;
 	unsigned int clu, next;
 	unsigned int count = 0;
 
@@ -310,10 +311,11 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 	do {
 		count++;
 		clu = next;
-		if (exfat_ent_get(sb, clu, &next, NULL))
+		if (exfat_ent_get(sb, clu, &next, &bh))
 			return -EIO;
 	} while (next != EXFAT_EOF_CLUSTER && count <= p_chain->size);
 
+	brelse(bh);
 	if (p_chain->size != count) {
 		exfat_fs_error(sb,
 			"bogus directory size (clus : ondisk(%d) != counted(%d))",
-- 
2.43.0


