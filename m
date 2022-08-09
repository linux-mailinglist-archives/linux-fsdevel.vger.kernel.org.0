Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB12358DD8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbiHIR6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245483AbiHIR6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:58:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A35725C5C;
        Tue,  9 Aug 2022 10:58:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660067915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kvvyUiRVRgL6TA44KhfhLoMFDaec9OAF6No66aB+hg4=;
        b=jp6kPDTXdZCgeGh5Z2OJQsdG1CD4fJu77sjAMdkwd3VKbUtMzK6sjq7bGG9hVAmop/p1Ig
        apNkAKMIsBI2eD2ukLvX4cskQ3vDfnprfAZ0iOhM8c03LKYKo26scaA2/4ox2kH5eEJNUn
        DibNE2edNhhHpHYrXHtGcWEIMR+0qVRQ6vS8jzbFjapfi9q69k1JlU2pKO85MhrK3y1YQG
        o0GxcNFxa12X5ZyRTmrmuf6lPO4KmsHoYin/jGLNrS+wVLZsZ/gChDC6iYbHtioPPnrD9a
        S6gdvo0aA4OfvbjKJ9gEgfKey1v4K1f1srdgpnMxv4g+TZgLheobkwZ/9lPW6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660067915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kvvyUiRVRgL6TA44KhfhLoMFDaec9OAF6No66aB+hg4=;
        b=vFsMB0bCBn2uKX030vBq4rSw8QPSjFdlyMdJng1rn+yTDXgMKdzbBjfir+XEKHswqvJNvE
        AojbQVAkeIiItqDQ==
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
In-Reply-To: <YvKIIa+2bTRWXuE+@casper.infradead.org>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
 <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home>
 <YusDmF39ykDmfSkF@casper.infradead.org>
 <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
 <8735e6qtjc.ffs@tglx>
 <CAHk-=wi1z8h=hcAhZ0hx9UNxWXzWFFrd-z3ZgwM5mxhNQjPHDw@mail.gmail.com>
 <87v8r1quem.ffs@tglx> <YvKIIa+2bTRWXuE+@casper.infradead.org>
Date:   Tue, 09 Aug 2022 19:58:34 +0200
Message-ID: <87sfm5qoxh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 09 2022 at 17:15, Matthew Wilcox wrote:
> On Tue, Aug 09, 2022 at 06:00:17PM +0200, Thomas Gleixner wrote:
>> On Mon, Aug 08 2022 at 15:43, Linus Torvalds wrote:
>> > But the kmap code may be so special that nothing else has _that_
>> > particular issue.
>> 
>> We just want to get rid of kmap_atomic() completely. I'll go and find
>> minions.
>
> Be sure to coordinate with Ira & Fabio who are working on this.

Will do.
