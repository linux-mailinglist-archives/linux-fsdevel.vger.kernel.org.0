Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD31773F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 11:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgCCKWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 05:22:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55857 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728102AbgCCKWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583230935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uy9QGkzP3M7ePq29WQyT+XeoSg6l7Sp/Eya8JeglC7c=;
        b=MpSeNUymUgIiMUQKHFatRjGZMUsGH/bA/jPGo5AnhSFTGvlVtYc6Rm3qqPnILNzh6XfjEo
        4i0gkVz8DJXUmNEMk/QtyFz+1gxDtPDu4BBbPOpiKUj+H1a5hVJJ3Oz1Z0mcWpoar3WFzM
        6mW+7y+pEHdi6dPGKz3LMkd6D6/bggk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-M1Qs26YlPxSbtksrXLRmBQ-1; Tue, 03 Mar 2020 05:22:14 -0500
X-MC-Unique: M1Qs26YlPxSbtksrXLRmBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BFFB800D5F;
        Tue,  3 Mar 2020 10:22:12 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 583C760BF3;
        Tue,  3 Mar 2020 10:22:00 +0000 (UTC)
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com>
 <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <CAJfpegtemv64mpmTRT6ViHmsWq4nNE4KQvuHkNCYozRU7dQd8Q@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <06d2dbf0-4580-3812-bb14-34c6aa615747@redhat.com>
Date:   Tue, 3 Mar 2020 10:21:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegtemv64mpmTRT6ViHmsWq4nNE4KQvuHkNCYozRU7dQd8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 03/03/2020 09:48, Miklos Szeredi wrote:
> On Tue, Mar 3, 2020 at 10:26 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Tue, Mar 3, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:
>>> Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>
>>>> I'm doing a patch.   Let's see how it fares in the face of all these
>>>> preconceptions.
>>> Don't forget the efficiency criterion.  One reason for going with fsinfo(2) is
>>> that scanning /proc/mounts when there are a lot of mounts in the system is
>>> slow (not to mention the global lock that is held during the read).
> BTW, I do feel that there's room for improvement in userspace code as
> well.  Even quite big mount table could be scanned for *changes* very
> efficiently.  l.e. cache previous contents of /proc/self/mountinfo and
> compare with new contents, line-by-line.  Only need to parse the
> changed/added/removed lines.
>
> Also it would be pretty easy to throttle the number of updates so
> systemd et al. wouldn't hog the system with unnecessary processing.
>
> Thanks,
> Miklos
>

At least having patches to compare would allow us to look at the 
performance here and gain some numbers, which would be helpful to frame 
the discussions. However I'm not seeing how it would be easy to throttle 
updates... they occur at whatever rate they are generated and this can 
be fairly high. Also I'm not sure that I follow how the notifications 
and the dumping of the whole table are synchronized in this case, either.

Al has pointed out before that a single mount operation on a subtree can 
generate a large number of changes on that subtree. That kind of 
scenario will need to be dealt with efficiently so that we don't miss 
things, and we also minimize the possibility of overruns, and additional 
overhead on the mount changes themselves, by keeping the notification 
messages small.

We should also look at what the likely worst case might be. I seem to 
remember from what Ian has said in the past that there can be tens of 
thousands of autofs mounts on some large systems. I assume that worst 
case might be something like that, but multiplied by however many 
containers might be on a system. Can anybody think of a situation which 
might require even more mounts?

The network subsystem had a similar problem... they use rtnetlink for 
the routing information, and just like the proposal here it contains a 
dump mechanism, and a way to listen to events (add/remove routes) which 
is synchronized with that dump. Ian did start looking at netlink some 
time ago, but it also has some issues (it is in the network namespace 
not the fs namespace, it also has various things accumulated over the 
years that we don't need for filesystems) but that was part of the 
original inspiration for the fs notifications.

There is also, of course, /proc/net/route which can be useful in many 
circumstances, but for efficiency and synchronization reasons if is not 
the interface of choice for routing protocols. David's proposal has a 
number of the important attributes of an rtnetlink-like (in a conceptual 
sense) solution, and I remain skeptical that a /sysfs or similar 
interface would be an efficient solution to the original problem, even 
if it might perhaps make a useful addition.

There is also the chicken-and-egg issue, in the sense that if the 
interface is via a filesystem (sysfs, proc or whatever), how does one 
receive a notification for that filesystem itself being mounted until 
after it has been mounted? Maybe that is not a particular problem, but I 
think a cleaner solution would not require a mount in order to watch for 
other mounts,

Steve.



