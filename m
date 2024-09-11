Return-Path: <linux-fsdevel+bounces-29108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF7975646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9049B2EA89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE131B150F;
	Wed, 11 Sep 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ViLjtovm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FD1B150C;
	Wed, 11 Sep 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065959; cv=none; b=eO1iJaBGN5qXjmFeb/UPlTz7D7Aax1tIsZph5Hq+HDjYjwiXWsKRC/8w0s15aw99uhTFImX/HxwcvvdWCB5xWuoI2mSBjRmTnUC3bHp76dL34DFehvOKU5zgU5q5wtz5a98zt1xwzlDsNilU8YcTXUIV2gdyYLajepAQKdjMaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065959; c=relaxed/simple;
	bh=bT2/q19cnNS7Q7W80DiDSRZZ6L7hZi9AEaHQUixUSXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+6roLYGhb625BqoZJW0VQ6GQDeem4lvZ6ltTwz7+kL9XTaQCj9kpFqC5FZYe7z5eq7E2bojSbqiaRXGLICUgUZPlgNZeCwusJrfRaXQ1cN351IjzOjQZNm4q+eT0KU+UfhwDpXrzzUqkftijvI40UXrf/GqUEDOZbqBEPnH8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ViLjtovm; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pK8srYuw9wrv3ZwJYkO0PSANkqjQtOsAR4zsFhEgnYA=; b=ViLjtovm9+jx46z9NAxTCgvkry
	83+J+2uzaaR+6xtpgGNpGwxlNqYrbscclmySVeWUNc4M5x0NRA9qyA3DeINjEBW6m0KO3tqeFh1i9
	WVU+dRvo8ovMdPLU+s07ZLsiMEvkNgpR2DVKPAwbjco4llsIwnDSbT+IAW7LNf7sn/JRDex/60WoS
	t9QbIB8RcRheSXc21NUKmn5X2NUGj2746kiav+LMMSeb5OWIpr5kXyTG9rnVDMOTMC9VnwYgdExG+
	GNBUguE2FMSA4DwzRxkh0QSnSeH36bJdhW6Y0TkedAwpFRhEQymVXoLOoRVglEoMMJnJjyC4EeR8n
	NBePUPYA==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soObN-00CTwi-Jj; Wed, 11 Sep 2024 16:45:50 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 09/10] tmpfs: Expose filesystem features via sysfs
Date: Wed, 11 Sep 2024 11:45:01 -0300
Message-ID: <20240911144502.115260-10-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911144502.115260-1-andrealmeid@igalia.com>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
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
index fc0e0cd46146..7e7e2461a314 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5401,3 +5401,40 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
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
2.46.0


