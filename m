Return-Path: <linux-fsdevel+bounces-47609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C09AA10EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7147C7ABA35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7023F26A;
	Tue, 29 Apr 2025 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie63ie1i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66923ED5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941837; cv=none; b=BgbtcGMKHB9KX12O0oT3iqHTm+8QntzWt9Owltp7/mVLeJJDJpT1rc3kdfSBRXYloXvfc6Luioqjo9oebFwdcMNSSRlvo6deVeLtKOSfo+LhTXk4dskkY5VS24HKYmyiNBQDAYttvM8aVkPDV1nNEZzxXKOrUKcrZFL+19VMlBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941837; c=relaxed/simple;
	bh=3Sy9kbsRYuk4QScRSGShkv+SS95vYtgFwONeRuo8LTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnFuXcpCte2YzjDLF5f6jRcverBkfhfLlHPt4RhsBj4CxXOoGH56tIWbA3eMUcoPwXnF1vUNYT7oIz2VUozTLzJBn76i8fPK0obkQtLs3HvCnYAt2YRg2fTOmcIlQkGbjlR5S0Z+3Lx262H4WimboOaFIlStgZoNE/Mpama5eU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ie63ie1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745941834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzyuIC5lN8iw0yHtCMolMLvXO2aa9rMo4MO2VDH7oxk=;
	b=ie63ie1ic6GpNnwTHGpmKLM0tJtx/FIc50YsiDorDa47BCDgUkSzUEzNFzJg5pg9lCorOj
	g3b5U+s/uPZBv076klD7+wwaF7NNCI1xpzroNN8f1kzPmPPfqho+nnUQz6cHHDfyo1ousR
	2FKMN9Jh1iZ8ogW4ax5mL/I1ME5zAVk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-PK0iwh_NP1SddwatWXB-yg-1; Tue,
 29 Apr 2025 11:50:30 -0400
X-MC-Unique: PK0iwh_NP1SddwatWXB-yg-1
X-Mimecast-MFC-AGG-ID: PK0iwh_NP1SddwatWXB-yg_1745941829
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2315D1800878;
	Tue, 29 Apr 2025 15:50:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.224])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6B435195608D;
	Tue, 29 Apr 2025 15:50:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 29 Apr 2025 17:49:49 +0200 (CEST)
Date: Tue, 29 Apr 2025 17:49:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, mjguzik@gmail.com,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250429154944.GA18907@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324160003.GA8878@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Damn, I am stupid.

On 03/24, Oleg Nesterov wrote:
>
> check_unsafe_exec() sets fs->in_exec under cred_guard_mutex, then execve()
> paths clear fs->in_exec lockless. This is fine if exec succeeds, but if it
> fails we have the following race:
>
> 	T1 sets fs->in_exec = 1, fails, drops cred_guard_mutex
>
> 	T2 sets fs->in_exec = 1
>
> 	T1 clears fs->in_exec

When I look at this code again, I think this race was not possible and thus
this patch (applied as af7bb0d2ca45) was not needed.

Yes, begin_new_exec() can drop cred_guard_mutex on failure, but only after
de_thread() succeeds, when we can't race with another sub-thread.

I hope this patch didn't make the things worse so we don't need to revert it.
Plus I think it makes this (confusing) logic a bit more clear. Just, unless
I am confused again, it wasn't really needed.

-----------------------------------------------------------------------------
But. I didn't read the original report from syzbot,
https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001f.GAE@google.com/#t
because I wasn't CC'ed. and then - sorry Kees!!! - I didn't bother to read
your first reply carefully.

So yes, with or without this patch the "if (fs->in_exec)" check in copy_fs()
can obviously hit the 1 -> 0 transition.

This is harmless, but should be probably fixed just to avoid another report
from KCSAN.

I do not want to add another spin_lock(fs->lock). We can change copy_fs() to
use data_race(), but I'd prefer the patch below. Yes, it needs the additional
comment(s) to explain READ_ONCE().

What do you think? Did I miss somthing again??? Quite possibly...

Mateusz, I hope you will cleanup this horror sooner or later ;)

Oleg.
---

diff --git a/fs/exec.c b/fs/exec.c
index 5d1c0d2dc403..42a7f9b43911 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1495,7 +1495,7 @@ static void free_bprm(struct linux_binprm *bprm)
 	free_arg_pages(bprm);
 	if (bprm->cred) {
 		/* in case exec fails before de_thread() succeeds */
-		current->fs->in_exec = 0;
+		WRITE_ONCE(current->fs->in_exec, 0);
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index 4c2df3816728..381af8c8ece8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1802,7 +1802,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
 		/* "users" and "in_exec" locked for check_unsafe_exec() */
-		if (fs->in_exec) {
+		if (READ_ONCE(fs->in_exec)) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
 		}


