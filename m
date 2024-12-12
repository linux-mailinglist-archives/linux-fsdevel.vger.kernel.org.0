Return-Path: <linux-fsdevel+bounces-37216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1CA9EFA35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE050166F7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC22153EC;
	Thu, 12 Dec 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OO/ksv0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2C206296
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026301; cv=none; b=mE1AF/3VY2PTj9+dP9H6qYPhKezQNfShz23fmQL7P9fQSRq8h1Y8tAQZRXFMtetD05EGtP+Hbhg+MsKtTPu44TiupolrcCf9qhRRXJykpz9bGiUUALikU2Fge6Ciru1AtA55DtwFTBbZW86wUmTiuLdo0oOBOsnE1AQm5BHUE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026301; c=relaxed/simple;
	bh=8n1kBTGUtlNdDycBwe1jpjZ5iw7Ylimysp5r0Qbuf8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQIOM+2enVfbyVXc/7WuM2uhADfC+yqS61TcgwK2DMizSaoarv2o5eI1VJFKFIMLHQNL5RlUjM0eW6KcLfF+FzTqi1mcFe3fXq5P8OIXiuBKxQhGoCnVSrtUyFDgFOvj6tLop7ckpWJUkHja+natWTwKjbknQAiit6oY/TeR2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OO/ksv0Q; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:55a0:0:640:1286:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id BED506090C;
	Thu, 12 Dec 2024 20:58:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6wsmue1Oc4Y0-50jK10KK;
	Thu, 12 Dec 2024 20:58:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1734026287; bh=bmH6GuJazNfXe81elplaYoKMoKP4FehDWWNplzyTaKU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=OO/ksv0Q0glI4U5tWcz6UIGoEyO+R3g7LEEcXGoshn8fjPoBCpCYxIfyMb7AT84Rf
	 U/r4e32Hml2Y7qN6tDdsnIzAONLkkFq/Qht7b+p6vssjLFuWGk0yM3aVVN1YiPdEeA
	 ZSHuWv1fJqNZjtrzsMcG1zDohHWkJsiSLHWu0DNQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Subject: [PATCH v2] f2fs: ensure that node info flags are always initialized
Date: Thu, 12 Dec 2024 20:57:48 +0300
Message-ID: <20241212175748.1750854-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <ec2729cc-2846-49c2-b7ca-4c1efe004cd1@kernel.org>
References: <ec2729cc-2846-49c2-b7ca-4c1efe004cd1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following KMSAN splat:

BUG: KMSAN: uninit-value in f2fs_new_node_page+0x1494/0x1630
 f2fs_new_node_page+0x1494/0x1630
 f2fs_new_inode_page+0xb9/0x100
 f2fs_init_inode_metadata+0x176/0x1e90
 f2fs_add_inline_entry+0x723/0xc90
 f2fs_do_add_link+0x48f/0xa70
 f2fs_symlink+0x6af/0xfc0
 vfs_symlink+0x1f1/0x470
 do_symlinkat+0x471/0xbc0
 __x64_sys_symlink+0xcf/0x140
 x64_sys_call+0x2fcc/0x3d90
 do_syscall_64+0xd9/0x1b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable new_ni created at:
 f2fs_new_node_page+0x9d/0x1630
 f2fs_new_inode_page+0xb9/0x100

So adjust 'f2fs_get_node_info()' to ensure that 'flag'
field of 'struct node_info' is always initialized.

Reported-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5141f6db57a2f7614352
Fixes: e05df3b115e7 ("f2fs: add node operations")
Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: move flag initialization to f2fs_get_node_info() as suggested by Chao
---
 fs/f2fs/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0b900a7a48e5..c04ee1a7ce57 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -558,6 +558,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	block_t blkaddr;
 	int i;
 
+	ni->flag = 0;
 	ni->nid = nid;
 retry:
 	/* Check nat cache */
-- 
2.47.1


