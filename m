Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B44D2524
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 02:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiCIBJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCIBIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:08:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B014563B
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 16:50:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s25so960935lfs.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOkhTNcLWPufcykwdZmZBF2oqQGok/K5B2vr+Tqh36g=;
        b=Vj4rshnTpWz5DU66OERET/pAsAiEtJHCvq1p7tYsuGWD7WJCMh23fM0fO4nZdPLYHC
         90pf8J0GgnEP+YZrzPyFs7Bg/J9pen3fzwCfz2wTn/gw4B+2lcPdZNWYCNfMWKpUwV9E
         ohAJR1uT0oUJ+kwVfBbrRuha/QYIMA/OMi3B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOkhTNcLWPufcykwdZmZBF2oqQGok/K5B2vr+Tqh36g=;
        b=yG3Y2JtkuukdE4sLmrI14ntHbjU0dsPNzNHZFjpzMxaWsWQ9O0aFWw/GiGGYWtg0oL
         idrC1wdGfaS0rDEB7i66QOZwFGZED4bHGgAOjebGSd86zwcC9mXaY72nooaHKUaXnA0z
         rwfd3Hq+nsbHwvuNccdx5zXdfx1o9bPyVT13wqnV8un0yBbWZlGKri8Of8CC8roZTN6s
         Cx/Id6LLbFxVvt7H6i8t0iHwNrgTOvrm6FNuql1ZCzreg8ZP3glMYtnMNk3ByWOEyaIc
         qXMtt2tyfkFlTfpuAiZkAjPbAgPwVbKJYCUWnu8A5HpxbvaASSq9OZMsRErxWHP1+WA0
         NcJg==
X-Gm-Message-State: AOAM5319EDyLfUfCGx3aoDbmCxSeRazFwypJBXm8bJ/j2tE5UX1cXTv0
        BfP6dpWh6nX4jY5XqRFIJUx2GhkfKi4ZSPvZM1s=
X-Google-Smtp-Source: ABdhPJyFEO5zeDAoV2cLTUD3VA5pMSE/TeM1DZunjOOeBVdiEj617D3CRmzQ1A643bsWtL52/cFSlw==
X-Received: by 2002:a05:651c:211a:b0:246:876c:bbf with SMTP id a26-20020a05651c211a00b00246876c0bbfmr12368905ljq.496.1646785373629;
        Tue, 08 Mar 2022 16:22:53 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p1-20020a05651238c100b004437b4e5034sm67158lft.159.2022.03.08.16.22.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 16:22:52 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id o6so897904ljp.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 16:22:51 -0800 (PST)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr696937ljc.506.1646785371366; Tue, 08
 Mar 2022 16:22:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com> <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
In-Reply-To: <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 16:22:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
Message-ID: <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 8, 2022 at 3:25 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Seems to be working on s390x for this test case at least; the kind of
> trace I'm getting is:

Good.

> This shows bursts of successful fault-ins in gfs2_file_read_iter
> (read_fault). The pauses in between might be caused by the storage;
> I'm not sure.

Don't know about the pauses, but the burst size might be impacted by that

+       const size_t max_size = 4 * PAGE_SIZE;

thing that limits how many calls to fixup_user_fault() we do per
fault_in_safe_writeable().

So it might be worth checking if that value seems to make any difference.

> I'd still let the caller of fault_in_safe_writeable() decide how much
> memory to fault in; the tight cap in fault_in_safe_writeable() doesn't
> seem useful.

Well, there are real latency concerns there - fixup_user_fault() is
not necessarily all that low-cost.

And it's actually going to be worse when we have the sub-page coloring
issues happening, and will need to probe at a 128-byte granularity
(not on s390, but on arm64).

At that point, we almost certainly will need to have a "probe user
space non-destructibly for writability" instruction (possibly
extending on our current arch_futex_atomic_op_inuser()
infrastructure).

So honestly, if you do IO on areas that will get page faults on them,
to some degree it's a "you are doing something stupid, you get what
you deserve". This code should _work_, it should not have to worry
about users having bad patterns (where "read data into huge cold
mappings under enough memory pressure that it causes access bit faults
in the middle of the read" very much counts as such a bad pattern).

> Also, you want to put in an extra L here:
> > Signed-off-by: linus Torvalds <torvalds@linux-foundation.org>

Heh. Fixed locally.

                 Linus
