Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1244C246589
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHQLdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 07:33:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726795AbgHQLdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597663994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGNaFx2Jg2/WUMJiM6JmNJk/uv+6+QM3rr6hE8Ya/eo=;
        b=P8RqICs6QPjiwUtacccFnu0jwiFyLZsDk8jSw9IeK3IMB9MDqQ9cIYKeFJBmfVAamkeeoZ
        sOSWA/CGZIyRKbbnsDMF3qiDYR8hPVXBRZlY/VLPxw7GMypgsXEAU+bYQ5MKe0UvyqsPkb
        lf2Awukdd6s12GWVFLRsknC7lfYeu4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-WwqY1EEVM_-CA6hqEqDjGw-1; Mon, 17 Aug 2020 07:33:07 -0400
X-MC-Unique: WwqY1EEVM_-CA6hqEqDjGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98322E75C;
        Mon, 17 Aug 2020 11:33:04 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AC7C7D66F;
        Mon, 17 Aug 2020 11:32:57 +0000 (UTC)
Subject: Re: file metadata via fs API
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
 <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
 <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com>
Date:   Mon, 17 Aug 2020 12:32:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 12/08/2020 20:50, Linus Torvalds wrote:
> On Wed, Aug 12, 2020 at 12:34 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
>> The point of this is to give us the ability to monitor mounts from
>> userspace.
> We haven't had that before, I don't see why it's suddenly such a big deal.
>
> The notification side I understand. Polling /proc files is not the answer.
>
> But the whole "let's design this crazy subsystem for it" seems way
> overkill. I don't see anybody caring that deeply.
>
> It really smells like "do it because we can, not because we must".
>
> Who the hell cares about monitoring mounts at a kHz frequencies? If
> this is for MIS use, you want a nice GUI and not wasting CPU time
> polling.
>
> I'm starting to ignore the pull requests from David Howells, because
> by now they have had the same pattern for a couple of years now:
> esoteric new interfaces that seem overdesigned for corner-cases that
> I'm not seeing people clamoring for.
>
> I need (a) proof this is actualyl something real users care about and
> (b) way more open discussion and implementation from multiple parties.
>
> Because right now it looks like a small in-cabal of a couple of people
> who have wild ideas but I'm not seeing the wider use of it.
>
> Convince me otherwise. AGAIN. This is the exact same issue I had with
> the notification queues that I really wanted actual use-cases for, and
> feedback from actual outside users.
>
> I really think this is engineering for its own sake, rather than
> responding to actual user concerns.
>
>                 Linus
>

I've been hesitant to reply to this immediately, because I can see that 
somehow there is a significant disconnect between what you expect to 
happen, and what has actually happened in this case. Have pondered this 
for a few days, I hope that the best way forward might be to explore 
where the issues are, with the intention of avoiding a repeat in the 
future. Sometimes email is a difficult medium for these kinds of 
communication, and face to face is better, but with the lack of 
conferences/travel at the moment, that option is not open in the near 
future.

The whole plan here, leading towards the ability to get a "dump plus 
updates" view of mounts in the kernel has been evolving over time. It 
has been discussed at LSF over a number of years [1] and in fact the new 
mount API which was merged recently - I wonder if this is what you are 
referring to above as:

> I'm starting to ignore the pull requests from David Howells, because
> by now they have had the same pattern for a couple of years now

was originally proposed by Al, and also worked on by Miklos[2] in 2017 
and others. Community discussion resulted in that becoming a 
prerequisite for the later notifications/fsinfo work. This was one of 
the main reasons that David picked it up[3] to work on, but not the only 
reason. That did also appear to be logical, in that cleaning up the way 
in which arguments were handled during mount would make it much easier 
to create future generic code to handle them.

That said, the overall aim here is to solve the problem and if there are 
better solutions available then I'm sure that everyone is very open to 
those. I agree very much that monitoring at kHz frequencies is not 
useful, but at the same time, there are cases which can generate large 
amounts of mount changes in a very short time period. We want to be 
reasonably efficient, but not to over-optimise, and sometimes that is a 
fine line. We also don't want to block mounts if the notifications queue 
fills up, so some kind of resync operation would be required in the 
queue overflows. The notifications and fsinfo were designed very much as 
two sides of the same coin, but submitted separately for ease of review 
more than anything else.

You recently requested some details of real users for the notifications, 
and (I assumed) by extension fsinfo too. Ian wrote these emails [4][5] 
in direct response to your request. That is what we thought you were 
looking for, so if that isn't not quite what you meant, perhaps you 
could clarify a bit more. Again, apologies if we've misinterpreted what 
you were asking for.

You also mention "...it looks like a small in-cabal of a couple of 
people..." and I hope that it doesn't look that way, it is certainly not 
our intention. There have been a fair number of people involved, and 
we've done our best to ensure that the development is guided by the 
potential users, such as autofs, AFS and systemd. If there are others 
out there with use cases, and particularly so if the use case is a GUI 
file manager type application who'd like to get involved, then please 
do. We definitely want to see involvement from end users, since there is 
no point in spending a large effort creating something that is then 
never used. As you pointed that out above, this kind of application was 
very much part of the original motivation, but we had started with the 
other users since there were clearly defined use cases that could 
demonstrate significant performance gains in those cases.

So hopefully that helps to give a bit more background about where we are 
and how we got here. Where we go next will no doubt depend on the 
outcome of the current discussions, and any guidance you can give around 
how we should have better approached this would be very helpful at this 
stage,

Steve.


[1] https://lwn.net/Articles/718803/

[2] https://lwn.net/Articles/718638/

[3] https://lwn.net/Articles/753473/

[4] https://lkml.org/lkml/2020/6/2/1182

[5] 
https://lore.kernel.org/linux-fsdevel/8eb2e52f1cbdbb8bcf5c5205a53bdc9aaa11a071.camel@themaw.net/


