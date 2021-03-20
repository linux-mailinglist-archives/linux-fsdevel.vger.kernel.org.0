Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E468D342976
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 01:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTAcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTAbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:31:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0E8C061762
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 17:31:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x28so12627702lfu.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61j+NwfICNWJWz0XMgFUBwrGhoQDi0J8u1n1is81ZYM=;
        b=CpbSVYpb9YM1T9z1e1UZGf7HmWEG3ed4KwVewC9begrECftVwGF0pqxn4xXjZL6kO3
         A9HqtpleUFq3FaYakT6UFgrfqOt7d3YRtgmx1JZdEDBxycA0My59WwVuumIknimBFEkM
         fCqs/yzGnaUnaQYMf0T5oTP5vCgohxkIx1HUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61j+NwfICNWJWz0XMgFUBwrGhoQDi0J8u1n1is81ZYM=;
        b=nklw481gBGY7P19fAphiI/VjoGyy1RgolXSC2hAeh/tpkHll3IjoKUb9/oAE+fk35/
         WblC1xhsycecgv7FnyMagO0FqcoKwbI/ChuVCgQt+ggSmA8dtqlkzFLuwrHdvKFdpAix
         K3KSVSpVnB1XIoiEYGZ+YNTbsmCaUxMhS2xGbmWZ8Nw1Bp25VPmoPFfbBa6h9/s6AktY
         SS3pzCjVqj+g/o0p6mKJrDJCMF54dWLoHSxBud8mpjH7Uk0vEgEF+rFNU2FSxy1DqoRq
         qKvt0hEWB/NTeKNk3wXDFeijaFMY4cXj3UZkyAfGGJ5F1gaAlb0BnUD9/B/KN8W+uUKE
         3hmQ==
X-Gm-Message-State: AOAM533esoeloAJsfLhhDdlNt+InF09nmyyz82h68UBuxl6Q0SfWDsYe
        z4y1a0tgbe0oxQOwKUEi4CRTn5lQTf8eMA==
X-Google-Smtp-Source: ABdhPJwc8Bx6crMJsNZ8zNouhqm8hsYeUmW7JtxP9oxZUWpAOz93HKEk7bl3dDCtFFGd/zvqIGNZPg==
X-Received: by 2002:a19:f608:: with SMTP id x8mr2292150lfe.380.1616200296562;
        Fri, 19 Mar 2021 17:31:36 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p22sm781167lfh.113.2021.03.19.17.31.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 17:31:35 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id o10so12628429lfb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 17:31:34 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr2189309lfo.201.1616200294775;
 Fri, 19 Mar 2021 17:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain> <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
 <YFUTnDaCdjWHHht5@relinquished.localdomain> <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
 <YFUpvFyXD0WoUHFu@relinquished.localdomain>
In-Reply-To: <YFUpvFyXD0WoUHFu@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 17:31:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
Message-ID: <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 3:46 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> Not much shorter, but it is easier to follow.

Yeah, that looks about right to me.

You should probably use kmap_local_page() rather than kmap_atomic()
these days, but other than that this looks fairly straightforward, and
I much prefer the model where we very much force that "must be the
first iovec entry".

As you say, maybe not shorter, but a lot more straightforward.

That said, looking through the patch series, I see at least one other
issue. Look at parisc:

    +#define O_ALLOW_ENCODED 100000000

yeah, that's completely wrong. I see how it happened, but that's _really_ wrong.

I would want others to take a look in case there's something else. I'm
not qualified to comment about (nor do I deeply care) about the btrfs
parts, but the generic interface parts should most definitely get more
attention.

By Al, if possible, but other fs people too..

           Linus
