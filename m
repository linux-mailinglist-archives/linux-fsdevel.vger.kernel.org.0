Return-Path: <linux-fsdevel+bounces-33395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B99B88A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177BF1F22705
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE003136338;
	Fri,  1 Nov 2024 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rSsUgbSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4955C29;
	Fri,  1 Nov 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425098; cv=none; b=OeVlPeIXeXS3RDk8exN3wXqL4veZE4zfGW79S7OA0QOMXVX0gxLxH0+4rA10vzyx3GTXnlFvXn0BIDRHdIAi+ewry+UlFEXQOTJTkuvp3l9HT7PWZT/cTfg668iQrcseE6c3vSh/CIkrtUJVv7CFIT2gAwb1JpZjiQx9+/NInO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425098; c=relaxed/simple;
	bh=TtAJ5PGUajaVYZfEUS9/1RvOM+3qd2uGeqpG6FL8DR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtxxPkyTbfA9MW7NRkG6NMr+XiUrZbl+bqmdnhB3mm0FF80OiXAkm3Ty2k+tUpSe1D5FOxbvjDPoW737YIaWCQVxujYZHlmCyZ5hig+LmnoQZNLdEzzFp3FNBYn2ykzw8St6nLMvaKJNXl2qnyOS9cWXt/Jqu/z9y4/ICM9S8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rSsUgbSb; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QXcbpwTTq6N974MuejeNHJ9xQ2vu2gRxnquK0VwfKiM=; b=rSsUgbSbSkaGXZl2Nm0F3ZzIbh
	AsSs1pLZiilNWolJ0Ng/HkCRkTwnkQLW9ZdhOtdOBVFNuPI8HjhXpwBWRgrI5/SaVZat03DoIaYV4
	uQrEZDBZ0N7tKgeKg3dtxC8JLbPmjfg2Fv5wL6LaCfy0TvL/Z6JszwJE7xsdjdsz9MQNEnlet/5iD
	cCuzVvwTvT6Vue9CJF/41cIz5pwqd7+GjifCk09VKnfRQOAorR8yfP8d+cHSnQmgBPutzEkAfJcrS
	IWQIM7j6PEHXGBBBtRCZ1oC7wpbHOqiNnawjK6epVIU1MKto1arXU5WH4jxQijvopmHnkJTscuu/l
	sFLOwJYw==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6gbu-000G0m-VI; Fri, 01 Nov 2024 02:37:59 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/3] tmpfs: Fix type for sysfs' casefold attribute
Date: Thu, 31 Oct 2024 22:37:40 -0300
Message-ID: <20241101013741.295792-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101013741.295792-1-andrealmeid@igalia.com>
References: <20241101013741.295792-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DEVICE_STRING_ATTR_RO should be only used by device drivers since it
relies on `struct device` to use device_show_string() function. Using
this with non device code led to a kCFI violation:

> cat /sys/fs/tmpfs/features/casefold
[   70.558496] CFI failure at kobj_attr_show+0x2c/0x4c (target: device_show_string+0x0/0x38; expected type: 0xc527b809)

Like the other filesystems, fix this by manually declaring the attribute
using kobj_attribute() and writing a proper show() function.

Also, leave macros for anyone that need to expand tmpfs sysfs' with
more attributes (as seen in fs/btrfs/sysfs.c).

Fixes: 5132f08bd332 ("tmpfs: Expose filesystem features via sysfs")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20241031051822.GA2947788@thelio-3990X/
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 mm/shmem.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b86f526a1cb1..6038e1d11987 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5548,13 +5548,38 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
+
+#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
+{									\
+	.attr	= { .name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
+#define TMPFS_ATTR_W(_name, _store)				\
+	static struct kobj_attribute tmpfs_attr_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0200, NULL, _store)
+
+#define TMPFS_ATTR_RW(_name, _show, _store)			\
+	static struct kobj_attribute tmpfs_attr_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
+
+#define TMPFS_ATTR_RO(_name, _show)				\
+	static struct kobj_attribute tmpfs_attr_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0444, _show, NULL)
+
 #if IS_ENABLED(CONFIG_UNICODE)
-static DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
+static ssize_t casefold_show(struct kobject *kobj, struct kobj_attribute *a,
+			char *buf)
+{
+		return sysfs_emit(buf, "supported\n");
+}
+TMPFS_ATTR_RO(casefold, casefold_show);
 #endif
 
 static struct attribute *tmpfs_attributes[] = {
 #if IS_ENABLED(CONFIG_UNICODE)
-	&dev_attr_casefold.attr.attr,
+	&tmpfs_attr_casefold.attr,
 #endif
 	NULL
 };
-- 
2.47.0


