Return-Path: <linux-fsdevel+bounces-48921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E0AB5F96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 00:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44C14C01C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD872116F6;
	Tue, 13 May 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FhS9ygCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD920FAB9;
	Tue, 13 May 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747176006; cv=none; b=XSbO+is8l3tQvE+ztT5OHl5xjkDokweJud0HRpu3cNjD3EHdwtwTGRszhH4Y8bMj4Umu4p9B6ob7t+47p0qxYWSHBI23OciURBu3EMXl/uIkb0TVJF9G8mu5kD/BQrCTM886urFzAUcPAwOT7MR4vpo2V2mJo+oj03zVa7nEddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747176006; c=relaxed/simple;
	bh=g8uWITCjtLS+qlpe3cbX3Alv8oBZg6ny0DdL7Vqjg3g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DzK+4BB1EhjCLBaLGxnMZPT190aMa/YBrKOPKKBAm0H03Ue7KVv3UBL2s4cg9QvntXZHtr1uEMvGWOk/cKiJRymO6MKFAMHskXbAl5G71SbmyNVFceKvXSUwWbUIG+yetKGSDN2xTzWkQPDWjgXzNWhLb6Mk+aMnjlU4gb/ZnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FhS9ygCN; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1747175992; bh=DryTadyn6BVnnHlHb1LTKt6pg14mZXRnI140cC5VMyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FhS9ygCN78BvbK2qG4m2ydR161wP0dghH/+PT9MZQ9EQHdyFgcPrWNbPq3e5NsAMN
	 b7tp4jMPOSXOWTOk7zZu5az2jOc4A90v69rk+W1boOQF/FJTozpRbm7i9akVgT0Adj
	 QigI0y6Vw4cuLKbeHJO9XAKEo83ugMAq++Os0lUs=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 9E829E20; Wed, 14 May 2025 06:39:40 +0800
X-QQ-mid: xmsmtpt1747175980t2dupv58g
Message-ID: <tencent_55ACA45C1762977206C3B376C36BA96B8305@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zUiBjxZ+w20wF+jT7kEQsGS+XVPTAKwyTxwU0pvEm4QMYCBmCLE
	 3pzGd6zj2xm0WkzXGUNKkHDeOztbQXMw4B0HZEQbIYQbJhh/lAKdwPOpHZBw+lTYgXA9opI5ukR1
	 NdTBHGgWM1PlfJs5R6B/Rk/2OKU79S9lJC6pNf3LYLI4hdoO5CBk0vjKhiQAqVBeMdX9D2ZPlKeQ
	 EvNP6Rkn+UuDikiqdB20TX7Gwy9WdM6vru50/Ads53pCbSAZhIFCodSNOmmKhUKdctEevTODb2uY
	 ZgQfGoYqcA6H5jHw6MV657CXlFdmKOQwri396VFAP3DBy1DX+r4I4R6V61B/vyjIX+AA9w1L1RuJ
	 nBQalii0+GAcw1Lz818h6QUKrTioOwPvuECcahxNRVRnWGfZd3G6rAnRU+KRmgcBxBGMZIeLqpRc
	 yNFm8FO7Lq09TWzv6GS4KHWyuSIMh0Yh2YyuMiKABZTcvzvwK8GRjnN5QCgCuLaxyFZ+ed2Vqj/o
	 t9/1F/dsKiakpasasDF/6IGIo4UXQvYVD3mB41ZrhSJpWh6VZLU4iwOc1sPiIo2xdhruVP96Tzjm
	 H+9aLgyKMG/kA/OKNqwcUO4+gpXKOp5cQzmUzAA93b6rtajLj+kuRWD4H3s8dhRrWJk4xQyV0jta
	 093eR4oBGg+vzqgceesBaUEyNe8R+2pAGTImkYgG873Y5nIXbSUTPFO89xIVYb3wu1dUOGL1T2ax
	 F8HQMQZmFZ7PnN8zk7XdinDruIzPoj9rWHBtyYY3Ucq4Ub4hLrjLo/oVvwMD3rHKuinA71sMXqjM
	 oRVQ5ynWs8Dhq415XHzCA8OpDCRtITD8xjutON6+Hy0uTO399e23TukBVRYNScgVaDkZk3njbrLb
	 AE1OrcFnL+iGN/4G1tnarbBKMF0Z8ts2/6M5P/Fq5K7rzO5DvY8gA90tYtxPg1zhdO7+UDmoTU
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] fs: Additional checks on new and old dir
Date: Wed, 14 May 2025 06:39:40 +0800
X-OQ-MSGID: <20250513223939.2438402-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <680809f3.050a0220.36a438.0003.GAE@google.com>
References: <680809f3.050a0220.36a438.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the reproducer, when calling renameat2(), olddirfd and newdirfd passed
are the same value r0, see [1]. This situation should be avoided.

[1]
renameat2(r0, &(0x7f0000000240)='./bus/file0\x00', r0, &(0x7f00000001c0)='./file0\x00', 0x0)

Reported-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=321477fad98ea6dd35b7
Tested-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 84a0e0b0111c..ff843007ca94 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5013,7 +5013,7 @@ int vfs_rename(struct renamedata *rd)
 	struct name_snapshot old_name;
 	bool lock_old_subdir, lock_new_subdir;
 
-	if (source == target)
+	if (source == target || old_dir == target)
 		return 0;
 
 	error = may_delete(rd->old_mnt_idmap, old_dir, old_dentry, is_dir);
-- 
2.43.0


