Return-Path: <linux-fsdevel+bounces-44789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A57A6CB5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A9F1B612B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E84233701;
	Sat, 22 Mar 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHSzT/oq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817BA233149
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658987; cv=none; b=gq8KXcQYtT9hmMmtFClhusbF9yD1OgT34ZjDh25MZwk/YTe5vhyeKNigKSWwpRbYBpuGOBIEDveL/D9pU1ZNEDKTPV2kTELKL9enPuFK9+SiyT8ThASf/OWrorwI0AAYMQUBt5K4sTs0P9SQnIkDtLeil97hX5QJng9cm6In7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658987; c=relaxed/simple;
	bh=doeceN/js06TXAI4aTf34GgmZWBpDr+yOG2Ab1HJcDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/kUSNvqgR+cQaT+xdkyJQLyYANKhhfKbp65HBpLZGxm4PdvCS/CF4P+7Cr7Iz4g8O0KCYpJ5T74Y9/v8E3MOkTG2zW6F+UzIU+Z7VG7PArmcN43gqbGYTDdpFaZGp/xzrYpPNp3dZl+o34rUmZW1PXrWuYk1JQKbcSN1b3Lrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHSzT/oq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742658984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jqIbltbOrjNEWpqd7XmuT8nnchsL9eSWGcr4/X0ZMY=;
	b=GHSzT/oqEnYBjwLV4klOpyJBJ/n2WeIJd9WmkthGUsWjTkox1aatMyK9thGV+W9vRs5UXy
	sG0d8RXsG6/yqqcgauhYRftvtxdkoo5O56oVpxD0TMzBe5Xn7vs0a6Da2twAqYR9WAY324
	vcmaK7yjEOgT6KXvJoutlJ3+1s6XEik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-XZvqU3npP-eF51G90MxKQw-1; Sat,
 22 Mar 2025 11:56:18 -0400
X-MC-Unique: XZvqU3npP-eF51G90MxKQw-1
X-Mimecast-MFC-AGG-ID: XZvqU3npP-eF51G90MxKQw_1742658977
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E088E1800EC5;
	Sat, 22 Mar 2025 15:56:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A731D19560AF;
	Sat, 22 Mar 2025 15:56:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 22 Mar 2025 16:55:44 +0100 (CET)
Date: Sat, 22 Mar 2025 16:55:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250322155538.GA16736@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322010008.GG2023217@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Quite possibly I am wrong, I need to recall this code, but at first
glance...

On 03/22, Al Viro wrote:
>
> Not really.

I agree, it is really racy. But,

> 1) A enters check_unsafe_execve(), sets ->in_exec to 1
> 2) B enters check_unsafe_execve(), sets ->in_exec to 1

No, check_unsafe_execve() is called with cred_guard_mutex held,
see prepare_bprm_creds()

> 3) A calls exec_binprm(), fails (bad binary)
> 4) A clears ->in_exec

So (2) can only happen after A fails and drops cred_guard_mutex.

And this means that we just need to ensure that ->in_exec is cleared
before this mutex is dropped, no? Something like below?

Oleg.
---

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..f8bf3c96e181 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1233,6 +1233,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * Make this the only thread in the thread group.
 	 */
 	retval = de_thread(me);
+	current->fs->in_exec = 0;
 	if (retval)
 		goto out;
 
@@ -1497,6 +1498,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
+		// for the case exec fails before de_thread()
+		current->fs->in_exec = 0;
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
@@ -1862,7 +1865,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
 	user_events_execve(current);
@@ -1881,7 +1883,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
 	return retval;


