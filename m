Return-Path: <linux-fsdevel+bounces-71257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0EDCBB4F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 00:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75EDE300B2BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65FD30CDB1;
	Sat, 13 Dec 2025 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+f1INb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740AA30BF52
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765669027; cv=none; b=LPjEUde55mTz30HIsz3MbyuoBfWgNqz6/Utqw5SiD87S8Cg8JFWG6kTf90jQZq+WuzNqpGcWzzbqYXtILFr06y9KncIuClUQwo4ALCf3C0+ZNfmFG0GXmL4TkfpDAuz15UF6Q1X6hwjEsQVZCrEbYf7VoIbCmhmU7yZqx4isIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765669027; c=relaxed/simple;
	bh=cJfN2LFQVsTToarEtrjJG6LBKZLE6UGOBVVViTLOxXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DStftUA/aSt+wkkD9v32DnJ+rUgaPyJlnmtozwFim74+z2e/07wKs8keXKKhsR2WzuShBULT7xV+OWGEB0x04B5ICZ9BDDqgpQHPXvvhCKKHg1Y2uR5HfId7IyqEuDWAI5Y7vv+FKLIyr+bZfCtRn+p24MFzmU+QErTm8XnhJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+f1INb2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47790b080e4so10165195e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 15:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765669023; x=1766273823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvM+YrUFgllyVXk9pxhptdAjipRbIePjBKtm7KoIwJ8=;
        b=U+f1INb2oiANqz9EbKbSTdA2QB+hy7ZcNE7YRI1DzKSsFO2y1RUz9K3gRftESeYxOp
         M+Bnt39qRZHH1MrvgPGeCR2iz7WWSHkgkJUeAEgAwIU6e3Dur3WLq/d89ZFNqEw8DSv6
         +IW7UyxUFCqfcC1fV3X9sYG0U+uyTYnjcPZxZzmo3w1CabTpbd4JVEt6PPzNbhqL0+uQ
         Li4kxSI8f5J+x5gptBhb+mw8v4mu/hvKmlAyxx6WjjTnkTUWu1EdOBktQn1SqnCRdKDp
         ockWoJbYsHyBdIqt8JfMeJXfQgxJNjBTMGa9OncFJRP871TEHKyTvHTmp9+HCB6skeoW
         VDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765669023; x=1766273823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvM+YrUFgllyVXk9pxhptdAjipRbIePjBKtm7KoIwJ8=;
        b=l9KxhDG8X16i0W1RI8iQ6ltsfLXqxxX97K4J/pyI3VxOGn88zFV9CfSv5Zhg9PmTO8
         A+s6ezk9ypOfkH6y7wWsrUqimrObTUQBflyNobnk+D4OIlcyRjbxTilhSqFiKlqPdpXC
         ysa4x9tEbNze6qVNbrez/EJZHHmUH1LiNUIWyHY3bKNngLSLaFqxQsWsFx0WAcksUE8F
         5z1tRuZL++OisF++lqZvM1Old7EDbx6iHUUhmQKQxkzClJn84nQobXBod6yFpuLc57Sl
         sPqVJ2gX+aj6zbhLLldhV8Nj6ZNkxaGY8z9OCHiw/tO8aSYViz4P4nxlKbvkPZtJpYtW
         NGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaiphDIoPOX//7vq3QgGmLYniZfR+PaeKJ840ibxwFxuSm7UNwGDkHDODER+TeA2ZrIuvyoyWL6cDQk/Yj@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3Z2U4JngMH/tFCanDCnM26Q7JQKNff72LSpXiqlWVVjtU8NU
	GD/DSAzjN6TRjoyAKV8Tk0o/Ed8tYy9p6peytpVyQ+bk5XI1VnofZw4q
X-Gm-Gg: AY/fxX7kkZh4BsIzXisOnn31n+u3qbnTn/VGs/HlPUmoR623QAU2ORyK2+XrY4xjtJY
	sHBELHT4/PJdhEWY4eP0vLBmqz0fol1f5ZS+CaRGqK4HxjJRHBp4nk4bjONhso8CBHCEwRsm3vG
	TRnKx0De3RTOLVCDw4hhffu11jaQm3PH/oibJP3uSE6nDntbEzHZFGIvg+64I0kqXlk5hLxNvdS
	WTs1IZnsTx2KHilw1UTQqpJXeOQrn5ury1OYr3v96B0nWbkcvS9xKGpz30gkqQcFf3yIWw5b17g
	uAKlV3pU3IIeWP0Eecc17LOspPpndDdOeHAlzEAOkr8kv7NsggV/SCaNdz3Genl2micjkHW8tkE
	dhVREmr02bxV5bp8+13077y52+k3jj9QWh0o2+W71kJH2pJLabMcFeSmlU7KRM7OQaPWJTv5NyG
	p9Kp+Bq31ZVjg=
X-Google-Smtp-Source: AGHT+IENkhxfPSBfbzNFq+lkIO4tXRzzEAa/71aLHopjgvmXksmw7sZUAvCfmFZtrx/jVGb4eEdANw==
X-Received: by 2002:a05:600c:6912:b0:479:3a88:de5d with SMTP id 5b1f17b1804b1-47a8f91dac4mr68687055e9.36.1765669022611;
        Sat, 13 Dec 2025 15:37:02 -0800 (PST)
Received: from eray-kasa.. ([2a02:4e0:2d18:46e:337b:a52b:d034:ae83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6f3a46sm111436235e9.15.2025.12.13.15.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 15:37:02 -0800 (PST)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: [PATCH] adfs: fix memory leak in sb->s_fs_info
Date: Sun, 14 Dec 2025 02:36:22 +0300
Message-ID: <20251213233621.151496-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a memory leak in adfs during the mount process. The issue
arises because the ownership of the allocated (struct adfs_sb_info) is
transferred from the filesystem context to the superblock via sget_fc().
This function sets fc->s_fs_info to NULL after the transfer.

The ADFS filesystem previously used the default kill_block_super for
superblock destruction. This helper performs generic cleanup but does not
free the private sb->s_fs_info data. Since fc->s_fs_info is set to
NULL during the transfer, the standard context cleanup (adfs_free_fc)
also skips freeing this memory. As a result, if the superblock is
destroyed, the allocated struct adfs_sb_info is leaked.

Fix this by implementing a custom .kill_sb callback (adfs_kill_sb)
that explicitly frees sb->s_fs_info before invoking the generic
kill_block_super.

Reported-by: syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=1c70732df5fd4f0e4fbb
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/adfs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index fdccdbbfc213..afcd9f6ef350 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -462,10 +462,19 @@ static int adfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void adfs_kill_sb(struct super_block *sb)
+{
+	struct adfs_sb_info *asb = ADFS_SB(sb);
+
+	kill_block_super(sb);
+
+	kfree(asb);
+}
+
 static struct file_system_type adfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "adfs",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= adfs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = adfs_init_fs_context,
 	.parameters	= adfs_param_spec,
-- 
2.43.0


