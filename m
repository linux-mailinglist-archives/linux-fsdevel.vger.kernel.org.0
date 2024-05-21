Return-Path: <linux-fsdevel+bounces-19867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E58CA79E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 07:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1D61F22252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 05:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36D3F9ED;
	Tue, 21 May 2024 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Du05iUcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2B2579;
	Tue, 21 May 2024 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716268912; cv=none; b=AlaeSbbzADkif7vNEi0mIiv4dTkszDHPapl9xxel5ibboOw4/tw9uFoSR7RX4FWUfqUzm9+Bq9nkVvkyIA9s2JRpcWV4SAzNAcrBM9JPkjTL2V1FM4PHyb2WKBZSC0m3qf3k+0eYAHsKKzFyuAU14sgaam8R44ouq/mMP387gT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716268912; c=relaxed/simple;
	bh=yAgAFccbsLhH5Kh8DfkFVFoeeV5JR++v4A1KPmkBP8M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AlzlqzeMQnq599a439QlraZ25is8WfQATJdo6GdPH/KPbbyIyvK4UnzlHDVvBb+uXl9PdD2Gsl8QvcmOj7QAjGAwL3ZPgH0cn0LLIz0JVcdLaYx/FdvFTKyApRiGnI+MAJEKZr3YQ622FCUHREekfGq6JEBWk4RM9SFKXTN3b5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Du05iUcY; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716268907; bh=Casgct2oLQqREqCGC1LCZkyZSznfO6GVNAfVv7GbcGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Du05iUcYd15znnKT/IWUZKV9ygnEX7S5Yi6GCBfFFeARzR+UZxIMndJAO8kS85Asx
	 4POVpO9DOdvBFiYIEceK7D0c25sHurNLa5UHnB/amCJUEvVdISe1FgaYL6OECOaNUi
	 rLtoBkoc0DbFgms/x7nqb0gcTg/hV35Ai34oUyX4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 56D2841B; Tue, 21 May 2024 13:21:45 +0800
X-QQ-mid: xmsmtpt1716268905tneqdgm41
Message-ID: <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnX8AD1fRRG+2fdkULK6pSBgCRNUbAQFl3RcY7Fkt+92njyCFoV4
	 CPkpRI+zwkB1QTxkNLXqDsWxB5dm8SStsGWrBFJbvp0kngZEv6uqQ1LHIcOVdD95da2V6ccq1rpU
	 8qhrs5EtDbiCQWY0TAqMGnicNK/otgmh8YttjJwp5a/JBf85MEN1huABiklyx3L7JwObn8YP3LLZ
	 STaWl94UosNbDkdRsGxcgxCfIZRvyGJd3GPz1qV3/bRXGC/2S2FWYX96LsGRUAzH9k0miSuccUXc
	 Jj5hb4/O1MRT82zMBd6tDNZ2XUDgwLPgRZBqYPXQL5Q6t2SevaXKSEfsnFpEFL0n8TSfNOVngvC3
	 oz0R8Ocr/d8QZFnNoL5JXrAIFQZzMmaZMw4sdxGksE3hRY5BlwnF0PiudqK5VzJogI0k1OOf6dco
	 JUk+Rq0cikvpDvj4aZl44/oV3cvra5L27NWzdUbGJ8zVLKzgTlselnYyufawSVGxkimFMVkJCotA
	 ZQlgViY56xP6jxzWqrdMjXBsQxktr7rfkHxEOzBCmLYx2Egqnx6uu48YOMAyHgSEa9YAFoLm5UCJ
	 EacVefi9YFqRbuSNVjTubPdPLLhWF1uGM3zhDN5V4pkfXFegXb1XjkdxqOhKyTtX9BTGWm+w/LnC
	 cBKIqqCdf8J8a3yM7RH78mOu0NbFdatWF5340NGoEj+Qa6QPvNG6PpJygL9a9vlHvjEytGt98k1V
	 O7iLqgg0ROVg/uy34BHnmTVDyUEw3P82NyA2KK1GrbLI5sKZBPIuRbsbDStzAV5+fOpCjLOH8Ev2
	 8ZUZuY4kpil+6NOhlud/pmIShxnlYFt9BPw2Q9YVwbCos2ipSsCOTsbLxu6MeGPjoXzB9mv3HVZG
	 TDJeEhUzftK47X7GZgzeV6PCLM081jsfmtbn2D4V9II7It1qvcvzHdj4TXEKob1w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: fix uninit-value in copy_name
Date: Tue, 21 May 2024 13:21:46 +0800
X-OQ-MSGID: <20240521052145.562245-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000037162f0618b6fefb@google.com>
References: <00000000000037162f0618b6fefb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
 sized_strscpy+0xc4/0x160
 copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
 hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmalloc_trace+0x57b/0xbe0 mm/slub.c:4065
 kmalloc include/linux/slab.h:628 [inline]
 hfsplus_listxattr+0x4cc/0x1a50 fs/hfsplus/xattr.c:699
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
[Fix]
When allocating memory to strbuf, initialize memory to 0.

Reported-and-tested-by: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..858029b1c173 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
+	strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
 			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;
-- 
2.43.0


