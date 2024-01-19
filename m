Return-Path: <linux-fsdevel+bounces-8314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E650832C6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 16:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080331C235C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4C54BDA;
	Fri, 19 Jan 2024 15:39:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E13C465;
	Fri, 19 Jan 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678769; cv=none; b=CiVPM4j9xmZUW5/YKDf4tLlOuvn9vcSGL3kS5cLNmvO7HUdKaiAB4fiBwX9EkhaSnJv5aqQbmfJ6M+eGHgKk5Hv8TCiQKWCkUdXpIBSQRWKoTunM5qU5GdMs6gQfCS6emkhCNcM6ZMoeA1eQUzmk042EoD5/2xZqc3Lp5nbU+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678769; c=relaxed/simple;
	bh=VtiMxsi1+ub0qW/r114MxUAGi/pPUxucnebfcw3ezbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eipn1GW45z0naebRbgewEbW+CK/Yax+LhBYdfOhd3Ma9j5gf5KmCvUZr3tRJ/NRN4vrdpKNpzWmbSND/e2RPlAseCwRkrU+qEQauw1l5zsqPbLP/arZPF2R4Htuci3iRISEEc3dhI1ywHUoBNt8odIZ3c8iEABeXaWowIUMelho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 19 Jan
 2024 18:39:17 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 19 Jan
 2024 18:39:16 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Chuck Lever <chuck.lever@oracle.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jeff Layton
	<jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>
Subject: [PATCH] do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
Date: Fri, 19 Jan 2024 07:39:06 -0800
Message-ID: <20240119153906.4367-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

syzbot identified a kernel information leak vulnerability in
do_sys_name_to_handle() and issued the following report [1].

[1]
"BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 do_sys_name_to_handle fs/fhandle.c:73 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x949/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 ...

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 do_sys_name_to_handle fs/fhandle.c:39 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x441/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 ...

Bytes 18-19 of 20 are uninitialized
Memory access of size 20 starts at ffff888128a46380
Data copied to user address 0000000020000240"

Per Chuck Lever's suggestion, use kzalloc() instead of kmalloc() to
solve the problem.

Fixes: 990d6c2d7aee ("vfs: Add name to file handle conversion support")
Suggested-by: Chuck Lever III <chuck.lever@oracle.com>
Reported-and-tested-by: syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
Link to Chuck's suggestion: 
https://lore.kernel.org/all/B4A8D625-6997-49C8-B105-B2DCFE8C6DDA@oracle.com/

 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 18b3ba8dc8ea..57a12614addf 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -36,7 +36,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
 		return -EINVAL;
 
-	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
-- 
2.25.1


