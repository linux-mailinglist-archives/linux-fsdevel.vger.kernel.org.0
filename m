Return-Path: <linux-fsdevel+bounces-78491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDMTGp1RoGnriAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:58:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE861A71DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388BE317AE82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6C396D2A;
	Thu, 26 Feb 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8X1lQuf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1F3246EB;
	Thu, 26 Feb 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113870; cv=none; b=ctcRbmVxiIKvvLbrtDeLkZlGaDw5WsXUyaIKsFxQOiz7XpQs2YLFg4u1tu2boQ0T1khc0x8EJPQVo0JVurWDa7bUknYWaJHy2BxYe2f9j8EZCtqcGp05h6uP7WQ8daI7aXTSJ5QttLBWDGsDIF0QvqFU1L1dQKE1PpZjhscg0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113870; c=relaxed/simple;
	bh=V6IJBd7br9ZXr2ywz4D2JlGXakfOQjwONRm7+MR7rAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y9ReOb0IGeljGVer550rgoEWUktaJxY+ny9HeussJMxEPH4ilq1myBv8g8UzrhQE8DESIz2KbM6D5jrF6Lg2UxxBeWSTSKHCNnIOfJEHBlOhIeQAAT4zvvyGUg6DzfH+zDCiZMlz593xxCPhqtTxTqNOfKfeDXTuXv8/V+XLqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8X1lQuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D80FC116C6;
	Thu, 26 Feb 2026 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113870;
	bh=V6IJBd7br9ZXr2ywz4D2JlGXakfOQjwONRm7+MR7rAs=;
	h=From:Subject:Date:To:Cc:From;
	b=h8X1lQufFk3tZdPqosRC0lzrdAABxcLlX/frgQbHcZc8y56fN3pRjIBEBWrKMxTJe
	 DQ4oR9yZOeQwWnRGqdoL8NPlj5pRz86VbN3SYdukd8YJctRaR3tdVzR86NGlhjgzVo
	 TwTfxU+3fQ8MVCFfca+2hiFIYn8z18THPXccndHUP0uiCtpJIxNI22vMAPqvqoKhRC
	 FvUyO66jx5IDEIohdyLT9uXO3D2kxVl0zF1RhNUZ4Ev8H1O8od8OTlmjdYk0XpprNH
	 JvY7chow5w78WXv08RXtFbA3xcZRtPzAidG4PYyzo2ansVKjRajV1S1jq9QSACEglK
	 i1QmKBKnHCrQQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v5 0/6] pidfd: add CLONE_AUTOREAP, CLONE_NNP, and
 CLONE_PIDFD_AUTOKILL
Date: Thu, 26 Feb 2026 14:50:58 +0100
Message-Id: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJPoGkC/23OQWrDMBAF0KsErTthpFFkp6veI3ShyONYpNhml
 CgtwXevFAik1MsP89+fu0oskZN639yVcI4pTmMJu7eNCoMfTwyxK1kZNA6NtnCb5Axz7PoE/nq
 ZhP0MxOyaho1F36rSnIX7+P1QD58lH31iOIofw1Ct3GwRJOh6OsRUkJ/Hfta18Jxyq1NZAwI76
 p0jxLY3H2eWkb+2k5xU3cr0ijTrCBWEyFukYFBr/Q+xL4ihdcTWT2hPAduA++4vsizLL/Lhvyt
 cAQAA
X-Change-ID: 20260214-work-pidfs-autoreap-3ee677e240a8
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=6520; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V6IJBd7br9ZXr2ywz4D2JlGXakfOQjwONRm7+MR7rAs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8D/9IHl71q9jbgx/nsyZYrRitnzyyZjHMUe3LQmc6
 vnUaN/PiR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATcfnN8D9Auk+hqaj6RHKs
 RWXFLO+FhnIxeV7SlxXPrj9cdE7HkYXhfxxXfOIKIcM6qzSWOvm5m6s2ZTHsmpJvOa24VZXtyvK
 jXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78491-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: CEE861A71DF
X-Rspamd-Action: no action

Add three new clone3() flags for pidfd-based process lifecycle
management.

=== CLONE_AUTOREAP ===

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
When the child exits do_notify_parent() checks this flag and causes
exit_notify() to transition the task directly to EXIT_DEAD. Since the
flag lives on the child it survives reparenting: if the original parent
exits and the child is reparented to a subreaper or init the child still
auto-reaps when it eventually exits. This is cleaner than forcing the
subreaper to get SIGCHLD and then reaping it. If the parent doesn't care
the subreaper won't care. If there's a subreaper that would care it
would be easy enough to add a prctl() that either just turns back on
SIGCHLD and turns off auto-reaping or a prctl() that just notifies the
subreaper whenever a child is reparented to it.

CLONE_AUTOREAP can be combined with CLONE_PIDFD to allow the parent to
monitor the child's exit via poll() and retrieve exit status via
PIDFD_GET_INFO. Without CLONE_PIDFD it provides a fire-and-forget
pattern. No exit signal is delivered so exit_signal must be zero.
CLONE_THREAD and CLONE_PARENT are rejected: CLONE_THREAD because
autoreap is a process-level property, and CLONE_PARENT because an
autoreap child reparented via CLONE_PARENT could become an invisible
zombie under a parent that never calls wait().

The flag is not inherited by the autoreap process's own children. Each
child that should be autoreaped must be explicitly created with
CLONE_AUTOREAP.

=== CLONE_NNP ===

CLONE_NNP sets no_new_privs on the child at clone time. Unlike
prctl(PR_SET_NO_NEW_PRIVS) which a process sets on itself, CLONE_NNP
allows the parent to impose no_new_privs on the child at creation
without affecting the parent's own privileges. CLONE_THREAD is rejected
because threads share credentials. CLONE_NNP is useful on its own for
any spawn-and-sandbox pattern but was specifically introduced to enable
unprivileged usage of CLONE_PIDFD_AUTOKILL.

=== CLONE_PIDFD_AUTOKILL ===

This flag ties a child's lifetime to the pidfd returned from clone3().
When the last reference to the struct file created by clone3() is closed
the kernel sends SIGKILL to the child. A pidfd obtained via pidfd_open()
for the same process does not keep the child alive and does not trigger
autokill - only the specific struct file from clone3() has this
property. This is useful for container runtimes, service managers, and
sandboxed subprocess execution - any scenario where the child must die
if the parent crashes or abandons the pidfd or just wants a throwaway
helper process.

CLONE_PIDFD_AUTOKILL requires both CLONE_PIDFD and CLONE_AUTOREAP. It
requires CLONE_PIDFD because the whole point is tying the child's
lifetime to the pidfd. It requires CLONE_AUTOREAP because a killed child
with no one to reap it would become a zombie - the primary use case is
the parent crashing or abandoning the pidfd so no one is around to call
waitpid(). CLONE_THREAD is rejected because autokill targets a process
not a thread.

If CLONE_NNP is specified together with CLONE_PIDFD_AUTOKILL an
unprivileged user may spawn a process that is autokilled. The child
cannot escalate privileges via setuid/setgid exec after being spawned.
If CLONE_PIDFD_AUTOKILL is specified without CLONE_NNP the caller must
have have CAP_SYS_ADMIN in its user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v5:
- Split no_new_privs into separate CLONE_NNP flag instead of having
  CLONE_PIDFD_AUTOKILL implicitly set it.
- CLONE_PIDFD_AUTOKILL now requires either CLONE_NNP or CAP_SYS_ADMIN.
- Link to v4: https://patch.msgid.link/20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org

Changes in v4:
- Set no_new_privs on child when CLONE_PIDFD_AUTOKILL is used. This
  prevents the child from escalating privileges via setuid/setgid exec
  and eliminates the need for magical resets during credential changes.
  The parent retains full privileges.
- Replace autokill_pidfd pointer with PIDFD_AUTOKILL file flag checked
  in pidfs_file_release(). This eliminates the need for pointer
  comparison, stale pointer concerns, and WRITE_ONCE/READ_ONCE pairing
  (Oleg, Jann).
- Reject CLONE_AUTOREAP | CLONE_PARENT to prevent a CLONE_AUTOREAP
  child from creating silent zombies via clone(CLONE_PARENT) (Oleg).
- Link to v3: https://patch.msgid.link/20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org

Changes in v2:
- Add CLONE_PIDFD_AUTOKILL flag
- Decouple CLONE_AUTOREAP from CLONE_PIDFD: the autoreap mechanism has
  no dependency on pidfds. This allows fire-and-forget patterns where
  the parent does not need exit status.
- Link to v1: https://patch.msgid.link/20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org

---
Christian Brauner (6):
      clone: add CLONE_AUTOREAP
      clone: add CLONE_NNP
      pidfd: add CLONE_PIDFD_AUTOKILL
      selftests/pidfd: add CLONE_AUTOREAP tests
      selftests/pidfd: add CLONE_NNP tests
      selftests/pidfd: add CLONE_PIDFD_AUTOKILL tests

 fs/pidfs.c                                         |  38 +-
 include/linux/sched/signal.h                       |   1 +
 include/uapi/linux/pidfd.h                         |   1 +
 include/uapi/linux/sched.h                         |   3 +
 kernel/fork.c                                      |  49 +-
 kernel/ptrace.c                                    |   3 +-
 kernel/signal.c                                    |   4 +
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 900 +++++++++++++++++++++
 10 files changed, 991 insertions(+), 11 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260214-work-pidfs-autoreap-3ee677e240a8


