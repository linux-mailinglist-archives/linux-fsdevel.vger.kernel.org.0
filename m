Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB5168411
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 17:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgBUQuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 11:50:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727960AbgBUQuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582303850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4h82rv0PoKdnsyNmTUn/xy7ivRxE79f7MGtv9RQvsxs=;
        b=K1shmBu8+u1/EsmCeJcLOaIF0aoRRyv11djXs6M4qTDQnYzkGX9nfNXZ9iN8RNF2H0Geqx
        rhLBJHFP4V21MftI7Z0FB/e2f+X8aWlloY8W5R8ppMf7/Ef+syM8Q0q/5B1X78Y5bOVIDf
        dKba6K/A0nDhzTG3K4b5gihJ92t+a3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-NEfudibLOf2BUHT9bNEyZQ-1; Fri, 21 Feb 2020 11:50:46 -0500
X-MC-Unique: NEfudibLOf2BUHT9bNEyZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C638119057C2;
        Fri, 21 Feb 2020 16:50:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 229DC1001B0B;
        Fri, 21 Feb 2020 16:50:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 21 Feb 2020 17:50:42 +0100 (CET)
Date:   Fri, 21 Feb 2020 17:50:37 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH 7/7] proc: Ensure we see the exit of each process tid
 exactly once
Message-ID: <20200221165036.GB16646@redhat.com>
References: <20200212200335.GO23230@ZenIV.linux.org.uk>
 <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk>
 <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org>
 <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org>
 <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87r1yp7zhc.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1yp7zhc.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/20, Eric W. Biederman wrote:
>
> +void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
> +{
> +	/* pid_links[PIDTYPE_PID].next is always NULL */
> +	struct pid *npid = READ_ONCE(ntask->thread_pid);
> +	struct pid *opid = READ_ONCE(otask->thread_pid);
> +
> +	rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
> +	rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
> +	rcu_assign_pointer(ntask->thread_pid, opid);
> +	rcu_assign_pointer(otask->thread_pid, npid);

this breaks has_group_leader_pid()...

proc_pid_readdir() can miss a process doing mt-exec but this looks fixable,
just we need to update ntask->thread_pid before updating ->first.

The more problematic case is __exit_signal() which does
		
		if (unlikely(has_group_leader_pid(tsk)))
			posix_cpu_timers_exit_group(tsk);

Oleg.

