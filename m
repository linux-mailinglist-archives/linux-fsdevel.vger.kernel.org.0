Return-Path: <linux-fsdevel+bounces-68724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 834EEC646F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EBBC35939C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE2332EA7;
	Mon, 17 Nov 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ykDEiun6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A04331A5B;
	Mon, 17 Nov 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386643; cv=none; b=pq4rp/Jlg8Iv4qmsWIZvxhGIrzXcMhxgY4tL5uzcITG9AjLqJ9p9xoiVUe+BgJEJbCbBcBSFhLSFkS1ScswbUwRHXz+rRIA4LOeLlD5Dc7h0tgULve04Xex5Ov5bcNmc9ZBpqMkKga7TaII1jDVFwU/OMhycUwFjEMBpUjhJ07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386643; c=relaxed/simple;
	bh=tk/BLR6SGDHZd8PgqWActDpF5QWDgHXfHSMSbURwoo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoFdZLZakQWAlTFRagmA1uUk1T7RTt/Dl5RyPbixGVsM4YQCc9nRuEaICu0SqD8YF5CMFVvSL+ixyxlgQhmyPhirW/aICkyFpLlas13AFkYQhTqAXMiYO0s+26dZkFd96RJCwZPc17+l/isISRUFCuCWGEVfuldg32Rk6Qcvewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ykDEiun6; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=p0umYnge/9FjlLkpy4PvS2wcFW3FASjdMXzdFE5g+6g=;
	b=ykDEiun6uQV0x6mT1Z3+CS6s2um2ALZmoXqzXZGY9B7fYbgrrdPioYXkHBidFDyRjPXiFpoX5
	tfyRDEhEfpPqwNAu49HkEEPW+idu9Q908Jdp9+RqzZdOZ8pM6dvRNpwCDF+rAULgwyGFT/BDItI
	i9tinlXEg7iqM4Ht/Uxq20Y=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d97zq2zltz12Lfd;
	Mon, 17 Nov 2025 21:35:51 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 043B1180471;
	Mon, 17 Nov 2025 21:37:20 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:19 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 10/10] erofs: implement .fadvise for page cache share
Date: Mon, 17 Nov 2025 13:25:37 +0000
Message-ID: <20251117132537.227116-11-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251117132537.227116-1-lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/ishare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index da735d69f21f..d8bff0cdf702 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -230,6 +230,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_readonly_mmap(file, vma);
 }
 
+static int erofs_ishare_fadvise(struct file *file, loff_t offset,
+				      loff_t len, int advice)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+	return vfs_fadvise(realfile, offset, len, advice);
+}
+
 const struct file_operations erofs_ishare_fops = {
 	.open		= erofs_ishare_file_open,
 	.llseek		= generic_file_llseek,
@@ -238,6 +248,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvise,
 };
 
 /*
-- 
2.22.0


