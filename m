Return-Path: <linux-fsdevel+bounces-16527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D796A89EBCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 09:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6508EB232E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D313CA89;
	Wed, 10 Apr 2024 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ic42icFt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D413CFA5;
	Wed, 10 Apr 2024 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733849; cv=none; b=VPkB34bmjg0aEfgvx1bPuEutkWApbrG39vHYpMFnOsET/TUwN+H63rlHC7J14AIgs+xGzeWqdzRfzNO1b4fU4WBYI8qyCBuAgzyJKBXEp+W83+JLlfZQ0E+tIoItZIZr8TAIjbz7roOICqoPXwXmon1PBnUKuX2glh2WYhQkYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733849; c=relaxed/simple;
	bh=plKIsQqad7OUKBDvXgrgFhGbOn+DnejZorpcSCoN6rw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Gb+Fw1wGXogQEvIjEFRyuY/DSib++LJ5NMImfuS52JG6yIgFhLQniP39p37tsikRyyl3tMFB6B3JPN0K4PfCwadIJmWpATba/FxAsXFH5jq3qz7kWSl4sYNu23k1qc/lwtW9ooVhJofXHGJR1qSWWGYQxGY+mt8VMwSfunopoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ic42icFt; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712733842; bh=ywal0kjEywMRpEv8bhSwZ1X9+BZ/7cgHpt4FFL9X9lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ic42icFtf62/8/91p3JiPpSy4ZPTXVOe6HfWYJMIZRDbnRj74/6FnRrDwqjCVNlj/
	 j6PaKJdI5ektrWltMSUyvaBy+xkx05RfZEFCE16GqcjjZ5TkgdgQ7Gnqz28OXSo0j4
	 dltNBoAAfNfpJhrJoU61/Q/cF0N0ZI6I5BVF4Q9I=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 600B4EB7; Wed, 10 Apr 2024 15:24:00 +0800
X-QQ-mid: xmsmtpt1712733840tvm5kf4hx
Message-ID: <tencent_616C382D056E049418E83AEE9ACCBC79060A@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIebw1DV93UFccpJjp+ZYS3u5weSNv9lcVPAQfvNGW/2pa9u+c2+K
	 R9Dn+8gPk/+hP1tMlUUKAiSPBbfFwKwSJNuR+w1Yu+rKbB3kMCPJxMq3cYVBRY+YrDDwC39I4bJr
	 4MTNHkaRfVzBfo3WMjUtH2dn7oxfrFlMC9xkgVFz5/1k1akRBFIvb/8jh3wtThKJw2yECfkk5Q0G
	 9e4aAB+7rKgohPBUgYdgLQsnoLEx3qH4ndh+KzWKDKm3wufFLnHFVMzEW4g5Q3neGJifEbGrc+fS
	 ZtwPD0H4nx9b+dRfDzmzX8KPeSzGq3zywBHPnlIR73fnA2bD1bMvo46Mnd3LtlGN0F6fV8AZaVjU
	 /SwvrN97w9Zzt5LPhdNHoHVfF1HCEOUaKVWnpKOLNo3ElTGO58dwpIsjq7XvhRzI3/gX3qzhSpoM
	 tkGCTfiA+2dQhIw7BJDiDJxCH9/6rvXPyJnxd0SuprTulIv+atbZR0YxoDH+RdMNDY6lj4F6sB9k
	 kEj308Nb/Migro3KF2TgtKernyHWE7YNWMOwc5SZdtM8Q9CBzmlFLXcKtB80Jw9G8PoOxiwWTX+J
	 0yFEObHNN7RrruRAb0hgr0iccS/5csM5+OcN69gVxCsJfVmO8gZZ+2iLglsJc5o0Q2kFJvfLnRVY
	 D1X+aIfetgwovww66/vUrYt2Sk0SOL55Sl5M32KIWYWz8wqAqfKfRd6HIZj4cH9sYFGyBAqgWgDH
	 IoTjwRSYuiY9WjhSfKOuvzhwcKgXkA4sCnj4fOSAlR0Kn4I6+MaMtU048mZVb+tnRC9IvKreWayS
	 NLH4wJguAMBwwWcNixyUUVaPrJPV2g0KIRO2UftAfe6fhQuc1CT5JRHaxiaZdI01KlkCS/7ywxxh
	 +VdSIflU1Gqizd4wvdYz9KPAu8bv2gEyP8UO8aEw6RWcaDL2qM7mh89OACPGLaZ/hjmC+aOvTL
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: fix uninit-value in hfsplus_listxattr
Date: Wed, 10 Apr 2024 15:24:01 +0800
X-OQ-MSGID: <20240410072400.750441-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fefd040615a5bef6@google.com>
References: <000000000000fefd040615a5bef6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
BUG: KMSAN: uninit-value in strncmp+0x11e/0x180 lib/string.c:291
 strncmp+0x11e/0x180 lib/string.c:291
 hfsplus_listxattr+0x97d/0x1a60
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmalloc_trace+0x578/0xba0 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 hfsplus_listxattr+0x4cc/0x1a60 fs/hfsplus/xattr.c:701
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
[Fix]
When allocating memory to strbuf, initialize memory to 0.

Reported-and-tested-by: syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com
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


