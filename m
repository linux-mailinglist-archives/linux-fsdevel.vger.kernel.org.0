Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42443D1821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGUTrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhGUTrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:47:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C9BC061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 13:28:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y7so4639831ljm.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Wfplf+fD3sAhG/xYw9pABvgaxNvCuT0joqilD8I+WIY=;
        b=Cy+092dUMFCuH1x/9wzZLNPpohYwL5mLJ+XoNI+Yu8Va3rjvRxkCDSxK4HdOBvSFlS
         0734f+bWrs/te02P8ApPWN8u9tATzWG8YVMRzmGI/BbmcsJ1RHcmjpVboynFKJRBL4z9
         CEy0kwsNhs6vH5oTOf6B4dDodN/vfPbEOpwUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Wfplf+fD3sAhG/xYw9pABvgaxNvCuT0joqilD8I+WIY=;
        b=YfQo1WwxazgPAVe37ZovEaRsZcU3eirM35uqmPQPySey8F/aSStPBIJSo+eYBw5I6l
         AchYtC/azQ6oVLdz1zX3rM3julpWowvi2HLhzWUcl66mFNhIVcASXzvdvqTC5q7zozG/
         LRMMRD/zC/2caEvuOXzrDWFlOWI9YfFKcyYM8mvQFNlvi1VMHeewpG5fw24AARxOFoLI
         4o/tfR2VNWax/0ooTqkhInPYRzoNb86k2EwmjdC88uU5elNifmEylZOjiPjcf2Sfo7YH
         O4V9RJ4owjOr583mrXQbvHeJef06oHvG7j3eV0YMQy6pvsO/84/ASfhf5fJPU4VZIuAa
         8Yyg==
X-Gm-Message-State: AOAM53324a7NtrJCjxUAmUfD2DrG9CdzeFyxF9bCbZr+KYAcqtRvqGwe
        JYSV3x5Gp88T7s1EuyVspmbyez28WXf1aS6H
X-Google-Smtp-Source: ABdhPJwjqlZxD2HpgnzPKuLkundkb/fEjYdvdbta8aoh9GfYHWGlKpni5PG6DMmM/aL+B7kr1YQLjQ==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr32381477ljk.508.1626899293834;
        Wed, 21 Jul 2021 13:28:13 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 11sm731315ljq.140.2021.07.21.13.28.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:28:13 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y25so3825218ljy.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 13:28:12 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr32086757ljg.251.1626899292773;
 Wed, 21 Jul 2021 13:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com> <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <20210721201029.GQ19710@twin.jikos.cz>
In-Reply-To: <20210721201029.GQ19710@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 13:27:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCygw44p30Pmf+Bt8=LVtmij3_XOxweEA3OQNruhMg+A@mail.gmail.com>
Message-ID: <CAHk-=whCygw44p30Pmf+Bt8=LVtmij3_XOxweEA3OQNruhMg+A@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     David Sterba <dsterba@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 1:13 PM David Sterba <dsterba@suse.cz> wrote:
>
> adding a memcmp_large that compares by native words or u64 could be
> the best option.

Yeah, we could just special-case that one place.

But see the patches I sent out - I think we can get the best of both worlds.

A small and simple memcmp() that is good enough and not the
_completely_ stupid thing we have now.

The second patch I sent out even gets the mutually aligned case right.

Of course, the glibc code also ended up unrolling things a bit, but
honestly, the way it did it was too disgusting for words.

And if it really turns out that the unrolling makes a big difference -
although I doubt it's meaningful with any modern core - I can add a
couple of lines to that simple patch I sent out to do that too.
Without getting the monster that is that glibc code.

Of course, my patch depends on the fact that "get_unaligned()" is
cheap on all CPU's that really matter, and that caches aren't
direct-mapped any more. The glibc code seems to be written for a world
where registers are cheap, unaligned accesses are prohibitively
expensive, and unrolling helps because L1 caches are direct-mapped and
you really want to do chunking to not get silly way conflicts.

If old-style Sparc or MIPS was our primary target, that would be one
thing. But it really isn't.

              Linus
