Return-Path: <linux-fsdevel+bounces-66972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC1C323CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 18:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34A5F4EC4CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA63331A7C;
	Tue,  4 Nov 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apBg6Y3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DD337B8E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275897; cv=none; b=jg5Aw12sW3gU7mIpJwb+pV6mQ8q3D4kss3Wh3UwdNIGQW7gUVvy/0AHdcF6L+acO5J9KN+bZZTiMQ7nR2E4PwqzrtoXAYReR0tAi54F6v6AH3MlTEwnkQ1wnZDJ8EOwrPzhqISjoelX3R4Vz6Bove5yb9pMENt8hWdI3NtcRd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275897; c=relaxed/simple;
	bh=fhIUlrOyPq3n7/GWnWAZGGSii/QB4Z9azjCnjk20+Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwdJZy8JfHCDO8ZvGiMGhonDDHiVoh/jzqX3VGU/ugHVDCw2WuiNHPJnqORPsormc3McjuVSpa9/6GjYlq7Oxrxs8ZuRfdBalz51imUWEjWZ278pINM5Yu6cGFxre1laEF3G0EC+9Mb5evpRJJP9bxzPT1jUtDQvrlaMK6KlGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apBg6Y3W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47755a7652eso7966185e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762275893; x=1762880693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbLDjKmL4uHc2dptE3aLwdNwU3mK9EQDqQ7oNou4dVA=;
        b=apBg6Y3WmpXV8tNupi0zCb7sivXs/efOMH8so3INU+XH4Mxb9jQuERfTzLYrPL7aM+
         bwYVKoMFoRE+38mLT/u060lLyRjP8BC+myPDVIQyfgG2TksBR84ZWEN8V5C1x5UOjoFv
         pb10IK90dFONKjq6SWXWoLHOM3FpPXEFVw26V5asAxLo7SzBT326gUiHbQkBISQ1gilY
         xSaggZ0U9hy0Z0Aeju6UstQBveQ27sNLCIV89wy9Xtf4h9STRmjrpkymw3bKHX9ZlbFb
         rbRGgJoeplqgDiyyEnX+0BJMI3u3KZBjkqWkvLRzTTBcIsqkJ1+kcaG6tAC63JaB9H8g
         vUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275893; x=1762880693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbLDjKmL4uHc2dptE3aLwdNwU3mK9EQDqQ7oNou4dVA=;
        b=eqpwyxlaLAnLWIyXLOzvM2MVlL8VP4neRBaAiBMCbeBkXWmSazpWIMj/zhrnWuNIRu
         79pUmOx9qB5yWDzwwZvIvxbQ8/EcGYdJiy7bZeCtPd07dHBcjNc80w+0ivn6N2DLeus9
         S8apWpxA4DkNJUM+ckdxFH2INGBwk9HA5krjbpevCQj0MwnQa7wYBUnRLc/RfYmKP5Hh
         asqmyoL+PbPEmHePobS+noB4v5qHuS3Gv06n+YUXGsgvk3LW0spTyZytsxqCR82Mnbf4
         NIG9jt25RzsXcM8nOOX3DjCK1DFfwedd0NEeSApTP2dpZEKbF6P4efFM4dlKofNu85Nk
         IuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4EDzC5hGaXS2eaYh2fDl4E1oMGOuTAPD8uTIwxNqVKfcmW9hPogFbQIX/3waFjlkj1axzB7vE33h5trhP@vger.kernel.org
X-Gm-Message-State: AOJu0YzkB89LW33JvHjXdt6lfIcaektmytIIdvl+7kpkysCiV3xDajg0
	8/DlD1EeurUhQ5caog8HoTv0VncAzow55Nb8DYwjQ/0q9hn3m1pj4T/o
X-Gm-Gg: ASbGncsM+6i84zD8QoFUmoHzgvBXFX2d28hD/M/TPkARFm2/yMszuc27dlyQ7YOB1dF
	GkQJ4aWJTPHsYSaXeqe4WtZs0ZoAYlchu8FFcW7YNdWqOysJzM4jGesK4yhdUU1pxsss5D6aWn1
	xVevO6ohBebQ+ycOcRWO1I2EPSoDYH3SpqZ9f2w4xPKom4AyJ/co36LEIKCh4zjlZcE6JI+DByR
	4cidpvs5OCdPfjNEKfLEBWooDE11f/xuuSFVaNv7NlgQ8xVX6lJ6ktC5fLtYMJzzkvH6wmRgalu
	PgCpBxd31egkouLxXW35ByZ/rFxTAXLqgh3Iko8CAyYmE5CKBcOiy8x06QxoK4ImDPgfqvSs09W
	pgqdmLl3MK03rrG4uDu2ZdB+JyTPcdm9VB4FAZA8x8TFmORIUoqZ9ep0fuSUBjIQeJ8wXfkSEKT
	lBl6GEV9s79Tr/0hl9ipM1zJMCyitYXmHGVONcSrV/af6JUVj9
X-Google-Smtp-Source: AGHT+IEOhm4LBQ3j+uFfRzsfx33ktH92iC6aRT+QVBa8crwQ3gFbKh37Db7od69wIcrjDZXtYn9XAw==
X-Received: by 2002:a05:600c:1d89:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-4775cd7d146mr681795e9.0.1762275893180;
        Tue, 04 Nov 2025 09:04:53 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1929b2sm5698036f8f.15.2025.11.04.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:04:52 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: inline current_umask() and move it to fs_struct.h
Date: Tue,  4 Nov 2025 18:04:48 +0100
Message-ID: <20251104170448.630414-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no good reason to have this as a func call, other than avoiding
the churn of adding fs_struct.h as needed.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

build tested with allmodconfig on x86-64

this pulls in sched.h in fs_struct.h for task_struct.

perhaps current_umask would be served better as a macro?

either way, it is used a lot and there is no good reason to func it

 fs/9p/acl.c               | 1 +
 fs/btrfs/inode.c          | 1 +
 fs/f2fs/acl.c             | 1 +
 fs/fat/inode.c            | 1 +
 fs/fs_struct.c            | 6 ------
 fs/hfsplus/options.c      | 1 +
 fs/hpfs/super.c           | 1 +
 fs/nilfs2/nilfs.h         | 1 +
 fs/ntfs3/super.c          | 1 +
 fs/ocfs2/acl.c            | 1 +
 fs/omfs/inode.c           | 1 +
 fs/smb/client/file.c      | 1 +
 fs/smb/client/inode.c     | 1 +
 fs/smb/client/smb1ops.c   | 1 +
 include/linux/fs.h        | 2 --
 include/linux/fs_struct.h | 6 ++++++
 include/linux/namei.h     | 1 +
 17 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index eed551d8555f..633da5e37299 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -6,6 +6,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <linux/slab.h>
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 433ffe231546..9ac88f66bfcc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9,6 +9,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index d4d7f329d23f..fa8d81a30fb9 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -9,6 +9,7 @@
  *
  * Copyright (C) 2001-2003 Andreas Gruenbacher, <agruen@suse.de>
  */
+#include <linux/fs_struct.h>
 #include <linux/f2fs_fs.h>
 #include "f2fs.h"
 #include "xattr.h"
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 9648ed097816..309e560038dd 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -22,6 +22,7 @@
 #include <linux/unaligned.h>
 #include <linux/random.h>
 #include <linux/iversion.h>
+#include <linux/fs_struct.h>
 #include "fat.h"
 
 #ifndef CONFIG_FAT_DEFAULT_IOCHARSET
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 28be762ac1c6..b8c46c5a38a0 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -146,12 +146,6 @@ int unshare_fs_struct(void)
 }
 EXPORT_SYMBOL_GPL(unshare_fs_struct);
 
-int current_umask(void)
-{
-	return current->fs->umask;
-}
-EXPORT_SYMBOL(current_umask);
-
 /* to be mentioned only in INIT_TASK */
 struct fs_struct init_fs = {
 	.users		= 1,
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index a66a09a56bf7..9b377481f397 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/fs_struct.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/nls.h>
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 8ab85e7ac91e..371aa6de8075 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -9,6 +9,7 @@
 
 #include "hpfs_fn.h"
 #include <linux/module.h>
+#include <linux/fs_struct.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/init.h>
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index f466daa39440..b7e3d91b6243 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -14,6 +14,7 @@
 #include <linux/buffer_head.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
+#include <linux/fs_struct.h>
 #include <linux/nilfs2_api.h>
 #include <linux/nilfs2_ondisk.h>
 #include "the_nilfs.h"
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ddff94c091b8..8d09dfec970a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -51,6 +51,7 @@
 #include <linux/buffer_head.h>
 #include <linux/exportfs.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/log2.h>
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 62464d194da3..af1e2cedb217 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/fs_struct.h>
 
 #include <cluster/masklog.h>
 
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index db80af312678..701ed85d9831 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -14,6 +14,7 @@
 #include <linux/writeback.h>
 #include <linux/seq_file.h>
 #include <linux/crc-itu-t.h>
+#include <linux/fs_struct.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include "omfs.h"
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 474dadeb1593..9dc0a968ec89 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -9,6 +9,7 @@
  *
  */
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/filelock.h>
 #include <linux/backing-dev.h>
 #include <linux/stat.h>
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index cc6871234ae9..e470d1cc5df6 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -6,6 +6,7 @@
  *
  */
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index ca8f3dd7ff63..78650527d4bb 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -7,6 +7,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
+#include <linux/fs_struct.h>
 #include <uapi/linux/magic.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 33129cda3a99..072b636827fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2902,8 +2902,6 @@ static inline void super_set_sysfs_name_generic(struct super_block *sb, const ch
 	va_end(args);
 }
 
-extern int current_umask(void);
-
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
 int inode_update_timestamps(struct inode *inode, int flags);
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index baf200ab5c77..0070764b790a 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FS_STRUCT_H
 #define _LINUX_FS_STRUCT_H
 
+#include <linux/sched.h>
 #include <linux/path.h>
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
@@ -41,4 +42,9 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 
 extern bool current_chrooted(void);
 
+static inline int current_umask(void)
+{
+	return current->fs->umask;
+}
+
 #endif /* _LINUX_FS_STRUCT_H */
diff --git a/include/linux/namei.h b/include/linux/namei.h
index fed86221c69c..b0679c7420a8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -7,6 +7,7 @@
 #include <linux/path.h>
 #include <linux/fcntl.h>
 #include <linux/errno.h>
+#include <linux/fs_struct.h>
 
 enum { MAX_NESTED_LINKS = 8 };
 
-- 
2.34.1


