Return-Path: <linux-fsdevel+bounces-13390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27E86F4CC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 13:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153F9281FAF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61E111B7;
	Sun,  3 Mar 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VIo9HtUj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F872111A4;
	Sun,  3 Mar 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468489; cv=none; b=ClyFoxwSxWlV0C7vnyFSyD0fy/cLodeevB7G4n7PPk3X2Ln/TYxHVkOcVnpQDzsLkv9RBO7ZdXHi0bRYojLSQshsZmwfFaiA8MtOu2OGFSVB9nRIrVCuvrBNHq1QNzaoDLqaJ3Jmdm38h0EawkVAO4WI43cvwB/l075vTSFse5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468489; c=relaxed/simple;
	bh=zwHRSE399zvO14wNCoVjD2Iw+mMHJViGTEUJcbdJnik=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ovw3PwFp515fRhZ1vVDK2j8O+3mBtkKNbmCRFIdApkJwBqLUbP5cPNQeJgiDwwzYKIXuJzG1Qu5r53DOwRMnopOY1VWHQ3V5mtlGQXi+0MKuYTP0V+TCnYUKogFn8496RdB74GfFxu74BG4Mo1/780RK9be7ADbXqoWGPpZI1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VIo9HtUj; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709468483; bh=CgOhE/dgm6I4NvX+ZRJHniVtwsR+cz4XQAYa5Q04GXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VIo9HtUjTt2SL3G60KSGA0CcI8eO0dXszUBceelOlP4/dLNXxnI+IyUdnSWcn7dxJ
	 hOVKto/t7GX3O6q7+icP8Z8SHPz6Tdw3rtDD/ZsQwlt9ybtAUf7aIA4k4nf42WPr4C
	 Ip+MYMHsusGbb61vyWj1O9tNhv/JZhNTu4qCT34s=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 54012E0D; Sun, 03 Mar 2024 20:21:00 +0800
X-QQ-mid: xmsmtpt1709468460t50or4z1m
Message-ID: <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UEwL1zQa/2t7K3v/lWcNbP/+of6Pr07iOWZgvklSOgghBMArXiS4
	 ZNScbdHzEdlndADc81nmIU73JFwuquPw9n9VOOj0T62/OwbVOGkFu1gGeafReejV87r8cM/+wkcU
	 c6+8dp5I9vFOgDKDaSjmCR7wN6UHBhF4FqaIBYhaVDpt0gp7MhBNq0EH67CVMwz0F7KyN1L/NLeb
	 9d7Kh1cMEhslvO09j8mcYV05ov7lQDj5bcCxiql0XpfOh58Ysq9k9H78Idxs19Bb8nFgGxjfT8m0
	 zzbk0fIKtLQIxsnar3NgOkm9L1zqAO/g4TTUUbBgZUEVVLJNcswqnJcVNYZ79V2bqL3fO5703zRY
	 o9HZFkOeSwDEK/+66pKf8Ty2Y1TlExBsFFH/cBkmJrh/14FM2mqNwC9ghpUZPkLvFnXpmSafEyu+
	 wFuygUAQ+7pqtYPv6PcZHlM8bPozmxQeireOb80IPPgTzQtncomRD7H4HqQWNQZL+e4AEJ+5I5B1
	 E3r1WR8v1EIvIwmA5HcDmzmr5X/Gv5/bVuKaFrOhPhkmsAJLNS2iZod35H3Z5ltYD+LIrDUIAFi1
	 IUI2fyyPj+j4VIihbj6YevNWLINXTuQl47nXwXumzKrACXZ1KE5A9LRALucTZeTMuPG6QsRPhaKT
	 sqJixTDwT5I3JC7pQBTK41+D/ovv+ove2ab758yzLxZedcl2IivD23KX//933zGgP1VkgfdP6Qp7
	 OcLOf8aXRvGaM0ifmy/SfpNKdialIAi6/ly4cn2u7tCcru849zTa41FAomTMp1PlCPchxVkWF+t9
	 8gB9dMmqdXTsEQfnpIYohn8Jw0A0wa7z/LSsHeKh8csTzoxcifyMXURxvbGLJGI8PwC9ynjOHqPb
	 yQ6u+WJii/nHjx6JLjwclHCrLdIHXKcWXshJ7Qvjs4tNt6D0Rictts5BAku2VonGESkfMC2kUhb7
	 8fUVjqntw=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Cc: bcrl@kvack.org,
	brauner@kernel.org,
	bvanassche@acm.org,
	jack@suse.cz,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] fs/aio: fix uaf in sys_io_cancel
Date: Sun,  3 Mar 2024 20:21:00 +0800
X-OQ-MSGID: <20240303122059.579229-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006945730612bc9173@google.com>
References: <0000000000006945730612bc9173@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aio poll work aio_poll_complete_work() need to be synchronized with syscall
io_cancel(). Otherwise, when poll work executes first, syscall may access the
released aio_kiocb object.

Fixes: 54cbc058d86b ("fs/aio: Make io_cancel() generate completions again")
Reported-and-tested-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/aio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 28223f511931..0fed22ed9eb8 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1762,9 +1762,8 @@ static void aio_poll_complete_work(struct work_struct *work)
 	} /* else, POLLFREE has freed the waitqueue, so we must complete */
 	list_del_init(&iocb->ki_list);
 	iocb->ki_res.res = mangle_poll(mask);
-	spin_unlock_irq(&ctx->ctx_lock);
-
 	iocb_put(iocb);
+	spin_unlock_irq(&ctx->ctx_lock);
 }
 
 /* assumes we are called with irqs disabled */
@@ -2198,7 +2197,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 			break;
 		}
 	}
-	spin_unlock_irq(&ctx->ctx_lock);
 
 	/*
 	 * The result argument is no longer used - the io_event is always
@@ -2206,6 +2204,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	 */
 	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
 		aio_complete_rw(&kiocb->rw, -EINTR);
+	spin_unlock_irq(&ctx->ctx_lock);
 
 	percpu_ref_put(&ctx->users);
 
-- 
2.43.0


