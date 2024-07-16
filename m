Return-Path: <linux-fsdevel+bounces-23783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 389EB93303E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 20:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B57B22DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793D1A7097;
	Tue, 16 Jul 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHGrsASy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9B1A707C;
	Tue, 16 Jul 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154828; cv=none; b=u8qZdeHLirfW9QglNYdUy4eBq+WlSIPkJLdorpQN9W29DMUnJPZKr7mvmRPltEyBc1PN0/Ykbhcv3ZgpW9OtHES988L2WbAfcMuXNjFhXjgML4YbZc9qptPJRY0lVvZRoApYtoy4kFq9OLglFfjacAnAJPvtW2VU0JrardMj6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154828; c=relaxed/simple;
	bh=ys9V1bEc7YcrtgnNHhHbA050mldDo30tqWLi5f3C77M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE84aeFdYt2Cwgcos/skHhhW+TdDSvz0nKICmTy9pttVxf8USHAt4dUBhor3QYFDSrcrWKCwYTqiUJki9Ql36DE3sa4I6eO+qouOvlzjQiN92RPQ4GXdfjKXd34bkMpQcVUTOOiiru82VZOAPl47Vkf2cGrW0lZpsSn14JZSUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHGrsASy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B8DC4AF0E;
	Tue, 16 Jul 2024 18:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154827;
	bh=ys9V1bEc7YcrtgnNHhHbA050mldDo30tqWLi5f3C77M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHGrsASyXglUh8p00NJBD1ERwdMI+9q/A+AnxnDdajd8sFBgyA/1zatGF0Lr9waQa
	 HzHCdxf89mjyrp7z8mSr2QVr8+LNOjle3m9lVDtveGjuT6F3/OeG4ybKmyyjMMuu8Y
	 WXA922iODJQt/DKSyFB0BBST/Rx9v2r0368WrDWV+01E0Y6kvMjL8/m6f4uu2W3Hvb
	 kwqY/2LMFTfRi7ZGb9M/ILK0EV6w+zgMkwIYHx8JkYz/b7hYd1HqaGc9jQAgOiSo/C
	 Ou7qjGLcLaPFfOp1L7qKDgWAePUgi6ib9MnTJjyxhKQgAxtNXBap/7zu7MeQra9gCb
	 ByHa/y1Q38t8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com,
	syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	walmeida@microsoft.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 6/8] hfsplus: fix uninit-value in copy_name
Date: Tue, 16 Jul 2024 14:33:03 -0400
Message-ID: <20240716183324.2814275-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183324.2814275-1-sashal@kernel.org>
References: <20240716183324.2814275-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 0570730c16307a72f8241df12363f76600baf57d ]

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
Link: https://lore.kernel.org/r/tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com
Reported-and-tested-by: syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 58021e73c00bf..f7f9d0889df34 100644
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


