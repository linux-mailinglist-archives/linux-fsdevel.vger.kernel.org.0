Return-Path: <linux-fsdevel+bounces-74095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA7D2F4EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E7D9308036E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17535FF7D;
	Fri, 16 Jan 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ET4nQgDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FE35FF52;
	Fri, 16 Jan 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558143; cv=none; b=VHb0K6jDUAe+xLEPZs4/0j9yOoWXbC5wQC0ltq5gDkyoFo4L/pkqyzRNfZHXRS5+Mmidx4BeuoihVE4JwldTakQAEayiIIbPJI5Hqni/1x6qeSw2C9rD3Mx7Hn16RaL0cTGV/nArqstWTuF7aTtyRt2oJJy4qLTnHTcXGvoRS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558143; c=relaxed/simple;
	bh=pXnDClVRTnHHgum20VgnGGA8xY6ykQ05HoqhepeDEv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0VCyK42kLAmU67C1Gf0LPe8x4URBOaSboIddszRBdJqyd5WSjskzjlM7xPY65Ehth+rXNMtVEEToDDAAjn7wj2rDX9skxGmR4o9sT0Xn+PtL6k1oib0Wa6v0BAF6+NrUXmvbDDzG/DdjLCMg2N/ZNbWzkmV2Xk4OFQRttnkFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ET4nQgDE; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XzmAs2VpZLSxoIrsGbEfPR013qwffyPmOWZWIOJmd7w=;
	b=ET4nQgDEN5fYb3hoQ8vIAzZBtp6wiXUMv1NRArCFLuT2+7LbB0ZtiaUJbe4KeP8OBrpaOTNYo
	IOgLN5fMC0HizzauOwIRsnpx/LjDgNUINCiH08vX29OH1T+GnUoIzDWysuevgBd0crGEm8GAn+k
	KCC9YTjfCMoJWlJMien4q0A=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dswTF1c2Cz1prKt;
	Fri, 16 Jan 2026 18:05:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EEEB240538;
	Fri, 16 Jan 2026 18:08:43 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Jan
 2026 18:08:43 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v15 9/9] erofs: implement .fadvise for page cache share
Date: Fri, 16 Jan 2026 09:55:50 +0000
Message-ID: <20260116095550.627082-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260116095550.627082-1-lihongbo22@huawei.com>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
index 96679286da95..78242f9d8dde 100644
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


