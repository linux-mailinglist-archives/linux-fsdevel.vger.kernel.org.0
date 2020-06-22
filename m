Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AA2035AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgFVL0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 07:26:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39051 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbgFVL0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592825162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvgK4KLrCZzFDYjMPOaGgUmxRiWf9yxcTyPhh0B1N/w=;
        b=I+5djOVgTKXOaBvgIQztB8c8P4BLSEu3PFnzgXfJvF4eXzY5n9nRbzSMXHnHIOECIpRd5U
        gRM8Udc0mnVfdZMusKLnyryc5KNwjh8FRKlyKi4d5Y2lWIw5JLKrODQSzQ5PsYXAvTa77Z
        6QAuCwJ6X2bhz5vSdMCurNF3FY/6JdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-QFsswXIUPQKDm9fXWiIXRQ-1; Mon, 22 Jun 2020 07:26:00 -0400
X-MC-Unique: QFsswXIUPQKDm9fXWiIXRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3561819200C4;
        Mon, 22 Jun 2020 11:25:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E8EF7C1FC;
        Mon, 22 Jun 2020 11:25:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Jun 2020 13:25:58 +0200 (CEST)
Date:   Mon, 22 Jun 2020 13:25:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
Message-ID: <20200622112555.GB6516@redhat.com>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
 <87k1026h4x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1026h4x.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/19, Eric W. Biederman wrote:
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -369,7 +369,6 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
>  	spin_lock_irq(&tsk->sighand->siglock);
>  	if (!signal_group_exit(tsk->signal)) {
>  		mm->core_state = core_state;
> -		tsk->signal->group_exit_task = tsk;
>  		nr = zap_process(tsk, exit_code, 0);
>  		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
>  	}
> @@ -481,7 +480,6 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
>  	spin_lock_irq(&current->sighand->siglock);
>  	if (core_dumped && !__fatal_signal_pending(current))
>  		current->signal->group_exit_code |= 0x80;
> -	current->signal->group_exit_task = NULL;
>  	current->signal->flags = SIGNAL_GROUP_EXIT;
>  	spin_unlock_irq(&current->sighand->siglock);
>  
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 0ee5e696c5d8..92c72f5db111 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -265,7 +265,7 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
>  /* If true, all threads except ->group_exit_task have pending SIGKILL */
>  static inline int signal_group_exit(const struct signal_struct *sig)
>  {
> -	return	(sig->flags & SIGNAL_GROUP_EXIT) ||
> +	return	(sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
>  		(sig->group_exit_task != NULL);
>  }

Looks correct.

Oleg.

