Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6BC6497C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 02:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLLBwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 20:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiLLBwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1073D2E9
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670809875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60f4Xv2PrgnMPYC6/emmrTXGIgNiLNjayDFVJUFJfss=;
        b=XseIVNfIRk9fbLeBcF283GkIIcwnuhVswu0VohJDXM0hmay8xxm+dlPK65COEH+Ms1EeHG
        p3Fx0vcTndGDHeq+tOxzM1Ruj6pWiHo4NY5W+rP0xeImw7wRoWi4NOC3DIcwqwjGogUiAL
        rJBhyDmdLYW/qffhUpl1vy0w/3otrCI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-4SHpMdbCO1Sf7DIt0tJnKg-1; Sun, 11 Dec 2022 20:51:13 -0500
X-MC-Unique: 4SHpMdbCO1Sf7DIt0tJnKg-1
Received: by mail-pg1-f200.google.com with SMTP id g1-20020a636b01000000b00479222d9875so4052665pgc.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60f4Xv2PrgnMPYC6/emmrTXGIgNiLNjayDFVJUFJfss=;
        b=z33vuZjAJRtzk6b0mlKsRuonvstBUAiPa1O9YROOlBtIk4JHcLdGD3mx1JaTaORL5k
         MlBY0jRXLNzXGE95SH3PWfbl6dHdfEMzX/JOcRfiR8qOSfYe46V0tXEuhmOa/mJ4B17h
         ThGp/jmnOpQJLj5I5hxiIskc4Bt5m5jAt2+X7Yb4RSSPpyknvWCAyYvoZpgZxKU5hIP7
         Bct26Ger6CVvglXte+NNmIHBQJpph/cCOcdnyPWshj5eDQECKux9ZUqKeKHUguF/7s1l
         mXGhnLkZ6EoBMrVTT38p823ZhdBjRNDPJ96JyyvEK9ZjG5VBtNg6kJfadshhlpOe/GFE
         Cwsw==
X-Gm-Message-State: ANoB5pmpcfTMxippGkyZSdsRVVPKjmQ2bC3LWef+UvhxNUP2+CnU0whN
        C9j2dWnovShv51WaIgLNCAV68VewCkuckEM4yFbQC/zvn5FeccbBukX8+JrPR5RIubKka1QpmRl
        UYmF2HhXvYnUIuYisHoJLfmqNlA==
X-Received: by 2002:a05:6a00:10cd:b0:56c:3e38:bf0e with SMTP id d13-20020a056a0010cd00b0056c3e38bf0emr18440781pfu.11.1670809872447;
        Sun, 11 Dec 2022 17:51:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf587NRhM6OVheRY/MbptuX/ZhFOPnacgTDgDlB18t7/QTrM6a6ECUroMCCqMDEs2WFOy2CMaQ==
X-Received: by 2002:a05:6a00:10cd:b0:56c:3e38:bf0e with SMTP id d13-20020a056a0010cd00b0056c3e38bf0emr18440762pfu.11.1670809872160;
        Sun, 11 Dec 2022 17:51:12 -0800 (PST)
Received: from ?IPV6:2403:580e:4b40:0:7968:2232:4db8:a45e? (2403-580e-4b40--7968-2232-4db8-a45e.ip6.aussiebb.net. [2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp.gmail.com with ESMTPSA id c7-20020aa79527000000b0057255b82bd1sm4513759pfp.217.2022.12.11.17.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 17:51:11 -0800 (PST)
Message-ID: <89b892c0-7dd9-3a98-99c8-6db83c5a7200@redhat.com>
Date:   Mon, 12 Dec 2022 09:51:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 4/5] pid: mark pids associated with group leader tasks
Content-Language: en-US
To:     Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onestero@redhat.com, willy@infradead.org, ebiederm@redhat.com
References: <20221202171620.509140-1-bfoster@redhat.com>
 <20221202171620.509140-5-bfoster@redhat.com>
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <20221202171620.509140-5-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/12/22 01:16, Brian Foster wrote:
> Searching the pid_namespace for group leader tasks is a fairly
> inefficient operation. Listing the root directory of a procfs mount
> performs a linear scan of allocated pids, checking each entry for an
> associated PIDTYPE_TGID task to determine whether to populate a
> directory entry. This can cause a significant increase in readdir()
> syscall latency when run in namespaces that might have one or more
> processes with significant thread counts.
>
> To facilitate improved TGID pid searches, mark the ids of pid
> entries that are likely to have an associated PIDTYPE_TGID task. To
> keep the code simple and avoid having to maintain synchronization
> between mark state and post-fork pid-task association changes, the
> mark is applied to all pids allocated for tasks cloned without
> CLONE_THREAD.
>
> This means that it is possible for a pid to remain marked in the
> xarray after being disassociated from the group leader task. For
> example, a process that does a setsid() followed by fork() and
> exit() (to daemonize) will remain associated with the original pid
> for the session, but link with the child pid as the group leader.
> OTOH, the only place other than fork() where a tgid association
> occurs is in the exec() path, which kills all other tasks in the
> group and associates the current task with the preexisting leader
> pid. Therefore, the semantics of the mark are that false positives
> (marked pids without PIDTYPE_TGID tasks) are possible, but false
> negatives (unmarked pids without PIDTYPE_TGID tasks) should never
> occur.
>
> This is an effective optimization because false negatives are fairly
> uncommon and don't add overhead (i.e. we already have to check
> pid_task() for marked entries), but still filters out thread pids
> that are guaranteed not to have TGID task association.
>
> Mark entries in the pid allocation path when the caller specifies
> that the pid associates with a new thread group. Since false
> negatives are not allowed, warn in the event that a PIDTYPE_TGID
> task is ever attached to an unmarked pid. Finally, create a helper
> to implement the task search based on the mark semantics defined
> above (based on search logic currently implemented by next_tgid() in
> procfs).

Yes, the tricky bit, but the analysis sounds thorough so it

should work for all cases ...


>
> Signed-off-by: Brian Foster <bfoster@redhat.com>


Reviewed-by: Ian Kent <raven@themaw.net>

> ---
>   include/linux/pid.h |  3 ++-
>   kernel/fork.c       |  2 +-
>   kernel/pid.c        | 44 +++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 343abf22092e..64caf21be256 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -132,9 +132,10 @@ extern struct pid *find_vpid(int nr);
>    */
>   extern struct pid *find_get_pid(int nr);
>   extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
> +struct task_struct *find_get_tgid_task(int *id, struct pid_namespace *);
>   
>   extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> -			     size_t set_tid_size);
> +			     size_t set_tid_size, bool group_leader);
>   extern void free_pid(struct pid *pid);
>   extern void disable_pid_allocation(struct pid_namespace *ns);
>   
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 08969f5aa38d..1cf2644c642e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2267,7 +2267,7 @@ static __latent_entropy struct task_struct *copy_process(
>   
>   	if (pid != &init_struct_pid) {
>   		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid,
> -				args->set_tid_size);
> +				args->set_tid_size, !(clone_flags & CLONE_THREAD));
>   		if (IS_ERR(pid)) {
>   			retval = PTR_ERR(pid);
>   			goto bad_fork_cleanup_thread;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 53db06f9882d..d65f74c6186c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -66,6 +66,9 @@ int pid_max = PID_MAX_DEFAULT;
>   int pid_max_min = RESERVED_PIDS + 1;
>   int pid_max_max = PID_MAX_LIMIT;
>   
> +/* MARK_0 used by XA_FREE_MARK */
> +#define TGID_MARK	XA_MARK_1
> +
>   struct pid_namespace init_pid_ns = {
>   	.ns.count = REFCOUNT_INIT(2),
>   	.xa = XARRAY_INIT(init_pid_ns.xa, PID_XA_FLAGS),
> @@ -137,7 +140,7 @@ void free_pid(struct pid *pid)
>   }
>   
>   struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> -		      size_t set_tid_size)
> +		      size_t set_tid_size, bool group_leader)
>   {
>   	struct pid *pid;
>   	enum pid_type type;
> @@ -257,6 +260,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   
>   		/* Make the PID visible to find_pid_ns. */
>   		__xa_store(&tmp->xa, upid->nr, pid, 0);
> +		if (group_leader)
> +			__xa_set_mark(&tmp->xa, upid->nr, TGID_MARK);
>   		tmp->pid_allocated++;
>   		xa_unlock_irq(&tmp->xa);
>   	}
> @@ -314,6 +319,11 @@ static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
>   void attach_pid(struct task_struct *task, enum pid_type type)
>   {
>   	struct pid *pid = *task_pid_ptr(task, type);
> +	struct pid_namespace *pid_ns = ns_of_pid(pid);
> +	pid_t pid_nr = pid_nr_ns(pid, pid_ns);
> +
> +	WARN_ON(type == PIDTYPE_TGID &&
> +		!xa_get_mark(&pid_ns->xa, pid_nr, TGID_MARK));
>   	hlist_add_head_rcu(&task->pid_links[type], &pid->tasks[type]);
>   }
>   
> @@ -506,6 +516,38 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>   }
>   EXPORT_SYMBOL_GPL(find_ge_pid);
>   
> +/*
> + * Used by proc to find the first thread group leader task with an id greater
> + * than or equal to *id.
> + *
> + * Use the xarray mark as a hint to find the next best pid. The mark does not
> + * guarantee a linked group leader task exists, so retry until a suitable entry
> + * is found.
> + */
> +struct task_struct *find_get_tgid_task(int *id, struct pid_namespace *ns)
> +{
> +	struct pid *pid;
> +	struct task_struct *t;
> +	unsigned long nr = *id;
> +
> +	rcu_read_lock();
> +	do {
> +		pid = xa_find(&ns->xa, &nr, ULONG_MAX, TGID_MARK);
> +		if (!pid) {
> +			rcu_read_unlock();
> +			return NULL;
> +		}
> +		t = pid_task(pid, PIDTYPE_TGID);
> +		nr++;
> +	} while (!t);
> +
> +	*id = pid_nr_ns(pid, ns);
> +	get_task_struct(t);
> +	rcu_read_unlock();
> +
> +	return t;
> +}
> +
>   struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
>   {
>   	struct fd f;

