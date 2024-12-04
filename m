Return-Path: <linux-fsdevel+bounces-36394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A59E3370
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 07:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B8B2273F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 06:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1B1865FA;
	Wed,  4 Dec 2024 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CevgJG41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592280BF8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733292634; cv=none; b=AoNKkg2ubJB3PVAiE2UTth2u6Yx1z7KsbniSJPNixur4fqk7gRTIyrwULQsCMsWtoPQMZ3bEFY7T1IUZtDzvgKq37UMLd6SJZwkxFq42MT7yCYPp/w/LloZJKBOQxD6gki5ZoQXeU+2OiJpFHBzcftGFb6hVQUsoPzQAPmeKo1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733292634; c=relaxed/simple;
	bh=PTpL2Rms4WjQ4jBpSqoSOgP8hCUMRgyoLomXKdSFhN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsWMAh2gH8VjeRcSMbRH3w09RaAVYjRQn//egMOvIS4edv7+uTaw3H9l7vuqKV6Z+aBxSXdrT8TeStnO5B7+sLVPEkXoYNrlP9gDFhOH5mJEidVZJeWSMQA66g2f7KWgIpM39nZoJvjvrm4QIGN0VkPh5zM6kNdnR52TO2E0h9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=CevgJG41; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id E2BD760ED4;
	Wed,  4 Dec 2024 09:10:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KAZlHoFMpGk0-YLjjREcj;
	Wed, 04 Dec 2024 09:10:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733292621; bh=8hWD62IZYAeUJp3Omrw96qmRw3cdYlrJesm7kt67svE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=CevgJG41h6uhOkpV4S6cGZPaFg/E5FdGAWpifLyvo4zJfbzc6MO8iBjmvkF2givGO
	 rF4R2r8McfJ613AFen+XweWbGYy/nJVC0SjhBZKbLesimUlfjBI9lIS35p7NHoqj+3
	 RgA5fdk+nSejL4E+79s+k3dp86NYk5mt6nxeiazA=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: ensure that node info flags are always initialized
Date: Wed,  4 Dec 2024 09:09:34 +0300
Message-ID: <20241204060934.697070-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
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

So adjust 'f2fs_new_node_page()' to ensure that 'flag' field of on-stack
'struct node_info' is always zeroed just like if it was allocated within
'struct nat_entry' via 'f2fs_kmem_cache_alloc(..., GFP_F2FS_ZERO, ...)'
in '__alloc_nat_entry()'.

Reported-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5141f6db57a2f7614352
Fixes: e05df3b115e7 ("f2fs: add node operations")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0b900a7a48e5..5103cc0d95c4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1314,7 +1314,7 @@ struct page *f2fs_new_inode_page(struct inode *inode)
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct node_info new_ni;
+	struct node_info new_ni = { .flag = 0 };
 	struct page *page;
 	int err;
 
-- 
2.47.1


