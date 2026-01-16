Return-Path: <linux-fsdevel+bounces-74090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2620D2F548
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54C2311236F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDA6361658;
	Fri, 16 Jan 2026 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aViTVgKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E0235FF55;
	Fri, 16 Jan 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558129; cv=none; b=fLdNvjLNFjhHitQ0uWpGbPhxirIQsmT0RVYq1Ej4RXvxLFgSEghLp1huWffbXFJa1CTd189DOunzsn4F/A6YMuMokvaXZMYFS6laQFbw2XRPcISrYUSKxnmzLSve0a9TWeXv+W0+QvTnGn0RVmAStSHyqU6eFnWvOr/Stt3u5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558129; c=relaxed/simple;
	bh=/DOP628ou57Yld7gMP4kYmxmunqIn78QOq3XPXhRUAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2UwF8O6ijYynBF4qJuxhbgz0xZgtNy72M6Ub952LhCzHMPXYXtv8anrBHjyq7ARQ0KsnM3m6syyyxWurLvotF1gFLJ6FPL9FPymq6qe2YtlxYYwF5a9AJszQdqIUW/CNh9ZdXqhm6bp5ZRI310rTUFEUUaFFIJFRrKt/+jE6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aViTVgKb; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IJqOVDMyH2cU6HZaQ6KGaq7L7r7sGB/NU+oSMo68sYk=;
	b=aViTVgKbU3p9F6fvfb/DRZ9GIhljQ3rKlHQMPA1II5YccTLm1l79Wl8RBcmkkhYNwMzHKxXz0
	9YV1Y0ow6kq2fONT0jz7uycW8blnvYaMxZYGGACdFOLs9cXkvJ3tWcEIwXSiiP4I/798eIXtO+j
	kCdEQvGGYPkM65v8oi6/oqU=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dswTC5Tc3z1cyq4;
	Fri, 16 Jan 2026 18:05:19 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 1137740539;
	Fri, 16 Jan 2026 18:08:40 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Jan
 2026 18:08:39 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v15 1/9] fs: Export alloc_empty_backing_file
Date: Fri, 16 Jan 2026 09:55:42 +0000
Message-ID: <20260116095550.627082-2-lihongbo22@huawei.com>
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

There is no need to open nonexistent real files if backing files
couldn't be backed by real files (e.g., EROFS page cache sharing
doesn't need typical real files to open again).

Therefore, we export the alloc_empty_backing_file() helper, allowing
filesystems to dynamically set the backing file without real file
open. This is particularly useful for obtaining the correct @path
and @inode when calling file_user_path() and file_user_inode().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index cd4a3db4659a..476edfe7d8f5 100644
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


