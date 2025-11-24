Return-Path: <linux-fsdevel+bounces-69637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AEEC7F6E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 078B83443FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAA2EFDB2;
	Mon, 24 Nov 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kz0fFuDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D06272631;
	Mon, 24 Nov 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974391; cv=none; b=CbP2rgF9xRLGbLdfXDUgQSpUQTi47TKdiNxt8KX3gYdH8qcsizUd82i43BEIi8zU6ClG6k9aBLpPdT9bopcFvPIlNiplsDzuNRaw1Mq9uwd5FrSiTy9mXOYWiAQyD1+3Gl/arTBE+FJnkHLYldPEcKq7qVXRvvLoAj3tss4dxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974391; c=relaxed/simple;
	bh=HOsbgCUtbNgi/B/bSlBhRujbyRv3eMz1XGxmTUW7yIo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Oa3TV6hpo40rxxAcAZDn4EKuyQGGzECIUVlE+HlJ1FL4YiDgDl1gnvaxj47x2x0jfwsPevzHb5vSMnzYh6tTfoDPKjj4/TGnvoHrpS1TVDzTbxMoIKfIMR4Gzn+lLL11EOh9ZkSCsb+eVKL5AoaZnpu9AM9RUuY4BOR5/c2D/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kz0fFuDb; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763974387; bh=ZRgrDQUjLFkTslkgJ3mUpuQXWhVhwkC4qd2OoOvGUZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kz0fFuDbWULH95qTIqhXqD6EQBimkFqMdL1aVVUZ9Dz2Eq9fPc37MhHq0jg6OP95q
	 liD0Ne/aXFHucISr3X7+VK2d6beYE9x7bKehX7mYaPum/zHvzPYxKUDK8W/qiyT8TD
	 +uqtH7W8gZArI6bE9L1JJbjJUfriuBvrYLjrFcRc=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D439EEB3; Mon, 24 Nov 2025 16:53:03 +0800
X-QQ-mid: xmsmtpt1763974383t047juipu
Message-ID: <tencent_734A1B432559BAF7BBA333429E581B034B08@qq.com>
X-QQ-XMAILINFO: NR0zW9LgXakqGqwRbOz21eTm+0oq9riIo+7iPRwuNIvdbNxRADmeFyRMi7cMKe
	 YfvwevKPouYxv814rjCJCk9hK53Sm8P0kdFcOkc2Tkp0fTpLRuWaYgd5Y8yahm1xbYQTUZGGsuhv
	 75acW9yJbp1rzjAWJAJlwbWs5zrGj4j4jhNjA9NAPW8/i0aEyuTiHrq49OJUXBRqPfgyzD6dRniq
	 cZxHGYI3WZxCKUWxdQWL4bFr/jFbqYiMIsDkp/fLhSu9XO2JgsfVI9dryYPqDMoJONLvD0ZIRjwT
	 gD+jQodVogHW75nVQQN2v4WApn1gh1sgs5Xn1eJNIbcf3FiT8/CGbnqr3N6RroGwQvYjtVMHDcNI
	 Xh07YCShd6hIAzCkGR1uknK+q8ZN/AHZkiApskfoRhuJ23TFIHCTGEYdesTmneVlvHl8l56Dnmuy
	 pC1i8l6NW6u2JoKv5PJBHgwL5RUoT9rTR3sNPkbLgNlPgYtbXsRSxcNfx9uRtTYzOcs6n+aGhdQj
	 sI0R4fgXQLyHepdeKGPWSBDlys3BPBr12ZUjjyoO76MR3lv9k0vcm9WSmuZ+qyTrg68nojafQEM4
	 yPNd2AmRFoOgGWmO+oPQ/vXwGFnw+HULcnSHy3w+0NIdgsCL6kIB0ZrwWqtc1z6YTYaPd9bi07xF
	 BHU+cRSecJ/s9C7G3WwwlddzEMlsb90nC3XBXAfyN93iP3R+0uPG1EY2EJxYIzPK5LvgQRq+tDNU
	 MINhFKObP4uu5GNTLA9/4sLrCBKohsaG+ww6KCs32u9g6LA5HO/PVuxU4QAGneV2dWj324+LRf/P
	 xopFwUMKjm2fJAJsHZrKjEMipwAIrZy2b8kHd5SUu+pCmRLvQ7gbxM67iVNZhmYbxRxAmYbfnRSr
	 sj+/CspejWusDPnTXO04VovdCvYv7VvSGCmk/BP6gzkxcVRDwswzxuE/XzyqMVfP0JjbJdMYuf6R
	 crwAWyeq56XRNFhN1+TLeFeLKDjIl22FOEEgHbCmm8oXwIALKjlQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH Next] iomap: Add sanity check for dio done workqueue
Date: Mon, 24 Nov 2025 16:53:04 +0800
X-OQ-MSGID: <20251124085303.4085309-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6923a05a.a70a0220.2ea503.0075.GAE@google.com>
References: <6923a05a.a70a0220.2ea503.0075.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s_dio_done_wq was not allocated memory, leading to the null-ptr-deref
reported by syzbot in [1].

As shown in [1], we are currently in a soft interrupt context, and we cannot
use sb_init_dio_done_wq() to allocate memory for wq because it requires a
mutex lock.

Added a check to the workqueue; if it is empty, it switches to using a
synchronous method to end the dio.

[1]
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full)
Call Trace:
 iomap_dio_bio_end_io+0xf4/0x1c0 fs/iomap/direct-io.c:222
 blk_update_request+0x57e/0xe60 block/blk-mq.c:1006
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1168
 blk_complete_reqs block/blk-mq.c:1243 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1248
 handle_softirqs+0x27d/0x880 kernel/softirq.c:626
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1067
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160

Reported-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a2b9a4ed0d61b1efb3f5
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/iomap/direct-io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index d4e2e328d893..6b0ef7e0f05b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -202,10 +202,14 @@ static void iomap_dio_done(struct iomap_dio *dio)
 		 * filesystem metadata changes or guarantee data integrity.
 		 */
 		INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
+		if (!inode->i_sb->s_dio_done_wq)
+			goto done;
+
 		queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
 		return;
 	}
 
+done:
 	WRITE_ONCE(iocb->private, NULL);
 	iomap_dio_complete_work(&dio->aio.work);
 }
-- 
2.43.0


