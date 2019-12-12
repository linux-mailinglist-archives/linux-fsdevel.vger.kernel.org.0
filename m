Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA211C380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 03:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfLLCrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 21:47:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46905 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfLLCrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:47:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id z17so436428ljk.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 18:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHahO8LZCdU8zaS7EVF3B7S7ImGonfhaVfJ1tDELB24=;
        b=HQtj4NOC4GpXxt0IO2bvTeez5WRIJN4iBxbju4l+SfUr9aGQjQQVxEEqv0iSvAH9Cf
         9oCv9CE4ffHGIPUk2jakyqwdkFRFRmmhpkingwTTi0fiZ9fYFLy2E+IJnHkXNmeji7HD
         t9R7bmUbOJQIYUbypH6AG8tdoLgT7EDiX9sBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHahO8LZCdU8zaS7EVF3B7S7ImGonfhaVfJ1tDELB24=;
        b=otoeenhfPF/NzUECbOuyoUSSaeWKL9d9rbBb5rEBV9PVRiC0UqvoUuc4C61FK0eLK3
         ajjGQwMovRwonASAgckPq5wiH6PetdaZd4tnaPbshkYmI6lDs8oZ01HLXj661otUsfel
         iRwTIqiPP2N9KkBPfKSIcuDiyLxvusswPkQVLIjNa69KhDG3WUiBXm/XQdjyYGY0yp9z
         qAVjSY0XXLFS6R0a6lz0NbgnfQ+kS7qW+3utmGqXt48GOXI11uXd7EvrPyNyH4DNPHn7
         XyBe9R1Obz3U35sLYRM2YVwgDKDMfoB2DY6Re4Utv/BAKjWljP4zIhjw4UgG799wKruI
         YVPQ==
X-Gm-Message-State: APjAAAWDAjM4tQPrecYB6Sisr6/nvxTg+/9FpasWAIWddHd10dwlfGSw
        3DYGJdLvw39ELmqICc8wVjbibRGkiFA=
X-Google-Smtp-Source: APXvYqxqsv/zywjgfh+UpetJ/elEzrUXXcdPsAQMELQcntaa/8X4hogx0XTDFgetiJLo/VQvanTbCQ==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr4113780ljk.220.1576118863176;
        Wed, 11 Dec 2019 18:47:43 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l12sm90137lji.52.2019.12.11.18.47.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 18:47:42 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id n25so480614lfl.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 18:47:41 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr4341762lfj.61.1576118861439;
 Wed, 11 Dec 2019 18:47:41 -0800 (PST)
MIME-Version: 1.0
References: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk> <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
 <20191212015612.GP32169@bombadil.infradead.org>
In-Reply-To: <20191212015612.GP32169@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 18:47:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
Message-ID: <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 5:56 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> It _should_ be the same order of complexity.  Since there's already
> a page in the page cache, xas_create() just walks its way down to the
> right node calling xas_descend() and then xas_store() does the equivalent
> of __radix_tree_replace().  I don't see a bug that would make it more
> expensive than the old code ... a 10GB file is going to have four levels
> of radix tree node, so it shouldn't even spend that long looking for
> the right node.

The profile seems to say that 85% of the cost of xas_create() is two
instructions:

# lib/xarray.c:143:     return (index >> node->shift) & XA_CHUNK_MASK;
        movzbl  (%rsi), %ecx    # MEM[(unsigned char *)node_13],
MEM[(unsigned char *)node_13]
...
# ./include/linux/xarray.h:1145:        return
rcu_dereference_check(node->slots[offset],
# ./include/linux/compiler.h:199:       __READ_ONCE_SIZE;
        movq    (%rax), %rax    # MEM[(volatile __u64 *)_80], <retval>

where that first load is "node->shift", and the second load seems to
be just the node dereference.

I think both of them are basically just xas_descend(), but it's a bit
hard to read the several levels of inlining.

I suspect the real issue is that going through kswapd means we've lost
almost all locality, and with the random walking the LRU list is
basically entirely unordered so you don't get any advantage of the
xarray having (otherwise) possibly good cache patterns.

So we're just missing in the caches all the time, making it expensive.

              Linus
