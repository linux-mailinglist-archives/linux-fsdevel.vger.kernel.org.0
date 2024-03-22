Return-Path: <linux-fsdevel+bounces-15041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F9886467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 01:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E901C21FED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1910E3;
	Fri, 22 Mar 2024 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KGNqJUXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C8376;
	Fri, 22 Mar 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067846; cv=none; b=UQpNZ0WwBwtslOS3taS/wZi7gqC5KHQLnlfOvipmm3vVq9ZLUAiKNSULzwc7InlZekET2mjoXMzMKfauvFZ/bjnRqzlaHqEWEXg9+GX88nbtKDOHtKiFYMczKyyPEH3/4lSMjtYHk35fVGWpSvLNB8S/DK9iZWli2ZejfVychzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067846; c=relaxed/simple;
	bh=lM2DDRDjWwjPRlQ67f2eeArWymy0wFusj65S5rDPcz4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nGBxUi/RSXy+nbiGDbPbIts/P1VTg6C644FHuR4+pQuv1bnC1sasIWqYX5W632BKEebH0v1pEuqXuA88MYCsmE4B68t2mbMCcMiwY84ug63HJZvspQw49gMnXEMVPbShnbgO38PDy6ck2tYUHBtqRogc+zI1HJb/a+PQ4RYBNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KGNqJUXn; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711067838; bh=r4IFZTlDc4FNVIlNbrQKRPaN2yiQZzGfTw9TeJnxUWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGNqJUXn8airvafwLPfVSg0b+B1dTwq1TNNJ0TGjEcnbXV13Ua1iMmV9ioOUZRT3e
	 FUzxMX3+T+bXIfX4eUGgwOwpPOR6Gv2qsEq2nnsCx64fpqGsUHZsOI9P59OYaUZe6U
	 rdfu63E2qY+Xrc2Uk68ciBHZO1rm4tawtYguLHtI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 7C7A2048; Fri, 22 Mar 2024 08:31:07 +0800
X-QQ-mid: xmsmtpt1711067467tnw9eno2d
Message-ID: <tencent_C54679498DEEC46ED40C8BA7F386D352D606@qq.com>
X-QQ-XMAILINFO: Ncpnai4dwVTHorlzyzhU77ytbUvOBdgC2WZW0ZSVeR1eDCJaBUV5De7sHzroXJ
	 NCPMnm1AImZ2qDwB048DoGdiKZWDPG7UwJNMeJTRqBiFFe9+mT/FkbgPGffkFy5g6d2L8ejVJY7s
	 sJOdcjJgnJEst4eVPRO3C6oiMhSRck2qfpnQtomsvRBa6kQpftLQLT9lRVL83jqVHiBCEEU4QKSD
	 7cewjJ5aJZZOrU/46m35tW55De4/L1MKcxc4qNHZfabPNUC/jwRX5ZK2EGYm5zS/Bnj0kUpVY72X
	 DjvcUqv068/keICLAuGFpcbqrpnbEKiKHt8nAbdo9YKPPqG4zEBOJGssqd/8NjnRALQugVVdSuuy
	 uI1JGCqgGYJCKAc9UR4TkAuNzmHJDKggo/EH8AvOQWcBc/JPK7qpjg5W061GSyAtWJnjNu79j2Xg
	 s30ghUxM9qJ9Z8qh4vV97A0GbIneN2rsau22iVu5jmVU7p3YaRDH2dEHdjjLTNMh4Mu6+LKQaHPk
	 WNmCsY5sEVwmuchDhGbdy4VD/jl6DhK5YHXoIrwztmVCadbPgUc2Oe/jJWYWHHsTrs3DR5pHKL5x
	 0lDtvTVc2ZIY0+v5TUymVCHYSxtj5z0yKejIcgcN1zp7yTgks6SZfjNGMSyrBlNAAiz/sDP4oszF
	 mXr+/hLa6VQUvwC4XJFvGn+GE97UV39j/IrY5Wou1VHCipab1JWwhtHrPLJe6dMMiWH1H008j7rv
	 5kh8cGys0k7oWeHqT5fznYJ+MHCxo4b6DrCvaRuWKxfTZW617oG/ln36jHim2ZhQHSNTKsidSmFh
	 pPVEE9pa/inLDfxGyfzycVlLnNtce/tl4VR3Rssgd5gR8aKfyztSUV1AxV1Mm5SXsspGNWO5L29C
	 eI+cF7dP7DfSiLKYQuOPFG9+MxqH8MUZnW7H2qrJSkrTJBsrcCcQuzMKZ6owYVo8K+/N/pfLXL
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+65f53dd6a0f7ad64c0cb@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/hfsplus: fix uninit-value in hfs_find_1st_rec_by_cnid
Date: Fri, 22 Mar 2024 08:31:08 +0800
X-OQ-MSGID: <20240322003107.2672796-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008fd9bc061428179e@google.com>
References: <0000000000008fd9bc061428179e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
BUG: KMSAN: uninit-value in hfs_find_1st_rec_by_cnid+0x27a/0x3f0 fs/hfsplus/bfind.c:78
 hfs_find_1st_rec_by_cnid+0x27a/0x3f0 fs/hfsplus/bfind.c:78
 __hfsplus_brec_find+0x26f/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_find_attr+0x30c/0x390
 hfsplus_listxattr+0x586/0x1a60 fs/hfsplus/xattr.c:708
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x6e4/0x1000 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_listxattr+0x44a/0x1a60 fs/hfsplus/xattr.c:695
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
[Fix]
Let's clear all search_key fields at alloc time.

Reported-and-tested-by: syzbot+65f53dd6a0f7ad64c0cb@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/bfind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..b939dc879dac 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-- 
2.43.0


