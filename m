Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00297AC500
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 22:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjIWUEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWUEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:04:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1911D
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 13:04:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bffa8578feso67664601fa.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695499455; x=1696104255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KHNqLCORfOJTNtw7tvckoFOgfFqHshijJO4Eh7ejvc=;
        b=IlUZydWF64KCzrto+lYCOa5oeDakmiOu7TJUmcbJ4yyOJI1wayn9L6OTXrgHBp/Ix5
         B8w5u+uujH/VB1LCYhQR46Rq8NMBQfY5KyXS27IL14C19K2sfPhJYijh1cL8+TVDh5jW
         2xWImTs1KT2pJv+XGBR18DCWm+xhyiHfP+7hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695499455; x=1696104255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KHNqLCORfOJTNtw7tvckoFOgfFqHshijJO4Eh7ejvc=;
        b=eGY0+ZIfcmrCJOfWKSreQXrwNKrUOs97E6cvyLmoteheC4AQ5Q7dn/VTtoMfcRTbzV
         pG/CeCWTqNj+Ic5YrQt1Pt3F4fBxUzwTNe3KExNp8H+TwZLiMQlIt/pYbX92E1yA6Q0T
         pyFdUgP3dmMeyBD4ZSNJkEwkWu9Zv4qmMKzLjW6qJA59FdYM7sdntRnhUi14HNiw0hQZ
         W4BY0AW62uTdKE7zTPJOnrPkrkGp3BgSM7TZ0eVZJDK9nIKQMpmIvEuNqZiPSA/zXJ9V
         zGU2tkrKS3K7FRIxa9tB5SkN/w+RIDK3wS8rTtyUZziv59fgGLWVetA1C0OJPEz/AWDG
         PQJg==
X-Gm-Message-State: AOJu0YytUxeZSQ1Nvqk3uE1sbFre+8nBRXgovhFC9DIxgfYVvVrBX1Yv
        DSGGAl2UHbYmDR9ssAAvRVwFWfU1gw7lMnGA2He6uNgF
X-Google-Smtp-Source: AGHT+IFE/ZxJUeFi7NUitHb1a/HiiezzyMZRiYY9T1J2Vgk5D5khcUjLjSWVP5lkuuMoZFKVcZmBFw==
X-Received: by 2002:ac2:5f08:0:b0:503:3ac:8457 with SMTP id 8-20020ac25f08000000b0050303ac8457mr1954441lfq.45.1695499454741;
        Sat, 23 Sep 2023 13:04:14 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l11-20020ac2554b000000b004fe3a8a9a0bsm1187132lfk.202.2023.09.23.13.04.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 13:04:14 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50307acd445so6397788e87.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 13:04:13 -0700 (PDT)
X-Received: by 2002:a05:6512:2820:b0:500:8fcb:e0c9 with SMTP id
 cf32-20020a056512282000b005008fcbe0c9mr2783936lfb.69.1695499453477; Sat, 23
 Sep 2023 13:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com> <ZQ884uCkKGu6xsDi@mit.edu>
In-Reply-To: <ZQ884uCkKGu6xsDi@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Sep 2023 13:03:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8zxC9h5a0qimfGJVvkN0H5fNgg03+TNn9GE=g_G30vw@mail.gmail.com>
Message-ID: <CAHk-=wg8zxC9h5a0qimfGJVvkN0H5fNgg03+TNn9GE=g_G30vw@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 23 Sept 2023 at 12:30, Theodore Ts'o <tytso@mit.edu> wrote:
>
> It depends on what conversion we need to do.  If we're converting to
> userspace's timespec64 data structure, which is denominated in
> nanosecods, it's actually much easier to use decimal 100ns units:

Actually, your data format seems to be a mix of "decimal nanoseconds"
and then a power-of-two seconds (ie bit shift).

Except it looks like ext4 actually does full nanosecond resolution (30
bits for nanoseconds, 34 bits for seconds). Thus the "only a couple of
hundred years of range".

And yes, that's probably close to optimal. It makes it harder to do
*math* on those dates (because you have seconds and 100ns as separate
fields), but for file timestamps that's likely not a real issue.

It was for 'ktime_t()', where with timers etc the whole "subtract and
add times" happens *all* the time, but for file timestamps you
basically have "set time" together with possibly comparing them (and
you can do comparisons without even splitting the fields if you lay
things out reasonably - which you ext4 doesn't seem to have done).

So yeah, I think that would be a fine 'fstime_t' for the kernel.

Except we'd do it without the EXT4_EPOCH_MASK conditionals, and I
think it would be better to have a bigger range for seconds. If you
give the seconds field three extra bits, you're comfortable in the
"thousands of years", and you still have 27 bits that can encode a
decimal "100ns".

It means that when you convert a fstime_t to timespec64 at stat()
time, you'd have to do a 32-bit "multiply by 100" to get the actual
nanosecond field, but that's cheap everywhere (and obviously the
shift-and-masks to get the separate fields out of the 64-bit value).

               Linus
