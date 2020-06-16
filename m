Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BD11FA529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 02:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgFPAbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 20:31:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726624AbgFPAbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592267479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1u3VhZiN1CG3z8hT45OLNwL3A84N3hwCn1n6w/03g5U=;
        b=HhWI44vrgaKOq5LBac2R5+9vQVR8eLo58WDjOplvdxso4JoP5BIxU3gekVoyDp3tDr0TA9
        xpv05cil5khVo/SpKH1gc6Xruyyw6YVOlWVQpVORPsRAXm8Vex0fRYrx9gjOWVsxNOaS6s
        R9kIj9eIJo95tvAfx+znHRyAaW8Yj6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-bM894ImQN4CeJoAVRa_pyQ-1; Mon, 15 Jun 2020 20:31:16 -0400
X-MC-Unique: bM894ImQN4CeJoAVRa_pyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E06C803330;
        Tue, 16 Jun 2020 00:31:11 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3309C19C79;
        Tue, 16 Jun 2020 00:31:01 +0000 (UTC)
Subject: Re: possible deadlock in send_sigio
To:     Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
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
References: <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
 <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
 <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200612070101.GA879624@tardis>
 <20200615164902.GV8681@bombadil.infradead.org>
 <0c854a69-9b89-9e45-f2c1-e60e2a9d3f1c@redhat.com>
 <20200615204046.GW8681@bombadil.infradead.org>
 <20200616001319.GA925161@tardis>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cd1554bb-bbcc-ddfc-f48e-33642dd46ddf@redhat.com>
Date:   Mon, 15 Jun 2020 20:31:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200616001319.GA925161@tardis>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/20 8:13 PM, Boqun Feng wrote:
> Hi Matthew,
>
> On Mon, Jun 15, 2020 at 01:40:46PM -0700, Matthew Wilcox wrote:
>> On Mon, Jun 15, 2020 at 01:13:51PM -0400, Waiman Long wrote:
>>> On 6/15/20 12:49 PM, Matthew Wilcox wrote:
>>>> On Fri, Jun 12, 2020 at 03:01:01PM +0800, Boqun Feng wrote:
>>>>> On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
>>>>> read lock, actually it's only recursive if in_interrupt() is true. So
>>>>> change the annotation accordingly to catch more deadlocks.
>>>> [...]
>>>>
>>>>> +#ifdef CONFIG_LOCKDEP
>>>>> +/*
>>>>> + * read_lock() is recursive if:
>>>>> + * 1. We force lockdep think this way in selftests or
>>>>> + * 2. The implementation is not queued read/write lock or
>>>>> + * 3. The locker is at an in_interrupt() context.
>>>>> + */
>>>>> +static inline bool read_lock_is_recursive(void)
>>>>> +{
>>>>> +	return force_read_lock_recursive ||
>>>>> +	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
>>>>> +	       in_interrupt();
>>>>> +}
>>>> I'm a bit uncomfortable with having the _lockdep_ definition of whether
>>>> a read lock is recursive depend on what the _implementation_ is.
>>>> The locking semantics should be the same, no matter which architecture
>>>> you're running on.  If we rely on read locks being recursive in common
>>>> code then we have a locking bug on architectures which don't use queued
>>>> rwlocks.
>>>>
>>>> I don't know whether we should just tell the people who aren't using
>>>> queued rwlocks that they have a new requirement or whether we should
>>>> say that read locks are never recursive, but having this inconsistency
>>>> is not a good idea!
>>> Actually, qrwlock is more restrictive. It is possible that systems with
>>> qrwlock may hit deadlock which doesn't happens in other systems that use
>>> recursive rwlock. However, the current lockdep code doesn't detect those
>>> cases.
>> Oops.  I misread.  Still, my point stands; we should have the same
>> definition of how you're allowed to use locks from the lockdep point of
>> view, even if the underlying implementation won't deadlock on a particular
>> usage model.
>>
> I understand your point, but such a change will require us to notify
> almost every developer using rwlocks and help them to get their code
> right, and that requires time and work, while currently I want to focus
> on the correctness of the detection, and without that being merged, we
> don't have a way to detect those problems. So I think it's better that
> we have the detection reviewed and tested for a while (given that x86
> uses qrwlock, so it will get a lot chances for testing), after that we
> we have the confidence (and the tool) to educate people the "new"
> semantics of rwlock. So I'd like to keep this patch as it is for now.

I agreed. We may have architectures that use recursive rwlocks and 
depend on that behavior in the arch specific code. So there can be false 
positive lockdep warnings when we force rwlock to use qrwlock behavior 
for all archs.

With the current patch, we can check the x86 and generic code to make 
sure that they don't have problem first. When other architectures decide 
to use the generic qrwlock later, they can find out if there are some 
inherent problems in their arch specific code.

Cheers,
Longman

