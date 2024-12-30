Return-Path: <linux-fsdevel+bounces-38270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95D9FE541
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A0318820CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF371A83F0;
	Mon, 30 Dec 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x5n90lJU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KrPWNORn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CD1A4E98;
	Mon, 30 Dec 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553867; cv=none; b=LDJ0duomFPxiAH5HacuM1UHD8KK9UfLz3AIuquWGtUjgq664CJLIc0EqMgKgg0ZWgR199yU1l7MyEBe2vL9fW9d2QYicD5YC7KQwFfQQ65WKXzsGMUFOzXwQSokKopBIiSkE46Ha/VOfUVJyqSS1zpCji31wpwEUNNhslXCcPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553867; c=relaxed/simple;
	bh=4H9ZJylduXRRHMfUpHNXIHs2g6rLm25TRnG8qCBOPJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDlZJ3ztOoNb9MEGhMVSI6N6H8/dAL2ICFx50MFndAIVjaVwYeGXUI8sw59pwypnjUiuFf/HMra4+5BilQ7Zj1tcFwvRiz6n5vV1342uMIDpZLCQqtXvTAx7t8xyRLc1EAEuV130uY1b39M7T0jhC6WCgxMNNFqGT4sepPWPPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x5n90lJU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KrPWNORn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735553858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f33f+vOPEpbAy15Gy01JmFduHJivlt7mB+BP76lxhwA=;
	b=x5n90lJUpi7zlX37sfnKO93JI7uic/U2ACSUrvq0HHibPwiuhN7kiiezPK3bWfcc3XMugX
	EHe8F4P3cfJ3QOJBwKcwHPuN0NZGjnwXFcisg0iTpdDIp83cDSeCrW2nv+yosdroheX2xw
	xiI8uwI/KYPGeg4xKW7P8tZEVfd60rXwhYAggp04d12yDv1BNl1f6nzTCMGSnY3cscb2BC
	G+IX/Uys83YQEFvwAyekenQkh6ePQgJZ9RqONEh6FbKBTUGyUBIFBy0GfV5qiQMlyaxr9Y
	nChopJ0flNqrwna4W80fG/jpRYz1ItQlSItBR0ilZa4CjdFPahZL/PtfQVgM+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735553858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f33f+vOPEpbAy15Gy01JmFduHJivlt7mB+BP76lxhwA=;
	b=KrPWNORnqZSwv7idAN02JwnvCU2/KBNd6fe4IjPlf0+M9X/Ee1jf0zb+PQ8yixJY94Z5dS
	Z1T6NfFeEsGQFYAw==
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
Subject: [PATCH v2 1/2] fs/proc: do_task_stat: Fix ESP not readable during coredump
Date: Mon, 30 Dec 2024 11:17:30 +0100
Message-Id: <c2f1b742c2b8f230f8e0ffa10a061116934dcf5b.1735550994.git.namcao@linutronix.de>
In-Reply-To: <cover.1735550994.git.namcao@linutronix.de>
References: <cover.1735550994.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The field "eip" (instruction pointer) and "esp" (stack pointer) of a task
can be read from /proc/PID/stat. These fields can be interesting for
coredump.

However, these fields were disabled by commit 0a1eb2d474ed ("fs/proc: Stop
reporting eip and esp in /proc/PID/stat"), because it is generally unsafe
to do so. But it is safe for a coredumping process, and therefore
exceptions were made:

  - for a coredumping thread by commit fd7d56270b52 ("fs/proc: Report
    eip/esp in /prod/PID/stat for coredumping").

  - for all other threads in a coredumping process by commit cb8f381f1613
    ("fs/proc/array.c: allow reporting eip/esp for all coredumping
    threads").

The above two commits check the PF_DUMPCORE flag to determine a coredump th=
read
and the PF_EXITING flag for the other threads.

Unfortunately, commit 92307383082d ("coredump:  Don't perform any cleanups
before dumping core") moved coredump to happen earlier and before PF_EXITIN=
G is
set. Thus, checking PF_EXITING is no longer the correct way to determine
threads in a coredumping process.

Instead of PF_EXITING, use PF_POSTCOREDUMP to determine the other threads.

Checking of PF_EXITING was added for coredumping, so it probably can now be
removed. But it doesn't hurt to keep.

Fixes: 92307383082d ("coredump:  Don't perform any cleanups before dumping =
core")
Cc: stable@vger.kernel.org
Cc: Eric W. Biederman <ebiederm@xmission.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 55ed3510d2bb..d6a0369caa93 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -500,7 +500,7 @@ static int do_task_stat(struct seq_file *m, struct pid_=
namespace *ns,
 		 * a program is not able to use ptrace(2) in that case. It is
 		 * safe because the task has stopped executing permanently.
 		 */
-		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE))) {
+		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE|PF_POSTCOREDUMP)=
)) {
 			if (try_get_task_stack(task)) {
 				eip =3D KSTK_EIP(task);
 				esp =3D KSTK_ESP(task);
--=20
2.39.5


