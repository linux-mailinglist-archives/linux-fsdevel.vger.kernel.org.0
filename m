Return-Path: <linux-fsdevel+bounces-77292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGGaI1sgk2kX1wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:49:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E114417F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08D753012262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386230EF95;
	Mon, 16 Feb 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE2wD4Cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5681308F3A;
	Mon, 16 Feb 2026 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249745; cv=none; b=Y4p9G8e5XvR77MlYS9EPi4qd8iuCPKV/+wJrCEtqUxT9vgyFHWTFJUjTV3XLYnNg0krxBrthCASuCBSRZdmzV59kQcRPFm0KL/3R7NClMVc/z6Q2RTYojecDZvDiVlJU1XCswPXDagMmpIfAao/7NBGNoXuSPhcOIUyVSWbagmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249745; c=relaxed/simple;
	bh=6iZo5+DmFVDVdgDqpx/nHtoKrVBgGVaPGTLuz7cs1Sk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JUOmHyz13o1YYVvEzayWB/a4sWnyFAhTYaNlf0uWxB2b+Rv22IhoBQyfzVeJOwlOFAN6XWbsovlSSGMo+/LtGc4FMrfTJikYTlwIyOvOp0O8cbtMFCpcNp3ZN1bhfXV1tUl8fQyyBe6kIIXqMrPlSPYrZNFoZ3ZrG9bmxA+SDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE2wD4Cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B788DC116C6;
	Mon, 16 Feb 2026 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771249745;
	bh=6iZo5+DmFVDVdgDqpx/nHtoKrVBgGVaPGTLuz7cs1Sk=;
	h=From:Subject:Date:To:Cc:From;
	b=GE2wD4CqZf2Ny0nevdP3etpr7D+KOirZEV43ZkwXJHAFcQv0EL8XEnAucdjknqV+K
	 8nZL7Aq0KvneNtaCZMa8I1mCCA193vkyCivru68Z5zroYup7VZA4lKv1w7TthSFsIs
	 6VRxZZ/wAqx8pUcZwCAdmzTZ7hp8gVWR4cCTAtCA9FOxGGpsRV0A2Xw+xKZEja8hB9
	 57N0qm33CZhFG/dQgqwsilqkAZDrR9kSxqbzoM5KBiHb/2ikMgGyU2cXo9FmANBEmd
	 dZaA7cPUgr/I4s2OglGE3A8zXDy94aca/z3MWouya5TaCVoYRXVNQEHPHPB15huqIf
	 HDcN7xXBBhiqw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/2] pidfd: add CLONE_AUTOREAP
Date: Mon, 16 Feb 2026 14:48:34 +0100
Message-Id: <20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIgk2kC/x2MSwrCMBQAr1Le2kj+sW4FD+BWXLykLzZIPyT1A
 6V3N7qcgZkVCuVEBY7NCpleqaRprCB2DYQexzux1FUGyaXlUmj2nvKDzamLheFzmTLhzBSRdY6
 k5niAWs6ZYvr8r1e4nE9wq9JjIeYzjqH/DQcsC+W9k0G1hkvdYTAkhRHKBh+ja5U2JnJrLFeeW
 9i2L3q8+fisAAAA
X-Change-ID: 20260214-work-pidfs-autoreap-3ee677e240a8
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3210; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6iZo5+DmFVDVdgDqpx/nHtoKrVBgGVaPGTLuz7cs1Sk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROVvBv2nd80a1Wjj3Pg2KVAqYGiPZ5XmP7eDj/8itu/
 wXxAlsFOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyW5DhD1+JvM7a13svJLm/
 FTgf2z1xdueLjU3H8ifru9w4FCT3VZLhD8evJcFzHx+YrRj082f8TDdr/wt3Vt4/9Nbws4ZczIp
 4XUYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77292-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F7E114417F
X-Rspamd-Action: no action

Add a new clone3() flag CLONE_AUTOREAP that makes a child process
auto-reap on exit without ever becoming a zombie. This is a per-process
property in contrast to the existing auto-reap mechanism via
SA_NOCLDWAIT or SIG_IGN for SIGCHLD which applies to all children of a
given parent.

With pidfds this is very useful as the parent can monitor the pidfd via
poll and retrieve the exit status from the pidfd.

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

CLONE_AUTOREAP requires CLONE_PIDFD because the process will never be
visible to wait(). The parent must use the pidfd to monitor exit via
poll() and retrieve exit status via PIDFD_GET_INFO. No exit signal is
delivered so exit_signal must be zero.

The flag is not inherited by the autoreap process's own children. Each
child that should be autoreaped must be explicitly created with
CLONE_AUTOREAP.

(Later on we can augment this with another addition CLONE_PIDFD_AUTOKILL
 which would SIGKILL the child process when the pidfd that was returned
 from clone3() is closed. Specifically, when the file referenced by the
 fd from clone3() is closed. The wrinkly here is that it would either
 have to be reset on privilege gaining exec - like pdeath signal - or we
 enforce that autokill only works when no-new-privileges is set.)

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      clone: add CLONE_AUTOREAP
      selftests/pidfd: add CLONE_AUTOREAP tests

 include/linux/sched/signal.h                       |   1 +
 include/uapi/linux/sched.h                         |   1 +
 kernel/fork.c                                      |  16 +-
 kernel/ptrace.c                                    |   3 +-
 kernel/signal.c                                    |   4 +
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 475 +++++++++++++++++++++
 8 files changed, 500 insertions(+), 3 deletions(-)
---
base-commit: 72c395024dac5e215136cbff793455f065603b06
change-id: 20260214-work-pidfs-autoreap-3ee677e240a8


