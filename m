Return-Path: <linux-fsdevel+bounces-33488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D35A9B95BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122FD1F2322F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1D11CC16B;
	Fri,  1 Nov 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="czU4tOPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA033F7;
	Fri,  1 Nov 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479417; cv=none; b=EDF6aik0K8zPmDtbdbMxQJxwPNWFppWwUqWqXzALGxWyZMaR6kjIS0wixWdtqWNtJsg+k/+X7cjpkyn9ZqKqoePQuqUNQHZSshB3k3GsW7W6ecrZyY8+u5I8MSo2pM9WGMTj1jpgmQL8zJxSWHBFnwzlfYtrtRMeioavOcG0fRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479417; c=relaxed/simple;
	bh=PK2v487FHAoC3wGhbaXrY59m3+cfmucKsS9/WZjxzZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSDuw6VJXwO7DKvrCSroniHEgWGBwc12nPvyR4KqSVowDtEOL0GnZesiCeuOUdpmWtzVem5NFc5diqaai+GQQvp5lVBrBV8AcLu7GaTMM3Yv5wOMGvBSZW0MnotcETlsRBItPnqnaoM7fuuBa6wGxSZAL87be/II/wzvxn8WarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=czU4tOPy; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=s2zJ3ZAsAPQ0E9uJzi8hgSgBj9U5Eh/vvFyC13/+d5w=; b=czU4tOPy9JPLZZs+bxemSdZzV5
	/rpbQSDGQENcIJBnYPji0JLIMHGJzmvhFqnTK1JRE6WCUHznLbk8ETVJUw+hCSb9kvFQ+5x80idPV
	bQi67u3Fnc41GYhvnpoKVp5qVUc+kHXfTp3SdwXUTlBqHlcTLvMTtLFbI/LVhZVAyD+CkECEoSKXG
	Hmk7nI9g8d4OhUhZ7/0uR0o1VPaljl8ssXLel3QvOXM1A+rQQ+3LenzA89PdfAl2WOXpK3KzvQwJi
	Icdy2puxLfCgC/mhKhtRDGmsRSaUP1VeNViyZye0EVUWcKR1+X9koKub9NY/exwJyTDK6cX8Gy/gh
	bjhTsZyA==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6uk7-000V2F-1g; Fri, 01 Nov 2024 17:43:23 +0100
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
Subject: [PATCH v2 2/3] tmpfs: Fix type for sysfs' casefold attribute
Date: Fri,  1 Nov 2024 13:42:50 -0300
Message-ID: <20241101164251.327884-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101164251.327884-1-andrealmeid@igalia.com>
References: <20241101164251.327884-1-andrealmeid@igalia.com>
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
more attributes.

Fixes: 5132f08bd332 ("tmpfs: Expose filesystem features via sysfs")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20241031051822.GA2947788@thelio-3990X/
Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
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


