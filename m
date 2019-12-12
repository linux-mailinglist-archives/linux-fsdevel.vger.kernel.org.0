Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA811C216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLLBXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:23:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42835 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfLLBXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:23:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so298712ljo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFejtvBe0docBJOjFHxtgIhfiR8IhEXMLIpQaHwz1hE=;
        b=Qc2vMRGn05C6BWhmeoZIaRoNsVj0SkjLXAbn9Gpo6T5N/+z6+RFmlpRLW5yvsYKNPg
         yDJ+wvL8TsHB0O6Oyi4tDJl0UJhonvrjzcws9HiezXHgSae108P3Sjj8l/gZO1nX23dW
         37s2bsGbyB3ZRoTk2x40dKoxY7GG6o7PWDKGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFejtvBe0docBJOjFHxtgIhfiR8IhEXMLIpQaHwz1hE=;
        b=Ia6V9erJ+N7afSSZ7sEgMfjIY3nC5okbuxFETPpowCndma3VUfMSGd8Pto6vIuVt0+
         oH7X4cf1+vKhPsd031xgneItPPczYkwzdE3K85sgnSJHmk8gOlhXSzhitW3nIyHiS+4p
         XXCBbtb7IE/HQQm+gfclvlk4dotVUBpRHiKoTd25J0+nCFVzhRtu0k0Eypzkql4XgfM3
         hl0ZDdVdNvAxgCuQbqWqtFUto9sqiNA56zL/wn3+9dRzJTMTPX2uZ9N36sOjWfeOW2V8
         Ras6CFVWKi2XD9AI+g8se26EcmLuZgYjBaocdJCUWYXBsl0OsaBdtM6zvjUt8JYifRq0
         K9IQ==
X-Gm-Message-State: APjAAAU4mHZCbvxZusz2ZiAS09WV0xEYgiXGNiOqp/Txz9w91Aa7Qc+R
        zMSFgTFl6FHFBZJlsCd1tztGSyd3bnE=
X-Google-Smtp-Source: APXvYqy2Rq0PK5phvSTK6oyQeUDILmP/FoBnhgyiRbwLq1xtzzhvkm+9DE478427g1id75GYYFIwpQ==
X-Received: by 2002:a2e:9694:: with SMTP id q20mr4074051lji.248.1576113787115;
        Wed, 11 Dec 2019 17:23:07 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c9sm1994667ljd.28.2019.12.11.17.23.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:23:06 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id i23so342790lfo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:23:06 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr4158153lfp.106.1576113785777;
 Wed, 11 Dec 2019 17:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
In-Reply-To: <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:22:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
Message-ID: <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 5:11 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> 15K is likely too slow to really show an issue, I'm afraid. The 970
> is no slouch, but your crypt setup will likely hamper it a lot. You
> don't have a non-encrypted partition on it?

No. I normally don't need all that much disk, so I've never upgraded
my ssd from the 512G size.

Which means that it's actually half full or so, and I never felt like
"I should keep an unencrypted partition for IO testing", since I don't
generally _do_ any IO testing.

I can get my load up with "numjobs=8" and get my iops up to the 100k
range, though.

But kswapd doesn't much seem to care, the CPU percentage actually does
_down_ to 0.39% when I try that. Probably simply because now my CPU's
are busy, so they are running at 4.7Ghz instead of the 800Mhz "mostly
idle" state ...

I guess I should be happy. It does mean that the situation you see
isn't exactly the normal case. I understand why you want to do the
non-cached case, but the case I think it the worrisome one is the
regular buffered one, so that's what I'm testing (not even trying the
noaccess patches).

So from your report I went "uhhuh, that sounds like a bug". And it
appears that it largely isn't - you're seeing it because of pushing
the IO subsystem by another order of magnitude (and then I agree that
"under those kinds of IO loads, caching just won't help")

                   Linus
