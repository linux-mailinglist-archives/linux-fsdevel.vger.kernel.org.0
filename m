Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098E24B788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgHTK4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 06:56:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731162AbgHTK4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597920974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXZn0ptz4OdIcD8qJiz0sPtwyG4FrJg7hkfvx+FDmUI=;
        b=eHPlxY2oeWC4XWMqJE6WSK1OtX30R1j1PGoJBqSEbhHdHuh6gu4H+bEd5tKG26/AyQKSgx
        EQ3W4pUUvqp0qqjdDWuh2JsMVb0dRAY3YX+kOoUvcqkhEy4/MtY+OzBsduQVTdFetCAds2
        RpfdA5mcL1xNacf0nQNcw9x/V8QzCZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-P_V1LyLiOz2MfwMupSW5mw-1; Thu, 20 Aug 2020 06:56:12 -0400
X-MC-Unique: P_V1LyLiOz2MfwMupSW5mw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29506871803;
        Thu, 20 Aug 2020 10:56:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E00C5D9F1;
        Thu, 20 Aug 2020 10:55:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 20 Aug 2020 12:56:06 +0200 (CEST)
Date:   Thu, 20 Aug 2020 12:55:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@suse.com, christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820105555.GA4546@redhat.com>
References: <20200820002053.1424000-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820002053.1424000-1-surenb@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/19, Suren Baghdasaryan wrote:
>
> Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
> used the additional mutex lock in that path of the clone() syscall should
> not affect its overall performance. Clearing the MMF_PROC_SHARED flag
> (when the last process sharing the mm exits) is left out of this patch to
> keep it simple and because it is believed that this threading model is
> rare.

vfork() ?

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1403,6 +1403,15 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>  	if (clone_flags & CLONE_VM) {
>  		mmget(oldmm);
>  		mm = oldmm;
> +		if (!(clone_flags & CLONE_SIGHAND)) {

I agree with Christian, you need CLONE_THREAD

> +			/* We need to synchronize with __set_oom_adj */
> +			mutex_lock(&oom_adj_lock);
> +			set_bit(MMF_PROC_SHARED, &mm->flags);
> +			/* Update the values in case they were changed after copy_signal */
> +			tsk->signal->oom_score_adj = current->signal->oom_score_adj;
> +			tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> +			mutex_unlock(&oom_adj_lock);

I don't understand how this can close the race with __set_oom_adj...

What if __set_oom_adj() is called right after mutex_unlock() ? It will see
MMF_PROC_SHARED, but for_each_process() won't find the new child until
copy_process() does list_add_tail_rcu(&p->tasks, &init_task.tasks) ?

Oleg.

