Return-Path: <linux-fsdevel+bounces-13611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B43871E13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560461C239BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BE57326;
	Tue,  5 Mar 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eRA4T9XF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20681C6AD;
	Tue,  5 Mar 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638702; cv=none; b=uq/GbijIZW/aOZc+48sbYqHx3FqurbcMJEJxl4FGUmzBVBqO6MtPXyxTQ1IHg/tUEULKiYTngpFnb5S2VDkiGnOQSSiu2MX5kR2paKI6i9+3nCYUsSuX4gB9bUiUuFnxDEJj6703WG9jMANDGF81GMvbtB77wNLUL7eeoP1dzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638702; c=relaxed/simple;
	bh=QzYHOd+dyVh7UrO6ChjHVt3V649waC8Wk+j1KEBrJfc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hjNqKagWssBgbauqbVLqOLWdwWfTboaMSH7hfO/UFoobaSwHVkneDk4vhX7fwwGb6RkELomQkX1Zp4Z3tCKfwGfKqhDLW8/yL7JMMBpZFqTAPPgvD7Eg7QIoEmUi657Yerckgyza0gMNgo8YQmL1dhtfopxhtHXWk/cy8Gb9kzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eRA4T9XF; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709638697; bh=N0nDmVEf6cg/5KEdeUPOw3ez2Rj/dBiw4YqbMxTZuvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eRA4T9XFgmozE5Z5y8j8RaNVwuiEKYjyQGM8NVsyFlRCNHCZ4XLJUSXHv919Zcz3S
	 gRVvxqNxFva/ZPcYpSqQOlwYSwOM5mVv5EWZl54DZhduy1/xfN5bmYo/Cf/cQoJELe
	 R4QwRWcRiP6VIc6hgEAxrrxzX4v1dbOur8TnHm/0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 98F1DE68; Tue, 05 Mar 2024 19:38:15 +0800
X-QQ-mid: xmsmtpt1709638695t7z4ovnkd
Message-ID: <tencent_11194B111B6F25CEBA5FBB71336B9E9D1B08@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujILhsONvPruo4uQ7+ppvZHX8EdiXAigos8aJey6DeGYUnmDConM
	 DSFl654zgZ/AFCiGSsXgceYX6ctfWdajefqhCi6QaMO4jtxV1ab8Qb7uEktCPjCnVdEEkZCTvFhj
	 PvKzoG1cA2A7/FVd5n+QWjiNl+Q62SU30vB7vTWA8mMS/hNTTsG5p6SnC597aGMahc8BGvcZacVw
	 +VyHdQu4pO/XfSQa5OxzyvRM+tMs4WkZQC5Y/HaxOq8X2BZFb5QjiBtSiM7Qsh/nOxAp7/N5XA8a
	 AXeTG4RNzDqDmcMIeUQh5hijdGHHvcYIK9mF44IYTWNW2e27fq3nRjte48VVmjBPjM5K49o2gaU2
	 Dx8irZ111mdzT0u272QCl+CADUumLwDRaKl1hf7CzJWYwitlZy92LRxOTEDaeAxvhFQEYCCY0LAX
	 b9DaMqFayvfNF4XOblTUnJz+rW9CyKy6s/xiQLkep3hFu4MHULnbJBWfTsIqnDdM5vsOcRNB0GsA
	 eA4ZvU1n7mEsC52sQf9HGUSB3OQ/JgeBB0nsVp0pCWyV0Tvy1qQvZ88Rtij1aIufsog0Yut74l7w
	 tYCPZ72fotajgMMXC2Q5inRjCGEPTaWEROLrK3DKgOqr92Ndrdy6MMGbPP/t9poAyV5PQAVAO90n
	 RG5Wv/MdC585WYronqW8gNGGc4Oolu1VCj3fxfz1o8SSE5Uo8iO266zJaZb3M1NR8g3HNccfIzo+
	 WgJuZo3AuULLtk+o5t58X7SsnGPzx0JdsKxfkwaBuj5tJu60JEcfiRvJHv92lM13ZNGtTcNxFaqC
	 vNtC3wUL2jQJIdc6MkiaialzmwAG4kCvclajAhvq9mGVQhOb0HL8v7uBf3N0yYo3QF4kCswZz0YR
	 IUlJcUgIdO0co3lkH7DqCfKX4OaQ8Wp34IoYj7dWh8jwolZmnvTn9mVO89td8/O+erHrlhmaHXyL
	 7wE66pJqI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] mm/pagemap: fix null ptr deref in do_pagemap_cmd
Date: Tue,  5 Mar 2024 19:38:16 +0800
X-OQ-MSGID: <20240305113815.2950328-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001bc4a00612d9a7f4@google.com>
References: <0000000000001bc4a00612d9a7f4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pagemap_open() runs in the kernel thread context, task->mm is NULL, it will
causes the pagemap file object's file->private_date to be NULL when the pagemap
file is opened, this will ultimately result in do_pagemap_cmd() referencing a 
null pointer.

So, before PAGEMAP_SCAN ioctl() call do_pagemap_scan(), need check mm first.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Reported-and-tested-by: syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/proc/task_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f78ebbb795f..ab28666956d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2510,6 +2510,8 @@ static long do_pagemap_cmd(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case PAGEMAP_SCAN:
+		if (!mm)
+			return -EINVAL;
 		return do_pagemap_scan(mm, arg);
 
 	default:
-- 
2.43.0


