Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4577864F78D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 05:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLQEmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 23:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLQEmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B5140D5
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 20:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671252076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igh8qy8rEJ/HKaAG0/pCIIFMuJJiLsx7f/WlxqjWaiI=;
        b=Dmp0xPhOvmYYzKnVgzQIFn1p+EqWLzTpf7lcF+EGC1Y+zIg9hN0l5IIoca9mBk43YkhDPu
        YxbdiIvwJijW3uWYHhq7W3W2gR+3n9b756RD7sCqGDxlg1jXEiPvitCPEo5NSVQPqbMDbM
        CxI51Y7EVGLYHLwBzGbOQ+kzXaVXmMM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-ufHIsj6nPX-Qwk2ajdCYuQ-1; Fri, 16 Dec 2022 23:41:13 -0500
X-MC-Unique: ufHIsj6nPX-Qwk2ajdCYuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FFA63C0F7E1;
        Sat, 17 Dec 2022 04:41:12 +0000 (UTC)
Received: from [10.22.8.73] (unknown [10.22.8.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A36D72166B26;
        Sat, 17 Dec 2022 04:41:11 +0000 (UTC)
Message-ID: <f86f666f-25f0-a742-b87e-bcf7ccbcca1e@redhat.com>
Date:   Fri, 16 Dec 2022 23:41:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: possible deadlock in __ata_sff_interrupt
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
 <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV> <Y50FIckzrV9sWlid@boqun-archlinux>
 <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
 <Y50yFYjysKQlLWtK@ZenIV>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y50yFYjysKQlLWtK@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/16/22 22:05, Al Viro wrote:
> On Fri, Dec 16, 2022 at 08:31:54PM -0600, Linus Torvalds wrote:
>> Ok, let's bring in Waiman for the rwlock side.
>>
>> On Fri, Dec 16, 2022 at 5:54 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>> Right, for a reader not in_interrupt(), it may be blocked by a random
>>> waiting writer because of the fairness, even the lock is currently held
>>> by a reader:
>>>
>>>          CPU 1                   CPU 2           CPU 3
>>>          read_lock(&tasklist_lock); // get the lock
>>>
>>>                                                  write_lock_irq(&tasklist_lock); // wait for the lock
>>>
>>>                                  read_lock(&tasklist_lock); // cannot get the lock because of the fairness
>> But this should be ok - because CPU1 can make progress and eventually
>> release the lock.
>>
>> So the tasklist_lock use is fine on its own - the reason interrupts
>> are special is because an interrupt on CPU 1 taking the lock for
>> reading would deadlock otherwise. As long as it happens on another
>> CPU, the original CPU should then be able to make progress.
>>
>> But the problem here seems to be thst *another* lock is also involved
>> (in this case apparently "host->lock", and now if CPU1 and CPU2 get
>> these two locks in a different order, you can get an ABBA deadlock.
>>
>> And apparently our lockdep machinery doesn't catch that issue, so it
>> doesn't get flagged.
> Lockdep has actually caught that; the locks involved are mention in the
> report (https://marc.info/?l=linux-ide&m=167094379710177&w=2).  The form
> of report might have been better, but if anything, it doesn't mention
> potential involvement of tasklist_lock writer, turning that into a deadlock.
>
> OTOH, that's more or less implicit for the entire class:
>
> read_lock(A)		[non-interrupt]
> 			local_irq_disable()	local_irq_disable()
> 			spin_lock(B)		write_lock(A)
> 			read_lock(A)
> [in interrupt]
> spin_lock(B)
>
> is what that sort of reports is about.  In this case A is tasklist_lock,
> B is host->lock.  Possible call chains for CPU1 and CPU2 are reported...
>
> I wonder why analogues of that hadn't been reported for other SCSI hosts -
> it's a really common pattern there...
>
>> I'm not sure what the lockdep rules for rwlocks are, but maybe lockdep
>> treats rwlocks as being _always_ unfair, not knowing about that "it's
>> only unfair when it's in interrupt context".
>>
>> Maybe we need to always make rwlock unfair? Possibly only for tasklist_lock?
That may not be a good idea as the cacheline bouncing problem will be 
back with reduced performance.
> ISTR threads about the possibility of explicit read_lock_unfair()...

Another possible alternative is to treat the read_lock as unfair if 
interrupt has been disabled as I think we should reduce the interrupt 
disabled interval as much as possible.

Thought?

Cheers,
Longman

