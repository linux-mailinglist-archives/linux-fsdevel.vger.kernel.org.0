Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2BE6C3CF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 22:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCUVsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCUVsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:48:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC181B549
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 14:48:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so65346755edc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679435293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xh3paPfK126WRaNNgpf/HW2EljH41BR2zEW9a9muNk=;
        b=EFxwAMPN5TNr9d2A4kweGJd3JvbAXyVvHd2P4P/SPMq8eJwqHtiU2c608UDjkDSyrz
         wR9OSjQqsgjrMn3V2brzMT7hrk3n7WySExiC0d5PdJqq8l2DHGZB+gq0rlaX1KwB/rmM
         fpNw9bEhzSMSgl0yKzTNbCiUhYXsAohTsLFDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679435293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xh3paPfK126WRaNNgpf/HW2EljH41BR2zEW9a9muNk=;
        b=iTjFDCcH2EfLBoMuOmlJMFzupKg7VRmoBRPyrMnr+hFYBITwDm6528cVxNivHb+yeR
         nLbVQxajYAwyQfxOSBL+gVcCk8yJqzRQ8tNtgpCSLkIY3eYyFILP9HSCXvXdsrPw1Qeg
         njPgwhQ2M3whYzGpAboBwSvJfVaWPRLDwN2BYk0AmdAfVNNK11fN7WQ67r84kExKJHPz
         lOMZv/1Ji37T1DlOtqRpLdyLwFrk2vqN7KFu0PmS4zuaq8UN4SAi4D/m5vmw9h0oneeg
         VHkuYcmxKgLxf/Usz7hNTlHhFY/Q0DNuQXGJUHhAqUSE6POiSCLU0VFUkQ7iPtmPmft4
         Rhjw==
X-Gm-Message-State: AO0yUKVhsT8E/Ta0KjU/53ZpAj267tSdd6P5FRCekjQDBvAYRypDqYFY
        WfABhKU+J62fjc3dj2xJ6UHNhPg2vAcOoi9IFeNr/7pu
X-Google-Smtp-Source: AK7set8r5pmoGtHSTVFJn6oN+hQ4Pq2URUeKxptKROX382iul8rPSAJyOsCQCSqVT1X48zM8WAm0Sw==
X-Received: by 2002:a05:6402:60a:b0:4f9:deb4:b97f with SMTP id n10-20020a056402060a00b004f9deb4b97fmr5496584edv.13.1679435293511;
        Tue, 21 Mar 2023 14:48:13 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm6918359edi.36.2023.03.21.14.48.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 14:48:12 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id y4so65371646edo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 14:48:12 -0700 (PDT)
X-Received: by 2002:a17:906:b28e:b0:935:3085:303b with SMTP id
 q14-20020a170906b28e00b009353085303bmr2028336ejz.15.1679435291907; Tue, 21
 Mar 2023 14:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein> <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
 <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com> <20230321201632.o2wiz5gk7cz36rn3@wittgenstein>
In-Reply-To: <20230321201632.o2wiz5gk7cz36rn3@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 14:47:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2nJ3Z8x-nDGi9iCJvDCgbhpN+qnZt6V1JPnHqxX2fhQ@mail.gmail.com>
Message-ID: <CAHk-=wg2nJ3Z8x-nDGi9iCJvDCgbhpN+qnZt6V1JPnHqxX2fhQ@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Christian Brauner <brauner@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 1:16=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> But yes, that is a valid complaint so - without having tested - sm like:

I'd actually go a bit further, and really spell all the bits out explicitly=
.

I mean, I was *literally* involved in that original O_TMPFILE_MASK thing:

   https://lore.kernel.org/all/CA+55aFxA3qoM5wpMUya7gEA8SZyJep7kMBRjrPOsOm_=
OudD8aQ@mail.gmail.com/

with the whole O_DIRECOTY games to make O_TMPFILE safer, but despite
that I didn't remember this at all, and my suggested "maybe something
like this" patch was broken for the O_TMPFILE case.

So while we do have all this documented in our history (both git
commit logs and lore.kernel.org), I actually think it would be lovely
to just make build_open_flags() be very explicit about all the exact
O_xyz flags, and really write out the logic fully.

For example, even your clarified version that gets rid of the
"O_TMPFILE_MASK" thing still eends up doing

        if (flags & __O_TMPFILE) {
                if ((flags & O_TMPFILE) !=3D O_TMPFILE)
                        return -EINVAL;

and so when you look at that code, you don't actually realize that
O_TMPFILE _cotnains_ that __O_TMPFILE bit, and what the above really
means is "also check O_DIRECTORY".

So considering how I couldn't remember this mess myself, despite
having been involved with it personally (a decade ago..), I really do
think that maybe this shoudl be open-coded with a comment, and the
above code should instead be

        if (flags & __O_TMPFILE) {
                if (!(flags & O_DIRECTORY))
                        return -EINVAL;

together with an explicit comment about how O_TMPFILE is the
*combination* of __O_TMPFILE and O_DIRECTORY, along with a short
explanation as to why.

Now, I agree that that test for O_DIRECTORY then _looks_ odd, but the
thing is, it then makes the reality of this all much more explicit.

In contrast, doing that

                if ((flags & O_TMPFILE) !=3D O_TMPFILE)

may *look* more natural in that context, but if you actually start
thinking about it, that check makes no sense unless you then look up
what O_TMPFILE is, and the history behind it.

So I'd rather have code that looks a bit odd, but that explains itself
and is explicit about what it does, than code that _tries_ to look
natural but actually hides the reason for what it is doing.

And then next time somebody looks at that O_DIRECTORY | O_CREAT
combination, suddenly the __O_TMPFILE interaction is there, and very
explicit.

Hmm?

I don't feel *hugely* strongly about this, so in the end I'll bow to
your decision, but considering that my initial patch looked sane but
was buggy because I had forgotten about O_TMPFILE, I really think we
should make this more explicit at a source level..

               Linus

            Linus
