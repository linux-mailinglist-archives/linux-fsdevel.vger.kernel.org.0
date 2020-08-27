Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D929254C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 20:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgH0SGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH0SGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:06:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE11C06121B
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 11:06:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so7452604ljj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7U2YQUo5PvChApZK/cKK/V+bD5P2TFvYUwUUfL3IKr8=;
        b=V+YFpBqcArUu/7w7NBd4zYiujYYZd0XbXg3pMzUSnwQHkdzIY7nP3mP+VimDcTthyi
         LlD3xPgdurxv9ctSZwPOT/zU/BV4vftgYTphIZCwjwJtNjyaIwWnhXCoLDg9QLVljgtJ
         MDCUHybVVKKZURhQ+X8r3p5PJ1lUGBFZYBCuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U2YQUo5PvChApZK/cKK/V+bD5P2TFvYUwUUfL3IKr8=;
        b=gynqLnGVYAfUIE1DdmvHwVt5bxLLaNkCP5Wkh8vgFHNWG47jiTlF0NUeRBPUSwrErX
         L1ZxQgMypbQeAyDDCjh0FbV7nvwvk94hss7kAU1aNFZ1YKjrr83oHC0vDBlKWHj3DU8T
         kOCkHKMwjQ3jQ8eZDoEbRSAnhRFI3mdEIZPTxFjEAxSoEbIjSof2FSm8j+9CFq9fvLnM
         MpHiEM1hbvBw3ThAoD5taSxBIAD4Pkj3k8D7bPizVyYB+MvMLxL/481i1eCOrHsL2lBt
         sxoniTft1Z3DB1VRHDFJwuQpVloz6xn15YXtQlebb/nQlTUHpjbfbzm5smq7QlnM7ig8
         bpHg==
X-Gm-Message-State: AOAM533YMBKE7GiqxNUOaI/LVXVCKKoIRIQ7rCjBZKvmqUui3LdMVWMt
        aiYcUDZb5K2vcd1m71xJ5v++hfwTyu+ppw==
X-Google-Smtp-Source: ABdhPJwlThKUpraqGC0pzA5Yr0UuGAnYCOWMQfG1niX4AFIOuxQksEpOmJoArQF0LHUAGSqHSwr5iA==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr11121593ljg.406.1598551606345;
        Thu, 27 Aug 2020 11:06:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id r18sm622683ljm.34.2020.08.27.11.06.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:06:45 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y26so3424360lfe.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 11:06:45 -0700 (PDT)
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr3180051lfb.192.1598551604725;
 Thu, 27 Aug 2020 11:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-6-hch@lst.de>
In-Reply-To: <20200827150030.282762-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:06:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
Message-ID: <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for !CONFIG_SET_FS
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Once we can't manipulate the address limit, we also can't test what
> happens when the manipulation is abused.

Just remove these tests entirely.

Once set_fs() doesn't exist on x86, the tests no longer make any sense
what-so-ever, because test coverage will be basically zero.

So don't make the code uglier just to maintain a fiction that
something is tested when it isn't really.

                 Linus
