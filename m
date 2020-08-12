Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC29242F68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHLTea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:34:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726756AbgHLTe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597260866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9pSEoniKEkFNSbD4TVkJ4Otoswkj5jDImE3i/ppi82o=;
        b=XzEheugoQtlYzcbFfnnod43CgVF2mWOJpalaOEUxK3g4qw1aIxdwyNUjylFSg6SfLh7CQL
        /pqYKVFNw3SYlGWlkz9+MJfTiO+8FQ5cDP/3RsfzwQ7Qnti5UnZ995C0oTFG4kwcS8ImcL
        pCo4h9En890oxqdIb7vYMlwsXe8e7aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-PsWf2ViBP-2ePLGug1Gcog-1; Wed, 12 Aug 2020 15:34:23 -0400
X-MC-Unique: PsWf2ViBP-2ePLGug1Gcog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B39E61902EB3;
        Wed, 12 Aug 2020 19:34:20 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 239A3100AE52;
        Wed, 12 Aug 2020 19:34:13 +0000 (UTC)
Subject: Re: file metadata via fs API
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
Date:   Wed, 12 Aug 2020 20:34:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 12/08/2020 19:18, Linus Torvalds wrote:
> On Tue, Aug 11, 2020 at 5:05 PM David Howells <dhowells@redhat.com> wrote:
>> Well, the start of it was my proposal of an fsinfo() system call.
> Ugh. Ok, it's that thing.
>
> This all seems *WAY* over-designed - both your fsinfo and Miklos' version.
>
> What's wrong with fstatfs()? All the extra magic metadata seems to not
> really be anything people really care about.
>
> What people are actually asking for seems to be some unique mount ID,
> and we have 16 bytes of spare information in 'struct statfs64'.
>
> All the other fancy fsinfo stuff seems to be "just because", and like
> complete overdesign.
>
> Let's not add system calls just because we can.
>
>               Linus
>

The point of this is to give us the ability to monitor mounts from 
userspace. The original inspiration was rtnetlink, in that we need a 
"dump" operation to give us a snapshot of the current mount state, plus 
then a stream of events which allow us to keep that state updated. The 
tricky question is what happens in case of overflow of the events queue, 
and just like netlink, that needs a resync of the current state to fix 
that, since we can't block mounts, of course.

The fsinfo syscall was designed to be the "dump" operation in this 
system. David's other patch set provides the stream of events. So the 
two are designed to work together. We had the discussion on using 
netlink, of whatever form a while back, and there are a number of 
reasons why that doesn't work (namespace being one).

I think fstatfs might also suffer from the issue of not being easy to 
call on things for which you have no path (e.g. over-mounted mounts) 
Plus we need to know which paths to query, which is why we need to 
enumerate the mounts in the first place - how would we get the fds for 
each mount? It might give you some sb info, but it doesn't tell you the 
options that the sb is mounted with, and it doesn't tell you where it is 
mounted either.

The overall aim is to solve some issues relating to scaling to large 
numbers of mount in systemd and autofs, and also to provide a 
generically useful interface that other tools may use to monitor mounts 
in due course too. Currently parsing /proc/mounts is the only option, 
and that tends to be slow and is certainly not atomic. Extension to 
other sb related messages is a future goal, quota being one possible 
application for the notifications.

If there is a simpler way to get to that goal, then thats all to the 
good, and we should definitely consider it,

Steve.




