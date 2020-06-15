Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E491F9E3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgFOROM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 13:14:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54856 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731226AbgFOROI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592241246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laujHXtNzuWRWuumln1La0bpzgZIGk/wirXDlUO/7Ek=;
        b=PKzDttg0lA9FLiqQMChpJlGa7om0/4/IAb3nUb3sX6K+/U3YWZTRBhMuEhXqgu0mW4GJ7U
        7wJZSDiBqfJj6/ABldlWXCe4ezQZpQOEPqmEf7OGgUhD39Ktpn0WWrbGe0qHisX1z5WyYk
        WDyKP1el+XVSbi4j7r0Wb0+gyfM/9IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-0ataK8GQPYKHIOZZVTHhuQ-1; Mon, 15 Jun 2020 13:14:02 -0400
X-MC-Unique: 0ataK8GQPYKHIOZZVTHhuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF6418585A7;
        Mon, 15 Jun 2020 17:13:58 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34B6A5C1D6;
        Mon, 15 Jun 2020 17:13:52 +0000 (UTC)
Subject: Re: possible deadlock in send_sigio
To:     Matthew Wilcox <willy@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
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
 <20200615164902.GV8681@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0c854a69-9b89-9e45-f2c1-e60e2a9d3f1c@redhat.com>
Date:   Mon, 15 Jun 2020 13:13:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200615164902.GV8681@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/20 12:49 PM, Matthew Wilcox wrote:
> On Fri, Jun 12, 2020 at 03:01:01PM +0800, Boqun Feng wrote:
>> On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
>> read lock, actually it's only recursive if in_interrupt() is true. So
>> change the annotation accordingly to catch more deadlocks.
> [...]
>
>> +#ifdef CONFIG_LOCKDEP
>> +/*
>> + * read_lock() is recursive if:
>> + * 1. We force lockdep think this way in selftests or
>> + * 2. The implementation is not queued read/write lock or
>> + * 3. The locker is at an in_interrupt() context.
>> + */
>> +static inline bool read_lock_is_recursive(void)
>> +{
>> +	return force_read_lock_recursive ||
>> +	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
>> +	       in_interrupt();
>> +}
> I'm a bit uncomfortable with having the _lockdep_ definition of whether
> a read lock is recursive depend on what the _implementation_ is.
> The locking semantics should be the same, no matter which architecture
> you're running on.  If we rely on read locks being recursive in common
> code then we have a locking bug on architectures which don't use queued
> rwlocks.
>
> I don't know whether we should just tell the people who aren't using
> queued rwlocks that they have a new requirement or whether we should
> say that read locks are never recursive, but having this inconsistency
> is not a good idea!

Actually, qrwlock is more restrictive. It is possible that systems with 
qrwlock may hit deadlock which doesn't happens in other systems that use 
recursive rwlock. However, the current lockdep code doesn't detect those 
cases.

Changing lockdep to only use qrwlock semantics can be problematic as the 
code hunk in locking selftest is due to the fact that it assumes 
recursive lock. So we need to change that. Anyway, this patch can allow 
us to see if current qrwlock semantics may have potential deadlock 
problem in the current code. I actually have bug report about deadlock 
due to qrwlock semantics in RHEL7. So I would certainly like to see if 
the current upstream code may have also this kind of problem.

Cheers,
Longman

