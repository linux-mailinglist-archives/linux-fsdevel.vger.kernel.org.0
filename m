Return-Path: <linux-fsdevel+bounces-52301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B296EAE1412
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 08:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B1D19E3998
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 06:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EC20766E;
	Fri, 20 Jun 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Fnu37Lfy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008330E844
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401515; cv=none; b=L1VUUL1RvIgbMEMZEecb6GzPbqsdJRzwMOAr5wbOjHvUQUja32kCJX8/plR8pUcw8c9ADfELp3rpY/vWr4Ra0QvFYKHVd48Kwt5euKw0WBYE6aCRH6UALiPO3wiBZL5cCPralv/H4gCsnnu+ZKmfRhVhLgNhQOc0YBxnKK2Cbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401515; c=relaxed/simple;
	bh=qp/jastW0t1lpq13DgO+P7USS9NFEVg+0Cnzg2FBloA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ga6C/1Y1v3MPSybf6Sa4823xIVopuSPxwUnK+AII1OnX5OSN3Atp59BmQKNCG3gzOLMV9LXUo12CoDBvq9hziPeR8BMBip8RIhWLH4mshDtem+JFfv4hgMAx/nLLali56pnXHGgED1XNSXDR4LLY9+5rxIN+0k6Q9v2hCrOm6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Fnu37Lfy; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id 97ED06489D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 09:31:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2db2:0:640:9334:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 68A5460ABD;
	Fri, 20 Jun 2025 09:31:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1VI3TRLLaKo0-XEGojijR;
	Fri, 20 Jun 2025 09:31:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1750401061; bh=lo73tL8VzriiDZPuOirxODiAHfeZPvPGU+tSk7f8x2A=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Fnu37LfykWe/YpfYDzmo1AFYtr9BpYoZEg9aWlsxv9CDtybfM+NJ94AxeuYNDfBfH
	 u//lK9GcCBSVblCV/T9Mq0/1h6Q+iOAEbKD6lGL7GbkPYjziU9HDMbDObSpaoSRRoR
	 B8Jzw4VJ+FIS8yIBAavPtnfFvUf5gbkU/b5BYA2I=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] fs: annotate suspected data race between poll_schedule_timeout() and pollwake()
Date: Fri, 20 Jun 2025 09:30:59 +0300
Message-ID: <20250620063059.1800689-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running almost any select()/poll() workload intense enough,
KCSAN is likely to report data races around using 'triggered' flag
of 'struct poll_wqueues'. For example, running 'find /' on a tty
console may trigger the following:

BUG: KCSAN: data-race in poll_schedule_timeout / pollwake

write to 0xffffc900030cfb90 of 4 bytes by task 97 on cpu 5:
 pollwake+0xd1/0x130
 __wake_up_common_lock+0x7f/0xd0
 n_tty_receive_buf_common+0x776/0xc30
 n_tty_receive_buf2+0x3d/0x60
 tty_ldisc_receive_buf+0x6b/0x100
 tty_port_default_receive_buf+0x63/0xa0
 flush_to_ldisc+0x169/0x3c0
 process_scheduled_works+0x6fe/0xf40
 worker_thread+0x53b/0x7b0
 kthread+0x4f8/0x590
 ret_from_fork+0x28c/0x450
 ret_from_fork_asm+0x1a/0x30

read to 0xffffc900030cfb90 of 4 bytes by task 5802 on cpu 4:
 poll_schedule_timeout+0x96/0x160
 do_sys_poll+0x966/0xb30
 __se_sys_ppoll+0x1c3/0x210
 __x64_sys_ppoll+0x71/0x90
 x64_sys_call+0x3079/0x32b0
 do_syscall_64+0xfa/0x3b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

According to Jan, "there's no practical issue here because it is hard
to imagine how the compiler could compile the above code using some
intermediate values stored into 'triggered' or multiple fetches from
'triggered'". Nevertheless, silence KCSAN by using WRITE_ONCE() in
__pollwake() and READ_ONCE() in poll_schedule_timeout(), respectively.

Link: https://lore.kernel.org/linux-fsdevel/bwx72orsztfjx6aoftzzkl7wle3hi4syvusuwc7x36nw6t235e@bjwrosehblty
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 9fb650d03d52..082cf60c7e23 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -192,7 +192,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 	 * and is paired with smp_store_mb() in poll_schedule_timeout.
 	 */
 	smp_wmb();
-	pwq->triggered = 1;
+	WRITE_ONCE(pwq->triggered, 1);
 
 	/*
 	 * Perform the default wake up operation using a dummy
@@ -237,7 +237,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 	int rc = -EINTR;
 
 	set_current_state(state);
-	if (!pwq->triggered)
+	if (!READ_ONCE(pwq->triggered))
 		rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
 	__set_current_state(TASK_RUNNING);
 
-- 
2.49.0


