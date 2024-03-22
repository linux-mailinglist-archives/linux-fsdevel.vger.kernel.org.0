Return-Path: <linux-fsdevel+bounces-15110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69E18870D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901352868E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8C59147;
	Fri, 22 Mar 2024 16:28:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6C5674E;
	Fri, 22 Mar 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124905; cv=none; b=L+h1BtTih1G3mWydMe0dtg0HFDuRiDTpZPEbyIftFGRf+btUWNqYam4hfDQhKrkhBH6wU26nQKQh5Yzn5DjtrnnNUhJZrDIBIPnfoCRldbHQXiHNSYC4pZA3sKTskEYZTJHJSCFk8CZ8gtRQ+/EWXHQF4/tv6Nf9ZDg27hDghQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124905; c=relaxed/simple;
	bh=lRVx4ECF5hJdd5NdS5SDeG9HLw77wx4Jl92htBH1/iY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rn7WxdXTvYhM9a3Yai+9cSfKKYRrPxt0BKWxraInIPsIPEARhxVHA4N5SHHEJmz1a0EAe+Yu9j3Lv2SrZvKve1jlE7+3KDASSkky65YuufqeAt7brAM2ub24qwS2vkMsq94XljrT83IBIf6wJc/lGNf5xvbzNO7xtvJstBaSnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DC7EFEC;
	Fri, 22 Mar 2024 09:28:56 -0700 (PDT)
Received: from PF4Q20KV.arm.com (PF4Q20KV.arm.com [10.1.26.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2D2B3F762;
	Fri, 22 Mar 2024 09:28:19 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>,
	Al Grant <al.grant@arm.com>,
	James Clark <james.clark@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] exec: Don't disable perf events for setuid root executables
Date: Fri, 22 Mar 2024 16:27:59 +0000
Message-Id: <20240322162759.714141-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Al Grant reported that the 'perf record' command terminates abnormally
after setting the setuid bit for the executable. To reproduce this
issue, an additional condition is the binary file is owned by the root
user but is running under a non-privileged user. The logs below provide
details:

    $ sudo chmod u+s perf
    $ ls -l perf
    -rwsr-xr-x 1 root root 13147600 Mar 17 14:56 perf
    $ ./perf record -e cycles -- uname
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.003 MB perf.data (7 samples) ]
    Terminated

Comparatively, the same command can succeed if the setuid bit is cleared
for the perf executable:

    $ sudo chmod u-s perf
    $ ls -l perf
    -rwxr-xr-x 1 root root 13147600 Mar 17 14:56 perf
    $ ./perf record -e cycles -- uname
    Linux
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.003 MB perf.data (13 samples) ]

After setting the setuid bit, the problem arises when begin_new_exec()
disables the perf events upon detecting that a regular user is executing
a setuid binary, which notifies the perf process. Consequently, the perf
tool in user space exits from polling and sends a SIGTERM signal to kill
child processes and itself. This explains why we observe the tool being
'Terminated'.

With the setuid bit a non-privileged user can obtain the same
permissions as the executable's owner. If the owner has the privileged
permission for accessing perf events, the kernel should keep enabling
perf events. For this reason, this patch adds a condition checking for
perfmon_capable() to not disabling perf events when the user has
privileged permission yet.

Note the begin_new_exec() function only checks permission for the
per-thread mode in a perf session. This is why we don't need to add any
extra checking for the global knob 'perf_event_paranoid', as it always
grants permission for per-thread performance monitoring for unprivileged
users (see Documentation/admin-guide/perf-security.rst).

Signed-off-by: Leo Yan <leo.yan@arm.com>
Cc: Al Grant <al.grant@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 fs/exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index ff6f26671cfc..5ded01190278 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1401,7 +1401,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * wait until new credentials are committed
 	 * by commit_creds() above
 	 */
-	if (get_dumpable(me->mm) != SUID_DUMP_USER)
+	if ((get_dumpable(me->mm) != SUID_DUMP_USER) &&
+	    !perfmon_capable())
 		perf_event_exit_task(me);
 	/*
 	 * cred_guard_mutex must be held at least to this point to prevent
-- 
2.39.2


