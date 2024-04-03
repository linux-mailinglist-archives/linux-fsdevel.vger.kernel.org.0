Return-Path: <linux-fsdevel+bounces-15974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35C8964FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A316B21243
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12CC5339E;
	Wed,  3 Apr 2024 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ww5v858u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071EF1757A;
	Wed,  3 Apr 2024 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127264; cv=none; b=olv1vYwV9HItiIAN2bQcgghp3nNfHTs5GtvDOlqX/QN2VveNwCJOXFNR1bDedJUx6VPXvF42WG2cBFKNQ7YIrugpKYWcoPYc2DB4Ry9xu9zKAKvF4y20iwa5ok7zTxtoXgN5hv69wen8RTfzEPNo3fTk/J/aja+/Fy99JHpJxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127264; c=relaxed/simple;
	bh=QbYk7mkbWCkqiAPyu00RQYNoFA+Z6ycbz2v55PnVMiI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BN0AlH8o/oMPehz4hlJaQsd5QdbzxJbTwMfX29qVwCgwE8lP31yjYoSZnse5TrDWGy0x641C3JdYzF+MKSMpZxJr7WyarkWU9TLuKmewbaWJwioAlCzNU6BywyI6bJCKk26KxyyguiQgsCJJy6Awowc+vVgZBMuAymkqyQTAtck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ww5v858u; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712127257; bh=wO+LSoJgGLH+WEilHLpBJL664dA/mQelv4HBiD7UnlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ww5v858uCwq1w5zdK55rhVxHczIbATC9FsYF/tgwRNlrL3vbDkusJHkunKqZUsCbS
	 Ita/esfj8fQoZTLxVcvIXblHaQsSnZ0F0w+ZDnpVs0FQ4B2wXlipMICPvsXCpGGIRZ
	 NLM5XmX4n1f5T2e+2FasGXZXHQ/hL+N/aFONa9qY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id D8D0E6B2; Wed, 03 Apr 2024 14:54:13 +0800
X-QQ-mid: xmsmtpt1712127253txeonps73
Message-ID: <tencent_A7845DD769577306D813742365E976E3A205@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90w12+nNA4lBxOmIdpSsE/HWlu6fSC76OnRo3mC7x1xVBJ6vgHm5t
	 LXX3DGeGvGv4D2FwSa6lO3Gpi8YBxx0Lrh0g5rbFivooSczFJHG50VzdqyFq0ibqKaWaa3M2Z0nL
	 hd21UYuZYqyQ9jxc4I1VVHuj1nM5Y5Ad+whhHfjaLDpUdYwqT9Km2SR5GAdWvF/rgP4YcmtOitjt
	 5J0DsVi8M/as00lbqj9w+x74Uzk/MwNJEBIpmfmexx10OiI8rQAWRamiJZf1RIeubMtWj2ZiOhn+
	 bpPF0Qt9UQf2h3C28M34880QFbNR7SbhJIDjUH/TYP5STa6CAo3GNYpMGL08zXI58jwLHVUj7EyM
	 rua8AsKW05KnEr6b2l6foUGH6KXjN/kjyOZM8jX2SwDAAfR799LZ0r+ONyWTrWICmXECwVgSBMng
	 gMJWA8fWsMM4cEDm/ClA/8Xl+UszHmF+E3Gr4hIiVCsS6YE309SYmDFPH8V+2fkbaYsQwgVri4ra
	 Obd1tQotfYLIoCMD/1KFveY2xClwhxi0xyTUmDbucEjx91cgX9WSt+/6qPtUXVBWDLeW0u0fwFiU
	 EdM6vTPY0HAadz+L9i8cQaAhKcJ0zRx7iayDzVNfbDAEaHJXwZdySPFJnI+fv2fiKqrgE3YBh+xC
	 ZD8I7lcShnGfhhAj6gGHXGz+GkBn0ywRhO5rdXpxaQ79A++l0Q7O8gODLb/tuwHinZH97x4gZnI1
	 c4eNL5tPFxSh1uc2to+mEJzqTQxBal2mcktEtyY3kmV9gUtfYyb+TrYfWgxCp0FPZxW7WNHk5eMo
	 eb3KJJjSpvqjgWkeRxsN3iG7zaC6zkAj09Jtuueje04/9mD/+PhMPUUaM9iNGKe+WHgNJDhuf8mV
	 n1Cw4oIXcGOSK0ByezdHjlrJlv4ry/5OPMyXXUIzuPWfm3xzDWJw9MhzPVfme9TkB6CPAVdx1v5O
	 siopw6vqQ=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH next] fs: fix oob in do_handle_open
Date: Wed,  3 Apr 2024 14:54:14 +0800
X-OQ-MSGID: <20240403065413.3307887-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000f075b9061520cbbe@google.com>
References: <000000000000f075b9061520cbbe@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
Write of size 48 at addr ffff88802b8cbc88 by task syz-executor333/5090

CPU: 0 PID: 5090 Comm: syz-executor333 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
 _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
 copy_from_user include/linux/uaccess.h:183 [inline]
 handle_to_path fs/fhandle.c:203 [inline]
 do_handle_open+0x204/0x660 fs/fhandle.c:226
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
[Fix] 
When copying data to f_handle, the length of the copied data should not include
the length of "struct file_handle".

Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 53ed54711cd2..8a7f86c2139a 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	*handle = f_handle;
 	if (copy_from_user(&handle->f_handle,
 			   &ufh->f_handle,
-			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
+			   f_handle.handle_bytes)) {
 		retval = -EFAULT;
 		goto out_handle;
 	}
-- 
2.43.0


