Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554577AF41F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 21:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjIZT2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZT2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:28:36 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24410A;
        Tue, 26 Sep 2023 12:28:30 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ae5ac8ddcaso709199b6e.3;
        Tue, 26 Sep 2023 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695756509; x=1696361309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RzhuJC66OOE8TiWsNKFDHq8mYhmXJzmYid5Q+XDuxeg=;
        b=mFiqn3/zC+V3jmfA3SG0NGFwjgGU3KIjbyLC5r3gSAU66dZwXbec4ntYOHRGB8s9ng
         PbH6F9312VgZTQo7ZbaA1d/q7rBSgn66ytpf55Y7H7s6dk3awp21pl8PR3C189+HV+zf
         w70YF7iSbUpjLEpDfck+hRdCa1ioOyXZqmvhfxAe8SM4HUq4/rXaoh60k0AUjc+ggRjN
         4ef5sL8WsJglEE/wmGRX0qQ+wZJxP8p6f79Pt/+UUKVKK3htJdoNV46DLDrNsLj2GlBe
         duZlmUKV/Tspz0jrzIu5mg1Hq+v2B9m/PXpztahDrvkmibxG+osb+GsJAlBsNHdZeuwh
         KdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695756509; x=1696361309;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzhuJC66OOE8TiWsNKFDHq8mYhmXJzmYid5Q+XDuxeg=;
        b=I30AGPVLHyOC/KkF7MCIFkxxsp+61BJ/XKs9nn2wtPuczchtcLOhmTN6I5eCNdIlOz
         dZ02Z1ClwQOrQKVz5gr1I/dALNfTVwJ5Sp6KFn65yGidL0wuc+JB8w6QQ8+EAM4KTyGq
         Md8m6BsLoYx1mPDBmL7jAinN5wfMcVYVO5tK+YABVplSyBJbsahY1sLafpcfjYUPVU0M
         7cTEkmCdSbhB5pPgcJqW3Zr/i159D1Rgu3Ax5P55BbJhRaD6s41B+vMYGxqNbwntwiKL
         KmIMQzT9AJc7KcSuCCSceg2GAMCsYH+YwotzDAyv/rRf7e/IjoiMcJnLvVQyDV7WBcz+
         VUHA==
X-Gm-Message-State: AOJu0YwtqPtNYVED6fY+qtN4pehStwKnQWA8Uzdny9cCIPxCnSKM3y5e
        N7mKcaahLyo8CLhdlLhK+dCdKlgzvEnwbCr9A23/1FzkKe0=
X-Google-Smtp-Source: AGHT+IFcIigrBUO6AArbAzcgpOXiDdSQA2YfMDdpdDgHazJoMAqv93Nd6nYOSY8LihAArRiBcvjj6jtt/V42y6xTJZA=
X-Received: by 2002:a05:6870:5623:b0:1d5:a377:f360 with SMTP id
 m35-20020a056870562300b001d5a377f360mr12897139oao.41.1695756509431; Tue, 26
 Sep 2023 12:28:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5d4a:0:b0:4f0:1250:dd51 with HTTP; Tue, 26 Sep 2023
 12:28:28 -0700 (PDT)
In-Reply-To: <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 26 Sep 2023 21:28:28 +0200
Message-ID: <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 26 Sept 2023 at 09:22, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> +void fput_badopen(struct file *file)
>> +{
>> +       if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
>> +               fput(file);
>> +               return;
>> +       }
>
> I don't understand.
>
> Why the FMODE_BACKING test?
>
> The only thing that sets FMODE_BACKING is alloc_empty_backing_file(),
> and we know that isn't involved, because the file that is free'd is
>
>         file = alloc_empty_file(op->open_flag, current_cred());
>
> so that test makes no sense.
>

I tried to future proof by dodging the thing, but I can drop it if you
insist. Also see below.

> It might make sense as another WARN_ON_ONCE(), but honestly, why even
> that?  Why worry about FMODE_BACKING?
>
> Now, the FMODE_OPENED check makes sense to me, in that it most
> definitely can be set, and means we need to call the ->release()
> callback and a lot more. Although I get the feeling that this test
> would make more sense in the caller, since path_openat() _already_
> checks for FMODE_OPENED in the non-error path too.
>
>> +       if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1))
>> {
>> +               fput(file);
>> +               return;
>> +       }
>
> Ok, I kind of see why you'd want this safety check.  I don't see how
> f_count could be validly anything else, but that's what the
> WARN_ON_ONCE is all about.
>

This would be VFSDEBUG or whatever if it was available. But between
nobody checking this and production kernels suffering the check when
they should not, I take the latter.

I wanted to propose debug macros for vfs but could not be bothered to
type it up and argue about it, maybe I'll get around to it.

> Anyway, I think I'd be happier about this if it was more of a "just
> the reverse of alloc_empty_file()", and path_openat() literally did
> just
>
>         if (likely(file->f_mode & FMODE_OPENED))
>                 release_empty_file(file);
>         else
>                 fput(file);
>
> instead of having this fput_badopen() helper that feels like it needs
> to care about other cases than alloc_empty_file().
>

I don't have a strong opinion, I think my variant is cleaner and more
generic, but this boils down to taste and this is definitely not the
hill I'm willing to die on.

I am enable to whatever tidy ups without a fight as long as the core
remains (task work and rcu dodged).

All that said, I think it is Christian's call on how it should look like.

-- 
Mateusz Guzik <mjguzik gmail.com>
