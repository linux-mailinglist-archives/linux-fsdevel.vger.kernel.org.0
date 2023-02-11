Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601F1693325
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Feb 2023 19:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBKS6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Feb 2023 13:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBKS6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Feb 2023 13:58:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282CF199E5
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Feb 2023 10:58:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qb15so21073392ejc.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Feb 2023 10:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v6OIGzvOpvoDs5k8U8ZXPR9Oe0WDhcfEQMGkRVj61LY=;
        b=EIXdLD2NKM3TRG47LtztKC0uokjWh9qOIVDhwX03oat6LH91fz1Bsf/lPs2NP2CG8X
         +DswqOlfYlGGKQggnB9PN5h6tY4I4kXpr4aX5smQFgvIZzwCwCuHFcRbAT4uyAPo4Q6z
         xKh6bsoMHKAriwGucZR6A+JhEX/u34NaffC2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6OIGzvOpvoDs5k8U8ZXPR9Oe0WDhcfEQMGkRVj61LY=;
        b=EU15qxv5soh4cJOWWoHZBPQ8IiM3aD2BFLKxaJIyuzSYhn6v4+2UbvMYKv1WC4FY0b
         qLnt4yZKWxVc9zljZ9QtqMjSXOTaaANGE93wNx6RJVa19ZZS6nyaC0MZJ6/IpO8pg/nQ
         nHLLQXuIWs3L1B6YJic9iyojO2SFpGPRgXzBoBOrfKjmPObtdwDNT3cCpOGDJh9QS7y9
         afesSU9t9Jbt2yBuXgtJn3xudwwieFfG9gCv+hzcUskhXreTHkGXhlm/F0Hr5srnhP6P
         +bvCqIttRibpZraFd0CXBsgINJBjt59ousvVtAm3x2w9LWeU8/7nKzRCPUk1oIWfcv1K
         QBzg==
X-Gm-Message-State: AO0yUKXkaFvIKm0lAZOvUuD1RBooxF16nzn9F0L/5QiTAsuqMJ1VF9h9
        /OyoEHF0tPt5IuxT7Xa4OlapTITUGxMVKcN6aoY=
X-Google-Smtp-Source: AK7set/SNHHMRaylaFCHYjoUtsuJTjnrTrsDhKER7eQCKWDrqnjyzo0i0HuEj+39ALWQR8ZAsK4ajg==
X-Received: by 2002:a17:907:d2a:b0:8af:ef9a:1911 with SMTP id gn42-20020a1709070d2a00b008afef9a1911mr4749255ejc.5.1676141893542;
        Sat, 11 Feb 2023 10:58:13 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906059300b0088f8803661asm4166754ejn.8.2023.02.11.10.58.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 10:58:12 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id sa10so23098182ejc.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Feb 2023 10:58:12 -0800 (PST)
X-Received: by 2002:a17:906:658:b0:88f:a9ec:dfd7 with SMTP id
 t24-20020a170906065800b0088fa9ecdfd7mr2491955ejb.0.1676141891911; Sat, 11 Feb
 2023 10:58:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk> <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
 <7a2e5b7f-c213-09ff-ef35-d6c2967b31a7@kernel.dk> <CALCETrVx4cj7KrhaevtFN19rf=A6kauFTr7UPzQVage0MsBLrg@mail.gmail.com>
 <b44783e6-3da2-85dd-a482-5d9aeb018e9c@kernel.dk> <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
 <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
 <Y+cJDnnMuirSjO3E@T590> <55eaac9e-0d77-1fa2-df27-4d64e123177e@kernel.dk>
 <Y+euv+zR5ltTELqk@T590> <787c3b62-f5d8-694d-cd2f-24b40848e39f@kernel.dk>
In-Reply-To: <787c3b62-f5d8-694d-cd2f-24b40848e39f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Feb 2023 10:57:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQ_V1ZE6jhQKHDk1MKvEkjpF2Pj-OcRQRXBTMsNpA1YA@mail.gmail.com>
Message-ID: <CAHk-=whQ_V1ZE6jhQKHDk1MKvEkjpF2Pj-OcRQRXBTMsNpA1YA@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
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

On Sat, Feb 11, 2023 at 7:33 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> OK, but then the ignore_sig change should not be needed at all, just
> changing that first bit to fatal_signal_pending() would do the trick?

Right. That was my point. The 'ignore_sig' flag just doesn't make
sense. It was a hack for a case that shouldn't exist.

              Linus
