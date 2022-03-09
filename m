Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A454D398A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 20:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbiCITJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 14:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiCITJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:09:22 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF15131976
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 11:08:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bt26so5510101lfb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 11:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXR1y9mWPI79aJN86zN1Xw4k1kIrgJW/qF3J3mr8s/o=;
        b=f2HKjN7pnq1Yx0IZQSDYsv3QQKsG+2d6SyKPs8kRV0DJINmCv0zY8YggZgmbRh8s9G
         5W1TTtOlOHELiVloxzikMZjMiZj3rLso6o3JgLPBQDjrwKLUkGQeH0vZpt7UqvmOkcfZ
         TYZh0tYA7JeXfR6IRR0cTQnv83g6YC9SeVOuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXR1y9mWPI79aJN86zN1Xw4k1kIrgJW/qF3J3mr8s/o=;
        b=N0q1tlm/cLt4abNk1u+/Cf7bs/pKxEe+KtIFPWpt5ukpxzqRTOmLPipsTWoxD9OAVD
         yq8HnGb3wqpikpq1xmIEpQRKEIXP+LkXVLJEBwBQ8paQzTJ/snCKm8vVArVY5u/XlKRY
         t1ETZRV7E22+AUPJb6pFM7td9JojGsNMG8hbcHsi5KLRwEq+fTcR5pkvK8eNzlTlIwuh
         ZNRalByavJEj3cGbQ5DfouE8pYTPLn3NUjhZieKd1zr+t2qk9H+ozz/Mxk9MK/gWCOjp
         x4bgPCMn1GWsH/T8iJHgdcLtP6pMoT9Y/jEq5i9EG8U0rVjC5qt+FRWMjRIQmjY6Ezv6
         fwJg==
X-Gm-Message-State: AOAM531QRj7i3W3eRxJDUDF6kpo4qOAI1SIr3V19DNP+3DT3i0DrWPAQ
        OFCrO8VxXOjV+DULkJlW7RKK/mI9ONvTVIp/GuU=
X-Google-Smtp-Source: ABdhPJxtyWf5NVpk+L4L68H6TjG3+zDYtSpPAvCIw/AXWCxhkRR1usNp777IscClrH3GtNZE2PnkIg==
X-Received: by 2002:a05:6512:2255:b0:446:6f6a:fd74 with SMTP id i21-20020a056512225500b004466f6afd74mr712508lfu.246.1646852900694;
        Wed, 09 Mar 2022 11:08:20 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f7-20020ac24e47000000b00443591e0d63sm535491lfr.189.2022.03.09.11.08.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:08:19 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id l20so5436076lfg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 11:08:19 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr679738lfi.52.1646852899217; Wed, 09 Mar
 2022 11:08:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com> <20220309184238.1583093-1-agruenba@redhat.com>
In-Reply-To: <20220309184238.1583093-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 11:08:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBOFg3brJbo-gcaPM+fxjzHwC4efhcM8tCKK3YUhYUug@mail.gmail.com>
Message-ID: <CAHk-=wgBOFg3brJbo-gcaPM+fxjzHwC4efhcM8tCKK3YUhYUug@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
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

On Wed, Mar 9, 2022 at 10:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> From what I took from the previous discussion, probing at a sub-page
> granularity won't be necessary for bytewise copying: when the address
> we're trying to access is poisoned, fault_in_*() will fail; when we get
> a short result, that will take us to the poisoned address in the next
> iteration.

Sadly, that isn't actually the case.

It's not the case for GUP (that page aligns things), and it's not the
case for fault_in_writeable() itself (that also page aligns things).

But more importantly, it's not actually the case for the *users*
either. Not all of the users are byte-stream oriented, and I think it
was btrfs that had a case of "copy a struct at the beginning of the
stream". And if that copy failed, it wouldn't advance by as many bytes
as it got - it would require that struct to be all fetched, and start
from the beginning.

So we do need to probe at least a minimum set of bytes. Probably a
fairly small minimum, but still...


> With a large enough buffer, a simple malloc() will return unmapped
> pages, and reading into such a buffer will result in fault-in.  So page
> faults during read() are actually pretty normal, and it's not the user's
> fault.

Agreed. But that wasn't the case here:

> In my test case, the buffer was pre-initialized with memset() to avoid
> those kinds of page faults, which meant that the page faults in
> gfs2_file_read_iter() only started to happen when we were out of memory.
> But that's not the common case.

Exactly. I do not think this is a case that we should - or need to -
optimize for.

And doing too much pre-faulting is actually counter-productive.

> * Get rid of max_size: it really makes no sense to second-guess what the
>   caller needs.

It's not about "what caller needs". It's literally about latency
issues. If you can force a busy loop in kernel space by having one
unmapped page and then do a 2GB read(), that's a *PROBLEM*.

Now, we can try this thing, because I think we end up having other
size limitations in the IO subsystem that means that the filesystem
won't actually do that, but the moment I hear somebody talk about
latencies, that max_size goes back.

                Linus
