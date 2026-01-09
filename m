Return-Path: <linux-fsdevel+bounces-72989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78255D06F7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 04:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8496030A9984
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D9254B03;
	Fri,  9 Jan 2026 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eT8p2xLl";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eT8p2xLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036E32BF2F;
	Fri,  9 Jan 2026 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928516; cv=none; b=Tt3BVroy+LK2p6DJW/zVGhz3CccIfu8TJG4EsLoBumAW2CXDfoLV6zAFQBt/+99d332Ub85PSmhwzdohWsAY9ivcLBpyjQANUwTm1jzfV8TDkGwnH6A+pZiTKsxpTyLfYad5Shqpt7+b+oHM1YxNkwAkdXYHoemkb/tcSaEeu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928516; c=relaxed/simple;
	bh=fWamhOFTM/hSqzDRnm3J+ehbkjswxcER7Tq3ufunKaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQIN9M6xeeacQu2kIrzocC6TJ9kjYmthh47/sMEXQ4E98zZdpxH1EX9TLUcQ9BZN34AYwNzSP48G/1QYdMk2B91A0SoJTu5WRIedcDc2N5+c6k/a1LYTN3uQ3SeUUHPZhJUuFDPQ//QAuur4TcLr0L0Z3Opa1ROlA4/t53O1TPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eT8p2xLl; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eT8p2xLl; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y9iG9ndcqnun6d+cB2jUtN8m3ukc7DAvlqzso25aXTA=;
	b=eT8p2xLl1jlYZCmBpyNNlXYMUHlAwZcLB//uGk3tQhpxbm6Jdc205QkIo8hUUYh0t03+Eo1K7
	BaGPyTTn0lrbA/DKSG2lZpLiVU72CCYfqDMAk1wtIYGkzqo0SSLBezY55zK9McrXncSDcBtoTK9
	2j9CfCdYzQwUqvDACKtTqzo=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dnRgv2WKwz1BFq8;
	Fri,  9 Jan 2026 11:14:03 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y9iG9ndcqnun6d+cB2jUtN8m3ukc7DAvlqzso25aXTA=;
	b=eT8p2xLl1jlYZCmBpyNNlXYMUHlAwZcLB//uGk3tQhpxbm6Jdc205QkIo8hUUYh0t03+Eo1K7
	BaGPyTTn0lrbA/DKSG2lZpLiVU72CCYfqDMAk1wtIYGkzqo0SSLBezY55zK9McrXncSDcBtoTK9
	2j9CfCdYzQwUqvDACKtTqzo=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dnRcn2rnNzcb3h;
	Fri,  9 Jan 2026 11:11:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 641DC40569;
	Fri,  9 Jan 2026 11:14:56 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 11:14:55 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v13 10/10] erofs: implement .fadvise for page cache share
Date: Fri, 9 Jan 2026 03:01:40 +0000
Message-ID: <20260109030140.594936-11-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260109030140.594936-1-lihongbo22@huawei.com>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/ishare.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 85b244ba306a..51170792e365 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -145,6 +145,13 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_readonly_mmap(file, vma);
 }
 
+static int erofs_ishare_fadvise(struct file *file, loff_t offset,
+				      loff_t len, int advice)
+{
+	return vfs_fadvise((struct file *)file->private_data,
+			   offset, len, advice);
+}
+
 const struct file_operations erofs_ishare_fops = {
 	.open		= erofs_ishare_file_open,
 	.llseek		= generic_file_llseek,
@@ -153,6 +160,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvise,
 };
 
 struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
-- 
2.22.0


