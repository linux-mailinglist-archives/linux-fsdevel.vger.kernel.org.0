Return-Path: <linux-fsdevel+bounces-72277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E657CEBA52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D855303C22C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1713164AA;
	Wed, 31 Dec 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aViTVgKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4A311C39;
	Wed, 31 Dec 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172444; cv=none; b=B1ZXqWPNq1k/6YTwB/oV/WssWVSawpT/c6HWxlBWI6j4A5QYhit1iSm3KBotVL+7Ahlm4H8Tn14KlYyJ6mn+EEC/OhnPF03L4pVebPsRb3iM1HoxtbOCJfB9Ny1uruWK3SDJAyUrlgCzyPk2mFUPMrmVSAhy8+AJ8DgQVK/ayWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172444; c=relaxed/simple;
	bh=/DOP628ou57Yld7gMP4kYmxmunqIn78QOq3XPXhRUAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsBaF6TbuaTzbkTVjTwlYbeB8RYZgmg6hHRFvzLD+fWPobjB4R5anUMgHMZOHMiFPdb4jOkj48RrdiMgOQfOlqSIlgkUxO0bpldCzs6IpnHAIhV5HZ7bRTuYCLcKG5sXGRIKtTRx/Rmst81L3UqEm5zzlo8ODZoJpcB95BsYXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aViTVgKb; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IJqOVDMyH2cU6HZaQ6KGaq7L7r7sGB/NU+oSMo68sYk=;
	b=aViTVgKbU3p9F6fvfb/DRZ9GIhljQ3rKlHQMPA1II5YccTLm1l79Wl8RBcmkkhYNwMzHKxXz0
	9YV1Y0ow6kq2fONT0jz7uycW8blnvYaMxZYGGACdFOLs9cXkvJ3tWcEIwXSiiP4I/798eIXtO+j
	kCdEQvGGYPkM65v8oi6/oqU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dh41k4dcTzpStp;
	Wed, 31 Dec 2025 17:10:50 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A3484056B;
	Wed, 31 Dec 2025 17:13:59 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:13:58 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 03/10] fs: Export alloc_empty_backing_file
Date: Wed, 31 Dec 2025 09:01:11 +0000
Message-ID: <20251231090118.541061-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251231090118.541061-1-lihongbo22@huawei.com>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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


