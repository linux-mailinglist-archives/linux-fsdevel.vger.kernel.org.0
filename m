Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8116FE659
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 23:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEJVdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 17:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjEJVdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 17:33:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48362171E
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:33:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so13923250a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683754425; x=1686346425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zexEus7JqShogX6gLLW2/DY+uGniLGr8wmolClBo1cs=;
        b=FZEJN0tlmIRTYPCxSWZ/878RHq68aEheF7B3kfBa5GI2+6nb/FfUAAJ1lhoPZdnVcd
         j4qcMix1N1b4IwAy8JtzoE7jL8dhMpem0QgOTISyKLWZvEAuc406cgjQroXfcfoffGf/
         po2dPRJDUmI2U02Ej/SQSbaZmIgfTQf7TjRxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754425; x=1686346425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zexEus7JqShogX6gLLW2/DY+uGniLGr8wmolClBo1cs=;
        b=cNbJUl6hT6+/msSKyAW1ICGZ10jlquwFeSaAdR9psqGKXf4urc0KYczETlHFMLGDK/
         SvyUOq1n7D9tWzZlGHxxOb2a+B5kgxZPUzEA4fcWaO2k0pJaArxZx39D2Pjl2AqByajn
         07YyYH/7ZArV3HthAasUqEYG+1CCE+UcSCHvVzDhd9NN9svrfGHJvLf4O+QMRId6Jd1O
         q1VADfRlD8vicqAmAe+C8hxDzx2wQbgpkFETI75ZQ+O/DuGcRydE3BhnzDdX8c3r+1CG
         y82zmK7XsA8VhnMKXm/UyfZ0+Zu4F4OXiLDR3zBO2PSxMgfDMpRK7uyvhMlfbfPa5gYy
         ya5w==
X-Gm-Message-State: AC+VfDxAPX4UJ63z1C7Sc+aii9ir+vHnZZhMRMSmDmZ6n7czZyj/IgYm
        AOsbk13ZLqxjXR5cYLvFPiZ51dLmi+tNNsRkaw/3tA==
X-Google-Smtp-Source: ACHHUZ79dW5d56PWrJjg3wkNsRK3HAwBEhqdDsAQH+wEUQOJEDsOa5LiOpFNs5Fxu7mtu0snRchgIw==
X-Received: by 2002:a17:907:a41e:b0:965:e556:8f6d with SMTP id sg30-20020a170907a41e00b00965e5568f6dmr18119571ejc.63.1683754425458;
        Wed, 10 May 2023 14:33:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906a41500b00965c6c63ea3sm3127236ejz.35.2023.05.10.14.33.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 14:33:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso13915479a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:33:44 -0700 (PDT)
X-Received: by 2002:a17:907:7b9b:b0:957:db05:a35d with SMTP id
 ne27-20020a1709077b9b00b00957db05a35dmr20319319ejc.48.1683754424213; Wed, 10
 May 2023 14:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <20230509191918.GB18828@cmpxchg.org> <ZFv+M5egsMxE1rhF@x1n>
In-Reply-To: <ZFv+M5egsMxE1rhF@x1n>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 May 2023 16:33:26 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjKVXt+BAh+Gk+Cs9u8s=XzbQyzHhZSW2bPFMX74gPuRw@mail.gmail.com>
Message-ID: <CAHk-=wjKVXt+BAh+Gk+Cs9u8s=XzbQyzHhZSW2bPFMX74gPuRw@mail.gmail.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
To:     Peter Xu <peterx@redhat.com>, Andrew Lutomirski <luto@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 3:27=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> The change looks all right to me.

I hate how this path has turned very architecture-specific again, and
this patch makes it worse.

For a short while we shared a lot of the code between architectures
thanks to the new fault helpers (ie fault_signal_pending() and
friends). Now CONFIG_PER_VMA_LOCK has made a mockery of that, and this
patch makes it worse by just fixing x86.

As is historically always the case.

And I think that patch is actually buggy. Because it does that

     ret =3D VM_FAULT_SIGBUS;
     if (fpin)
             goto out_retry;

in the fault path, and now returns VM_FAULT_SIGBUS | VM_FAULT_RETRY as a re=
sult.

And there are a lot of users that will be *very* unhappy about that combina=
tion.

Look at mm/gup.c, for example. It will do

        if (ret & VM_FAULT_ERROR) {
                int err =3D vm_fault_to_errno(ret, *flags);

                if (err)
                        return err;
       ...

and not react to VM_FAULT_RETRY being set at all - so it won't clear
the "locked" variable, for example.

And that all just makes it very clear how much of a painpoint that
conditional lock release is. It's horrendous.

That's always a huge pain in general, and it really complicates how
things get handled. It has very real and obvious historical reasons
("we never released the lock" being converted one case at a time to
"we release the lock in this situation and set the bit to tell you"),
but I wonder if we should just say "handle_mm_fault() _always_
releases the lock".

We'd still keep the RETRY bit as a "this did not complete, you need to
retry", but at least the whole secondary meaning of "oh, and if it
isn't set, you need to release the lock you took" would go away.
Because RETRY has really annoying semantics today.

Again - I know exactly _why_ it has those horrendous semantics, and
I'm not blaming anybody, but it makes it really painful to deal with
15 different architectures that then have to deal with those things.

How painful would it be to try to take baby steps and remove those
kinds of things and slowly move towards a situation where RETRY isn't
such a magically special bit?

Peter Xu, you did a lot of the helper function cleanups, and moved
some of the accounting code into generic code. It's a few years ago,
but maybe you still remember this area.. And Luto, I'm adding you to
the participants because you've touched that code more than most.

Could we make the rule be that handle_mm_fault() just *always*
releases the lock? How painful would that be?

For many of the architectures, I *think* it would mean just removing the

        mmap_read_unlock(mm);

in the fault handling path (after the RETRY test).

But there's a couple of other uses of handle_mm_fault() too, notably GUP.

Am I just dreaming? Or could we try to simplify this area first?
Because I think Johannes' patch right now is quite buggy, and only
converted one caller, when a lot of other callers will currently find
it very problematic to see both VM_FAULT_RETRY and one of the error
bits..

It's also possible that I'm misreading things. But I really think the
lock handling would be a lot easier if the rule was "it is locked on
entry, it's always unlocked on exit".

Of course, with the vma locking, the "it" above is nontrivial too.
That sure didn't simplify thinking about this all....

              Linus
