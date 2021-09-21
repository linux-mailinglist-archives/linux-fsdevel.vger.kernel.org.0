Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFED8413B2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhIUUVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 16:21:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50872 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhIUUVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:21:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632255587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vz7syRUN5sOPwLSCYUbNIMEsi/R8b4KCW0BzfDAPCcc=;
        b=Sf9kJ8F6bEpGkCkxYVZGemVx+bK63FHeiLTxvZyHUTnoC7XuxpxUV7Ph+HtegzCwp5uq4D
        cWVbqwxqXTmdDCPWsfTNHFf+MV8RO3fv5wsyXWu+fL2bqNiKa1tm0cY5jnJKG1+In/mLiM
        MMD8T7J2lS2hJddf+s/Ccgw5u8w6CqP6QcG0JXJkGfHPgKyFxcwj0MTN0u/lEFY06rULAS
        I4tTlJYBFWTCJv9le1meDqyrMh8Qq5Np2uqxdHbWXUqcRudYQxdMFw/nqUwJKzbaweucli
        cO97nILeRe6RCL1e53AWnVBvzUJH9t91akGfKWf8qwM7IY+ldC2hJE0jsIp6PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632255587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vz7syRUN5sOPwLSCYUbNIMEsi/R8b4KCW0BzfDAPCcc=;
        b=tOvQKv/XPYCfTewSYn+SettAP7SzvcJxhKAHw16af75OfyfT5EbbVaO2gQkQ+l6KCioBgk
        uV8iuATHODDNYkBQ==
To:     Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Waiman Long <llong@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] WARNING in __init_work
In-Reply-To: <163224949689.3714697.17466968510780664239@swboyd.mtv.corp.google.com>
References: <000000000000423e0a05cc0ba2c4@google.com>
 <20210915161457.95ad5c9470efc70196d48410@linux-foundation.org>
 <163175937144.763609.2073508754264771910@swboyd.mtv.corp.google.com>
 <87sfy07n69.ffs@tglx>
 <163224949689.3714697.17466968510780664239@swboyd.mtv.corp.google.com>
Date:   Tue, 21 Sep 2021 22:19:46 +0200
Message-ID: <87v92t65r1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen,

On Tue, Sep 21 2021 at 11:38, Stephen Boyd wrote:
> Quoting Thomas Gleixner (2021-09-19 05:41:18)
>> Even if debug objects would support objects on irq stacks, the above is
>> still bogus. But it does not and will not because the operations here
>> have to be fully synchronous:
>> 
>>     init() -> queue() or arm() -> wait() -> destroy()
>> 
>> because you obviously cannot queue work or arm a timer which are on stack
>> and then leave the function without waiting for the operation to complete.
>
> Is there some way to make it more obvious that initializing a timer or
> work on the stack in an irq context is a NONO because we can't wait for
> it? Maybe some sort of debugobjects call to might_sleep() when it's
> being told the object is on the stack, or throwing a might_sleep() into
> the initialization of any stack based timer or workqueue, or both?

Let me have a look.
