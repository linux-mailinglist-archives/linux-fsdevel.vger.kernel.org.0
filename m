Return-Path: <linux-fsdevel+bounces-77424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMgRNoHtlGnUIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:36:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21C15189A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 084253046695
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA6313E39;
	Tue, 17 Feb 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryoX3JVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B8381C4;
	Tue, 17 Feb 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367792; cv=none; b=lO2rjxz7ziZ5oNGs/+q8DkmhxvhElDteYCTeDl0dCG46yXtsBJ90B/PpYzS2pWi+F/blBXCxuK+6ZZrhZ4jPyY7Qegk9bizI9kEPt+FUZo2ETVNPS0cpSotouk5jtwVjcsXg0BayfkjgeYke/obzTBXE3Xa5b5oOm5pPHd2Z8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367792; c=relaxed/simple;
	bh=alAAiRPjiZ5yT6o8q8RrKQMWmAr8kFPsUa73uvqi3oM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q+oFl7RSaDiUpyIW1cuurZ2ch+ImJ8P7v1sdZceUVLZ3v4OeJUYqsPOsdjKG/k0uv7y8sQqMETHoHKc15N6x0Rt+tWN5UUSaUjvHmr0ANoG0GY1vdlxsbOsPHR4SyiMofi50pHtfJ/db/Za3jENtpdHM6H6A5BxiZ9QyteAoRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryoX3JVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8056CC19421;
	Tue, 17 Feb 2026 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367792;
	bh=alAAiRPjiZ5yT6o8q8RrKQMWmAr8kFPsUa73uvqi3oM=;
	h=From:Subject:Date:To:Cc:From;
	b=ryoX3JVWM/goSfb0cUO/fn8eX/kLQ9onOsqOJYxAH+buyWqdRpwnJrnY3zJdJoSM5
	 QwKzI59dBYL1ugnXj56zR8qCfb07Qx/Ic+pmL1NS84qK0bXzGsnf2xfPdzMwOEWh0p
	 ySTPXq9skwe7aWbN1WCCkHN3T0uhu012U/D5UXYtHWM746EzCYdO6z1P/JOv0GCCGq
	 kdvDVHLaL6r1nEYtuKq+59qZKPmIbFHWR5/2N79y0iA4pfYIuNnkNIH9CLYIc5hmGv
	 qUsXXsOOkgqQXmK6b3wg04OvlbmaGx7/Rtfq5FTosj2yO0gzKWsjqOGgdwtXvqCgxs
	 SksvXOKaGBVpg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v3 0/4] pidfd: add CLONE_AUTOREAP and
 CLONE_PIDFD_AUTOKILL
Date: Tue, 17 Feb 2026 23:35:49 +0100
Message-Id: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXtlGkC/22Oy27CMBBFfwXNGiM/EjtmVQmJD2BbsRgnY2JBk
 2gMaSuUf6+JumQ3d6R77nlCJk6UYb95AtOcchqHEsx2A22Pw4VE6koGLbWVWlXie+SrmFIXs8D
 HfWTCSRgi6xzpSmIDpTkxxfSzUj/hdDzAuTwDZhKBcWj7F/AL8514553U3nrvGuvrzmM5UUVTO
 afqRrZdCKo2wZgXtk+5DP6urrNa4f9a9q3WrIQUZE201kjZRP1xJR7othv5AudlWf4AQi6BHf4
 AAAA=
X-Change-ID: 20260214-work-pidfs-autoreap-3ee677e240a8
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4472; i=brauner@kernel.org;
 h=from:subject:message-id; bh=alAAiRPjiZ5yT6o8q8RrKQMWmAr8kFPsUa73uvqi3oM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROeZvr4s/DW14XsClq0UdRub83kn5O+L9uTuSKD4FTZ
 +++vT1EpqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAib2MYGdbpTj61dH7AvwQt
 6YKanVZBXXfKdwc69HoxlxuuX7nhSgPDP/OyQwaFBsc3xf6rmdOWPt2o2qh7QuZP9u7tk4qUn7C
 KcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77424-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5A21C15189A
X-Rspamd-Action: no action

Add two new clone3() flags for pidfd-based process lifecycle management.

CLONE_AUTOREAP makes a child process auto-reap on exit without ever
becoming a zombie. This is a per-process property in contrast to the
existing auto-reap mechanism via SA_NOCLDWAIT or SIG_IGN for SIGCHLD
which applies to all children of a given parent.

Currently the only way to automatically reap children is to set
SA_NOCLDWAIT or SIG_IGN on SIGCHLD. This is a parent-scoped property
affecting all children which makes it unsuitable for libraries or
applications that need selective auto-reaping of specific children while
still being able to wait() on others.

CLONE_AUTOREAP stores an autoreap flag in the child's signal_struct.
When the child exits do_notify_parent() checks this flag and returns
autoreap=true causing exit_notify() to transition the task directly to
EXIT_DEAD. Since the flag lives on the child it survives reparenting: if
the original parent exits and the child is reparented to a subreaper or
init the child still auto-reaps when it eventually exits. This is
cleaner then forcing the subreaper to get SIGCHLD and then reaping it.
If the parent doesn't care the subreaper won't care. If there's a
subreaper that would care it would be easy enough to add a prctl() that
either just turns back on SIGCHLD and turns of auto-reaping or a prctl()
that just notifies the subreaper whenever a child is reparented to it.

CLONE_AUTOREAP can be combined with CLONE_PIDFD to allow the parent to
monitor the child's exit via poll() and retrieve exit status via
PIDFD_GET_INFO. Without CLONE_PIDFD it provides a fire-and-forget
pattern. No exit signal is delivered so exit_signal must be zero.

The flag is not inherited by the autoreap process's own children. Each
child that should be autoreaped must be explicitly created with
CLONE_AUTOREAP.

CLONE_PIDFD_AUTOKILL ties a child's lifetime to the pidfd returned from
clone3(). When the last reference to the struct file created by clone3()
is closed the kernel sends SIGKILL to the child. A pidfd obtained via
pidfd_open() for the same process does not keep the child alive and does
not trigger autokill - only the specific struct file from clone3() has
this property. This is useful for container runtimes, service managers,
and sandboxed subprocess execution - any scenario where the child must
die if the parent crashes or abandons the pidfd.

CLONE_PIDFD_AUTOKILL requires both CLONE_PIDFD and CLONE_AUTOREAP. It
requires CLONE_PIDFD because the whole point is tying the child's
lifetime to the pidfd. It requires CLONE_AUTOREAP because a killed child
with no one to reap it would become a zombie - the primary use case is
the parent crashing or abandoning the pidfd so no one is around to call
waitpid().

The clone3 pidfd is identified by storing a pointer to the struct file in
signal_struct.autokill_pidfd. The pidfs .release handler compares the
file being closed against this pointer and sends SIGKILL only on match.
dup()/fork() share the same struct file so they extend the child's
lifetime until the last reference drops.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Add CLONE_PIDFD_AUTOKILL flag
- Decouple CLONE_AUTOREAP from CLONE_PIDFD: the autoreap mechanism has
  no dependency on pidfds. This allows fire-and-forget patterns where
  the parent does not need exit status.
- Link to v1: https://patch.msgid.link/20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org

---
Christian Brauner (4):
      clone: add CLONE_AUTOREAP
      pidfd: add CLONE_PIDFD_AUTOKILL
      selftests/pidfd: add CLONE_AUTOREAP tests
      selftests/pidfd: add CLONE_PIDFD_AUTOKILL tests

 fs/pidfs.c                                         |  16 +
 include/linux/sched/signal.h                       |   4 +
 include/uapi/linux/sched.h                         |   2 +
 kernel/fork.c                                      |  28 +-
 kernel/ptrace.c                                    |   3 +-
 kernel/signal.c                                    |   4 +
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 676 +++++++++++++++++++++
 9 files changed, 732 insertions(+), 4 deletions(-)
---
base-commit: 9702969978695d9a699a1f34771580cdbb153b33
change-id: 20260214-work-pidfs-autoreap-3ee677e240a8


