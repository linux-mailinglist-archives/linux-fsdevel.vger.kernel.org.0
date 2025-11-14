Return-Path: <linux-fsdevel+bounces-68457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFDC5C83A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C44CF4F88C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF4312829;
	Fri, 14 Nov 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WVWfC3KE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC63112D3;
	Fri, 14 Nov 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114828; cv=none; b=FEKD3MmanVGQaO5sNzDd3emzZ/Fr2B/5+Jelu2/ybrQpxisjRtSYjFDBWVZTTw2mC2nJIt2vRoKaRxF3TJc0rMJ4URSQnyoOgFBeHZ7Qqk9OIFpxmjDYuOv3xx6umNV6n2NMEZCnfP/2KjwYrixUwKydxBEy7OTR9fpcJGPRx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114828; c=relaxed/simple;
	bh=PUhMmJO3qrxkT0LDtv6TTprBoAA6+lK6CQ814PKAuP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATgYSioRx865ianoCGVC0FNUXyIaclZYjguzxRIu2WX7aS4R3mStrSQ2Y5nxNzOWsRswkdLV2Y22oTfzwF99C/S/XR4/qrOKmCzUtKEke05r5tIOwbAlvhGnlTvxUJcm48GRs1D8BUBBbMHe/USzjO2xu6Pbq/eiLx6VSLlaMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WVWfC3KE; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BCMyMCc7n0nJXxkfnxnWAQQyWIQKmftwqT0fy6ncGbk=;
	b=WVWfC3KEX4PuA9XOjVyZAaI2g+IXsviDtdLkgbyYyZI6oOob1B41G98KeAM5E95fvEhkAsT4x
	Rg+tJUH32VmAMkhqU9bjTFCa/DrJkkt5Dtc2ARBRvGOzoZgR+Thxv50rDCNXSjftWMLzYrnauEN
	TyT33ug2g5rwWACxr56kQpQ=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d7CSY0WNLz1T4g8;
	Fri, 14 Nov 2025 18:05:33 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BE6318048B;
	Fri, 14 Nov 2025 18:06:59 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:58 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 9/9] erofs: implement .fadvise for page cache share
Date: Fri, 14 Nov 2025 09:55:16 +0000
Message-ID: <20251114095516.207555-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/ishare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 14b2690055c5..88c4af3f8993 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -239,6 +239,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_readonly_mmap(file, vma);
 }
 
+static int erofs_ishare_fadvice(struct file *file, loff_t offset,
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
@@ -247,6 +257,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvice,
 };
 
 void erofs_read_begin(struct erofs_read_ctx *rdctx)
-- 
2.22.0


