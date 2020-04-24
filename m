Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40A81B7D1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgDXRjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 13:39:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56026 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbgDXRji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgQK9XAbwzLmLV+qfkziGOTjqm2qDmPdwhUEm9j9Saw=;
        b=NV04DR+MnPuM/6LzAMtZuowx6YwAOD0b+iqpx7rdMkoIAfNY/knm5PIFqV8VoCjyNHhlIa
        R2EdnXxGlszPYdz/P9XbQLx/+40tfP1q9waEYs/3+pzqZvShFM745qaMqV8LZcN14Wgb+4
        YQax+CjzHv+QaInljsOXkvCURq7kaEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-sMY4QfKLNsezFEmtfeffSA-1; Fri, 24 Apr 2020 13:39:33 -0400
X-MC-Unique: sMY4QfKLNsezFEmtfeffSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA670800D24;
        Fri, 24 Apr 2020 17:39:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id A6B311001B2C;
        Fri, 24 Apr 2020 17:39:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 24 Apr 2020 19:39:31 +0200 (CEST)
Date:   Fri, 24 Apr 2020 19:39:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid
 exactly
Message-ID: <20200424173927.GB26802@redhat.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org>
 <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/23, Eric W. Biederman wrote:
>
> When the thread group leader changes during exec and the old leaders
> thread is reaped proc_flush_pid

This is off-topic, but let me mention this before I forget...

Note that proc_flush_pid() does nothing if CONFIG_PROC_FS=n, this mean
that in this case release_task() leaks thread_pid.

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
> +	WRITE_ONCE(ntask->pid_links[PIDTYPE_PID].pprev, &opid->tasks[PIDTYPE_PID].first);
> +	WRITE_ONCE(otask->pid_links[PIDTYPE_PID].pprev, &npid->tasks[PIDTYPE_PID].first);
> +	WRITE_ONCE(ntask->pid, pid_nr(opid));
> +	WRITE_ONCE(otask->pid, pid_nr(npid));
> +}

Oh, at first glance this breaks posix-cpu-timers.c:lookup_task(), the last
user of has_group_leader_pid().

I think that we should change lookup_task() to return "struct *pid", this
should simplify the code... Note that none of its callers needs task_struct.

And, instead of thread_group_leader/has_group_leader_pid checks we should
use pid_has_task(TGID).

After that, this patch should kill has_group_leader_pid().

What do you think?

Oleg.

