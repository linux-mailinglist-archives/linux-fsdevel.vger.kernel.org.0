Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE876929D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjBJWI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 17:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjBJWI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:08:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0F6C7F9
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 14:08:56 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ml19so19491124ejb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=abSFB59ri4FOl7mUi8eUgUBhSEYjEYSp3hrpjZkmJ0U=;
        b=NcU1uFZdoJAjGPI44x/T/oJNFFkClW4PcLYk/vV5Feaov42tAJqpKYVo9/YlqDXw24
         MP1ObyJcJdHSRWORQxht+uP0G/aT/dcYZ9VhAyTSNq5BQ9jK4YMDeinqtABv+BxW+AIh
         cxBZ6zXZfc4dJfwH59qtqzuo+YrVtdjQpLas8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abSFB59ri4FOl7mUi8eUgUBhSEYjEYSp3hrpjZkmJ0U=;
        b=2ujflOXJ4DjdyJbtYsoPp7E0BNdDWbLeFz+j/fD3wivUy/wQ1GNMPqNKVjMVlu57SQ
         VJVyUrffOSZdR0ILNyV8foWcIEFZS4d+I7bxqcIHMA9gTyj+ixipxcd3kQkhJeZuD0WM
         9XTnFpT2eBZ0+qL/Rr6Fuz6EcO6qqu0QG1riWFv71EycSWZezx0PrKrHdmYh2qsSACFU
         TGar5JWiIfpHiVN7XqZr/oRcu3agruvX0t8mfkzxX/Ph8aK7L5sTNttLHvfX5kH3P/7a
         Nz05RZa5Hr0Qt8uB82fsvdqNXypzGWGMXsDytp8coiuB7zGFhv8faBrY74PLBSu4QQ4F
         Yq9A==
X-Gm-Message-State: AO0yUKXHDKWMmzPPEyNru1WFmQBMZv6JjCMEeEP2BhBZfuV8+fdMchAD
        3F1M/ghFBuxynQz1Q4gSnzRramugARwpTLv9bXs=
X-Google-Smtp-Source: AK7set+Z0dHewgnf7SslRy6Cm5ELyGd8ojP0r7r5Fwdgoa440n2WVhH7+/pO1Rt1oYgs9YokeZoe4Q==
X-Received: by 2002:a17:906:6a04:b0:8af:12d9:a4ac with SMTP id qw4-20020a1709066a0400b008af12d9a4acmr12970209ejc.25.1676066934592;
        Fri, 10 Feb 2023 14:08:54 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id de56-20020a1709069bf800b00878530f5324sm2985149ejc.90.2023.02.10.14.08.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:08:53 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id fj20so6098143edb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 14:08:52 -0800 (PST)
X-Received: by 2002:a50:c353:0:b0:4ac:b616:4ba9 with SMTP id
 q19-20020a50c353000000b004acb6164ba9mr189716edb.5.1676066932381; Fri, 10 Feb
 2023 14:08:52 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
 <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk> <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk> <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
 <7a2e5b7f-c213-09ff-ef35-d6c2967b31a7@kernel.dk> <CALCETrVx4cj7KrhaevtFN19rf=A6kauFTr7UPzQVage0MsBLrg@mail.gmail.com>
 <b44783e6-3da2-85dd-a482-5d9aeb018e9c@kernel.dk> <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
In-Reply-To: <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 14:08:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
Message-ID: <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

On Fri, Feb 10, 2023 at 1:51 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Speaking of splice/io_uring, Ming posted this today:
>
> https://lore.kernel.org/io-uring/20230210153212.733006-1-ming.lei@redhat.com/

Ugh. Some of that is really ugly. Both 'ignore_sig' and
'ack_page_consuming' just look wrong. Pure random special cases.

And that 'ignore_sig' is particularly ugly, since the only thing that
sets it also sets SPLICE_F_NONBLOCK.

And the *only* thing that actually then checks that field is
'splice_from_pipe_next()', where there are exactly two
signal_pending() checks that it adds to, and

 (a) the first one is to protect from endless loops

 (b) the second one is irrelevant when  SPLICE_F_NONBLOCK is set

So honestly, just NAK on that series.

I think that instead of 'ignore_sig' (which shouldn't exist), that
first 'signal_pending()' check in splice_from_pipe_next() should just
be changed into a 'fatal_signal_pending()'.

But that 'ack_page_consuming' thing looks even more disgusting, and
since I'm not sure why it even exists, I don't know what it's doing
wrong.

Let's agree not to make splice() worse, while people are talking about
how bad it already is, ok?

                Linus
