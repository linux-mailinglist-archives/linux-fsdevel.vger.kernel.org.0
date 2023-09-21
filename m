Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838FC7A9E61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjIUUA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjIUUA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8AD4814
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:25:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b962c226ceso21528561fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695320702; x=1695925502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDCsdJjp/GQ+Gh7L2otFH827lj9wOoNnRjLWZyU2JH0=;
        b=JDznRerxh9gF1teTJdIJ/ZTjo8zSlfFHDj744hM3H4DnDggRMjTGUH4HaCm+xar5hc
         Ef0oPS2BPlLJ1PF7n8Q9qSsff5MRm6KJ8MOYulsDqf84WUGd3N36n3awFnC5W0L6QR7J
         Uix87punZwIFFUeZ2PHjgpqbpQf1RUiuQJG0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320702; x=1695925502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDCsdJjp/GQ+Gh7L2otFH827lj9wOoNnRjLWZyU2JH0=;
        b=bjZ8Bs1jPJ/F9Rs7VHU51TzfSbrQihrFA66/Qlui1ZjfFAdjj8mcj2q1c2eeMo+lZc
         vjMO5qePjv8RxVhaub/UOHkK0VWISVAlzXzkpdYcGKr8HCngSzKMiw3NoIjf7zisuJaH
         w4o9p0MtJwQsjk1YsHNbZoqJDN4QPchH9vY+36WNqrZmY7QMbILlp68hc4cmmd233NDO
         op0emuhWVT7qbOztXoR5nhXFxkhGDxE1CPrT1+UAFPL8il+FOHez+Y7zZBwnVPZuMkFb
         /sDvHRD22F/7CAbagsUmanGLpaAVPAWsQNfZ1bHKmPJ+eS/9M6CSaz+VYtG+Zpehykc0
         7W9g==
X-Gm-Message-State: AOJu0YxfV2keeM961WCg2vNd+nYXwPQ7akMXOt2dGEHa/fWut9EE2vAC
        FxW7R425Bc6Tc1T/iG/FvyZc1r0zq1lICuNLqB7b1zHn
X-Google-Smtp-Source: AGHT+IG46FqFbZUANNDR3Zxv4gaxsZzOW9UNqRngYRW7iacJfNKk+av5udLY1UGCiNKn5mU7MRfQHw==
X-Received: by 2002:a2e:3609:0:b0:2c0:240:b574 with SMTP id d9-20020a2e3609000000b002c00240b574mr5503065lja.31.1695320701935;
        Thu, 21 Sep 2023 11:25:01 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061b1a00b0099bcb44493fsm1438981ejg.147.2023.09.21.11.25.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:25:01 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so961116a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:25:01 -0700 (PDT)
X-Received: by 2002:a05:6402:1a32:b0:525:6c9f:e1a3 with SMTP id
 be18-20020a0564021a3200b005256c9fe1a3mr5642919edb.20.1695320700919; Thu, 21
 Sep 2023 11:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
In-Reply-To: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Sep 2023 11:24:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
Message-ID: <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sept 2023 at 04:21, Christian Brauner <brauner@kernel.org> wrote:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc3.vfs.ctime.revert

So for some reason pr-tracker-bot doesn't seem to have reacted to this
pull request, but it's in my tree now.

I *do* have one reaction to all of this: now that you have made
"i_ctime" be something that cannot be accessed directly (and renamed
it to "__i_ctime"), would you mind horribly going all the way, and do
the same for i_atime and i_mtime too?

The reason I ask is that I *really* despise "struct timespec64" as a type.

I despise it inherently, but I despise it even more when you really
use it as another type entirely, and are hiding bits in there.

I despise it because "tv_sec" obviously needs to be 64-bit, but then
"tv_nsec" is this horrible abomination. It's defined as "long", which
is all kinds of crazy. It's bogus and historical.

And it's wasteful.

Now, in the case of i_ctime, you took advantage of that waste by using
one (of the potentially 2..34!) unused bits for that
"fine-granularity" flag.

But even when you do that, there's up to 33 other bits just lying
around, wasting space in a very central data structure.

So it would actually be much better to explode the 'struct timespec64'
into explicit 64-bit seconds field, and an explicit 32-bit field with
two bits reserved. And not even next to each other, because they don't
pack well in general.

So instead of

        struct timespec64       i_atime;
        struct timespec64       i_mtime;
        struct timespec64       __i_ctime;

where that last one needs accessors to access, just make them *all*
have helper accessors, and make it be

        u64  i_atime_sec;
        u64  i_mtime_sec;
        u64  i_ctime_sec;
        u32  i_atime_nsec;
        u32  i_mtime_nsec;
        u32  i_ctime_nsec;

and now that 'struct inode' should shrink by 12 bytes.

Then do this:

  #define inode_time(x) \
       (struct timespec64) { x##_sec, x##_nsec }

and you can now create a timespec64 by just doing

    inode_time(inode->i_atime)

or something like that (to help create those accessor functions).

Now, I agree that 12 bytes in the disaster that is 'struct inode' is
likely a drop in the ocean. We have tons of big things in there (ie
several list_heads, a whole 'struct address_space' etc etc), so it's
only twelve bytes out of hundreds.

But dammit, that 'timespec64' really is ugly, and now that you're
hiding bits in it and it's no longer *really* a 'timespec64', I feel
like it would be better to do it right, and not mis-use a type that
has other semantics, and has other problems.

              Linus
