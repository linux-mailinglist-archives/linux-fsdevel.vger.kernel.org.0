Return-Path: <linux-fsdevel+bounces-58872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D75B3262F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CE31CC7688
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17817A2F5;
	Sat, 23 Aug 2025 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cLSqCdSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0128F4;
	Sat, 23 Aug 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911843; cv=none; b=k/X6nxunu03MU4S3TBzHwCWP/0IEcRt9yH8wU7zyGjOKFlQKTn1O/FE4/6FwCnRmCjplqrL0NU1ugEczT5VEajuhmW1TKPAJFKJR26IKFkVrbvgChvE+lAnH8Q5JeZOKZw0NtUodRwBzaMvGe/4c01gijEGdTZwJ6DUjn9uS5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911843; c=relaxed/simple;
	bh=DkCtyXPX+y2jfq7vMKfHqEsjaUAWfzSIF6DlJCdQSD0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SG2WTiK4fkHnr4o/VT/Tr/aWU3A8bizSFtwBlBOY70syQOjYFSM/Ru5BP3uS92zq8tlBG/8uePOrV8fQ/h9tAA6muzB9I/J+LAOoE26MAM17v3jHFd2C+ovOosZQfP8a3zq/tqoF382dus2BWW1jjMUYGqT5xwz1PxU5ZDiAAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cLSqCdSZ; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755911837; bh=2MpJbxTAdsXSbHIcD9m74B6dZkiCe6Zt1dqe5uXqKRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLSqCdSZ8lMABvwaIBOvCxgz0tdlIfaLfoPLCORkbUbWoN3cG/C6uujaDp0rKHd2F
	 yqjcK5nNfBoFVnYyLeL8WSpiGgLq9N33QCkyARq7ekZ0i6oExV+WfGobRKUNgOJr0u
	 x3Vsg+USDbTzQVTuxQZr6imEXKO/0sPunoor33i4=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 44F37E8D; Sat, 23 Aug 2025 09:17:15 +0800
X-QQ-mid: xmsmtpt1755911835t5z22u9gn
Message-ID: <tencent_F0CF4B761BAA2549BAA0BB1E33D09E561B08@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTkR+tgqlDhJfQ6Y81DDgs+ktDGMBgkusIuKADNSKX/5nB4xM+Y9+
	 8kslEkBeH7Z/EsTzYQHzuYctJTULo7cqVu40BapoWD+OEB1KwxdqqQs8FPAnCo+6SR0Sr3cddg05
	 bneBec4ZUm8Mm6j7/2Llsmz6yBzI6MP/vuH7sqy6XSf0sTIXZthMgF86ibQ9xohqNqm+iWL3BK6T
	 jIJfzCsWZfrnTRNVuaujHCyQyXmptXOwuJ0klrrclfzgJpDPV1jLVHt9KsQKCrXG7elj9KPwmTy2
	 k13gxey1uoNsvP3EQF3/kXRz3y9G7KNyQ6jVWWUOduldZFEFob6HQUY6jSjNLjcSinGUbbI47VQf
	 MBKeYRxb9EZWsAZdItbnFgpWXSMacmbAVnhr4G7OXPVWWe2JHcA9IXNuA1hjjo9a24/lZn6Eg+qn
	 eXXwn36gzC67q0QCOtyaO5fFGSea67Ekqul7g13OQLxGhi/PGNc+VQI8Dmxv7yYMyk7f/bOvMjV4
	 dsHS4oZI5MIG1jBqhqkVy8HTEBcgzqUmu73rySwiEt91yvqeGNc0pF8EMLCmSsjCCoL/9t4pPypa
	 oTPjX940bVhbpbn1MJiBGuvPMGxCpLXU+072CUNtJP03/8XQaMSUt6Pcd/vDR3ImtCH1pWVt48Tq
	 ifaP433x+0LrfB6vbUXS0go/SkUv0Y7hhKQJVICImgUvtpRmMG4oGGtnCMsjHYiu+NWyPBYY0B/u
	 CtfSESzbcRxYbh031/bc0f94cBem7xqfZFFK4F+B1VuIdR29vaOvjwbkZWosdH2p8iAdxhdjRwwg
	 3rU41t8vV8oCGFjr6EBsSTG3z2n0ChRkWnPRhOW58/ZcZv4I1EA/GXSuEIO2YurHwU5qNpEwU04w
	 9DkQPEGBhwlrgHiZ464ePT412iYVWdBS/KdA7Hdz+zaJaQ9JB8Gzsj2FvTq/yh1HxlWeFXRluFao
	 oJRqZv8vevW4zzN6ywmLzwNVSAJ9ccswcI+PKh5OoAKq+bJo23Xns4uAkw5U4xsbQxbXXg4yE=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fuse: Block access to folio overlimit
Date: Sat, 23 Aug 2025 09:17:13 +0800
X-OQ-MSGID: <20250823011712.2621959-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com>
References: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syz reported a slab-out-of-bounds Write in fuse_dev_do_write.

Using the number of bytes alone as the termination condition in a loop
can prematurely exhaust the allocated memory if the incremented byte count
is less than PAGE_SIZE.

Add a loop termination condition to prevent overruns.

Fixes: 3568a9569326 ("fuse: support large folios for retrieves")
Reported-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
Tested-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..5150aa25e64b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1893,7 +1893,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num) {
+	while (num && ap->num_folios < num_pages) {
 		struct folio *folio;
 		unsigned int folio_offset;
 		unsigned int nr_bytes;
-- 
2.43.0


