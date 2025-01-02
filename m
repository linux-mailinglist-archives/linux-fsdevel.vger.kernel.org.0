Return-Path: <linux-fsdevel+bounces-38317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743839FF6D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 09:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDF73A28AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6EB194C61;
	Thu,  2 Jan 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBKxo+9k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8/6kxGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9A13CF82;
	Thu,  2 Jan 2025 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735806194; cv=none; b=jBwEUsEAGr0rTOdhKjnxLHabNRAL2WXDafV756TrPOrKwmAAddKFCz1QBJcsudIPkfFAOEUVA6SleEFB/IN58UxYOAOUlnaMVKiWz9dshAOlCZdIPp+USK1BrczHcSCkQLajbs9UuNE9Sa/JwZo1aiW8cYH1cSOb6mHmcaqQmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735806194; c=relaxed/simple;
	bh=TExUURZWJ583E2vNDs7uiTcwesEW6Z4FXqiuzGwNkfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRKdjkz5cl3vCMffPI0VozUpnv1gBJcwRHU4mVSNfGO0iHi+ieau66GHO4YXj4QsDynDZ1qnCH3OmmCtAETZ2PEudRWKvjNmW/0sxg7PcW/7ZsyxleknWOIkE/R+p8+u1X02wJ2y4nE6p2y9Ki5DF239q6lO47zFgBMYJUv9By4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBKxo+9k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E8/6kxGg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735806190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIALOsxl/ryHqgD9kCZxM3tkMNvYUyPEPhH91OwzRvE=;
	b=uBKxo+9k91cmQBpbDQCDJM4uh/sIt+vw45BkJKB6/rCBzciqg6AyUxDGmNh+zPMaFZ4yOR
	wE2ln6eMc68svUVxeqeNmeVV5rnJt72A7SVdoLMjkcftF59o58i5KQEDnAZpij6k9GoGo2
	E8vb0CSkMVlnnWuLGM7FvyZF1hSCZ2QlYXvtsZS8ekOY+w2BcyiYbt7BT6P+HuLgl8Oj5e
	n4ONmxFlVBk/olSJF60qSvG2Te6XMRRem9Z264c4lskdJR0obpTykFuMZ/mhXIKE+ahDWi
	spKmf0qY7mlamRZvWV/zY6bz3SC4AOQ0phhrtrsbnQkzxpyFTF9q/ym84DViRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735806190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIALOsxl/ryHqgD9kCZxM3tkMNvYUyPEPhH91OwzRvE=;
	b=E8/6kxGgdLkvuQ+D8S4oXpAcJvfUfdTw/jIIMLR7I4Qbop6BuMMZZ6i/iqcPL1cb+at8hi
	gVnDAEUrDlK0G2BQ==
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
Subject: [PATCH v3 1/2] fs/proc: do_task_stat: Fix ESP not readable during coredump
Date: Thu,  2 Jan 2025 09:22:56 +0100
Message-Id: <d89af63d478d6c64cc46a01420b46fd6eb147d6f.1735805772.git.namcao@linutronix.de>
In-Reply-To: <cover.1735805772.git.namcao@linutronix.de>
References: <cover.1735805772.git.namcao@linutronix.de>
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
Acked-by: Kees Cook <kees@kernel.org>
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


