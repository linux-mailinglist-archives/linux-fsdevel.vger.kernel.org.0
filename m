Return-Path: <linux-fsdevel+bounces-44834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D601A6D036
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 18:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69BE1894C7D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D714375C;
	Sun, 23 Mar 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Np2Ik/IR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708442AA6
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742750438; cv=none; b=Ix/Dw11cAgZjSzThKfvOgWYQzLoVBNj4tb+OCztEP+Pst3oAWS0dGDGmWsVcvo3WRrtd/yw7+/32j6hN4qs0vVpWSXJWkArBee3HTCEXxyLpa/Nqj4H3e4ayXLHScFM8Pbdxe6AVrH39BQ6NDV33NzYXhKXqInRL2kWGQEm0SQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742750438; c=relaxed/simple;
	bh=YAe5kMuesEXACQxCSdKf6GOTRwmzemqZ0OU8LejH9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCn02MPNtuhfd901bO6sqGteXI81SSE4IPox9qaNAdFOupJ+LJvr9VX2E5BF1/7fG9ixNckOf6ANNHvFdqPvA/s84khEbTwZQGXwl6Ij/4HqaVtqIMtujgHuhvs5KsWL0hNVZk7eKMCZQlYEvDvKG2BW8NjhCaNfNwrnHXELgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Np2Ik/IR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742750435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SNnRTWUYOcoRFxJ1dPglkVTDz/o6lwL8KQ531uCTLE=;
	b=Np2Ik/IRJiNL54qhzd0rCU++3HiD8HHvZkW8xX3Ns+X92u1V2Xeaa1wxXXzUToSK2D3tw/
	oScteuoQFbZIvR+OGMgKi+/DGfyRfjknL3bM4V74l92vwS2zQUECUSNfbwXvl1o3BhZXD7
	iO+yPQt9WCjce+QMu7SRwKk0I/rECTo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-nKGfM10ZPk66yQ7wiqWr1g-1; Sun,
 23 Mar 2025 13:20:34 -0400
X-MC-Unique: nKGfM10ZPk66yQ7wiqWr1g-1
X-Mimecast-MFC-AGG-ID: nKGfM10ZPk66yQ7wiqWr1g_1742750432
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97B4519560B1;
	Sun, 23 Mar 2025 17:20:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C8B991956095;
	Sun, 23 Mar 2025 17:20:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Mar 2025 18:19:59 +0100 (CET)
Date: Sun, 23 Mar 2025 18:19:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: [PATCH] pidfs: cleanup the usage of do_notify_pidfd()
Message-ID: <20250323171955.GA834@redhat.com>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

If a single-threaded process exits do_notify_pidfd() will be called twice,
from exit_notify() and right after that from do_notify_parent().

1. Change exit_notify() to call do_notify_pidfd() if the exiting task is
   not ptraced and it is not a group leader.

2. Change do_notify_parent() to call do_notify_pidfd() unconditionally.

   If tsk is not ptraced, do_notify_parent() will only be called when it
   is a group-leader and thread_group_empty() is true.

This means that if tsk is ptraced, do_notify_pidfd() will be called from
do_notify_parent() even if tsk is a delay_group_leader(). But this case is
less common, and apart from the unnecessary __wake_up() is harmless.

Granted, this unnecessary __wake_up() can be avoided, but I don't want to
do it in this patch because it's just a consequence of another historical
oddity: we notify the tracer even if !thread_group_empty(), but do_wait()
from debugger can't work until all other threads exit. With or without this
patch we should either eliminate do_notify_parent() in this case, or change
do_wait(WEXITED) to untrace the ptraced delay_group_leader() at least when
ptrace_reparented().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c   | 8 ++------
 kernel/signal.c | 8 +++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 683766316a3d..d0ebccb9dec0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -742,12 +742,6 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		kill_orphaned_pgrp(tsk->group_leader, NULL);
 
 	tsk->exit_state = EXIT_ZOMBIE;
-	/*
-	 * Ignore thread-group leaders that exited before all
-	 * subthreads did.
-	 */
-	if (!delay_group_leader(tsk))
-		do_notify_pidfd(tsk);
 
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
@@ -760,6 +754,8 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 			do_notify_parent(tsk, tsk->exit_signal);
 	} else {
 		autoreap = true;
+		/* untraced sub-thread */
+		do_notify_pidfd(tsk);
 	}
 
 	if (autoreap) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 027ad9e97417..1d8db0dabb71 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2179,11 +2179,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
-	/*
-	 * Notify for thread-group leaders without subthreads.
-	 */
-	if (thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+
+	/* ptraced, or group-leader without sub-threads */
+	do_notify_pidfd(tsk);
 
 	if (sig != SIGCHLD) {
 		/*
-- 
2.25.1.362.g51ebf55



