Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6E2D4E81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 00:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgLIXIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 18:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgLIXIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:08:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3255DC0613CF;
        Wed,  9 Dec 2020 15:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t/kn1zEJAReVKYrtOYKBTrvf7aHmeGPWEokbx3HDDoQ=; b=UNO5kVG0d+ETE9RsvuHAiZxcj5
        Adv8kCIydWRV0f6iORie7fLCP3D33gjJtKjU9TZM4GQGhmdkUcka00Vg35ozS+3F3Q8kvZDYdZodK
        IHeoPFaIsHFJm5L4l1Ms31pUpqWh4kYC782eh7Q6n+E0m331CeB/wPvDAUkxxBaYXgAZOwuzhVDAC
        O0QyRAb/GKfVAvYzjBMszuKCsKRNE9wF8ILtYBpnbPRdtMyWmc5SZZLmVS/FjcpIuEIppwk/bWbKc
        mfgPjcf13ICnaaiGlMIleLdavqd59X4woYz6QzTZRmx7DiMFsb054nHpkh3qbw0nfYJPXzkMpLFNK
        2NM3q2VA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn8Yt-0000Bk-CQ; Wed, 09 Dec 2020 23:07:55 +0000
Date:   Wed, 9 Dec 2020 23:07:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201209230755.GV7338@casper.infradead.org>
References: <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk>
 <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org>
 <20201209225828.GR3579531@ZenIV.linux.org.uk>
 <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 03:01:36PM -0800, Linus Torvalds wrote:
> On Wed, Dec 9, 2020 at 2:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Dec 09, 2020 at 07:49:38PM +0000, Matthew Wilcox wrote:
> > >
> > > Assuming this is safe, you can use RCU_INIT_POINTER() here because you're
> > > storing NULL, so you don't need the wmb() before storing the pointer.
> >
> > fs/file.c:pick_file() would make more interesting target for the same treatment...
> 
> Actually, don't.
> 
> rcu_assign_pointer() itself already does the optimization for the case
> of a constant NULL pointer assignment.
> 
> So there's no need to manually change things to RCU_INIT_POINTER().

I missed that, and the documentation wasn't updated by
3a37f7275cda5ad25c1fe9be8f20c76c60d175fa.

Paul, how about this?

+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1668,8 +1668,10 @@ against mishaps and misuse:
    this purpose.
 #. It is not necessary to use rcu_assign_pointer() when creating
    linked structures that are to be published via a single external
-   pointer. The RCU_INIT_POINTER() macro is provided for this task
-   and also for assigning ``NULL`` pointers at runtime.
+   pointer. The RCU_INIT_POINTER() macro is provided for this task.
+   It used to be more efficient to use RCU_INIT_POINTER() to store a
+   ``NULL`` pointer, but rcu_assign_pointer() now optimises for a constant
+   ``NULL`` pointer itself.
 
 This not a hard-and-fast list: RCU's diagnostic capabilities will
 continue to be guided by the number and type of usage bugs found in

