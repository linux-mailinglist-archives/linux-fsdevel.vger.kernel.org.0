Return-Path: <linux-fsdevel+bounces-70877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0ECA903B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 20:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3BD3220DC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0C357A41;
	Fri,  5 Dec 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCehPqhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6D357A30
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959966; cv=none; b=exbpAufIGU3K3v2WcAmST+h15hREYDNJW27iF34xJJG2vxfaHo4eOVXwUNg6riMiKA2BulqNWOKnM95Zk2rbQsxSQNwAUKGzwdtX5+alNI3ydO/nkmxWWWHFw4XcPCXwXnUjDCZA17XIKWNEEOrciyFYWlG+yqAzol71XJUhoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959966; c=relaxed/simple;
	bh=cjNKHrQrnXLTUtPo/NH2OLDEK0teLVgujXCxRj1xbCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDyV6/0N7+s+OujGrWCfvThqoexnT1ocd/xq3R6I8zuxE0J2sbFLbWdiKFRqg4bMNMyPmf3UNbbICtgBrg0w79wRPo+tNu+HK/C99asHEcGLQawklJcfT6bl4lCNdrp52mUolGWPQRSvf3SU7NiqU6d5i6I5z22KKHuRxwEzsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCehPqhH; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so1659461a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 10:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764959962; x=1765564762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3b2MXk7/01ozYqBLq6Lp8YCFWTmwEngfJtvZiESMsc=;
        b=LCehPqhHYlPhn091Z6OkrTl1AN1hYG4bEU13wH0hEI3YAxO7Q3K1AbXnphUdpwekNL
         ztXjpPsnuYjtMUxDVXPZmERNL37pQ0SafdgdPjJ5J/tcXD/amfqnBD/FO1mavAMXKroU
         XIudvjucBfXXpHew6B3nENEBJ67GT9ojSPM8F3pBpF9ZegNiWcm1kG3GTY0aua0Dzrt/
         gWtFuIJfGzLROUzVCuKGo0wnwjZSsvNO9Dji1IGCLha9+i47H68IQUmx7Npn+R2A2dUN
         FqOTP0mvelyd+PS5iH80PoaiN6pJ0W9VAu2ZAmKnaHa2o2Al4qXOFjijuJVOTlWdKic/
         kiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959962; x=1765564762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3b2MXk7/01ozYqBLq6Lp8YCFWTmwEngfJtvZiESMsc=;
        b=IsCkDsDLTLkshrZwMk5/WeAw8uicfoiGJiAkOWwq+vAgRftpCcVUSfNVlicoJ61HLn
         5g7563eFjVanykAFSlBiTd82jShwh3TbReOzjknH3lB54LnjhVKd7mBQEvwoHGpYrwt7
         3MVAkqtFQSf+FVo07Py1Nx+tC/v4Qicxhm2qNYYrzmgE8s6o18YBqVqlJvkKZQzcVYXB
         2YmZq7la7gPzRGBDDjO+bbg7lxcgcAsQuHKFxl0yc/xTAyNDHzzPQMEgVzwJruMDkN8H
         TAP9tWpA52yaFlbNlGV58+oHodYGW/rvL6SgSTRCFbwrC9JBF8SdIwDVQTONvy8PRneJ
         d6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhVPw3xFZwC7slnLOPPVtvSQ0DtIjkyAUb68mo5cEt/sh+ILU3Rolo+hP+S6rzHxlmgsqORf5c65C4wsB/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7N/9eLZoqYVxNFbe9zUPqAFpZ2g7MRWWvragvOg94lVddmExr
	Hz4KBU76LZMLYwvi4HmW+aHpGiRNBcj/sPjfynxKjuPrVO2Mk4pFtdbj
X-Gm-Gg: ASbGncuFqSXpjBfrbS5jWA7bISmLzPHuXg5TtETLfB2WFhBC5UvjIyDwaSuSkc+vbMF
	DT29rsDLiqCOp8YHy1JZRonGXb/BE1+wNROBh/He75VakPqpsDeBhDk9wBL33SH/79VcyCBC0hq
	1NQP7x8MGivL6u1zzkCgSBmgd1VkV8PGE7Qz1Txv2npDZL8DADc8KRcVYwL43jqrDAuy3GjjUVc
	iZgbZY8zF8ZlUzuVIUT7xPPyLtSDEl0MHWWdPmfDHbK9V7a+qzG5wORgz2zH5q/O0D0DkyC3bGj
	xjppLMtEQhWzWU0KUpGtvyZKIB2BjEEGlc77+IgBBw22si5SD/NLrReEg1eBDq7AljTOAJ8jcAh
	Wkdc1+MOgGLnAKW3bGt3M7q36kJhOsgX/PRY7DEPIUoht5SOANWhfLA9fvZf3DDGvxgscemiM2S
	hI9YNGNJtZAtkcYDvLO1z6ppcpP114ZA==
X-Google-Smtp-Source: AGHT+IGp/pD+55VxfNaGNlZMHcVDyCZzwtjcXLNX3ZsgvJQlW5QwGHduUe4BhdJ+a4kKFe7mkksxqg==
X-Received: by 2002:a17:90b:2e8c:b0:343:3898:e7c7 with SMTP id 98e67ed59e1d1-349a1c84d90mr160863a91.12.1764959961918;
        Fri, 05 Dec 2025 10:39:21 -0800 (PST)
Received: from LilGuy ([2409:40c2:102b:bda0:cf8c:6055:172b:8eed])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3494ea899desm5326165a91.17.2025.12.05.10.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:39:21 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzkaller-bugs@googlegroups.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH v1] hfsplus: fix memory leak on mount failure
Date: Sat,  6 Dec 2025 00:09:02 +0000
Message-ID: <20251206000902.71178-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <69326fcf.a70a0220.d98e3.01e5.GAE@google.com>
References: <69326fcf.a70a0220.d98e3.01e5.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzbot reported a memory leak in the hfsplus mount path when the mount
fails, which occurs because the fs_context API moves ownership of
fc->s_fs_info to sb->s_fs_info early in sget_fc().

When filesystems are mounted using the new API, the VFS (specifically
sget_fc) transfers the ownership of the context's s_fs_info (the 'sbi'
struct) to the superblock (sb->s_fs_info) and clears the context
pointer.

If the mount fails after this transfer the VFS calls
deactivate_locked_super, which invokes the filesystem's kill_sb
callback. Previously, hfsplus used the generic kill_block_super, which
does not free sb->s_fs_info, resulting in the 'sbi' structure and its
loaded NLS tables being leaked.

Fix this by implementing a filesystem-specific ->kill_sb() that frees
sb->s_fs_info and its NLS resources before calling kill_block_super().
Also remove the early kfree(sbi) from hfsplus_fill_super()’s error path,
because the superblock unconditionally owns s_fs_info when using the
fs_context API.

Testing:
This fix was verified by building the kernel with the .config provided
by the syzkaller reporter and running the reproducer. The reproducer
now runs successfully without triggering any memory leaks or kernel errors.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e69c7c175115

Reported-by: syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 fs/hfsplus/super.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 16bc4abc67e0..fa7420d08da1 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -629,7 +629,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 out_unload_nls:
 	unload_nls(sbi->nls);
 	unload_nls(nls);
-	kfree(sbi);
 	return err;
 }

@@ -688,10 +687,23 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
 	return 0;
 }

+static void hfsplus_kill_sb(struct super_block *sb)
+{
+    struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+
+    if (sbi) {
+        unload_nls(sbi->nls);
+        kfree(sbi);
+        sb->s_fs_info = NULL;
+    }
+
+    kill_block_super(sb);
+}
+
 static struct file_system_type hfsplus_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfsplus",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfsplus_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfsplus_init_fs_context,
 };

base-commit: 6bda50f4333fa61c07f04f790fdd4e2c9f4ca610
--
2.52.0


