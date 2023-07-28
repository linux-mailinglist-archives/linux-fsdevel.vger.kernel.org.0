Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823C37676F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjG1UXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 16:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjG1UXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:23:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71738423B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:23:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991da766865so346787566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690575810; x=1691180610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaL8vCWD2qZnjDMvOO1mSqawEYt68vZaybEyeqD8qzc=;
        b=iNa4V4wbqIB8YQAIu3YWecMdqgfDDBvx7YotKRvzxFMEkV1NPN9FFaahGfVAarwaAV
         kRJWDO6+avyfDWom2I0N3AENnd/ucA3n3b4Lmo9UgnRCWibEYgsywdeA1ZqkQqRmTlZh
         XV8dRItJxUnXX6LhTgM/AywiqSgw2XGInhu/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690575810; x=1691180610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaL8vCWD2qZnjDMvOO1mSqawEYt68vZaybEyeqD8qzc=;
        b=HrgwSYZXJQuoxQtrnzQ+SQz7NpUziHl3mBubUtsXiy6Q4LiJG3Xt65YzYH9vP/FSa+
         x95g6/M8ANqS6SVo+GbJw+3BHXLnjQxS0OxECn5cnbTVqfgN6wt7mX3VAUkCW33PT/7v
         PpVRuVS4FCtS+/ivmqbpGyXa0j5ElOMVd6/4x1EGssRuFJTsa/rjnqPZkmczHFe2BTMp
         CQgdmygKN5mwV3cDB5BvZfDtaYexQDjJxb98YLJrRSfMj6wdb4Lw7VBBsNFD/byaFZ6l
         iTJOPfCjrpTpsg0lAUKSzaGO5QdoqG16GQHmS7UETYE0isoM3SyH9yBJOxzpFbOOuJAq
         Y9NA==
X-Gm-Message-State: ABy/qLZmVbugeY1IuMTcpLxf6dza99ugWw/4/y+Nn24UQswSdrMVd8Xx
        2/Ako68tugaviBOslpX+cFfOVNxX+t+pdrCdkYpU8LBN
X-Google-Smtp-Source: APBJJlFBMq/4vgWRHHABj4W7P7EgcWinbnZsUpIt4UAV0rvOD65XFiSUeMu845Cd7PuLtudjDXbYKQ==
X-Received: by 2002:a17:906:3092:b0:99b:ca24:ce42 with SMTP id 18-20020a170906309200b0099bca24ce42mr307950ejv.44.1690575809740;
        Fri, 28 Jul 2023 13:23:29 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a26-20020a17090640da00b009829dc0f2a0sm2413382ejk.111.2023.07.28.13.23.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 13:23:29 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso3310501a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:23:28 -0700 (PDT)
X-Received: by 2002:aa7:d507:0:b0:522:3a28:feca with SMTP id
 y7-20020aa7d507000000b005223a28fecamr2820293edq.24.1690575808575; Fri, 28 Jul
 2023 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com> <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
In-Reply-To: <ZMQZfn/hUURmfqWN@x1n>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 13:23:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
Message-ID: <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone fallout
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Jul 2023 at 12:39, Peter Xu <peterx@redhat.com> wrote:
>
> But then does it means that any gup-only user will have numa balancing
> completely disabled?

Why would we ever care about a GUP-only user?

Who knows where the actual access is coming from? It might be some
device that is on a different node entirely.

And even if the access is local from the CPU, it

 (a) might have happened after we moved somewhere else

 (b) who cares about the extra possible NUMA overhead when we just
wasted *thousands* of cycles on GUP?

So NUMA balancing really doesn't seem to make sense for GUP anyway as
far as I can see.

Now, the other side of the same thing is that (a) NUMA faulting should
be fairly rare and (b) once you do GUP, who cares anyway, so you can
also argue that "once you do GUP you might as well NUMA-fault, because
performance simply isn't an issue".

But I really think the real argument is "once you do GUP, numa
faulting is just crazy".

I think what happened is

 - the GUP code couldn't tell NUMA and actual PROTNONE apart

 - so the GUP code would punch through PROTNONE even when it shouldn't

 - so people added FOLL_NUMA to say "I don't want you to punch
through, I want the NUMA fault"

 - but then FOLL_FORCE ends up meaning that you actually *do* want to
punch through - regardless of NUMA or not - and now the two got tied
together, and we end up with nonsensical garbage like

        if (!(gup_flags & FOLL_FORCE))
                gup_flags |= FOLL_NUMA;

   to say "oh, actually, to avoid punching through when we shouldn't,
we should NUMA fault".

so we ended up with that case where even if YOU DIDN'T CARE AT ALL,
you got FOLL_NUMA just so that you wouldn't punch through.

And now we're in the situation that we've confused FOLL_FORCE and
FOLL_NUMA, even though they have absolutely *nothing* to do with each
other, except for a random implementation detail about punching
through incorrectly that isn't even relevant any more.

I really think FOLL_NUMA should just go away. And that FOLL_FORCE
replacement for it is just wrong.  If you *don't* do something without
FOLL_FORCE, you damn well shouldn't do it just because FOLL_FORCE is
set.

The *only* semantic meaning FOLL_FORCE should have is that it
overrides the vma protections for debuggers (in a very limited
manner). It should *not* affect any NUMA faulting logic in any way,
shape, or form.

               Linus
