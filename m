Return-Path: <linux-fsdevel+bounces-49247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F6AB9B05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A46A22416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868FB2367DA;
	Fri, 16 May 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyQJhYJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29A236431;
	Fri, 16 May 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394783; cv=none; b=K5jQ0vg7F2qbXjWJOmAuCz3gIxYCYXN/pqQB1KTkDAa0oJ4kOF5UL1Ubno1k47h5PrmB9hUucw9dbsp6isjk9wCrYM3FckWRImsbWYy/xFzfMa4GgOH4AX++1HuT45gnVHlJ7l7oaSv+HO4KncRTBQ/LQdc0cTLyg/iL55tuu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394783; c=relaxed/simple;
	bh=cdHC8XIcBNIdLFjlHlwiRrtkhnKb7FpbkKLOq0IziuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSgJhsHmelYMTgViN2o20iAujlUgrgoRhBUS+d305esUpcAXEv+RJOm3uXEa1QU6vOAIoWBd96qp/J9ZqBfcwqKrfRHHld+lo7l7+5acYGD1AqIOpL4Epa/TZ5yP+G+5jqUT5eJyVsdMSuQOxb6DmDuR7+hHiQHV9rRFzcNLCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyQJhYJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB1AC4CEE4;
	Fri, 16 May 2025 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394782;
	bh=cdHC8XIcBNIdLFjlHlwiRrtkhnKb7FpbkKLOq0IziuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kyQJhYJI9pGnMPXVFWedYdnvczVPVcbPy74MhDh7FnQeSybufq49b8RL4d2dGKH+n
	 HxdvUlyi4fHZZRoUOB1Vgq451o2pttbclrDkLZgb9P0W5drdepSPnJ9DRBzPiW+1PH
	 XNHRJNuqm9aVHuyq1p/cE/5BbM5xHD0uYeXt97GjvAx0sQS7VmrB0+k0BuOAMXDjxj
	 LXH2+NoK2BfrKwbpv+VhcWBaK4nUPLftgu7Md7/sKpMcG/VdVy+Z2hxiyqtNTurD1b
	 UW0gA6b4tjMIIfwbzkWwYIez3lYFnswtIkS78EKuKlE9W0qWS3+5WDxkG6XOJiHlFM
	 Tah9xrmBty54Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 May 2025 13:25:34 +0200
Subject: [PATCH v8 7/9] coredump: validate socket name as it is written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-work-coredump-socket-v8-7-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cdHC8XIcBNIdLFjlHlwiRrtkhnKb7FpbkKLOq0IziuI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2zdde9lejNPSz732qlnNYUq0+MXLnj25NSkP7umO
 zUd+GR/r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi5QqMDJ0bH3EfnXi663Px
 +292Lpp7Vhw0PSpT1j6//U5JWMrlvxoM/51Sn9/oz/Hvv1JW8HypjWjwibrLHMueW55IuM1SGf2
 2kx0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In contrast to other parameters written into
/proc/sys/kernel/core_pattern that never fail we can validate enabling
the new AF_UNIX support. This is obviously racy as hell but it's always
been that way.

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7b9a659683fc..c5c57e8e496f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1215,13 +1215,44 @@ void validate_coredump_safety(void)
 	}
 }
 
+static inline bool check_coredump_socket(void)
+{
+	if (core_pattern[0] != '@')
+		return true;
+
+	/*
+	 * Coredump socket must be located in the initial mount
+	 * namespace. Don't give the impression that anything else is
+	 * supported right now.
+	 */
+	if (current->nsproxy->mnt_ns != init_task.nsproxy->mnt_ns)
+		return false;
+
+	/* Must be an absolute path. */
+	if (*(core_pattern + 1) != '/')
+		return false;
+
+	return true;
+}
+
 static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int error = proc_dostring(table, write, buffer, lenp, ppos);
+	int error;
+	ssize_t retval;
+	char old_core_pattern[CORENAME_MAX_SIZE];
+
+	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
+
+	error = proc_dostring(table, write, buffer, lenp, ppos);
+	if (error)
+		return error;
+	if (!check_coredump_socket()) {
+		strscpy(core_pattern, old_core_pattern, retval + 1);
+		return -EINVAL;
+	}
 
-	if (!error)
-		validate_coredump_safety();
+	validate_coredump_safety();
 	return error;
 }
 

-- 
2.47.2


