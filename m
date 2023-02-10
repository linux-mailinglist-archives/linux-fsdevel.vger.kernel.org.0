Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD9692656
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 20:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjBJT3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 14:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjBJT3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:29:53 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BC7DD1C
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 11:29:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u21so5640796edv.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 11:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r61/0h5NTTq+Qoz9OXQLKuxfQJmXqVpaixbdP55tAzc=;
        b=IAdLRQRIm/NXW+WeR+UYR2ZTsvGw0tN2PBRMeoFQUWHyntbQJr49WmKYDyvef9iYCp
         lUUb1ydt4R7bdgKIQp1NsqwNFy5yaD5bZK5PWeSLfJdZfj2Cqzk/kag9hbbtNtbhJf4N
         zm6LxZ2ObZ/VLq+NbgF57dtNvJBp8k5O0X+1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r61/0h5NTTq+Qoz9OXQLKuxfQJmXqVpaixbdP55tAzc=;
        b=5QxZeh4rOVZRBA2rWstbg1Iq1QJqQ4UmyYtG3+sgtDVYRX0/tnH/lPXAsLn6qTDq2o
         jwreRli7XzsnZkNjxb8vp2Z2Lj1PqD0IP/zjFAqlpeswcMm/PoIRQL/+7B4rzMZGB5jB
         O+Kfo6k/g6+ZUaAB3oeGtNUZcL5SZGBNxpGtGI1kqL3x4jyCYd6AXmx/ojOn2U8OXFSY
         ShTrG4VrTCR7BVLHb4AH4iDPBg/jf+cehQ4Csd4VxyAhez0wlmnf6Lvq9Cxhqt+zSZcu
         jqAut4xu/agKMeHD3pvs2vP6q64VekWPFFV4aAjVZGQlVARuBqOLox0QMDxrNMGsMHVr
         mBJQ==
X-Gm-Message-State: AO0yUKXbOyo2vfbEgYqjBu6tCgavVMboZEhgW0EHgpe/1W9T0fUIJL9K
        8B+Ypm3K9Af22kO4zLaGBUmrQ7TBRQR5ifioMqw=
X-Google-Smtp-Source: AK7set+76aguFEzOjAYxrlwDTKq4c4fBxpaNib6wgxz9BOYYssJ0mh5TGIySlcNKYeqtU9lP4ndIpw==
X-Received: by 2002:a50:9eee:0:b0:49d:9ff4:d82b with SMTP id a101-20020a509eee000000b0049d9ff4d82bmr17774238edf.15.1676057390109;
        Fri, 10 Feb 2023 11:29:50 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id m17-20020a50c191000000b004a22ed9030csm2674390edf.56.2023.02.10.11.29.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:29:49 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id u21so5640709edv.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 11:29:48 -0800 (PST)
X-Received: by 2002:a50:aad4:0:b0:4ab:4d34:9762 with SMTP id
 r20-20020a50aad4000000b004ab4d349762mr582230edc.5.1676057388706; Fri, 10 Feb
 2023 11:29:48 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com> <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 11:29:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg2Mb4ZgRuBthw6O0KLhZNksGBQNs73386Gdg4gHny=XA@mail.gmail.com>
Message-ID: <CAHk-=wg2Mb4ZgRuBthw6O0KLhZNksGBQNs73386Gdg4gHny=XA@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>,
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

On Fri, Feb 10, 2023 at 11:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - and finally, I do think it might make sense for the networking
> people to look at how the networking side works with 'sendpage()'.

Put another way: I do not believe that it is at all fundamental that
you can't send data from an changing source over the network. That's
likely _particularly_ true of the people who care the most, and who
already have network cards that do a lot of the heavy lifting for you.

So why spend a lot of effort to stabilize the data, if it's not
needed, when the primary users of it would likely not want that
performance hit and extra work in the first place?

Then making that "strict mode" be the only mode going forward and just
disallowing people from doing the simple thing sounds particularly
wrong.

For example, it may *literally* be that the IPV4 TCP case could be
fixed with something trivial like this

  --- a/net/ipv4/tcp.c
  +++ b/net/ipv4/tcp.c
  @@ -1134,7 +1134,8 @@ EXPORT_SYMBOL_GPL(do_tcp_sendpages);
   int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
                        size_t size, int flags)
   {
  -     if (!(sk->sk_route_caps & NETIF_F_SG))
  +     if (!(sk->sk_route_caps & NETIF_F_SG) ||
  +         !(sk->sk_route_caps & (NETIF_F_HW_CSUM | NETIF_F_IP_CSUM)))
                return sock_no_sendpage_locked(sk, page, offset, size, flags);

        tcp_rate_check_app_limited(sk);  /* is sending application-limited? */

which would basically make hardware that can't deal with the data
changing under it just fall back to the "safe and slow" model on its
own.

But then hardware that doesn't care would "just work".

See what I'm saying? The above patch may be garbage because I don't
understand the network driver rules fully, so don't take the above as
some kind of "last word" on this AT ALL. But I'm just saying that
requiring stable sources doesn't necessarily make any sense at all.

              Linus
