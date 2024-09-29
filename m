Return-Path: <linux-fsdevel+bounces-30315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03145989559
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817BB1F22BA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81C1779B1;
	Sun, 29 Sep 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHz0NwQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55918E29
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727612994; cv=none; b=gfGUONU3MvaRllIh+Hz2kYGo5wRsi/f8k52+uA1T6Q27CnNK9fHhpecSdL/R6xQBB1XDtlP4OyrpyuHtBp6iMIjyroILk9ORaUMLqOMveumam+cSAl9KMYf78VvOtD0w9T6dpkuvAXHnY/FPgrt9+jXraPusE9RFF+kP7znPlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727612994; c=relaxed/simple;
	bh=fUh47SpTkl6C2h6K30DK2PNQ30kE94fL+R7zUH80g4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hv+QAZfwbZ2sUAIIi1KVO6SuGUTykbjdiH8jCKE9bL6VaI62YFxU6eT80UuvvkFnbDhbRY6I7SOZB8jtuYmHgAdI3Kczd+FV67WXTqx7d+Nupj5LblVwo74pbA4qD1m+KsEmHPjS+vcXTAxh0d8xDwvguYmT9ZhD1atrryserCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHz0NwQi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b01da232aso24933555ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727612992; x=1728217792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/SJ1Z6fGgI+zhFCfvznmUk4IXIl5VUu/wjq+I0D2qo=;
        b=OHz0NwQijcuqtrFzAVlSyLS3FoAmo2K2Eiuqqbnp7pkgrElcGKq3HpwJoYQb8SIsMt
         uxqSpqs479Cm5hXqqRCbxKA7XZbbPP9u3WbmOGTjjhPlxK8BFYwqxmJ3ZWmat4EQJb9F
         FylnFUoXE2EAD9iZrb97FpXJJy59L65xtmAub/CPFugSedHr3kYEVNi7zwzFKkcvxoTC
         f8KL2+Kc7qIuek5PyXieKraRJMU6tfNIJErNHx+b2WPph8y6OES9ziEGuvK6jSDAm7M9
         uQAm+v5/7voxjAza9JKyhOAaZjeTdaNGnEnSxr9kI7xoTjhOJCtsQzvZIlorVXYgQMON
         A2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727612992; x=1728217792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/SJ1Z6fGgI+zhFCfvznmUk4IXIl5VUu/wjq+I0D2qo=;
        b=TbIen+cpdxIMo1Dsp27IhL7sNd2Xg1resKHCuOrBJtQqXCPaN8ql19Dw1aSEwi61lt
         vke5DybZYxMNWh59oeutyGTPjO4L+HlFt7vd7S18F06tXVaxcGjsL9U6ha8jfyELkxXz
         dXgMHfwFajbPcXuqqpjSKhqhW0afJPE9G/E5L0bemOUcs2sXNJy3d/ghxiG5MMtPdh97
         64wBm0xoW6aoq25XgOLI4bNvhHlvW3WhmeuErSOfJ5hRmIywakZCV8KvY2RGSFDR+g5X
         gwOYAZejkst7SKkhu/NkPitECicIy8e0VNxpRXQ5xlLMeCj2E+7OgLWk0h28J+I8WolC
         W1tQ==
X-Gm-Message-State: AOJu0YwnDqa1llr6ja/CQ8dYk+x2fYmR7+aatBRYRqvFquIo5zoTa4n/
	XeV/C1hRAQIbhYPLqLuWuc+pgci7h0wk0efdawpXnijEIIre6HlD
X-Google-Smtp-Source: AGHT+IEwgEk8WbMA6r1UQUnAnUpuqo9TXmIVL2rOuG6LZu1oJuPWZf3kU7zYy9hPIjbrf8V72QUdEQ==
X-Received: by 2002:a17:903:2301:b0:20b:723a:cba1 with SMTP id d9443c01a7336-20b723acf1emr26982265ad.1.1727612992351;
        Sun, 29 Sep 2024 05:29:52 -0700 (PDT)
Received: from localhost.localdomain ([39.144.244.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4e61csm39299705ad.237.2024.09.29.05.29.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2024 05:29:51 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] vfs: Add a sysctl for automated deletion of dentry
Date: Sun, 29 Sep 2024 20:28:31 +0800
Message-Id: <20240929122831.92515-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 681ce8623567 ("vfs: Delete the associated dentry when deleting a
file") introduced an unconditional deletion of the associated dentry when a
file is removed. However, this led to performance regressions in specific
benchmarks, such as ilebench.sum_operations/s [0], prompting a revert in
commit 4a4be1ad3a6e ("Revert "vfs: Delete the associated dentry when
deleting a file"").

This patch seeks to reintroduce the concept conditionally, where the
associated dentry is deleted only when the user explicitly opts for it
during file removal. A new sysctl fs.automated_deletion_of_dentry is
added for this purpose. Its default value is set to 0.

There are practical use cases for this proactive dentry reclamation.
Besides the Elasticsearch use case mentioned in commit 681ce8623567,
additional examples have surfaced in our production environment. For
instance, in video rendering services that continuously generate temporary
files, upload them to persistent storage servers, and then delete them, a
large number of negative dentries—serving no useful purpose—accumulate.
Users in such cases would benefit from proactively reclaiming these
negative dentries.

Link: https://lore.kernel.org/linux-fsdevel/202405291318.4dfbb352-oliver.sang@intel.com [0]
Link: https://lore.kernel.org/all/20240912-programm-umgibt-a1145fa73bb6@brauner/
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>
---
 Documentation/admin-guide/sysctl/fs.rst |  5 +++++
 fs/dcache.c                             | 12 ++++++++++++
 2 files changed, 17 insertions(+)

---
v2: Add doc for this new sysctl

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 47499a1742bd..d8e1db4f2a29 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -38,6 +38,11 @@ requests.  ``aio-max-nr`` allows you to change the maximum value
 ``aio-max-nr`` does not result in the
 pre-allocation or re-sizing of any kernel data structures.
 
+automated_deletion_of_dentry
+----------------------------
+
+Deletes the associated dentry when a file is removed. Set to 1 to enable
+this behavior, and 0 to disable it. By default, this behavior is disabled.
 
 dentry-state
 ------------
diff --git a/fs/dcache.c b/fs/dcache.c
index 0f6b16ba30d0..498b2e261237 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -135,6 +135,7 @@ struct dentry_stat_t {
 static DEFINE_PER_CPU(long, nr_dentry);
 static DEFINE_PER_CPU(long, nr_dentry_unused);
 static DEFINE_PER_CPU(long, nr_dentry_negative);
+static int automated_deletion_of_dentry;
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
 /* Statistics gathering. */
@@ -199,6 +200,15 @@ static struct ctl_table fs_dcache_sysctls[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
 	},
+	{
+		.procname	= "automated_deletion_of_dentry",
+		.data		= &automated_deletion_of_dentry,
+		.maxlen		= sizeof(automated_deletion_of_dentry),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static int __init init_fs_dcache_sysctls(void)
@@ -2401,6 +2411,8 @@ void d_delete(struct dentry * dentry)
 	 * Are we the only user?
 	 */
 	if (dentry->d_lockref.count == 1) {
+		if (automated_deletion_of_dentry)
+			__d_drop(dentry);
 		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
 		dentry_unlink_inode(dentry);
 	} else {
-- 
2.43.5


