Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6DE1F7E74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 23:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFLVdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFLVdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:33:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43374C03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 14:33:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so12723266ljn.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pL7avKA2KDNOM9X/kgFl9MqbEPb7aiLKYA3rHavzFAQ=;
        b=DUXfZ05dc4FLn033pP/DvBQEoDqo9l9I/qr+GeWTXdccy9NPuiJFBm8tJ6Ag/uVtPs
         HfhkXSv/7Jz63j3e9CKigwf5GeXP332/vjJYhT7vhVEnuBNN/DA1L+yF7svDbU0axGyW
         OJ7DBcOv91xpWm6tDakYfFrQRMOPXMXKekM4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pL7avKA2KDNOM9X/kgFl9MqbEPb7aiLKYA3rHavzFAQ=;
        b=X65zS1oDJopAMZfLZYJDA791XLe9fdkII3ZdMw14OwXwviKlQ2RI8x08RDX/e1yYQM
         9A1782PRsiYuqLh6/AhVoXulRFkyahgSgs73QLmdo0tH3MRrnmoqTaxV4gEZNumOkk4z
         XeiMHF3k6LhLHVLzJCb3tT5gFP0fU4ounVT6d2vF+twnsB/ywyo4xdd0m5qsiUjy/0s2
         5L0ynCZvY1Hppsbzn5/WINf6bGRnD09znIkGyPKUD3WZCBeGbjpIvZ5OafISvfEVAaf3
         inSKFag9ipx3A/+Fi5xb89NmkVORMXcCeK7Jq6s2Kx5Fe0uc6UQrv75pcv8z/QIBSK0m
         2QVg==
X-Gm-Message-State: AOAM530tNrZQVT5SadbIBKJOhmGNKzk5Mq+rLxbCddu60iNRaBF00FIV
        zVB/zw70cT22ku/pNZJFLex9O7uR4O0=
X-Google-Smtp-Source: ABdhPJzWEbK1cHmiVXTxIaR43osN/aZouGii2U369TEzM8Q/+DZa/e6OuKQkziHtMYiLGcaVBg8aBw==
X-Received: by 2002:a05:651c:1195:: with SMTP id w21mr8460763ljo.464.1591997580235;
        Fri, 12 Jun 2020 14:33:00 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id b26sm2321570lfp.40.2020.06.12.14.32.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 14:32:59 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id n23so12670874ljh.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 14:32:59 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr7467995ljj.102.1591997578744;
 Fri, 12 Jun 2020 14:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 14:32:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
Message-ID: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     Karel Zak <kzak@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Finally getting around to this since my normal pull queue is now empty ]

On Wed, Jun 10, 2020 at 4:13 AM Karel Zak <kzak@redhat.com> wrote:
>
> The notification stuff looks pretty promising, but I do not understand
> why we need to use pipe for this purpose

The original intent was never to use the "pipe()" system call itself,
only use pipes as the actual transport mechanism (because I do not for
a second believe in the crazy "use sockets" model that a lot of other
people seem to blindly believe in).

But using "pipe()" also allows for non-kernel notification queues (ie
where the events come from a user space process). Then you'd not use
O_NOTIFICATION_PIPE, but O_DIRECT (for a packetized pipe).

> Is it because we need to create a new file descriptor from nothing?
> Why O_NOTIFICATION_PIPE is better than introduce a new syscall
> notifyfd()?

We could eventually introduce a new system call.

But I most definitely did *NOT* want to see anything like that for any
first gen stuff.  Especially since it wasn't clear who was going to
use it, and whether early trials would literally be done with that
user-space emulation model of using a perfectly regular pipe (just
with packetization).

I'm not even convinced O_NOTIFICATION_PIPE is necessary, but at worst
it will be a useful marker. I think the only real reason for it was to
avoid any clashes with splice(), which has more complex use of the
pipe buffers.

I'm so far just reading this thread and the arguments for users, and I
haven't yet looked at all the actual details in the pull request - but
last time I had objections to things it wasn't the code, it was the
lack of any use.

             Linus
