Return-Path: <linux-fsdevel+bounces-16526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC889EB95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 09:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC661B2639F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1913C917;
	Wed, 10 Apr 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xDK9pbC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BB13C900;
	Wed, 10 Apr 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733256; cv=none; b=asN+YMOkWdDFTc4x+evE7Zo4PJcA5V3XPNu8Mzs/CEu+Icr5WSocib6qxFJwMuHpsAoSAvwQt17+gkjAaL0S42Zcd8xJt+qtn30PcLDr3WoVR5eNKBZn6mRV4RJ5Po9FZl50wKf1EA8AQJRstyrqI0lUSj0+zh62FAc2C3mGq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733256; c=relaxed/simple;
	bh=YmJ4s2H8wjmREoV2xAlGhvbwF7Bfw51LOFU0l1TB+EI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fMriTQTjsRsGqq8CAtF01o8P2pgNIBdzIlb+zN9tsEe4Ot3y3+8yqGHwhOZF8aJC7GHpw6ZShPGQvHyNmXXxwebLBJS7g0IEOes46gq69tXfKRi6NN+ewLnKkkgtKbThxduBq+RjnotD1Rhcj5wopCQQvRrGOcQF1ps/Mdvhr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xDK9pbC9; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712733251; bh=pLNFfWJZyrrjt5ug/1IiEA0s6nA/zcDIGuvnAc6EYyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xDK9pbC9vhrDJHlw/ChVdWteJDO1a2Co2kYL43vQB0XHJy+WZwxe1zDyrP5v1N02/
	 uCqLt4bgGfx3FGBKc9oE8GTFjHhHkbwAaCM+af4wL3lDGporPtaNOp/dSuWqWyBknY
	 R91wrOSCMOEVotXmFeyseZz/2JzeyBhsY64YpjXI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 16E9E07C; Wed, 10 Apr 2024 15:05:46 +0800
X-QQ-mid: xmsmtpt1712732746taw9g6jm2
Message-ID: <tencent_59925DB41938CFAC0DDEA5A40DB592425D07@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z6Me8BtzExIGoq9q6kn1ilN1+Ec9Q63Jhv6qjQlpeJnwHPB3qZP
	 fM0X6whyJCXIGus//1EjkvBvcpw1HrIZgiT1xP+6jirBUlHhvwCAW1gPMAnlku9xKbgsumlHPs/w
	 6P0T6w8bK8ZbNPa4RzxBhzZIrCfmnvuqeX5Y7ICdI+Pb2l9+3veyUebYmFVhlzFT4Tfv+W6m2Iro
	 SGzByP40FpR2FY0bilje3dXlxksQLrrHoYH4srDecZ2qmQWqbV+AufclGN2Kdgjbc1p1+7SdLPKI
	 mxEgGx0Yjboonu5s5hzcZxz4sUuWjG1Tf2+qKPUiE9fY/twK2QwKwGVzLipLSyZOIllBvM8penmU
	 cozVmNEL0t+m1bjl+lAAHq7JuIA9BSnmwsdxiWYnW1niy8/f35KXPaDuvmeiAxGvSZWoybD/MQq0
	 5LE8Vp0In2V8X2IYI39eCvV6R4Rux1DADk7k3ly28SnSIS9qDOFHKRRwZDKQQhjY0IGAbcgYAm3g
	 7N269nIOwsO8nrwToukukOIsw5Rrlc4jGX8yVtpJU+0CGT6lQhg1Yxn2zi0cQWEicOKT9FN0Im41
	 MlELpxFEvHf+sXzI6wYQy5YJmOlHlBuU3rTd2Ewb7JaHkLtC5woOdXm4JFd0MF1FMgFXWFg/aZHk
	 A9OziP1aaXB+co9psyv2MAeapUrUhufYZFS2pvKXr6BAtVRr3/TpHYmz4V/S+/mMbXT6I4Dgi2Ne
	 ycOi2c3ad3l2qaUmtq++YkY16ny9LrW559DOFwhd9yu3ygssWBZ4Q5yYn5FsBWdHhDcn4y1QTYSu
	 iyiaOovWrNxJLlgOLC8uqI1vfUU8WihwK/lU0LfvVNjqFuhuxVL8oWBdnYj0+kxG/cVZAHepLAyv
	 ZzKJKNzZQ0EOs/CxPkxXvJZAO3rmVKaj29yfbiTDsdNjRYi0uQoLwwN7C5fJQ7ZnfAmtLZ3EH8SG
	 RTuRTZdHM=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: reserve the header and use freelist from second
Date: Wed, 10 Apr 2024 15:05:47 +0800
X-OQ-MSGID: <20240410070546.719365-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ea6cba0615a3f177@google.com>
References: <000000000000ea6cba0615a3f177@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5061 Comm: syz-executor404 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:dtInsertEntry+0xd0c/0x1780 fs/jfs/jfs_dtree.c:3713
...
[Analyze]
When the pointer h has the same value as p, after writing name in UniStrncpy_to_le(),
p->header.flag will be cleared.
This will cause the previously true judgment "p->header.flag & BT-LEAF" to change
to no after writing the name operation, this leads to entering an incorrect branch
and accessing the uninitialized object ih when judging this condition for the
second time.
[Fix]
When allocating slots from the freelist, we start from the second one to preserve
the header of p from being incorrectly modified.

Reported-by: syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_dtree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 031d8f570f58..deb2a5cc78d8 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3618,7 +3618,8 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 	kname = key->name;
 
 	/* allocate a free slot */
-	hsi = fsi = p->header.freelist;
+	hsi = fsi = p->header.freelist = p->header.freelist == 0 ? 
+		1 : p->header.freelist;
 	h = &p->slot[fsi];
 	p->header.freelist = h->next;
 	--p->header.freecnt;
-- 
2.43.0


