Return-Path: <linux-fsdevel+bounces-19169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558768C0F94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA75281DC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD1815278A;
	Thu,  9 May 2024 12:21:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD614D420;
	Thu,  9 May 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257286; cv=none; b=qaBapmF+Zaf29P3QLTAww7smgYDjhpNnQNlM3FaggsEYblfoZSqqjlA82sNXGPnrSZcRqDmEJ84uvnH4Jrbrhb4aPUaKBxdZuIeiZgtbjVxMB3wwF3NBTCu1JBEzSKdPASE7YZ4GeWZZ8IIrFxDzujn10ISMQPIIE9mweEjjlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257286; c=relaxed/simple;
	bh=IkdJx82TC8CSPoXp0DmmD2UOyL9+5oahKUAWhpJCB1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WY98w0MBlzTLEX649miHOVOg7vWUYMFpkXwZl8JsWJwZ3iif8wnWGzV75dRBIbyV6KgSM1l5Amj2+XCygojXARdJG9cWZq8zQiHskvZo0i6BoIO7Ca9tapMhxWDTtqvi+p/+AHGJpEpyhIpi040c4LE1mi4uT9sdPWsyXynI0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZrhn50tKz4f3jJ2;
	Thu,  9 May 2024 20:21:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0F8D61A0C85;
	Thu,  9 May 2024 20:21:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RG+vzxm2lnBMA--.55991S6;
	Thu, 09 May 2024 20:21:20 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Zhao Chen <winters.zc@antgroup.com>,
	linux-kernel@vger.kernel.org,
	houtao1@huawei.com
Subject: [PATCH 2/2] fuse: clear FR_SENT when re-adding requests into pending list
Date: Thu,  9 May 2024 20:21:54 +0800
Message-Id: <20240509122154.782930-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240509122154.782930-1-houtao@huaweicloud.com>
References: <20240509122154.782930-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RG+vzxm2lnBMA--.55991S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZw15ur1UXryrZry8try3CFg_yoW5XF18pr
	WfCF42yr17Xr1UAayaq342ga4jvr93ZF43JryktryS9Fn3ZFZ0yFyYka4UWFy3AryxWr4j
	qrWDurZ7u395X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUzMKuUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The following warning was reported by lee bruce:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 8264 at fs/fuse/dev.c:300
  fuse_request_end+0x685/0x7e0 fs/fuse/dev.c:300
  Modules linked in:
  CPU: 0 PID: 8264 Comm: ab2 Not tainted 6.9.0-rc7
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  RIP: 0010:fuse_request_end+0x685/0x7e0 fs/fuse/dev.c:300
  ......
  Call Trace:
  <TASK>
  fuse_dev_do_read.constprop.0+0xd36/0x1dd0 fs/fuse/dev.c:1334
  fuse_dev_read+0x166/0x200 fs/fuse/dev.c:1367
  call_read_iter include/linux/fs.h:2104 [inline]
  new_sync_read fs/read_write.c:395 [inline]
  vfs_read+0x85b/0xba0 fs/read_write.c:476
  ksys_read+0x12f/0x260 fs/read_write.c:619
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xce/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  ......
  </TASK>

The warning is due to the FUSE_NOTIFY_RESEND notify sent by the write()
syscall in the reproducer program and it happens as follows:

(1) calls fuse_dev_read() to read the INIT request
The read succeeds. During the read, bit FR_SENT will be set on the
request.
(2) calls fuse_dev_write() to send an USE_NOTIFY_RESEND notify
The resend notify will resend all processing requests, so the INIT
request is moved from processing list to pending list again.
(3) calls fuse_dev_read() with an invalid output address
fuse_dev_read() will try to copy the same INIT request to the output
address, but it will fail due to the invalid address, so the INIT
request is ended and triggers the warning in fuse_request_end().

Fix it by clearing FR_SENT when re-adding requests into pending list.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/58f13e47-4765-fce4-daf4-dffcc5ae2330@huaweicloud.com/T/#m091614e5ea2af403b259e7cea6a49e51b9ee07a7
Fixes: 760eac73f9f69 ("fuse: Introduce a new notification type for resend pending requests")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8eb2ce7c0b012..9eb191b5c4de1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1814,6 +1814,7 @@ static void fuse_resend(struct fuse_conn *fc)
 
 	list_for_each_entry_safe(req, next, &to_queue, list) {
 		set_bit(FR_PENDING, &req->flags);
+		clear_bit(FR_SENT, &req->flags);
 		/* mark the request as resend request */
 		req->in.h.unique |= FUSE_UNIQUE_RESEND;
 	}
-- 
2.29.2


