Return-Path: <linux-fsdevel+bounces-67596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FC8C4444C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC73B5384
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D7D305963;
	Sun,  9 Nov 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSz+6fFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C23043A2
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708615; cv=none; b=nBVfCxdBhMViGu+KSPau1Nucsgyv6eAEYX+Y5M2bCjraajuoV7x/082OQ9fRVgH73mw9jSBaqD+fjuSi47plCdIrvm08mAydSefnHvirZ1gtZnDnLyHYCnkdCA+LxFipmtZ5vi53TRH8DbSK3Bnu62Du1CWLhgxvuI/0Ch3QSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708615; c=relaxed/simple;
	bh=TEHCsYmNR3I9xmM/WSR88FgTxB0Xly9HoUofVNoZx/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0RY4I6oK9n4IregGq/4yIu/y3SK0cwrMQuLagG2FJDip+9bLJgBE7LuftJs0ZY7rE+cxZ8kAPN3GXdPGrwOdm6q0awjKkE2XRAfKpKMtSdZyknffDhW9vdbldl38rygY1w/PVhLZTi7ZY/FMvErJhzFf7wjaC1WpuYxG0FwvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSz+6fFR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762708612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=De3qwJZddIJhWbGGVbrDOYNQpF2Q/objdb0xufnPYfw=;
	b=TSz+6fFRaO77dvaI+P/PSTXWFQoEudO1h7kSM4Szk+w6tZ6h0q2aOQcfz68OEv9veYCe7E
	aDgOIMfGCLYgk8e/YP1wm+L4EcoUm20yFhJbtu5L4qb57QgQ+S9uMioFOiMd9DVNXS19b1
	pgwUTpPmPLH6QA+TnneFStR3S7rmqTk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-sgxsSvgzNTOqDj75cxvXMA-1; Sun,
 09 Nov 2025 12:16:50 -0500
X-MC-Unique: sgxsSvgzNTOqDj75cxvXMA-1
X-Mimecast-MFC-AGG-ID: sgxsSvgzNTOqDj75cxvXMA_1762708604
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C53D19560B2;
	Sun,  9 Nov 2025 17:16:44 +0000 (UTC)
Received: from fedora (unknown [10.44.32.53])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3C7C919560A7;
	Sun,  9 Nov 2025 17:16:19 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Nov 2025 18:16:42 +0100 (CET)
Date: Sun, 9 Nov 2025 18:16:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Levin <ldv@strace.io>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 3/3] ptrace: ensure PTRACE_EVENT_EXIT won't stop if the
 tracee is killed by exec
Message-ID: <aRDMYSuEV82irPmA@redhat.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDL3HOB21pMVMWC@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The previous patch fixed the deadlock when mt-exec waits for debugger
which should reap a zombie thread, but we can hit the same problem if
the killed sub-thread stops in ptrace_event(PTRACE_EVENT_EXIT). Change
ptrace_stop() to check signal->group_exit_task.

This is a user-visible change. But hopefully it can't break anything.
Note that the semantics of PTRACE_EVENT_EXIT was never really defined,
it depends on /dev/random. Just for example, currently a sub-thread
killed by exec will stop, but if it exits on its own and races with
exec it will not stop, so nobody can rely on PTRACE_EVENT_EXIT anyway.

We really need to finally define what PTRACE_EVENT_EXIT should actually
do, but this needs other changes.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 334212044940..59f61e07905b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2376,6 +2376,10 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	if (!current->ptrace || __fatal_signal_pending(current))
 		return exit_code;
 
+	/* de_thread() -> wait_for_notify_count() waits for us */
+	if (current->signal->group_exec_task)
+		return exit_code;
+
 	set_special_state(TASK_TRACED);
 	current->jobctl |= JOBCTL_TRACED;
 
-- 
2.25.1.362.g51ebf55



