Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641CF3BF9A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGHMFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 08:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhGHMFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625745743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irJWbsazcANgVH4MXpW0qDIuSKTyiYEmedYDwUz4854=;
        b=haKNQXNcFHZeHhD4SIZ4O+M4e2+PBDs8ZONfC3rovUB+u4aKjdHk86tTUfFJDY919MWoOf
        imEpLNVwvjeOaMf7z+DvRowalms2YGGn2koW4UA/Bc5aEtRB1dtq4UXQ4k6vmubr5MABXK
        rL1yS5FSY+XlEe/hlvNukiwGcxwbKi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-7quC6f1YNGOg_60yIhjsTA-1; Thu, 08 Jul 2021 08:02:20 -0400
X-MC-Unique: 7quC6f1YNGOg_60yIhjsTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F55BBEE0;
        Thu,  8 Jul 2021 12:02:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D7525C1C2;
        Thu,  8 Jul 2021 12:02:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  8 Jul 2021 14:02:17 +0200 (CEST)
Date:   Thu, 8 Jul 2021 14:02:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Vladimir Divjak <vladimir.divjak@bmw.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mcgrof@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] coredump: allow PTRACE_ATTACH to coredump user mode
 helper
Message-ID: <20210708120213.GA29937@redhat.com>
References: <20210705151019.989929-1-vladimir.divjak@bmw.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705151019.989929-1-vladimir.divjak@bmw.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/05, Vladimir Divjak wrote:
>
> * Problem description / Rationale:
> In automotive and/or embedded environments,
> the storage capacity to store, and/or
> network capabilities to upload
> a complete core file can easily be a limiting factor,
> making offline issue analysis difficult.

To be honest, I don't like the idea... plus the implementation looks
horrible to me, sorry.

Can't the coredump helper process simply do
ptrace(PTRACE_SEIZE, PTRACE_O_TRACEEXIT), close the pipe, and wait
for PTRACE_EVENT_EXIT ? Then it can use ptrace() as usual.

> +void cdh_unlink_current(void)
> +{
> +	struct cdh_entry *entry, *next;
> +
> +	mutex_lock(&cdh_mutex);
> +	list_for_each_entry_safe(entry, next, &cdh_list, cdh_list_link) {

Why _safe ?

> +bool cdh_ptrace_allowed(struct task_struct *task)
> +{
> +	struct cdh_entry *entry;
> +
> +	mutex_lock(&cdh_mutex);
> +	list_for_each_entry(entry, &cdh_list, cdh_list_link) {
> +		if (task_tgid_nr(entry->task_being_dumped) == task_tgid_nr(task)
> +		    && entry->helper_pid == task_tgid_nr(current)) {
> +			reinit_completion(&(entry->ptrace_done));
> +			wait_task_inactive(entry->task_being_dumped, 0);

So. IIUC, this assumes that when cdh_ptrace_allowed() returns the dumping
process must be blocked in dump_emit()->wait_for_completion(ptrace_done).
And thus ptrace_attach() can safely do task->state = TASK_TRACED.

But it is possible that __dump_emit() has already failed and task_being_dumped
sleeps in cdh_unlink_current() waiting for cdh_mutex. So it will be running
right after cdh_ptrace_allowed() drops cdh_mutex.

> +struct cdh_entry *cdh_get_entry_for_current(void)
> +{
> +	struct cdh_entry *entry;
> +
> +	list_for_each_entry(entry, &cdh_list, cdh_list_link) {
> +		if (entry->task_being_dumped == current)
> +			return entry;

Why is it safe without cdh_mutex ?

> @@ -361,6 +362,8 @@ static int ptrace_attach(struct task_struct *task, long request,
>  {
>  	bool seize = (request == PTRACE_SEIZE);
>  	int retval;
> +	bool core_state = false;
> +	bool core_trace_allowed = false;
>
>  	retval = -EIO;
>  	if (seize) {
> @@ -392,10 +395,17 @@ static int ptrace_attach(struct task_struct *task, long request,
>
>  	task_lock(task);
>  	retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +	if (unlikely(task->mm->core_state))
> +		core_state = true;

task->mm can be NULL

> +	if (!seize && unlikely(core_state)) {
> +		if (cdh_ptrace_allowed(task))
> +			core_trace_allowed = true;
> +	}

Why !seize ???

What if ptrace_attach() fails after that? Who will wake this task up ?

> +	/*
> +	 * Core state process does not process signals normally.
> +	 * set directly to TASK_TRACED if allowed by cdh_ptrace_allowed.
> +	 */
> +	if (core_trace_allowed)
> +		task->state = TASK_TRACED;

See above.

But even if I missed something, this is wrong no matter what, you should
never change another task's state.

> @@ -821,6 +838,8 @@ static int ptrace_resume(struct task_struct *child, long request,
>  {
>  	bool need_siglock;
>
> +	cdh_signal_continue(child);

takes cdh_mutex :/

Oleg.

