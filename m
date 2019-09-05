Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D464AAB36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 20:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbfIESho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 14:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732093AbfIEShn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:37:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5A793090FD1;
        Thu,  5 Sep 2019 18:37:42 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA512600F8;
        Thu,  5 Sep 2019 18:37:38 +0000 (UTC)
Subject: Re: Why add the general notification queue and its sources
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rstrode@redhat.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        raven@themaw.net, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Lehman <dlehman@redhat.com>, Ian Kent <ikent@redhat.com>
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk>
 <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
Date:   Thu, 5 Sep 2019 19:37:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 05 Sep 2019 18:37:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 05/09/2019 18:19, Linus Torvalds wrote:
> On Thu, Sep 5, 2019 at 10:01 AM David Howells <dhowells@redhat.com> wrote:
>>> I'm just going to be very blunt about this, and say that there is no
>>> way I can merge any of this *ever*, unless other people stand up and
>>> say that
>>>
>>>   (a) they'll use it
>>>
>>> and
>>>
>>>   (b) they'll actively develop it and participate in testing and coding
>> Besides the core notification buffer which ties this together, there are a
>> number of sources that I've implemented, not all of which are in this patch
>> series:
> You've at least now answered part of the "Why", but you didn't
> actually answer the whole "another developer" part.
>
> I really don't like how nobody else than you seems to even look at any
> of the key handling patches. Because nobody else seems to care.
>
> This seems to be another new subsystem / driver that has the same
> pattern. If it's all just you, I don't want to merge it, because I
> really want more than just other developers doing "Reviewed-by" after
> looking at somebody elses code that they don't actually use or really
> care about.
>
> See what I'm saying?
>
> New features that go into the kernel should have multiple users. Not a
> single developer who pushes both the kernel feature and the single use
> of that feature.
>
> This very much comes from me reverting the key ACL pull. Not only did
> I revert it, ABSOLUTELY NOBODY even reacted to the revert. Nobody
> stepped up and said they they want that new ACL code, and pushed for a
> fix. There was some very little murmuring about it when Mimi at least
> figured out _why_ it broke, but other than that all the noise I saw
> about the revert was Eric Biggers pointing out it broke other things
> too, and that it had actually broken some test suites. But since it
> hadn't even been in linux-next, that too had been noticed much too
> late.
>
> See what I'm saying? This whole "David Howells does his own features
> that nobody else uses" needs to stop. You need to have a champion. I
> just don't feel safe pulling these kinds of changes from you, because
> I get the feeling that ABSOLUTELY NOBODY ELSE ever really looked at it
> or really cared.
>
> Most of the patches has nobody else even Cc'd, and even the patches
> that do have some "Reviewed-by" feel more like somebody else went "ok,
> the change looks fine to me", without any other real attachment to the
> code.
>
> New kernel features and interfaces really need to have a higher
> barrier of entry than one developer working on his or her own thing.
>
> Is that a change from 25 years ago? Or yes it is. We can point to lots
> of "single developer did a thing" from years past. But things have
> changed. And once bitten, twice shy: I really am a _lot_ more nervous
> about all these key changes now.
>
>                      Linus

There are a number of potential users, some waiting just to have a 
mechanism to avoid the racy alternatives to (for example) parsing 
/proc/mounts repeatedly, others perhaps a bit further away, but who have 
nonetheless expressed interest in having an interface which allows 
notifications for mounts.

The subject of mount notifications has been discussed at LSF/MM in the 
past too, I proposed it as a topic a little while back: 
https://www.spinics.net/lists/linux-block/msg07653.html and David's 
patch set is a potential solution to some of the issues that I raised 
there. The original series for the new mount API came from an idea of 
Al/Miklos which was also presented at LSF/MM 2017, and this is a follow 
on project. So it has not come out of nowhere, but has been something 
that has been discussed in various forums over a period of time.

Originally, there was a proposal to use netlink for the notifications, 
however that didn't seem to meet with general approval, even though Ian 
Kent did some work towards figuring out whether that would be a useful 
direction to go in.

David has since come up with the proposal presented here, which is 
intended to improve on the original proposal in various ways - mostly 
making the notifications more efficient (i.e. smaller) and also generic 
enough that it might have uses beyond the original intent of just being 
a mount notification mechanism.

The original reason for the mount notification mechanism was so that we 
are able to provide information to GUIs and similar filesystem and 
storage management tools, matching the state of the filesystem with the 
state of the underlying devices. This is part of a larger project 
entitled "Project Springfield" to try and provide better management 
tools for storage and filesystems. I've copied David Lehman in, since he 
can provide a wider view on this topic.

It is something that I do expect will receive wide use, and which will 
be tested carefully. I know that Ian Kent has started work on some 
support for libmount for example, even outside of autofs.

We do regularly hear from customers that better storage and filesystem 
management tools are something that they consider very important, so 
that is why we are spending such a lot of effort in trying to improve 
the support in this area.

I'm not sure if that really answers your question, except to say that it 
is something that is much more than a personal project of David's and 
that other people do care about it too,

Steve.


