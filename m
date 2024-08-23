Return-Path: <linux-fsdevel+bounces-26954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026E95D46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFC289A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF7194A65;
	Fri, 23 Aug 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ma3Xhzs3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67E194A49;
	Fri, 23 Aug 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434443; cv=none; b=FpwSBpnj9LqViBhRTmNA63fiZIePipT6Sx9u9EmOl3OcSFAXjzr5HBRerZl4XdoL7B4lqgzAx2+BEc/bQfj3owQfWxkiB61kchAqwlq5TjS1xGlzklAWG4L3EmuGwwVoQ46gtV5tgpm2nEPOdzTpJCe/cM4yWrJJUwBF9Mu8vIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434443; c=relaxed/simple;
	bh=GuM/my+ueJwwiTYUV31nvUyJgTzMIZtZX3DKI/64XoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYtN+3bKqlMIs91L8KKPXVk6QQdgknLGOIHnyTXtEOcys+xKjk+qp9wZWwo7JcrFVQc04hKzRcpBxZhbayOhuSSPbWpfVraMEyG+D0zSTltzJfgr3G6YCf/oRFCS8d386EkGjv8tEPzWvLK76y106hDM0x3Wm82lA7NMem8vJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ma3Xhzs3; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zap4iol6rqGSjG5PpDRAFuTwCuOL01NSJqIIbGm2kbw=; b=ma3Xhzs3EwKomj3mpglFRwcABm
	abpsMnv+HGliRBrfAeREW4zYsafdnHo80mfj+l0CnjSX0kFp/aBnkN8w8WfuU/be7Rfj4RXbN4UiT
	gIBa9vYSVbaAHcRm60M3BeSNazFmJtScWkAV4emfUMWDIocYFhxQ0Yo32MR1/xvsGg4q77vk2kFaT
	wuVBFl4Z0Vy6wWRk8cgnfivmp3BEQHW/cDf2xwKHWFmhIosfhPZpDDxzEvOs/cD0QMWf+v2VB9+kg
	rq2TOD5vgs/K6zW7MmrTryws+94SffwMgyL21J5JMcLrd+rBnEPavyd0LNxej8vw5mE/rYY00xTKx
	fMbvGxGw==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shYAa-0048Ww-Pr; Fri, 23 Aug 2024 19:33:52 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 4/5] tmpfs: Expose filesystem features via sysfs
Date: Fri, 23 Aug 2024 14:33:31 -0300
Message-ID: <20240823173332.281211-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823173332.281211-1-andrealmeid@igalia.com>
References: <20240823173332.281211-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Expose filesystem features through sysfs, so userspace can query if
tmpfs support casefold.

This follows the same setup as defined by ext4 and f2fs to expose
casefold support to userspace.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 mm/shmem.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5c77b4e73204..f6e19b88d647 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5384,3 +5384,40 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	return page;
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
+
+#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
+#if IS_ENABLED(CONFIG_UNICODE)
+DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
+#endif
+
+static struct attribute *tmpfs_attributes[] = {
+#if IS_ENABLED(CONFIG_UNICODE)
+	&dev_attr_casefold.attr.attr,
+#endif
+	NULL
+};
+
+static const struct attribute_group tmpfs_attribute_group = {
+	.attrs = tmpfs_attributes,
+	.name = "features"
+};
+
+static struct kobject *tmpfs_kobj;
+
+static int __init tmpfs_sysfs_init(void)
+{
+	int ret;
+
+	tmpfs_kobj = kobject_create_and_add("tmpfs", fs_kobj);
+	if (!tmpfs_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(tmpfs_kobj, &tmpfs_attribute_group);
+	if (ret)
+		kobject_put(tmpfs_kobj);
+
+	return ret;
+}
+
+fs_initcall(tmpfs_sysfs_init);
+#endif /* CONFIG_SYSFS && CONFIG_TMPFS */
-- 
2.46.0


