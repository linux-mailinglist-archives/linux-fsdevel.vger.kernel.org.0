Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C5E3A8388
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhFOPFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFOPFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:05:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE72C061574;
        Tue, 15 Jun 2021 08:03:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623769415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6xyx21xxnuOeb+VMJL8CvX9khm7B/T5rgexDM0SXxE=;
        b=M/0YttZrgRntJFJx1PMbhnmci98YhVhQHFYf8aXnDl3J6tGeu82dpLeeW5sQO9Qb2tDRfw
        FoBIINP9lOL8pEEu1YbVYr6Clok1bnp1GOD74gOHT6S3SireYTNNnOthrYEqQFWTY+gLsZ
        LQb90bJ/aJt++SOLHNJDUSdqCwUKXq/rQ+lOr1C5jLvCGi6F88su/np1sxc8EHhOV9xFZz
        rgMcEIeiRFNB/kpnRSySnfz8ckUAp2liKLLsoIh4hmAKKHTKAWggNdDqUZ/01EHt2DUcvd
        z0QVpOvV2bfhk5GaPt7FeGl8sb2/348yxT5aY5CYDgikJAz00YJPp0GNN6HCqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623769415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6xyx21xxnuOeb+VMJL8CvX9khm7B/T5rgexDM0SXxE=;
        b=V7fbDvQxi8F2jVjr4FBt71Sb5eAodQQissDqayoWj3maSKWkjkuU8L9qdLg/vCWmQHyUO6
        6aHLgS1NzEJXzMCA==
To:     Matthew Wilcox <willy@infradead.org>,
        David Mozes <david.mozes@silk.us>
Cc:     "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: futex/call -to plist_for_each_entry_safe with head=NULL
In-Reply-To: <YMZkwsa4yQ/SsMW/@casper.infradead.org>
References: <AM6PR04MB563958D1E2CA011493F4BCC8F1329@AM6PR04MB5639.eurprd04.prod.outlook.com> <YMZkwsa4yQ/SsMW/@casper.infradead.org>
Date:   Tue, 15 Jun 2021 17:03:34 +0200
Message-ID: <87k0mvgoft.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 13 2021 at 21:04, Matthew Wilcox wrote:
> On Sun, Jun 13, 2021 at 12:24:52PM +0000, David Mozes wrote:
>> Hi *,
>> Under a very high load of io traffic, we got the below=C2=A0 BUG trace.
>> We can see that:
>> plist_for_each_entry_safe(this, next,=C2=A0&hb1->chain, list) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (match_futex (&this->key, &key1))
>> =C2=A0
>> were called with hb1 =3D NULL at futex_wake_up function.
>> And there is no protection on the code regarding such a scenario.
>> =C2=A0
>> The NULL can=C2=A0 be geting from:
>> hb1 =3D hash_futex(&key1);

Definitely not.

>> =C2=A0
>> How can we protect against such a situation?
>
> Can you reproduce it without loading proprietary modules?
>
> Your analysis doesn't quite make sense:
>
>         hb1 =3D hash_futex(&key1);
>         hb2 =3D hash_futex(&key2);
>
> retry_private:
>         double_lock_hb(hb1, hb2);
>
> If hb1 were NULL, then the oops would come earlier, in double_lock_hb().

Sure, but hash_futex() _cannot_ return a NULL pointer ever.

>> =C2=A0
>> =C2=A0
>> This happened in kernel=C2=A0 4.19.149 running on Azure vm

4.19.149 is almost 50 versions behind the latest 4.19.194 stable.

The other question is whether this happens with an less dead kernel as
well.

Thanks,

        tglx
