Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A3692460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 18:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjBJRYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 12:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBJRYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:24:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8974367FB
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 09:24:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j23so5799405wra.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jK4GcD8hacKVWz6zl8bBrz233whrxcoTUY/2ygZZfmc=;
        b=M2jDhbmblGLdfowPWsAysOenXMHJGfjKF4XBxa3qOAJbzKq8BVW5Bi70WAjt5O9fGN
         qp+ANsnVyXQKsU16qsl+FTAEnXVOzh8BC6x36hX/4beu9BTYwt7CqPuJFw/mHj4k+UR8
         H8YDYi8jHuZgdrghm16rzRYLYR86rDIbo1cgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jK4GcD8hacKVWz6zl8bBrz233whrxcoTUY/2ygZZfmc=;
        b=KudSrdiJ7RJQyihz7giUgJhezTpMAZYCsRoVpQ+Kuqg9VLok+Af3E5lzmTSymiS0uC
         SWn+VaOdQFPvAnfAd1zn/CAmtcnWN3KC6IpOSe6IM9mCvObmtDBJgXKnV9000sgN6IRk
         2Q67yAw7t0pN7Y7cTfxpyp6+4AA+eWSIpiVyAG0/e6aZMBx07pPIEPUIGVXDHCqzWtYa
         IfdXHdwhtflGchnf9FEeFXdNMnwQKGUqgADb4OH2ujern5mLF3ha5QjKsBOD4erX5dht
         vcYiwjUJr1456k5WNkG+8dGfJdaDS9QLE216kubDzc1ruoxvV6V+QpdLUVlJUfB9H4Nu
         mb/w==
X-Gm-Message-State: AO0yUKXBwZSpLDpfVUdDWA32T+PYsXO7WvX5IJhO4lpOcFZMUSo6iWU1
        J1IPOyRY/HXCJLnB6xWHghcN5TjOproZ/ySBOKo=
X-Google-Smtp-Source: AK7set8iQejUyRARXKyYC3AVfo7JnbeN2gbU8pHdTiJTNQ6bSjskSNWTNdcQde0Kph8Spr4Sg/xhKw==
X-Received: by 2002:a5d:678c:0:b0:2c3:e392:67ae with SMTP id v12-20020a5d678c000000b002c3e39267aemr8170507wru.3.1676049853097;
        Fri, 10 Feb 2023 09:24:13 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d514a000000b002c3e28d0343sm4022040wrt.85.2023.02.10.09.24.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 09:24:12 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id lu11so17773441ejb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 09:24:12 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr3050972ejw.78.1676049852037; Fri, 10 Feb
 2023 09:24:12 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <CAHk-=wip9xx367bfCV8xaF9Oaw4DZ6edF9Ojv10XoxJ-iUBwhA@mail.gmail.com> <20230210061953.GC2825702@dread.disaster.area>
In-Reply-To: <20230210061953.GC2825702@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 09:23:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6jd0JWtxO0JvjYUgKfnGEj4BzPVOfY+4_=-0iiGh0tw@mail.gmail.com>
Message-ID: <CAHk-=wj6jd0JWtxO0JvjYUgKfnGEj4BzPVOfY+4_=-0iiGh0tw@mail.gmail.com>
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

On Thu, Feb 9, 2023 at 10:19 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Splice has two sides - a source where we splice to the transport
> pipe, then a destination where we splice pages from the transport
> pipe. For better or worse, time in the transport pipe is unbounded,
> but that does not mean the srouce or destination have unbound
> processing times.

Well, they are possibly fairly unbounded too - think things like
network packet re-send timeouts etc.

So the data lifetime - even just on just one side - can _easily_ be
"multiple seconds" even when things are normal, and if you have actual
network connectivity issues we are easily talking minutes.

So I don't think a scheme based on locking works even for just the
"one side" operations - at least in the general case.

That said, I wasn't really serious about my "retry" model either.
Maybe it could be made to work, but it sounds messy.

And when it comes to networking, in general things like TCP checksums
etc should be ok even with data that isn't stable.  When doing things
by hand, networking should always use the "copy-and-checksum"
functions that do the checksum while copying (so even if the source
data changes, the checksum is going to be the checksum for the data
that was copied).

And in many (most?) smarter network cards, the card itself does the
checksum, again on the data as it is transferred from memory.

So it's not like "networking needs a stable source" is some really
_fundamental_ requirement for things like that to work.

But it may well be that we have situations where some network driver
does the checksumming separately from then copying the data.

               Linus
