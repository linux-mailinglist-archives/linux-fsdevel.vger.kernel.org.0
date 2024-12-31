Return-Path: <linux-fsdevel+bounces-38305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392589FF1C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 21:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B6188257D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA801B0437;
	Tue, 31 Dec 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA73lcDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49B1534F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735676710; cv=none; b=jqBM1Y6nOrv8zC9504D+G0BYXuAXplCNrqRJqLSywLNpMI4N7IlcXiVYOGOF2D+l7oIGMBmR7N/CW9YWSfu3jt1QC2PmVsNvPEnzvIJgrduyLlrFc117x8P2a3o8idbku9lO058Z5VItpqJvGv1Z6eb9sZTmtQbcfWbHTyMMGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735676710; c=relaxed/simple;
	bh=NYYxQaQOmFLkEjVDd+NcmPWNvrx1tmgIeZpgojXZtjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVZvZKiRLntzahlJsggxpgMdLc/pFAchMadPaB29wmf7ciwFqzFsEyH0rXbZ5mZj9PKWF7yKEi811OL5pqRUt/8elbQQt/42xvdnuBj90TnIc6nJgPY1j2iGZLMgjAJNzgE36xQ7UgItQ1bzjaMecZrkIroEK7hYg+VOBs+afLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA73lcDH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735676706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dq/D7sPLgPI53JdHmdpFP8sI8Qyi9nH3UJQWrZM60uQ=;
	b=GA73lcDHMdHIFJx4sY0JEFC1hQ0WYbJz2kHbQDNJ1nC5IK+MdwmebRbPhe6ekH8t8wUA5i
	jO1vgbW1VqDxOhQGq1un2KF3O5L/41YKHvBr/+hDRKWw3yFA8r4frGgKvXjWsi1F8CeWK6
	dk9tr495qvJG2ET0gVB+EhXH+xu/L6s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-3cW2G9aDOUmDE5vFRcJcvA-1; Tue,
 31 Dec 2024 15:25:03 -0500
X-MC-Unique: 3cW2G9aDOUmDE5vFRcJcvA-1
X-Mimecast-MFC-AGG-ID: 3cW2G9aDOUmDE5vFRcJcvA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 907FE195609E;
	Tue, 31 Dec 2024 20:25:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 497601956086;
	Tue, 31 Dec 2024 20:24:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 31 Dec 2024 21:24:37 +0100 (CET)
Date: Tue, 31 Dec 2024 21:24:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, 1vier1@web.de
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241231202431.GA1009@redhat.com>
References: <20241230153844.GA15134@redhat.com>
 <20241231111428.5510-1-manfred@colorfullife.com>
 <CAHk-=wjST86WXn2FRYuL7WVqwvdtXPmmsKKCuJviepeSP2=LPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjST86WXn2FRYuL7WVqwvdtXPmmsKKCuJviepeSP2=LPg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 12/31, Linus Torvalds wrote:
>
> Oleg's patch to only wake up writers when readers have actually opened
> up a slot may not make any actual difference (because readers in
> *practice* always do big reads),

Yes, yes, that patch is mostly cleanup/simplification. I'll write the
changelog and send it after the holidays. Plus probably another one to fix
the theoretical problem (I need to recheck) in wakeup_pipe_readers/writers.

But let me ask another question right now. what do you think about another
minor change below?

Again, mostly to make this logic more understandable. Although I am not
sure I really understand it...

Oleg.

diff --git a/fs/pipe.c b/fs/pipe.c
index 82fede0f2111..ac3e7584726a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -661,8 +661,11 @@ pipe_poll(struct file *filp, poll_table *wait)
 	struct pipe_inode_info *pipe = filp->private_data;
 	unsigned int head, tail;
 
+#ifdef CONFIG_EPOLL
 	/* Epoll has some historical nasty semantics, this enables them */
-	WRITE_ONCE(pipe->poll_usage, true);
+	if ((filp->f_mode & FMODE_READ) && filp->f_ep)
+		WRITE_ONCE(pipe->poll_usage, true);
+#endif
 
 	/*
 	 * Reading pipe state only -- no need for acquiring the semaphore.


