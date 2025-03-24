Return-Path: <linux-fsdevel+bounces-44874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A3A6DF2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C0F3AE9DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133326156D;
	Mon, 24 Mar 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqmepITp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBFA25D1E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832050; cv=none; b=diFr/sJhlc1f9trOhWOtCoqh6Zdz4TSNbuinTERtonL+79fILFWxb2LTHUyeaacuUfqycKUH8LkUdfez8ssV0ZXxpQq0YzCf5uv4HZAlYeHbmfial/+HRbhfy0yLcSNAdkireBg/m1vkJjOtv13O/DULSr5UeBI403SOrAFWPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832050; c=relaxed/simple;
	bh=nsepdpyI/2xuzKhuRDEqeV/G99EfCkZ+x2I7tt8a45g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLVuEOvU/aR/uddcur1JzP64KUkYg0ttfZEK9f3F+ROXK5NjUcaJP1wk0esW2bQBWx7wHlS18irrDe8cUAAlYIrzGVo4XpbymY6fwa7+Aqw8yhYtCSOBflC5eRiRDhAVHW7Z2zxljh4p6Bq//GHUAGuWCfV6GIuug4fVb7hpS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqmepITp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742832047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEzePZHL5YOYb8ZhIKkkzL7fHN+3KRqzc+zq67vlHtI=;
	b=RqmepITpa6zkp/QFvuF18N2dvZCvaB5ocZqoBEbUdvOduqTd2EHZsKg3B+LrICrTjIHljK
	MvI24OsXbnxXkG9HryIzFDcRKbJRNnvgMOVa2RRyxDaznAFZL3ndP0yJpUTOo41EVeUhCa
	gegDifTiHf8yxatTow7kLPVDDnze6jU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-cF6EvRTIOYSZ3zi_G86ECw-1; Mon,
 24 Mar 2025 12:00:43 -0400
X-MC-Unique: cF6EvRTIOYSZ3zi_G86ECw-1
X-Mimecast-MFC-AGG-ID: cF6EvRTIOYSZ3zi_G86ECw_1742832042
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70E571800EC5;
	Mon, 24 Mar 2025 16:00:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7E901180175F;
	Mon, 24 Mar 2025 16:00:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Mar 2025 17:00:08 +0100 (CET)
Date: Mon, 24 Mar 2025 17:00:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>,
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, mjguzik@gmail.com
Subject: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250324160003.GA8878@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

check_unsafe_exec() sets fs->in_exec under cred_guard_mutex, then execve()
paths clear fs->in_exec lockless. This is fine if exec succeeds, but if it
fails we have the following race:

	T1 sets fs->in_exec = 1, fails, drops cred_guard_mutex

	T2 sets fs->in_exec = 1

	T1 clears fs->in_exec

	T2 continues with fs->in_exec == 0

Change fs/exec.c to clear fs->in_exec with cred_guard_mutex held.

Reported-by: syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001f.GAE@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/exec.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..17047210be46 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1229,13 +1229,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->point_of_no_return = true;
 
-	/*
-	 * Make this the only thread in the thread group.
-	 */
+	/* Make this the only thread in the thread group */
 	retval = de_thread(me);
 	if (retval)
 		goto out;
-
+	/* see the comment in check_unsafe_exec() */
+	current->fs->in_exec = 0;
 	/*
 	 * Cancel any io_uring activity across execve
 	 */
@@ -1497,6 +1496,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
+		/* in case exec fails before de_thread() succeeds */
+		current->fs->in_exec = 0;
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
@@ -1618,6 +1619,10 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	 * suid exec because the differently privileged task
 	 * will be able to manipulate the current directory, etc.
 	 * It would be nice to force an unshare instead...
+	 *
+	 * Otherwise we set fs->in_exec = 1 to deny clone(CLONE_FS)
+	 * from another sub-thread until de_thread() succeeds, this
+	 * state is protected by cred_guard_mutex we hold.
 	 */
 	n_fs = 1;
 	spin_lock(&p->fs->lock);
@@ -1862,7 +1867,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
 	user_events_execve(current);
@@ -1881,7 +1885,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
 	return retval;
-- 
2.25.1.362.g51ebf55



