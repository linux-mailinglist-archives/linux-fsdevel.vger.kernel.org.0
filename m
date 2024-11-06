Return-Path: <linux-fsdevel+bounces-33728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB99BE24F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651391F228FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A5F1DA31D;
	Wed,  6 Nov 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MObBbPf9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWmh/UVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0B1D9668;
	Wed,  6 Nov 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884956; cv=none; b=UdRxXBxIlrftePpsSwin0Z0Z1Fy+YtdVPY1yCBQUpj7gtmD+wp1W4ySjeHLO4jIMqgbWE0s77yBY9St5WJvi62tePUUXlCA8emErU4pVPaWQp9dBw8o8TW1r/s7lGTSMfLXbXodqvAKeysiSZ28JTpIj79NPi25F+Yp9nH0Jkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884956; c=relaxed/simple;
	bh=9dvyDZDuzFgzVdh1Sna0suVR+NmThMTgtfsCk+jg5HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRps1L8m/S3PIuemO3AsxHfy8/E008+BVosTOYTwO5juFAOooaLfvV07DpikfiGcokZv0Vx39QZiYE5IhKlqf4FHOkVkzEPBPJf/Cu4cEoEkVlRUr129pt5KH5HqKWyCDeIU+wSvhcRuyCZBlkp9nmOUswqWnnhNk+2PQGrfWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MObBbPf9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWmh/UVn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730884953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8oBmdWzEG5uKEf7eXEXq4AParcdRSRipW4U/BCZKfQ=;
	b=MObBbPf9pftiMail7/CM1jJESKDTea6PRR2e/LndqzfMa0RHFrsiPg88o/YrcuQqC6jBK8
	c7o4+L5WhkrAgLNl21sw40kJNI3RmF91754ZcRj3jUQ8T/8bmpVuY2cnTPcATZFoHImd7w
	C6x+nW/EgEMMENBC6OmeyFWlKdRfd0XtdOfXeTDowbSVyURRnWO3DjGR3xoNYRd4fi0/tI
	RoH/86Km33+LNy+nM4+e9mlRGkhtbrL46e8Cq1gldbXSskfdljxTKIdThhYuwXjVj7DOhK
	HbirB+po9XIYaH7NX1oenkRbkFtyAaIf2x3FpdC9rmxiRW+iDGaNhTefvv3qOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730884953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8oBmdWzEG5uKEf7eXEXq4AParcdRSRipW4U/BCZKfQ=;
	b=pWmh/UVnZtabwAb4lrcxkMNxl6uVJmgzXC9t/GFHd9v+Krx09n9kC5KHzm8kH6ZtTB571U
	RQ3Yl6N2YiRVOrBQ==
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fs/proc: do_task_stat: Fix ESP not readable during coredump
Date: Wed,  6 Nov 2024 10:22:15 +0100
Message-Id: <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
In-Reply-To: <cover.1730883229.git.namcao@linutronix.de>
References: <cover.1730883229.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
/proc/PID/stat") disabled stack pointer reading, because it is generally
dangerous to do so.

Commit fd7d56270b52 ("fs/proc: Report eip/esp in /prod/PID/stat for
coredumping") made an exception for coredumping thread, because for this
case it is safe.

The exception was later extended to all threads in a coredumping process by
commit cb8f381f1613 ("fs/proc/array.c: allow reporting eip/esp for all
coredumping threads").

The above two commits determine if a task is core dumping by checking the
PF_EXITING and PF_DUMPCORE flags.

However, commit 92307383082d ("coredump:  Don't perform any cleanups before
dumping core") moved coredump to happen earlier and before PF_EXITING is
set. Thus, the check of the PF_EXITING flag no longer works.

Instead, use task->signal->core_state to determine if coredump is
happening. This pointer is set at the beginning of coredump and is cleared
once coredump is done. Thus, while this pointer is not NULL, it is safe to
read ESP.

Fixes: 92307383082d ("coredump:  Don't perform any cleanups before dumping =
core")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/array.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 34a47fb0c57f..2f1dbfcf143d 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -489,25 +489,8 @@ static int do_task_stat(struct seq_file *m, struct pid=
_namespace *ns,
 	vsize =3D eip =3D esp =3D 0;
 	permitted =3D ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS | PTRACE_M=
ODE_NOAUDIT);
 	mm =3D get_task_mm(task);
-	if (mm) {
+	if (mm)
 		vsize =3D task_vsize(mm);
-		/*
-		 * esp and eip are intentionally zeroed out.  There is no
-		 * non-racy way to read them without freezing the task.
-		 * Programs that need reliable values can use ptrace(2).
-		 *
-		 * The only exception is if the task is core dumping because
-		 * a program is not able to use ptrace(2) in that case. It is
-		 * safe because the task has stopped executing permanently.
-		 */
-		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE))) {
-			if (try_get_task_stack(task)) {
-				eip =3D KSTK_EIP(task);
-				esp =3D KSTK_ESP(task);
-				put_task_stack(task);
-			}
-		}
-	}
=20
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
@@ -534,6 +517,23 @@ static int do_task_stat(struct seq_file *m, struct pid=
_namespace *ns,
 		ppid =3D task_tgid_nr_ns(task->real_parent, ns);
 		pgid =3D task_pgrp_nr_ns(task, ns);
=20
+		/*
+		 * esp and eip are intentionally zeroed out.  There is no
+		 * non-racy way to read them without freezing the task.
+		 * Programs that need reliable values can use ptrace(2).
+		 *
+		 * The only exception is if the task is core dumping because
+		 * a program is not able to use ptrace(2) in that case. It is
+		 * safe because the task has stopped executing permanently.
+		 */
+		if (permitted && task->signal->core_state) {
+			if (try_get_task_stack(task)) {
+				eip =3D KSTK_EIP(task);
+				esp =3D KSTK_ESP(task);
+				put_task_stack(task);
+			}
+		}
+
 		unlock_task_sighand(task, &flags);
 	}
=20
--=20
2.39.5


