Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4ACABD64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 18:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfIFQMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 12:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfIFQMU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:12:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC0284E832;
        Fri,  6 Sep 2019 16:12:19 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0823CC8;
        Fri,  6 Sep 2019 16:12:15 +0000 (UTC)
Subject: Re: Why add the general notification queue and its sources
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk>
 <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
 <5396.1567719164@warthog.procyon.org.uk>
 <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
 <14883.1567725508@warthog.procyon.org.uk>
 <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com>
 <27732.1567764557@warthog.procyon.org.uk>
 <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
 <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <8e60555e-9247-e03f-e8b4-1d31f70f1221@redhat.com>
Date:   Fri, 6 Sep 2019 17:12:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 06 Sep 2019 16:12:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 06/09/2019 16:53, Linus Torvalds wrote:
> On Fri, Sep 6, 2019 at 8:35 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> This is why I like pipes. You can use them today. They are simple, and
>> extensible, and you don't need to come up with a new subsystem and
>> some untested ad-hoc thing that nobody has actually used.
> The only _real_ complexity is to make sure that events are reliably parseable.
>
> That's where you really want to use the Linux-only "packet pipe"
> thing, becasue otherwise you have to have size markers or other things
> to delineate events. But if you do that, then it really becomes
> trivial.
>
> And I checked, we made it available to user space, even if the
> original reason for that code was kernel-only autofs use: you just
> need to make the pipe be O_DIRECT.
>
> This overly stupid program shows off the feature:
>
>          #define _GNU_SOURCE
>          #include <fcntl.h>
>          #include <unistd.h>
>
>          int main(int argc, char **argv)
>          {
>                  int fd[2];
>                  char buf[10];
>
>                  pipe2(fd, O_DIRECT | O_NONBLOCK);
>                  write(fd[1], "hello", 5);
>                  write(fd[1], "hi", 2);
>                  read(fd[0], buf, sizeof(buf));
>                  read(fd[0], buf, sizeof(buf));
>                  return 0;
>          }
>
> and it you strace it (because I was too lazy to add error handling or
> printing of results), you'll see
>
>      write(4, "hello", 5)                    = 5
>      write(4, "hi", 2)                       = 2
>      read(3, "hello", 10)                    = 5
>      read(3, "hi", 10)                       = 2
>
> note how you got packets of data on the reader side, instead of
> getting the traditional "just buffer it as a stream".
>
> So now you can even have multiple readers of the same event pipe, and
> packetization is obvious and trivial. Of course, I'm not sure why
> you'd want to have multiple readers, and you'd lose _ordering_, but if
> all events are independent, this _might_ be a useful thing in a
> threaded environment. Maybe.
>
> (Side note: a zero-sized write will not cause a zero-sized packet. It
> will just be dropped).
>
>                 Linus

The events are generally not independent - we would need ordering either 
implicit in the protocol or explicit in the messages. We also need to 
know in case messages are dropped too - doesn't need to be anything 
fancy, just some idea that since we last did a read, there are messages 
that got lost, most likely due to buffer overrun.

That is why the initial idea was to use netlink, since it solves a lot 
of those issues. The downside was that the indirect nature of the 
netlink sockets resulted in making it tricky to know the namespace of 
the process to which the message was to be delivered (and hence whether 
it should be delivered at all),

Steve.

