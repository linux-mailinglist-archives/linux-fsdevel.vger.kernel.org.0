Return-Path: <linux-fsdevel+bounces-37343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603579F11E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D2A188B7FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F261E22FC;
	Fri, 13 Dec 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vNC8EzyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877F139587
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106704; cv=none; b=iDe0LqFK0D/2Mz7Ep9DhXpNgmvxoz6AQ2nbbUQE6t1ASam/DcFmM9/iA3d5QWfl39fjKlmcM3xPA4CWeXPlXQPF7uINi5M9ejAHBFZC5BVvScaZHEoDgONGTQ/g9Xjd/jgfJY5fzZK9najEdleS8EGMbVg1P7q7hUm/S3QoAwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106704; c=relaxed/simple;
	bh=kicQe2L5Q8NeE2fQw+OVzFPOXZrsKZ1DsXdynfG9FyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNlC9SudbePVsu5riDC5fNph+XDTvaPyQLDbDz47SQFTB/iAisukT6FnHNdlz+bULnVeuOwSQ+LM8MDY0IFhDFXGFwulh/Y8rLOEhTxJ7WyqxblLlR8PZBm27Fyq8B5CHUrBQH0lNie8rMmTpROMAcj4RYRyA20jMR82tteC6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vNC8EzyC; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2d9f:0:640:f6ce:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 1042F60CFC;
	Fri, 13 Dec 2024 19:18:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 9IPUCn2OqGk0-tOJDaYDu;
	Fri, 13 Dec 2024 19:18:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1734106691; bh=HAbuCWYNac8PsFY8xupWydLBNTlMKG7cPREROmn5G7k=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=vNC8EzyCU8xUMcVn63ndTQatA/8OeuPsXX+fmff3qseNy9T9ZogxO4C6CpknTq6Xs
	 UQNdsvTwLdcRTj1crND/g0Ax17W3bM3sZUVbR/wjjcxwaVP3pcu0onHfEWPK7Mnxhd
	 R0phpYN6NJfStg+UvRTInAChxgXYlN2w6Wf2RiXk=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com
Subject: [PATCH] exfat: bail out on -EIO in exfat_find_empty_entry()
Date: Fri, 13 Dec 2024 19:17:57 +0300
Message-ID: <20241213161757.1928209-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following KASAN splat:

KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
...
Call Trace:
 <TASK>
 ...
 ? exfat_get_dentry_cached+0xb6/0x1b0
 ? exfat_get_dentry_cached+0x11a/0x1b0
 ? exfat_get_dentry_cached+0xb6/0x1b0
 exfat_init_ext_entry+0x1b6/0x3b0
 exfat_add_entry+0x321/0x7a0
 ? __pfx_exfat_add_entry+0x10/0x10
 ? __lock_acquire+0x15a9/0x3c40
 ? __pfx___lock_acquire+0x10/0x10
 ? _raw_spin_unlock_irqrestore+0x52/0x80
 ? do_raw_spin_unlock+0x53/0x230
 ? _raw_spin_unlock+0x28/0x50
 ? exfat_set_vol_flags+0x23f/0x2f0
 exfat_create+0x1cf/0x5c0
 ...
 path_openat+0x904/0x2d60
 ? __pfx_path_openat+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 ? lock_acquire.part.0+0x11b/0x380
 ? find_held_lock+0x2d/0x110
 do_filp_open+0x20c/0x470
 ? __pfx_do_filp_open+0x10/0x10
 ? find_held_lock+0x2d/0x110
 ? _raw_spin_unlock+0x28/0x50
 ? alloc_fd+0x41f/0x760
 do_sys_openat2+0x17a/0x1e0
 ? __pfx_do_sys_openat2+0x10/0x10
 ? __pfx_sigprocmask+0x10/0x10
 __x64_sys_creat+0xcd/0x120
 ...
</TASK>

On exFAT with damaged directory structure, 'exfat_search_empty_slot()'
may issue an attempt to access beyond end of device and return -EIO.
So catch this error in 'exfat_find_empty_entry()', do not create an
invalid in-memory directory structure and do not confuse the rest
of the filesystem code further.

Reported-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
Fixes: 5f2aa075070c ("exfat: add inode operations")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/exfat/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 97d2774760fe..73dbc5cdf388 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -331,7 +331,7 @@ static int exfat_find_empty_entry(struct inode *inode,
 	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
 					num_entries, es)) < 0) {
 		if (dentry == -EIO)
-			break;
+			return -EIO;
 
 		if (exfat_check_max_dentries(inode))
 			return -ENOSPC;
-- 
2.47.1


