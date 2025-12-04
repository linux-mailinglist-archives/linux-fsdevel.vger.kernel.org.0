Return-Path: <linux-fsdevel+bounces-70664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D54CA3C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 14:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687E5304D84A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D06344020;
	Thu,  4 Dec 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FMVLyIZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CF343204;
	Thu,  4 Dec 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854194; cv=none; b=UICTCTAqEsA9UREhencZa1xF01jniLJRXRI2eU1CWjp6xKfHKiSp3xD1/AUP9eIr2wRXqZWZRSXpeAZIvlepRTeyMCu0HM4q7lrYa6GgCd3clBUfLe8R/a4HxonvCuTPZwkQN6hBRASRkZzxBvVEU7KDKPtvQ6OZNr4vw8oPBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854194; c=relaxed/simple;
	bh=4dV8/r3Bb0Y5qQ/7TNRC/7rDlYRTuvYkOTU1lMJg1uE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m17cbOIPeMXmJ2ei/K/xVegGuCI1mZiFNhTFHzvUi3R5oeZK5CxJ6mA1x02JyljKO4Eox7IwXgSeAVv9gR0myf+ct5u5II3l/n7tbQHFFuKJE1y9gLoAPsMjEIEF+2Px069gtEqqanyNJlOv+lYctvu0hIQ11jA1XMFOnE8BySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FMVLyIZ6; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764854184; bh=rkL+54XxdOgJvxot978PJbUQ/2cROymY9B50UxPZoiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMVLyIZ6BiHaZ2s72GE/K309Y0S135yoSVdLa9heQrcMHfjINuB8NpKpByLyFTuVx
	 kst7VNojUi11iitUVTxkSQ8Hbx9AI6qykNWOJFHN0tMIlg6FG7eesKrV4Zp4jWKyvF
	 F+DJR7c9/l9dTjpWklz4ECsG796dhU6IeNjc+JN4=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 415ACE38; Thu, 04 Dec 2025 21:16:21 +0800
X-QQ-mid: xmsmtpt1764854181tx7j7ssg7
Message-ID: <tencent_369728EA76ED36CD98793A6D942C956C4C0A@qq.com>
X-QQ-XMAILINFO: Mv0iqKHUGHx5SvxmX8PgRqdwdcUq8Wum/y2wiblUuSHgoGVXggMBVDOIn0edtf
	 Urdhl+jZkmWvDei0XMr4RHM6d4K0tQ/E5s63XvmRtU987W3zU8SDnAVZB4NXmRYvkvepzMEvyfVT
	 pAQAT0PZDiWfl8rcVxkiqLUvN3AcUvE8BQ3jEenQui06bk5eAZ9h9G+7vN7L+kMV7INl2i13a5ZX
	 04Fw/Ylb0WTEfMQViGexpi1cevLnplFjzPujF3gO8nAiWk4CWcjBZW24qNJDWBWzfBT6eKI0NKCa
	 SzpB+6ekFxxBC6EIlIM3FtvhZkn8XLmyMkdSx1N1szozBzO0exjhkR2GzSgmj5+TYmYz4GXIX3JE
	 91cu7XYNDy3HVeuaQvcZzqgCgZaotWoLnklph0AaACh98mbpSUM2TulBdOS5Oh9sCpeBO1eEkuJZ
	 YPTqO/TYQ/xmh15xt69Ar30PLHIZT7bnVbW9AbEFpv4TGSWTib6nlTBOQradRs8j1jg8Tyquk6u7
	 o8LZMrimlMiWGY57lciyPjyuH2iPzCG4FNR74DwLhRrECQgN2NhkUvsotOIyu5qhyqUSKRPzNU5P
	 6vGb5HL9waKZmkv+H3Pg0fdmDP3o4CdD009fbIVFLPM00LXK+kdkjHoJgDV7TUIO8JBwLFfr784H
	 hPu7nyV2WaeaT8mlMXTQGcGHsk8fU3DBcYJvwzxneXSwhJekolGr6Rl1HdtdPuvmF9wsBXEZ6f92
	 62BF6AK5dTG9CftYib8ILzAm3MfDCUT6IWJNf3r3pY1/r/NlEJFxKDCqH3YbKtEY0cT68xvQs/MF
	 QJhpU5fBG8EuoR6yaVgVbCj7vvp/8Ghcw8E147DEE1gvR5Fe74PaLYTEo2lZM+nwvUT4hO9JaJ6z
	 9jDk8zS/1VYn+EZKsRPuRHereMw1p0QtsvkhcpymR4QV9DPW2xXm7V6DS7c/MOCxbYaDvG8qZdss
	 8zk+RhAxz0m4+scqkiNOO5nOFBYC7jh1vzlaO3qI4InSZc/g5vML+HBt9UXeYx52ajHSu8LCq8Ky
	 TZwSrcwXL2Tbup8wc/
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] mqueue: correct the type of ro to int
Date: Thu,  4 Dec 2025 21:16:22 +0800
X-OQ-MSGID: <20251204131621.338676-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69315929.a70a0220.2ea503.00d8.GAE@google.com>
References: <69315929.a70a0220.2ea503.00d8.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ro variable, being of type bool, caused the -EROFS return value from
mnt_want_write() to be implicitly converted to 1. This prevented the file
from being correctly acquired, thus triggering the issue reported by
syzbot [1].

Changing the type of ro to int allows the system to correctly identify
the reason for the file open failure.

[1]
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
Call Trace:
 do_mq_open+0x5a0/0x770 ipc/mqueue.c:932
 __do_sys_mq_open ipc/mqueue.c:945 [inline]
 __se_sys_mq_open ipc/mqueue.c:938 [inline]
 __x64_sys_mq_open+0x16a/0x1c0 ipc/mqueue.c:938

Fixes: f2573685bd0c ("ipc: convert do_mq_open() to FD_ADD()")
Reported-by: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=40f42779048f7476e2e0
Tested-by: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 56e811f9e5fa..90664d26ec07 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -893,7 +893,7 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
 }
 
 static struct file *mqueue_file_open(struct filename *name,
-				     struct vfsmount *mnt, int oflag, bool ro,
+				     struct vfsmount *mnt, int oflag, int ro,
 				     umode_t mode, struct mq_attr *attr)
 {
 	struct dentry *dentry;
-- 
2.43.0


