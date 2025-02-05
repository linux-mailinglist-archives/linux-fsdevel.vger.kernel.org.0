Return-Path: <linux-fsdevel+bounces-40994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D26A29CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 23:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F10168043
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11521518D;
	Wed,  5 Feb 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ad7FvivE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41251FF5FE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794616; cv=none; b=lkDa6RBreBOk7GtqVTl58sNchnFDDslh4wuxmw8xzPUq13f97tF5795peK1voLHoNi10C5+WjCImNrrNpoNJUyCGExnFhtoBOa1IdJ25g+dyGtaVp/wbrTykClCs4giH+d1BIg0LzrKKXB+7/SZv7tqTv3bAKRhM4WYgB8R3YYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794616; c=relaxed/simple;
	bh=Niu9AIL4O3DtUYGSUfwFn1vsrJ7ltpIotQa8XWF+w9A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hJdozX7PsipeIrqPIx38iPVurZXJakDfx4K9D0lxlctFpr4GUXcUBx4ysXOxOyAcMhAO4hJfBllbH9SrSUekMPVQKA/XMEwgXg8JdIXdkXgt1qEvpCvfQx5eMjJsnAaBxQbK6PRaVWiaTdEj0HkgeSM7CM2LCZG4Vkf0kfY38/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ad7FvivE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738794613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nn1dsWTEkEfHlGQecH4x0hBqMHFORd9ok163jgS/ZvM=;
	b=ad7FvivEYPn2mjAT/TccvFyo/qfvBXAzuPkM3aNCd7hcbg+G3/0rH/A136FNT7cDozULLM
	icUfQ5IoLn+t4E0JZ0EUTS7nAAkn66kwhjUVPTYGFd7oeG/OzfuKYMLf5Cy1JNMjXp/1jf
	xitAP21Flh/BzohJheZEZ7SJ4CIz5no=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322--96YlcfgPE6LBGLBpNCDVw-1; Wed, 05 Feb 2025 17:30:12 -0500
X-MC-Unique: -96YlcfgPE6LBGLBpNCDVw-1
X-Mimecast-MFC-AGG-ID: -96YlcfgPE6LBGLBpNCDVw
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cfb3c4fc77so1947565ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 14:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794611; x=1739399411;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nn1dsWTEkEfHlGQecH4x0hBqMHFORd9ok163jgS/ZvM=;
        b=lZhyAYBxzPAktpecV3ooqMmImbf80LiwS5fyTIfrjUO8M2CgqU9x83Gpq2YWFaOJw0
         fKsuFhKa1HkYNPUKMRrWvzR4YxYp3LsoOk7J/5PiMqhz8nZA6vUQPv307yXvok28Fh0c
         D6qy3bX16Bs4YVJkbFsb8SDNuq0AVbgvkb6xg8Px5LRghVAlOdJE5f5uQwt6rmLZrqUF
         Z7Ryyd2tLm/EFffxOG6Ddbg7ko69ekPD0rSmiR9M3yYR+w0mNnQpt3OIT5Bs4tr01iug
         WCqiCbaDHPDOJScjphsjuTRZt33elDziJnQ/PlYvabnTbjbrx1oNQnZvsZbB1uMplPDL
         kCnA==
X-Gm-Message-State: AOJu0YxdG4XMllujgdnB9UtlnA2/Jw+aClKdKMpz3oYbWHE/qlh3kIoO
	3fxiCnbTfq5Ov0Tv+TuGU69rFMDNilvXTkKHyOF2txzLMG2rvGaY56RD1eHZTkOgTE9wwnGs5yV
	A10VQqg1SgiNYJM2hDXF+8X6hTnTjLMNtoq0vbOb9Tz5bCdBtUuGxaHgGrG3vnXJC8eokgc3WxI
	KTQK360SlCAZsBSUIrBdT9hOwYXHF9B5/yANkqrU62le3zyRBl
X-Gm-Gg: ASbGncsCPMd1xNgj9hhV2a5przsRk9VXj+dhOBlkq2/sPtrXSKDf8oaWXPh9gKIUwCH
	jRonEkKxv6MmKrBG3LMS4NLPCetQGiYZ9RU7sqzUVsNT6W8gIQACUWWMT0+BWtUGXRNkfrUXvBh
	jlJ8+vxyrG30ERTceI3gqO2cepqKWGVibwqp6CUkmpdpcmi1Eo12D3FG4XHmsRxt2egndVEbcrw
	KDyrtcgPqW//HPOFp3EqcXXd3HQm/Xcb0dSNHF8ug7dKkv+JDcrFyu6gLHH460J/LMPQ5EtBeUv
	iDM3lJ7gWE0IU5MRF+r/OB5uPgr/Qez1ZI0KvRJWhglM
X-Received: by 2002:a92:cd84:0:b0:3ce:3565:629 with SMTP id e9e14a558f8ab-3d05a54b0damr11566575ab.1.1738794611230;
        Wed, 05 Feb 2025 14:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfxoB7bpG/UFGIN/ZtrU/xYkPU2XoiMdfj2gpRYtRTTwJLK6SeQszgeVoCtig33L/bB7gCzw==
X-Received: by 2002:a92:cd84:0:b0:3ce:3565:629 with SMTP id e9e14a558f8ab-3d05a54b0damr11566365ab.1.1738794610756;
        Wed, 05 Feb 2025 14:30:10 -0800 (PST)
Received: from [10.0.0.48] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d05255d777sm4874335ab.59.2025.02.05.14.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:30:10 -0800 (PST)
Message-ID: <be08b1c1-c6d7-4e82-b457-87116879bdac@redhat.com>
Date: Wed, 5 Feb 2025 16:30:09 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] sysv: convert sysv to use the new mount api
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert the sysv filesystem to use the new mount API.

Tested by mounting some old sysv & v7 images I found in archives;
there are no mount options, and no remount op, so this conversion
is trivial.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/sysv/super.c | 57 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 18 deletions(-)

I understand that sysv has been discussed for removal, and that's fine.

There seemed to be a little pushback so I figured I'd throw this
out there just in case removal gets deferred. Feel free to take it or
leave it, there's minimal time investment here.

With sysv done (or removed) we'll be down to just ext2, f2fs, bfs,
9p and omfs for remaining (un-sent) conversions. (orangefs seems to
be in a black hole for now though.)

diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index 5c0d07ddbda2..03be9f1b7802 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
+#include <linux/fs_context.h>
 #include "sysv.h"
 
 /*
@@ -349,12 +350,13 @@ static int complete_read_super(struct super_block *sb, int silent, int size)
 	return 1;
 }
 
-static int sysv_fill_super(struct super_block *sb, void *data, int silent)
+static int sysv_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct buffer_head *bh1, *bh = NULL;
 	struct sysv_sb_info *sbi;
 	unsigned long blocknr;
 	int size = 0, i;
+	int silent = fc->sb_flags & SB_SILENT;
 	
 	BUILD_BUG_ON(1024 != sizeof (struct xenix_super_block));
 	BUILD_BUG_ON(512 != sizeof (struct sysv4_super_block));
@@ -471,10 +473,11 @@ static int v7_sanity_check(struct super_block *sb, struct buffer_head *bh)
 	return 1;
 }
 
-static int v7_fill_super(struct super_block *sb, void *data, int silent)
+static int v7_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct sysv_sb_info *sbi;
 	struct buffer_head *bh;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	BUILD_BUG_ON(sizeof(struct v7_super_block) != 440);
 	BUILD_BUG_ON(sizeof(struct sysv_inode) != 64);
@@ -528,33 +531,51 @@ static int v7_fill_super(struct super_block *sb, void *data, int silent)
 
 /* Every kernel module contains stuff like this. */
 
-static struct dentry *sysv_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int sysv_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, sysv_fill_super);
+	return get_tree_bdev(fc, sysv_fill_super);
 }
 
-static struct dentry *v7_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int v7_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, v7_fill_super);
+	return get_tree_bdev(fc, v7_fill_super);
+}
+
+static const struct fs_context_operations sysv_context_ops = {
+	.get_tree	= sysv_get_tree,
+};
+
+static const struct fs_context_operations v7_context_ops = {
+	.get_tree	= v7_get_tree,
+};
+
+static int sysv_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &sysv_context_ops;
+	return 0;
+}
+
+static int v7_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &v7_context_ops;
+	return 0;
 }
 
 static struct file_system_type sysv_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "sysv",
-	.mount		= sysv_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "sysv",
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
+	.init_fs_context	= sysv_init_fs_context,
 };
 MODULE_ALIAS_FS("sysv");
 
 static struct file_system_type v7_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "v7",
-	.mount		= v7_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "v7",
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
+	.init_fs_context	= v7_init_fs_context,
 };
 MODULE_ALIAS_FS("v7");
 MODULE_ALIAS("v7");
-- 
2.48.0


