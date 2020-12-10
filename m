Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1544A2D6931
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 21:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404587AbgLJUyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 15:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390467AbgLJUyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:54:19 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D199C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:53:39 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id q1so6667700ilt.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AV69bGfhUdEycodDDhyR1U9yTN3e9xSNDJOQA71JSdA=;
        b=b9K8oRpbje3k072ZzmyuLz7tYSYyWPotEbQ2IyK3M97pRFvjPTbMDZm5lMkfrrM3ka
         uAsJjnQOYShGXJl+CRl5TqBDIAmwOv8OG48ZSN1jBmDvFzoyh64d71ZLkbI2/vM3X3lo
         vwd/RicBp5bb8YK6cqRHOndh5q5ezMRoVwc1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AV69bGfhUdEycodDDhyR1U9yTN3e9xSNDJOQA71JSdA=;
        b=mNHXyL+Mijz9V2UkN1f36WcvlrOOHBa8mURJtR/dVZOZNDgTaA2KjO3edbUIpergoc
         UODvOTZNT+5yGUzONr8NvFVleg/F+8AgsdcG4MGCZQzE+MmCqMZRqLRUm8EpcjIlqLvk
         8+Drt9/OoiPK8FpiO7ICCFxywe2pm1AL0A09edkZBAWcCwOT4vtwwsc3uhD4scSzoQ82
         lWdToaZuJtkMCPvjhClsa0u6abSwcrhU9dUOI4jiOih43i4nu7a8D6OAplR0bC8PzVDW
         QJJVqJRcJ6o9QBsAahIKKKdpDbUIBA2Yb7NTpEcqJEYRa1JwrQXBDHghO3lVSglK3m78
         6AYA==
X-Gm-Message-State: AOAM533Fkj+VPl01zbRzFfR+sRJFCvWJUZbFOivTdY9jzttgy2SZLYRc
        TZfC4xFFQkn3swxCpiCBOx1KB2te4dwfRg==
X-Google-Smtp-Source: ABdhPJz9WQyTwetyjiJ/muZCksFZXsp8e//cF63yOnsgNGAt/dNX7gueMjxXCSzQwikNvJSVZqcbCA==
X-Received: by 2002:a92:40c6:: with SMTP id d67mr11082279ill.236.1607633618042;
        Thu, 10 Dec 2020 12:53:38 -0800 (PST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id z10sm3252414ioi.47.2020.12.10.12.53.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:53:36 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id q137so7058044iod.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:53:36 -0800 (PST)
X-Received: by 2002:a02:a98c:: with SMTP id q12mr11118517jam.140.1607633615921;
 Thu, 10 Dec 2020 12:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20201210200114.525026-1-axboe@kernel.dk> <20201210200114.525026-2-axboe@kernel.dk>
In-Reply-To: <20201210200114.525026-2-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Dec 2020 12:53:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
Message-ID: <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> io_uring always punts opens to async context, since there's no control
> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
> just doing the fast RCU based lookups, which we know will not block. If
> we can do a cached path resolution of the filename, then we don't have
> to always punt lookups for a worker.

Ok, this looks much better to me just from the name change.

Half of the patch is admittedly just to make sure it now returns the
right error from unlazy_walk (rather than knowing it's always
-ECHILD), and that could be its own thing, but I'm not sure it's even
worth splitting up. The only reason to do it would be to perhaps make
it really clear which part is the actual change, and which is just
that error handling cleanup.

So it looks fine to me, but I will leave this all to Al.

           Linus
