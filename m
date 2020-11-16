Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900A42B51A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 20:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgKPTy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 14:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKPTy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:54:56 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB227C0613CF;
        Mon, 16 Nov 2020 11:54:55 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so19981954edt.9;
        Mon, 16 Nov 2020 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofMmIaobK6V2Goc9VEebfBxUUPRgl2PUEKptBDb4xfk=;
        b=LEVHGihk+jRuI5qEahH5/m+QMuwwR2bH0py0AcxUAKuyRgsYEo+QspoWsR1vGXmE+2
         vlEQ+WeukXDtVecituDoCgCkbrZUWTnnB8RqVjeiHMKzMTVqT8eGTbBSUykZtad/HF9L
         vvQctjGVs7H3/2dUIGaT8G1ZfqoKOabKD8N5J1Y3dyN3ILaR7eS0MsQbIvkkGQfM+xKN
         jh5FxJ3XSi5GbUe2o0mpCFxYXYyXr85VqUwKwl92lNPAkLzMotHmtDXyZBJncEByWtVE
         DrHvksv+gJY1U+ZVLRs4EknWkASW1sKCOdynVEd6nAZadswWWyNzxiZZEO9Q6FRm11hn
         ayqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofMmIaobK6V2Goc9VEebfBxUUPRgl2PUEKptBDb4xfk=;
        b=OlOhfeufHbCJHIwFk2ovBTeKX8IdEVF1HOzX+ZgLxe/yRFJvr6vsH6a3SVxEwlw9mk
         2XZ0xJphfbEOhglHvOhpTyJCbhjrIapSYH8l7QKDXnGEuJPl0L2/Qjz/aqyEar34IUut
         2KUnHmjbvSUKui0hMURgCZHlRLN0dEG0FOCkpLRPn9AJXR0Nj3pCKtN9QqSPqF14Cirm
         9Ke9tezx8o/a1qLVoWKBp9P2QIqwbcpZxNOzhUZLAqwBoKaoWkGFQi9l3NFJ3vrBi6pO
         Q4JO96DqYuD/Crg28CA58yaK0/NdzNQ2tlRL26gAIhNhF02uV1MHXeGrGaW98JMg22zL
         T0tA==
X-Gm-Message-State: AOAM531GTzhcad1/XJo+W9J+AQmC7FyEAOA3UvdG0eKhkcAFKv/TPDoW
        ywDrFnVH/KNigBRcT7+oSwK4Iw0Ao4rA/sobgsw=
X-Google-Smtp-Source: ABdhPJy6ivRt5mKCar1fHIdALWr7qUMThUbJnMAaXPrnwNVBITWvF60LXDh+SWayt2e0hbSWn6IGLTenulfMXmsrKAE=
X-Received: by 2002:a50:cd0a:: with SMTP id z10mr16938749edi.223.1605556494664;
 Mon, 16 Nov 2020 11:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
 <20201116161930.GF29991@casper.infradead.org> <CA+FuTSdifgNAYe4DAfpRJxCO08y-sOi=XhOeMhd9mKbA3aPOug@mail.gmail.com>
 <eead2765ea5e417abe616950b4e5d02f@AcuMS.aculab.com>
In-Reply-To: <eead2765ea5e417abe616950b4e5d02f@AcuMS.aculab.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Nov 2020 14:54:17 -0500
Message-ID: <CAF=yD-LGtfPGuqM8WP5Wz7d9_u6x-HdeBitKg81zdA8E6tMQwQ@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
To:     David Laight <David.Laight@aculab.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:11 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Willem de Bruijn
> > Sent: 16 November 2020 17:01
> >
> > On Mon, Nov 16, 2020 at 11:19 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Nov 16, 2020 at 11:10:01AM -0500, Willem de Bruijn wrote:
> > > > diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> > > > index 8a3432d0f0dc..f6ef9c9f8ac2 100644
> > > > --- a/include/uapi/linux/eventpoll.h
> > > > +++ b/include/uapi/linux/eventpoll.h
> > > > @@ -21,6 +21,7 @@
> > > >
> > > >  /* Flags for epoll_create1.  */
> > > >  #define EPOLL_CLOEXEC O_CLOEXEC
> > > > +#define EPOLL_NSTIMEO 0x1
> > > >
> > > >  /* Valid opcodes to issue to sys_epoll_ctl() */
> > > >  #define EPOLL_CTL_ADD 1
> > >
> > > Not a problem with your patch, but this concerns me.  O_CLOEXEC is
> > > defined differently for each architecture, so we need to stay out of
> > > several different bits when we define new flags for EPOLL_*.  Maybe
> > > this:
> > >
> > > /*
> > >  * Flags for epoll_create1.  O_CLOEXEC may be different bits, depending
> > >  * on the CPU architecture.  Reserve the known ones.
> > >  */
> > > #define EPOLL_CLOEXEC           O_CLOEXEC
> > > #define EPOLL_RESERVED_FLAGS    0x00680000
> > > #define EPOLL_NSTIMEO           0x00000001
> >
> > Thanks. Good point, I'll add that in v3.
>
> You could also add a compile assert to check that the flag is reserved.

Like this?

        /* Check the EPOLL_* constant for consistency.  */
        BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
+        BUILD_BUG_ON(EPOLL_NSTIMEO & EPOLL_RESERVED_FLAGS);
