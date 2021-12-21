Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CBC47C772
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbhLUT16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 14:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233354AbhLUT15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640114876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAqUVYyX8GGNbuDInZkyqWznH3DItMsslMtWzh73Y2E=;
        b=JIWvgfARR7K6kMEFxcKVJHnEv83uPAyPKCbBCcZO0r3wisvkMryqrGanZcdaWYoWGSfE8/
        b4xmA4eoy3f/VmajRs6X533NucpocEycLv5JWO5Bj2UJKgMScVIobPccPcGrHT07fbyivl
        hlhcQTfGlSJyYaYLJ67FPdg4mqXLFds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-iRelq30OOm2x5uJ6l-PKqA-1; Tue, 21 Dec 2021 14:27:52 -0500
X-MC-Unique: iRelq30OOm2x5uJ6l-PKqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79B74101F015;
        Tue, 21 Dec 2021 19:27:49 +0000 (UTC)
Received: from [10.22.33.162] (unknown [10.22.33.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C41F67F559;
        Tue, 21 Dec 2021 19:27:47 +0000 (UTC)
Message-ID: <7f0f8e71-cf62-4c0b-5f13-a41919c6cd9b@redhat.com>
Date:   Tue, 21 Dec 2021 14:27:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries
 irrespective of invoking users
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Willy Tarreau <w@1wt.eu>
References: <20211221021744.864115-1-longman@redhat.com>
 <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
 <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
 <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
 <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
 <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/21 13:19, Linus Torvalds wrote:
> On Tue, Dec 21, 2021 at 10:01 AM Waiman Long <longman@redhat.com> wrote:
>> Default RLIMIT_CORE to 0 will likely mitigate this vulnerability.
>> However, there are still some userspace impacts as existing behavior
>> will be modified. For instance, we may need to modify su to restore a
>> proper value for RLIMIT_CORE after successful authentication.
> We had a "clever" idea for this that I thought people were ok with.
>
> It's been some time since this came up, but iirc the notion was to
> instead of setting the rlimit to zero (which makes it really hard to
> restore afterwards, because you don't know what the restored value
> would be, so you are dependent on user space doing it), we just never
> reset set_dumpable() when we execve.
>
> So any suid exec will do set_dumpable() to suid_dumpable, and exec'ing
> something else does nothing at all - it stays non-dumpable (obviously
> "non-dumpable" here depends on the actual value for "suid_dumpable" -
> you can enable suid dump debugging manually).
>
> And instead, we say that operations like "setsid()" that start a new
> session - *those* are the ones that enable core dumping again. Or
> doing things like a "ulimit(RLIMIT_CORE)" (which clearly implies "I
> want core-dumps").
>
> Those will all very naturally make "login" and friends work correctly,
> while keeping core-dumps disabled for some suid situation that doesn't
> explicitly set up a new context.
>
> I think the basic problem with the traditional UNIX model of "suid
> exec doesn't core dump" is that the "enter non-core-dump" is a nice
> clear "your privileges changed".
>
> But then the "exit non-core-dump" thing is an exec that *doesn't*
> change privileges. That's the odd and crazy part: you just disabled
> core-dumps because there was a privilege level change, and then you
> enable core-dumps again because there *wasn't* a privilege change -
> even if you're still at those elevated privileges.
>
> Now, this is clearly not a Linux issue - we're just doing what others
> have been doing too. But I think we should just admit that "what
> others have been doing" is simply broken.
>
> And yes, some odd situation migth be broken by this kind of change,
> but I think this kind of "the old model was broken" may simply require
> that. I suspect we can find a solution that fixes all the regular
> cases.
>
> Hmm?

I think this is a pretty clever idea. At least it is better than 
resetting RLIMIT_CORE to 0. As it is all done within the kernel, there 
is no need to change any userspace code. We may need to add a flag bit 
in the task structure to indicate using the suid_dumpable setting so 
that it can be inherited across fork/exec.

Thanks for the suggestion.

Cheers,
Longman

