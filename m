Return-Path: <linux-fsdevel+bounces-75336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MV5HgEVdGk32AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:40:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4737BBE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21E593006815
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190C2080C1;
	Sat, 24 Jan 2026 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b2ZyWQEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6C1465B4;
	Sat, 24 Jan 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215224; cv=none; b=rUSZnP/GWvdqpeQ2vJ/jd4ZEMXj40zsL5EWEi8ILtsGcxcVV0+Wm56vYUFlLfOaJiIOmhJYsThss/pfVk3HF6JJ190Vvz1TbmNDyPjvM0Tcvo4e3LUvKDatiCh3gprM6MXJWf+y4UMXssE7dXRvbMXTAP23rfXALZVQLv1vZbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215224; c=relaxed/simple;
	bh=VIIxrbHBSOZTQZmk6RThUD6/XbYBdxSTBSmfqc2iAFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAJLw2ZApL1eQMX0VGJ4By1jkTr7oQSfRimkyeJicYc9ftMqIyhq9v/ltrBm1eNQOXDVaNGM/2U6VpuhNY6PE1aIWoXYYkMzxzhORB7elyGCy/Z5AzwoGsTeSbLHETXN7asJ2dxL3GnZ8ff1ZOw2JzkGU7L5VOJiyhXTiISswN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=b2ZyWQEn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60O0dnvW1194278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 23 Jan 2026 16:39:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60O0dnvW1194278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1769215199;
	bh=3gvBwig0hzF7NIxzN91ZTmQDDoHaKk76XYdPUXtLHtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2ZyWQEnLPMG+1UJZWR/Ow1pjzS/Djnc00LiKj1d8h1eCCB0mvoGq/eMeskUGvKmR
	 i+L0UzZ9MF9M/AEZrKR4khIlkezkbOh6ureJXZPQFdkmFL/S5kyFUZzTsOWjuLPSAM
	 wRhUm7ZLqGy7866RoXPT3inwZaUaIFjm1FADRY/0weXQmO6+dTCgWXqoiS9mKo0DZ2
	 uvPc6pDsaSvbXEOnQnEuwtLYDby2QHhnHSNe5i2lCyubnw5EAaLWKLa9cHaQhR1hUm
	 d0N9/aeQpWIvLiJI93yaJnBeEdhIWwImjbYMJ5App+xp2wtK/YDZhHtXe4q0mu7Wiw
	 tv+TPgIMj/Ayw==
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        systemd-devel@lists.freedesktop.org
Subject: [RFC PATCH 1/3] fs/init: move creating the mount data_page into init_mount()
Date: Fri, 23 Jan 2026 16:39:34 -0800
Message-ID: <20260124003939.426931-2-hpa@zytor.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124003939.426931-1-hpa@zytor.com>
References: <20260124003939.426931-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2025122301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75336-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[zytor.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA4737BBE2
X-Rspamd-Action: no action

path_mount() wants the mount data if not NULL to be a whole
page. Expanding a string onto an allocated page was done in
do_mount_root(); move it instead into init_mount() so other users of
init_mount() can leverage this same code.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 fs/init.c                     | 23 ++++++++++++++++++++---
 include/linux/init_syscalls.h |  3 ++-
 init/do_mounts.c              | 17 ++---------------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index e0f5429c0a49..1253bcc73e26 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -14,16 +14,33 @@
 #include "internal.h"
 
 int __init init_mount(const char *dev_name, const char *dir_name,
-		const char *type_page, unsigned long flags, void *data_page)
+		      const char *type_page, unsigned long flags,
+		      const char *data_str)
 {
+	struct page *data_page = NULL;
+	char *data_buf = NULL;
 	struct path path;
 	int ret;
 
+	/* path_mount() wants a proper page for data */
+	if (data_str && data_str[0]) {
+		data_page = alloc_page(GFP_KERNEL);
+		if (!data_page)
+			return -ENOMEM;
+		data_buf = page_address(data_page);
+		strscpy_pad(data_buf, data_str, PAGE_SIZE);
+	}
+
 	ret = kern_path(dir_name, LOOKUP_FOLLOW, &path);
 	if (ret)
-		return ret;
-	ret = path_mount(dev_name, &path, type_page, flags, data_page);
+		goto out;
+
+	ret = path_mount(dev_name, &path, type_page, flags, data_buf);
 	path_put(&path);
+
+out:
+	if (data_page)
+		put_page(data_page);
 	return ret;
 }
 
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 92045d18cbfc..804d3070ce73 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -1,7 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 int __init init_mount(const char *dev_name, const char *dir_name,
-		const char *type_page, unsigned long flags, void *data_page);
+		      const char *type_page, unsigned long flags,
+		      const char *data_str);
 int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
diff --git a/init/do_mounts.c b/init/do_mounts.c
index defbbf1d55f7..87cf110a48e6 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -147,23 +147,12 @@ static int __init split_fs_names(char *page, size_t size)
 }
 
 static int __init do_mount_root(const char *name, const char *fs,
-				 const int flags, const void *data)
+				 const int flags, const char *data)
 {
 	struct super_block *s;
-	struct page *p = NULL;
-	char *data_page = NULL;
 	int ret;
 
-	if (data) {
-		/* init_mount() requires a full page as fifth argument */
-		p = alloc_page(GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-		data_page = page_address(p);
-		strscpy_pad(data_page, data, PAGE_SIZE);
-	}
-
-	ret = init_mount(name, "/root", fs, flags, data_page);
+	ret = init_mount(name, "/root", fs, flags, data);
 	if (ret)
 		goto out;
 
@@ -177,8 +166,6 @@ static int __init do_mount_root(const char *name, const char *fs,
 	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 
 out:
-	if (p)
-		put_page(p);
 	return ret;
 }
 
-- 
2.52.0


