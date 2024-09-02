Return-Path: <linux-fsdevel+bounces-28300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF296903E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04071C22E14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2CB192D70;
	Mon,  2 Sep 2024 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="p9Uj+HQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2A19048C;
	Mon,  2 Sep 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317757; cv=none; b=pPmIH5bNWSCZqau2zCgD8VzRYMuwa9u71NUS1xf9SBbOV0rxtYWVSGPlIann+hgFSVSIBZ+PieUwvCg8/GX50dIXY7kA1zxbiUdCDbCEvidLy0vPUtIm13dBGG7SItpJnlBcH94ap5S4fgg/w+OW8dnHqkliu706KyX0o3pubL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317757; c=relaxed/simple;
	bh=CueJSYPu+C5v/XeiXzcOKVhfI+GbCRABjHF8pIgXU68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSejEu593EV1vS8JYoHGEzLrw8bA6Kv3Fba24xmH87TZF/tZI8ygTWu8ue6OEPavetW0YIkLISnc2RAtz1/H6zH5wKix95x6MYs6wKKMlDB3KQ39QC7uPm3cjlwLhMYbNu18fumNztVNlY8A1Qb6iBVVK/+ry8p51UwPUkmh7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=p9Uj+HQO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3R/tp+CDqyBtPlv516oP8Fp25VoAZ0ob6jRSgnVwtV0=; b=p9Uj+HQO7xB0nBgaoWBjepov4N
	hHfY4s4Au6B3vEil6NOrGBzm5GroC1P0mp5WyxlUIc372IGKu7pI0vyl/sC7ES4VZnj4YxPwFtB2t
	KxF1C7a7cgdwihU4cE3z4dUwucE1+ci/hnTZEd4SBpjHVHmd87vT9sNYe6eBQ0/eB/Myqxsvi3zfH
	/xHeHyMcNs3ZOPh1MLSYgq0s3NxfGLun+OoFVvpzLD0iwGiefDz85zXF1Ay7zRSfW8GnkXO81R6ol
	1RMf1Q/2mm8NWh/ACClOonMPxgS33SKmuNuqkWtMz87RuBxl+UcdzK4tv99AFJl7Ivb+ccefu8ytu
	A0axMLqQ==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxc-008VrL-6R; Tue, 03 Sep 2024 00:55:48 +0200
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 7/8] tmpfs: Expose filesystem features via sysfs
Date: Mon,  2 Sep 2024 19:55:09 -0300
Message-ID: <20240902225511.757831-8-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902225511.757831-1-andrealmeid@igalia.com>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
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
index 9a0fc7636629..fdaae7543d1a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5365,3 +5365,40 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
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


