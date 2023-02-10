Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B546924CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjBJRru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 12:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjBJRrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:47:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84C20570
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 09:47:48 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so17947966ejc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qgcGO8+97UxFzUa9otLoe9WhcHYqh4IFJols7jxOVL4=;
        b=LPrqOkJVT4UEg85v/nAzVlpJ472gmcKMbYYeMraUOPgiYjqle9VbUDBs8e3Zm1gWBH
         WQRxTLfEGgHGfiMMIfID24IotHRUddIaw08CZd8coY3Et2DEy+b/r/ymu4POvA/PHwNn
         rJAnwEUqrti8kF2sB3Coh+mEuGxmaaVK+5Ue4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgcGO8+97UxFzUa9otLoe9WhcHYqh4IFJols7jxOVL4=;
        b=ZhuIoGhbP3vwzG5wdXn81abmyW3swK66y2K0ByPGuEgPphr6h93JIh09Rl5NQPvO9C
         saGmi9PuzeplShu07Go0vpPq99Wb50ZGfGFDRnT8gb5yTQOlLmAEg4yRtO50FSuTes0L
         PHkut9WndhD/KPUcFA3NIhenW10427xLoEXCtl8Ra6kaagZxs0xvR4nr8Q3r5hSaoh+k
         qW4oByk3STZzVzHag7da5R4uDo5gvprPHHkRfu/Iy5eU294tVWfrwiIC1xoURShF+jxL
         x5E1ucfZas7kGyv3sqxAId5BmL/znusZ1OjhebeId+ptFFw/8Xti5GaVGP1ksBXHrY1y
         3nYA==
X-Gm-Message-State: AO0yUKVK6/0u7BUsuyRN+Didr56LLhYS1ZT2utNiNXNYTEOwtesg0cEF
        xCKesQjwi7InCL8vrqwt9dvpp1+xemsUCeXHpN4=
X-Google-Smtp-Source: AK7set9sILX/6TFZzMDO4vBFJEnThur9PNGwsUxafgtMxQ1SHh9qfc9iZw7Ts7uKQBYagbFyPLFLpw==
X-Received: by 2002:a17:906:c310:b0:86a:833d:e7d8 with SMTP id s16-20020a170906c31000b0086a833de7d8mr15053807ejz.17.1676051266714;
        Fri, 10 Feb 2023 09:47:46 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709064a0900b0084d4733c428sm2663593eju.88.2023.02.10.09.47.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 09:47:45 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id ml19so18072328ejb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 09:47:45 -0800 (PST)
X-Received: by 2002:a17:906:651:b0:88a:b6ca:7d3a with SMTP id
 t17-20020a170906065100b0088ab6ca7d3amr3101829ejb.1.1676051265120; Fri, 10 Feb
 2023 09:47:45 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <CAHk-=wip9xx367bfCV8xaF9Oaw4DZ6edF9Ojv10XoxJ-iUBwhA@mail.gmail.com>
 <20230210061953.GC2825702@dread.disaster.area> <CAHk-=wj6jd0JWtxO0JvjYUgKfnGEj4BzPVOfY+4_=-0iiGh0tw@mail.gmail.com>
In-Reply-To: <CAHk-=wj6jd0JWtxO0JvjYUgKfnGEj4BzPVOfY+4_=-0iiGh0tw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 09:47:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXvRKwsHUjA9T9Tw6n5x1pCO6B+4kk0GAx+oQ5qhUyRw@mail.gmail.com>
Message-ID: <CAHk-=wgXvRKwsHUjA9T9Tw6n5x1pCO6B+4kk0GAx+oQ5qhUyRw@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Dave Chinner <david@fromorbit.com>
Cc:     Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>,
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

On Fri, Feb 10, 2023 at 9:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And when it comes to networking, in general things like TCP checksums
> etc should be ok even with data that isn't stable.  When doing things
> by hand, networking should always use the "copy-and-checksum"
> functions that do the checksum while copying (so even if the source
> data changes, the checksum is going to be the checksum for the data
> that was copied).
>
> And in many (most?) smarter network cards, the card itself does the
> checksum, again on the data as it is transferred from memory.
>
> So it's not like "networking needs a stable source" is some really
> _fundamental_ requirement for things like that to work.
>
> But it may well be that we have situations where some network driver
> does the checksumming separately from then copying the data.

Ok, so I decided to try to take a look.

Somebody who actually does networking (and drivers in particular)
should probably check this, but it *looks* like the IPv4 TCP case
(just to pick the ony I looked at) gores through
tcp_sendpage_locked(), which does

        if (!(sk->sk_route_caps & NETIF_F_SG))
                return sock_no_sendpage_locked(sk, page, offset, size, flags);

which basically says "if you can't handle fragmented socket buffers,
do that 'no_sendpage' case".

So that will basically end up just falling back to a kernel
'sendmsg()', which does a copy and then it's stable.

But for the networks that *can* handle fragmented socket buffers, it
then calls do_tcp_sendpages() instead, which just creates a skb
fragment of the page (with tcp_build_frag()).

I wonder if that case should just require NETIF_F_HW_CSUM?

              Linus
