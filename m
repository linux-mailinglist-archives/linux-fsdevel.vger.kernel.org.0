Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2F4E7D6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiCYTkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiCYTiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562AA1FF40F
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 12:10:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g20so10294856edw.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ahgn5YhupKleRSjVO6dYdyUyW4I3o3ogwWA6kSn9nQ=;
        b=QPyPgps8QuodjsWDPXqvtMcTFVfWZsR0aqQQoSdRP7TaUmnhJ/tGC7gy0+oYuAFy4G
         I35vO7sHK49kml7c6c+lxUraXYenfryl7ARNrJyFeUcJlg4t2/7Igiv31HYM9zEQNhwN
         YQwW2KkWZXK6NhNQ525LLg7PM/nZgzdlIt+Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ahgn5YhupKleRSjVO6dYdyUyW4I3o3ogwWA6kSn9nQ=;
        b=G0ArTjfNu8dzQOeOF0ejyDUC6mcs5LyO7tqkeE1LJ8Zl6ihS/TEDuUVfbOLuoqXvYB
         8/+dpsQy9vVpfOPrZr8qF75f3s1JTuCDwJCRY85/GpT7d3jXmZJdfeo6CxSiLn2Spoz1
         GazsygctTslhKjHXcLDcCsDD1+g0rOtfNMl3bWgZPzjidpVmUtg0GBJTnjDO6JK/Oni1
         hzoiPmYI3qwoQbMWgDOIlKZ5VmKBrIYycpOlPqsDEvi6JucSZHAcm5v6gfzmuHR0BiiN
         If4DcnUlmXu7dqZ0gUDlFordN3QElBlpaUmSZb4ePBXiVwUDwiSw73BACqEJX9otHoAa
         3jsg==
X-Gm-Message-State: AOAM531l7ZNIjnE1724hpvzRQ3p2jmLVZYztgnSCMZwCMG7hfahPBolF
        UFM7c8Xexd9pvhqeUu/ExwhA72sidaoCnRKntjw=
X-Google-Smtp-Source: ABdhPJxl1bGAq1b2S4vOWZPs0suvN6V0hrKfYnxItuVbrn8zv25vkqjKz9H9QLejWSuLFpwgrnXNTQ==
X-Received: by 2002:a2e:9592:0:b0:24a:c0b0:5738 with SMTP id w18-20020a2e9592000000b0024ac0b05738mr1004780ljh.99.1648233635941;
        Fri, 25 Mar 2022 11:40:35 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id a12-20020a2eb16c000000b0024805905f1bsm772496ljm.98.2022.03.25.11.40.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 11:40:33 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id o6so11428950ljp.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 11:40:32 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr9410106lji.291.1648233631835; Fri, 25
 Mar 2022 11:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <YjudB7XARLlRtBiR@mit.edu> <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
 <20220325084646.7g6oto2ce3vou54x@ws.net.home>
In-Reply-To: <20220325084646.7g6oto2ce3vou54x@ws.net.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 11:40:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibqjNiLgnsL2LcTDKqnKyQ17rhHJv-qkHY1w93LJuXjA@mail.gmail.com>
Message-ID: <CAHk-=wibqjNiLgnsL2LcTDKqnKyQ17rhHJv-qkHY1w93LJuXjA@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Karel Zak <kzak@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 1:46 AM Karel Zak <kzak@redhat.com> wrote:
>
> I can imagine something like getvalues(2) in lsblk (based on /sys) or
> in lsfd (based on /proc; lsof replacement).

I really would be very hesitant to add new interfaces for completely
specialty purposes.

As others have mentioned, this has been tried for much more
fundamental reasons (that whole "open-and-read" thing), and it hasn't
been an obvious improvement.

It *could* possibly be an improvement if it would allow us to take
advantage of special server-side operations in a networked filesystem
(ie like the whole "copy_file_range" kinds of interfaces that allow
server-side things) where you need to transfer less data, or need
fewer back-and-forth operations.

And even that is clearly questionable, with some of those network file
interfaces basically not having been used in real world situations in
the past, so..

(Also, with "copy_file_range" we not only had others actively doing
it, but the wins were "several orders of manitude", so even if it was
fairly rare, it was _so_ big that it was worth doing anyway).

With the "open-and-read" thing, the wins aren't that enormous.

And getvalues() isn't even that. It's literally a speciality interface
for a very special thing. Yes, I'm sure it avoids several system
calls. Yes, I'm sure it avoids parsing strings etc. But I really don't
think this is something we want to do unless people can show enormous
and real-world examples of where it makes such a huge difference that
we absolutely have to do it.

             Linus
