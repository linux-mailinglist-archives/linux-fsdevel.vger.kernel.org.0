Return-Path: <linux-fsdevel+bounces-31634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534AD9992E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069F61F28C5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266E1F471F;
	Thu, 10 Oct 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X6en/DE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4611F131C;
	Thu, 10 Oct 2024 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589302; cv=none; b=WVY+XV3e+wMN3ITPlpFn8WnQG70ae+Pjo9/uz9aMeKAfPQ/BARZvZgLiEJDr2gI1LQ0+E7hOZMJ3w0CXU1YIZ3ce6q1P6EXMPYBUtumf/Hkv5oW0N27Mtg6c0rPG3zHLr1jbmNgZaviUcALlqW5cE8FDqa080KBfyCfEDeVLiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589302; c=relaxed/simple;
	bh=8sTcVklYZK+ygXjhy+vyLT/3hBZVl45qtQchkQV2cY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGSP+avjYeMmO1fD6DRcjWwxw09J4dMPSBQvzidyRJrVmr95QA12yYhh2pwA0FU7vAVDRXKKBIpUJB9xEVa4fmMiSknHEqgseHdrluCmUrHqQN6JfaiBbAStDS67Kx2Wl0HRza5kcUpvgJkz7AvKhvnTk1up00rOj7zTujxTLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X6en/DE+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PVI2yOyAN/UHNCWVPw7UlxKiOm9A/KNT9EdQ/TMvelI=; b=X6en/DE+BvgjfVsX7s/4m3ZAOI
	9JKyGbPjruDT4Cgi76g0Ltw6bLkYySyicttEMYiglcq6d+oj8vdyF3avkASdHGZhNHLDWNDeF2eSf
	s0bVUQP5Wg0LBbAA0Gz4BONeWHHH6AnD1k081SIsMvAqacrP3gG8U+97JuFOZT6jnsqqjPBGyb+9x
	KeVYaDKvz3pHSxPLuvAKB7Q/Z4/LUERI7Dtqwwzs9SlVH5WNOAZ9hqGgnJONGyWaYWPgg4zJdfLTF
	qszQ5+E23RkLLoSeoJP/elIl5zM4LB2ObH+RPG3zd8cuVdkn7vuMaROuHB5FCl+Y/hnY9I8gPJnsc
	m8owllnQ==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz2Y-007SHz-JF; Thu, 10 Oct 2024 21:41:38 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:44 -0300
Subject: [PATCH v6 09/10] tmpfs: Expose filesystem features via sysfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-9-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>
X-Mailer: b4 0.14.2

Expose filesystem features through sysfs, so userspace can query if
tmpfs support casefold.

This follows the same setup as defined by ext4 and f2fs to expose
casefold support to userspace.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 mm/shmem.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1c130a7d58ff3a4f5f920374414f9e7a29347ed9..eb1ea1f3b37cf7a4a11c3d11ad3f70ebb0e48d07 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5543,3 +5543,40 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	return page;
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
+
+#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
+#if IS_ENABLED(CONFIG_UNICODE)
+static DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
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
2.47.0


