Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5A1F9D98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgFOQhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:37:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729772AbgFOQho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592239061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/F86sDejhlUEqRwVwDh76wLLWekpmeDUzYfAKQeYOc=;
        b=dmOQwNv6q60lHU9xbm7VzHrVu+4xJsDqQ+qv51pe3NXuStlqaiNMAgUA8dMsmR9UfJeoOS
        EowJaH/4y3RN+oH1vRLH4WPDt0pVemr2qv0zZLbY5qlfKVtYMfWNj94cN0bKyNxi79eTNu
        1rOSjgMco3CpiaelcO4SeC9z14Z3gAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-j2t8gLqFMsmI5YdEf7dy2w-1; Mon, 15 Jun 2020 12:37:37 -0400
X-MC-Unique: j2t8gLqFMsmI5YdEf7dy2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF6CA107AD74;
        Mon, 15 Jun 2020 16:37:33 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6379C19C66;
        Mon, 15 Jun 2020 16:37:27 +0000 (UTC)
Subject: Re: possible deadlock in send_sigio
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000760d0705a270ad0c@google.com>
 <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
 <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
 <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200612070101.GA879624@tardis>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d48b4102-7b6a-e239-2eee-3acadfd0f7f9@redhat.com>
Date:   Mon, 15 Jun 2020 12:37:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200612070101.GA879624@tardis>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/20 3:01 AM, Boqun Feng wrote:
> On Fri, Jun 12, 2020 at 07:55:26AM +0800, Boqun Feng wrote:
>> Hi Peter and Waiman,
>>
>> On Thu, Jun 11, 2020 at 12:09:59PM -0400, Waiman Long wrote:
>>> On 6/11/20 10:22 AM, Peter Zijlstra wrote:
>>>> On Thu, Jun 11, 2020 at 09:51:29AM -0400, Waiman Long wrote:
>>>>
>>>>> There was an old lockdep patch that I think may address the issue, but was
>>>>> not merged at the time. I will need to dig it out and see if it can be
>>>>> adapted to work in the current kernel. It may take some time.
>>>> Boqun was working on that; I can't remember what happened, but ISTR it
>>>> was shaping up nice.
>>>>
>>> Yes, I am talking about Boqun's patch. However, I think he had moved to
>>> another company and so may not be able to actively work on that again.
>>>
>> I think you are talking about the rescursive read deadlock detection
>> patchset:
>>
>> 	https://lore.kernel.org/lkml/20180411135110.9217-1-boqun.feng@gmail.com/
>>
>> Let me have a good and send a new version based on today's master of tip
>> tree.
>>
> FWIW, with the following patch, I think we can avoid to the false
> positives. But solely with this patch, we don't have the ability to
> detect deadlocks with recursive locks..
>
> I've managed to rebase my patchset, but need some time to tweak it to
> work properly, in the meantime, Dmitry, could you give this a try?
>
> Regards,
> Boqun
>
> ------------->8
> Subject: [PATCH] locking: More accurate annotations for read_lock()
>
> On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
> read lock, actually it's only recursive if in_interrupt() is true. So
> change the annotation accordingly to catch more deadlocks.
>
> Note we used to treat read_lock() as pure recursive read locks in
> lib/locking-seftest.c, and this is useful, especially for the lockdep
> development selftest, so we keep this via a variable to force switching
> lock annotation for read_lock().
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>   include/linux/lockdep.h | 35 ++++++++++++++++++++++++++++++++++-
>   lib/locking-selftest.c  | 11 +++++++++++
>   2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 8fce5c98a4b0..50aedbba0812 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -43,6 +43,7 @@ enum lockdep_wait_type {
>   #include <linux/list.h>
>   #include <linux/debug_locks.h>
>   #include <linux/stacktrace.h>
> +#include <linux/preempt.h>
>   
>   /*
>    * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
> @@ -640,6 +641,31 @@ static inline void print_irqtrace_events(struct task_struct *curr)
>   }
>   #endif
>   
> +/* Variable used to make lockdep treat read_lock() as recursive in selftests */
> +#ifdef CONFIG_DEBUG_LOCKING_API_SELFTESTS
> +extern unsigned int force_read_lock_recursive;
> +#else /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
> +#define force_read_lock_recursive 0
> +#endif /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
> +
> +#ifdef CONFIG_LOCKDEP
> +/*
> + * read_lock() is recursive if:
> + * 1. We force lockdep think this way in selftests or
> + * 2. The implementation is not queued read/write lock or
> + * 3. The locker is at an in_interrupt() context.
> + */
> +static inline bool read_lock_is_recursive(void)
> +{
> +	return force_read_lock_recursive ||
> +	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
> +	       in_interrupt();
> +}
> +#else /* CONFIG_LOCKDEP */
> +/* If !LOCKDEP, the value is meaningless */
> +#define read_lock_is_recursive() 0
> +#endif
> +
>   /*
>    * For trivial one-depth nesting of a lock-class, the following
>    * global define can be used. (Subsystems with multiple levels
> @@ -661,7 +687,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
>   #define spin_release(l, i)			lock_release(l, i)
>   
>   #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
> -#define rwlock_acquire_read(l, s, t, i)		lock_acquire_shared_recursive(l, s, t, NULL, i)
> +#define rwlock_acquire_read(l, s, t, i)					\
> +do {									\
> +	if (read_lock_is_recursive())					\
> +		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
> +	else								\
> +		lock_acquire_shared(l, s, t, NULL, i);			\
> +} while (0)
> +
>   #define rwlock_release(l, i)			lock_release(l, i)
>   
>   #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 14f44f59e733..caadc4dd3368 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -28,6 +28,7 @@
>    * Change this to 1 if you want to see the failure printouts:
>    */
>   static unsigned int debug_locks_verbose;
> +unsigned int force_read_lock_recursive;
>   
>   static DEFINE_WD_CLASS(ww_lockdep);
>   
> @@ -1978,6 +1979,11 @@ void locking_selftest(void)
>   		return;
>   	}
>   
> +	/*
> +	 * treats read_lock() as recursive read locks for testing purpose
> +	 */
> +	force_read_lock_recursive = 1;
> +
>   	/*
>   	 * Run the testsuite:
>   	 */
> @@ -2073,6 +2079,11 @@ void locking_selftest(void)
>   
>   	ww_tests();
>   
> +	force_read_lock_recursive = 0;
> +	/*
> +	 * queued_read_lock() specific test cases can be put here
> +	 */
> +
>   	if (unexpected_testcase_failures) {
>   		printk("-----------------------------------------------------------------\n");
>   		debug_locks = 0;

Your patch looks good to me.

Reviewed-by: Waiman Long <longman@redhat.com>

