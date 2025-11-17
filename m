Return-Path: <linux-fsdevel+bounces-68723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6ACC64639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3CFC02411E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AF331A70;
	Mon, 17 Nov 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WvVM8WAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE733030F;
	Mon, 17 Nov 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386643; cv=none; b=eF8mIver6D1DVOFs9s8RHWCUgY2olrnjY8uLAcM1R9BqgHC2jsOVBwtR6L8+3JebW6E9KuyhtuhOROOmlPYelUAHNknNesHYe0N6DvfpAufeZVlccdnqtaBYZqR3lqEPvmHwePeTk0Z0W30RqHMdVLaYhiyvCeAC5kOj9JQYHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386643; c=relaxed/simple;
	bh=0A9Wkrt8+ZhaJnsnwTcszWsChlrIImuGRWWh7hulGP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqkMrv0Rc7xwpDUzzxQPNuMP5MKobl+kC0SShgJ1lt2LFXJ/dV8eT5zj3rRWcj31oD3/MQ7T1HT7522U5AG9lYZHnyOz7JoEJ8pQcqWbYNK7/IWDU3Ev5nYojKrpdjIaQ24kb8SbPubfYE66i7HApnxsPxfgXzoxE7U4T4Pk+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WvVM8WAY; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FbVkas6xVh0EDYbcJEaJK0b7cxUQjdGPdQbtHmbK7b4=;
	b=WvVM8WAYbcCPfvxIdH80g3SFtK4G6jWtv6xeMl0W4ZnksajU36D/yxNVcxFylE5k57bFBZGP2
	NoNThwtMbhT9AzGRahB3aI+S7QK7cpok4MncykLqMEnp2g0W3wRbb2dnzefbv4XFS9w4z6cuUxa
	nw57G2pty4rDrYfsgXLVf8k=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d97zm3GCnznTW3;
	Mon, 17 Nov 2025 21:35:48 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EEC4D140276;
	Mon, 17 Nov 2025 21:37:16 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:16 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 03/10] fs: Export alloc_empty_backing_file
Date: Mon, 17 Nov 2025 13:25:30 +0000
Message-ID: <20251117132537.227116-4-lihongbo22@huawei.com>
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

There is no need to open nonexistent real files if backing files
couldn't be backed by real files (e.g., EROFS page cache sharing
doesn't need typical real files to open again).

Therefore, we export the alloc_empty_backing_file() helper, allowing
filesystems to dynamically set the backing file without real file
open. This is particularly useful for obtaining the correct @path
and @inode when calling file_user_path() and file_user_inode().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/file_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index b223d873e48b..7508f69a1839 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -308,6 +308,7 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
 	return &ff->file;
 }
+EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
 
 /**
  * file_init_path - initialize a 'struct file' based on path
-- 
2.22.0


