Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93C24E81F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 17:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiCZQeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiCZQeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 12:34:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26DD7B10C
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 09:32:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c10so2382808ejs.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FHUop+N9DjDqruU3lt9gAtPmONXBVCffK/ZydWfHX0=;
        b=hkQj2+GTSx7kzHRwd/MNLlw4RCAOmwETSWEC10MusiwRDX1AFpEvmm9t7j5Ld0cUTm
         06o5slMz4MqmYIYbYd+j4DYqxPXS5j73y+A0YeycSyXT8/2TzuFNan2j97A52DnVbkQh
         DgC3bhknxto3OrRbxbx18V6Ff5V4T1A4wttWC4iL++TKxjZSdHbQwg2SyO4C2qMJEuxX
         WxGPSigsPqxAs4ZU0B6ANz4h1TOJQoMWVqwiZ04r9MfuR4kRpXk6fVEAysvvqwy6rSV1
         A4CYS547Ugj0dmOISzM6xea1mkRnfcImdMDmu8yN2xV5pYZeDADK8OQ7wNJqAkdnqecV
         Arsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FHUop+N9DjDqruU3lt9gAtPmONXBVCffK/ZydWfHX0=;
        b=Uq2pdAoGO7zM8dQD00GS3B6X5PaTlvrUCtCMm7yKYBFAwCrW4vGGwhwIku3AkKDX/r
         9Ekcs1OmwbF1VNv6qvFmJD4j7HqUO+uSPlDrk70+xktu1jyUedoGhGhZ1FRQce3O1jmw
         Zfomv4uRa3GN8XNz0qdcah54RhkaFHXQzsTlFnDbduMUcTzopA9Wi8QAEmddI6W4DnL+
         QVJr4ifqXhJww144BbEDir/6/tIbU3A8m9n6ped80RMDD8e9VkYcJzEexhxu+Z0q2D/N
         mt/nZCebd1RG/mDKfCjW50RgHgC6gF6hHV2pMn3Ab1kaarWcxe0Agjxl4Iq01rA7if0S
         TV1A==
X-Gm-Message-State: AOAM532ZKamGHR2TLmq9FpT0GUf7/F4ets9GoM9+ck8FO3ODCMS8Z95y
        RN4o6iY/uv3yd24qypbXtCLKCB1faLK18YjdoxvHsA==
X-Google-Smtp-Source: ABdhPJwilYkx9IgtUxjhEnf6pM0gX/15sG6lay1fo6m8XzqLw06syRvP6rMKCVy1bmz7wRl60FGfxHdncV9MRy4nGgs=
X-Received: by 2002:a17:907:3f9c:b0:6d8:116d:476b with SMTP id
 hr28-20020a1709073f9c00b006d8116d476bmr17517009ejc.432.1648312361976; Sat, 26
 Mar 2022 09:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220326063558.89906-1-kuniyu@amazon.co.jp>
In-Reply-To: <20220326063558.89906-1-kuniyu@amazon.co.jp>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Sat, 26 Mar 2022 12:32:05 -0400
Message-ID: <CACSApvZT8ZzA6ZDwxbei6s5e0T6rP6h6+20cDmh_C9RqNPSz4Q@mail.gmail.com>
Subject: Re: [PATCH] list: Fix another data-race around ep->rdllist.
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+19480160ef25c9ffa29d@syzkaller.appspotmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 26, 2022 at 2:36 AM Kuniyuki Iwashima <kuniyu@amazon.co.jp> wrote:
>
> syzbot had reported another race around ep->rdllist.  ep_poll() calls
> list_empty_careful() locklessly to check if the list is empty or not
> by testing rdllist->prev == rdllist->next.
>
> When the list does not have any nodes, the next and prev arguments of
> __list_add() is the same head pointer.  Thus the write to head->prev
> there is racy with lockless list_empty_careful() and needs WRITE_ONCE()
> to avoid store-tearing.
>
> Note that the reader side is already fixed in the patch [0].
>
> [0]: https://lore.kernel.org/mm-commits/20220326031647.DD24EC004DD@smtp.kernel.org/
>
> BUG: KCSAN: data-race in do_epoll_ctl / do_epoll_wait
>
> write to 0xffff888103e43058 of 8 bytes by task 1799 on cpu 0:
>  __list_add include/linux/list.h:72 [inline]
>  list_add_tail include/linux/list.h:102 [inline]
>  ep_insert fs/eventpoll.c:1542 [inline]
>  do_epoll_ctl+0x1331/0x1880 fs/eventpoll.c:2141
>  __do_sys_epoll_ctl fs/eventpoll.c:2192 [inline]
>  __se_sys_epoll_ctl fs/eventpoll.c:2183 [inline]
>  __x64_sys_epoll_ctl+0xc2/0xf0 fs/eventpoll.c:2183
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> read to 0xffff888103e43058 of 8 bytes by task 1802 on cpu 1:
>  list_empty_careful include/linux/list.h:329 [inline]
>  ep_events_available fs/eventpoll.c:381 [inline]
>  ep_poll fs/eventpoll.c:1797 [inline]
>  do_epoll_wait+0x279/0xf40 fs/eventpoll.c:2234
>  do_epoll_pwait fs/eventpoll.c:2268 [inline]
>  __do_sys_epoll_pwait fs/eventpoll.c:2281 [inline]
>  __se_sys_epoll_pwait+0x12b/0x240 fs/eventpoll.c:2275
>  __x64_sys_epoll_pwait+0x74/0x80 fs/eventpoll.c:2275
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> value changed: 0xffff888103e43050 -> 0xffff88812d515498
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 1802 Comm: syz-fuzzer Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>
> Fixes: e59d3c64cba6 ("epoll: eliminate unnecessary lock for zero timeout")
> Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in epoll_wait()")
> Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
> Reported-by: syzbot+19480160ef25c9ffa29d@syzkaller.appspotmail.com
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> ---
> CC: Soheil Hassas Yeganeh <soheil@google.com>
> CC: Davidlohr Bueso <dave@stgolabs.net>
> CC: Sridhar Samudrala <sridhar.samudrala@intel.com>
> CC: Alexander Duyck <alexander.h.duyck@intel.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Thank you for the fix!

> ---
>  include/linux/list.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/list.h b/include/linux/list.h
> index dd6c2041d..2eaadc84a 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -69,10 +69,10 @@ static inline void __list_add(struct list_head *new,
>         if (!__list_add_valid(new, prev, next))
>                 return;
>
> -       next->prev = new;
>         new->next = next;
>         new->prev = prev;
>         WRITE_ONCE(prev->next, new);
> +       WRITE_ONCE(next->prev, new);
>  }
>
>  /**
> --
> 2.30.2
>
