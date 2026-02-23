Return-Path: <linux-fsdevel+bounces-77925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAYEL+MvnGkKAgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:45:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 217CE175156
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0853032F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFE835D604;
	Mon, 23 Feb 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm4DYcB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723635C18D;
	Mon, 23 Feb 2026 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843516; cv=none; b=pmP3XViPRonWhR+k8dYR0ZEdzVRwQ4tGI5U6t7zyDQwbgbimfIEJIkMKFwnXE3gcY9sEL5bt8RuIwGniYcR0c4I/oG9egfrPKQs7uxLFaYASviKGNgrv+FOpd8ce6B4q63vdks/C8TmW6jRb5dnDW163gNLegQErDQ+NbRLn5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843516; c=relaxed/simple;
	bh=+gtVG+GwbpotxLa71ZndFiBlb90NhCMwtdUsd5dr0mY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cjscw1aWV4+8OzcEUuiEeT6rQTRGBiaU1v0Cxh9oaIxbrRmeEwGbu4tlakIz5xNP1nzdxJvPSVLXpo6t/OJrWfAhUoUUrMrMHakRzGlEc1nQWbIXku7J1uebRcb4Y/oKK2lFOg1fO9Ud7Hv9D2i0kPDU3T1MRwBILf58nKcvI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm4DYcB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD869C116C6;
	Mon, 23 Feb 2026 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771843515;
	bh=+gtVG+GwbpotxLa71ZndFiBlb90NhCMwtdUsd5dr0mY=;
	h=From:Subject:Date:To:Cc:From;
	b=Hm4DYcB4byCA+EnXUemEhMKHpKFzhkuWuC05GVauAjPdOmsWF4UiQafZ8UDyhbunO
	 OCJo1I0RZgM1Q36B6otVmqwn0DEanHGA2BTlN9gfhzd+NWQNd+UEvKxban4quI/FDC
	 WLFsRyG3e3e+6KS75YwcqFA4qFvSBsEAWK9XIPrnroVYjIBsWdgBy6i/nL0hBY9kcS
	 Ikto6ER8dhuRm06uZaacv0RbPTMF6CQYjfmGN8gcIgi5og5QtpB04UOTa9+IT8gfLy
	 /roWEsigmzqQHkmyyF+TLLZPaqltGG9ipFi1T8dKbWuCPVVV/posp3nqalU1SlELGF
	 guGzhqzObtRxQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 0/4] pidfd: add CLONE_AUTOREAP and CLONE_PIDFD_AUTOKILL
Date: Mon, 23 Feb 2026 11:44:57 +0100
Message-Id: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkvnGkC/23NQQqDMBCF4auUrDsySSRKV71H6SLqqMGiMmnTF
 vHuTYRCCy4fzHz/IjyxIy9Oh0UwBefdNMaRHw+i7u3YEbgmbqFQGVQyh+fEA8yuaT3Yx31isjN
 oIlMUpHK0pYifM1PrXpt6ucZdWU9QsR3rPlmhyBC4lum0dz4i760fZHr4psxuKkhAIKNbYzRi2
 arzQDzSLZu4E6kV9C9S7CM6IlrbHHWtUEr5h6zr+gGKJHDpFwEAAA==
X-Change-ID: 20260214-work-pidfs-autoreap-3ee677e240a8
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5867; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+gtVG+GwbpotxLa71ZndFiBlb90NhCMwtdUsd5dr0mY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO0d+Z97A7tfBAbMJkw6VH+oTLjzNzSna+PVv1I1TGU
 NGoxH5ORykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESMuxkZvl7nbn3+/2toXWiu
 6dSNck/2zW5aenYxEwPrDtaW1JB1txkZFqjm22yrF82taT5qsu6gY/mrBj5bE7fkM2+LXx4LOK/
 CAgA=
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
	TAGGED_FROM(0.00)[bounces-77925-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 217CE175156
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
When the child exits do_notify_parent() checks this flag causes
exit_notify() to transition the task directly to EXIT_DEAD. Since the
flag lives on the child it survives reparenting: if the original parent
exits and the child is reparented to a subreaper or init the child still
auto-reaps when it eventually exits. This is cleaner then forcing the
subreaper to get SIGCHLD and then reaping it. If the parent doesn't care
the subreaper won't care. If there's a subreaper that would care it
would be easy enough to add a prctl() that either just turns back on
SIGCHLD and turns of auto-reaping or a prctl() that just notifies the
subreaper whenever a child is reparented to it.

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
die if the parent crashes or abandons the pidfd or just wants a
throwaway helper process.

CLONE_PIDFD_AUTOKILL requires both CLONE_PIDFD and CLONE_AUTOREAP. It
requires CLONE_PIDFD because the whole point is tying the child's
lifetime to the pidfd. It requires CLONE_AUTOREAP because a killed child
with no one to reap it would become a zombie - the primary use case is
the parent crashing or abandoning the pidfd so no one is around to call
waitpid().

CLONE_PIDFD_AUTOKILL automatically sets no_new_privs on the child
process. This ensures the child cannot escalate privileges beyond the
parent's credential level via setuid/setgid exec. Because the child can
never can more privileges than the parent the autokill SIGKILL is always
within the parent's authority. This avoids the pdeath_signal trap where
the kernel resets the property during secureexec and commit_creds()
making it useless for container runtimes and service managers that
deprivilege themselves. The no_new_privs restriction only affects the
child. The parent retains full privileges.

The clone3 pidfd is identified by the PIDFD_AUTOKILL file flag set on
the struct file at clone3() time. The pidfs .release handler checks this
flag and sends SIGKILL only when it is set. dup()/fork() share the same
struct file so they extend the child's lifetime until the last reference
drops.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
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
Christian Brauner (4):
      clone: add CLONE_AUTOREAP
      pidfd: add CLONE_PIDFD_AUTOKILL
      selftests/pidfd: add CLONE_AUTOREAP tests
      selftests/pidfd: add CLONE_PIDFD_AUTOKILL tests

 fs/pidfs.c                                         |  38 +-
 include/linux/sched/signal.h                       |   1 +
 include/uapi/linux/pidfd.h                         |   1 +
 include/uapi/linux/sched.h                         |   2 +
 kernel/fork.c                                      |  34 +-
 kernel/ptrace.c                                    |   3 +-
 kernel/signal.c                                    |   4 +
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 793 +++++++++++++++++++++
 10 files changed, 868 insertions(+), 11 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260214-work-pidfs-autoreap-3ee677e240a8


