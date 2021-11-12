Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2644EE8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhKLV3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 16:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhKLV3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:29:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFBC061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 13:26:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c8so42540191ede.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 13:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntZGBdiceWxX5bWKAyYQPAfUlf1Jy17/iBsUfaHjtvE=;
        b=WnpzkwgfwXofLeiX77Oe8YFgQJUod+ED3X+7zGSdhuhBdJ1F2P+TdKgmMLEdVL1SvZ
         /GS6JghHYzPxFbK4+NWebHaGgWNfR8ePRUJ+vL2ZwudXOMenfcKfNrB9ar+yxKCNchIc
         qL8+VW1E3C2BAaWeSIjvcK1Ufg0h/Rn5taTmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntZGBdiceWxX5bWKAyYQPAfUlf1Jy17/iBsUfaHjtvE=;
        b=ZQ3fWZ4ytyTn9cr112M7lshMFUpJsMlHpSxXM2Xi4p+ZwYZDaoyuAGwXBCEKWVpq4e
         vb/I92xDVqzMUMyScpHKBpZVofHnKyFRK0h9MGuf87KLAeVR91h2pMFEBI52ci3Jhf9L
         W472lwMffmg2EXSEt9W9YoqQChwwmbydFhcRCxfprtDtMWTwA9vprVIXixbiVbBqLx6R
         aDy5ihzqsOyE33N4vGVydBdnLhmlfbKiLqbeNhsot12H/GUi0lQRtNB3Z2GpyIfgPA1r
         +r3Lhkal25KZQfv3DA5XpKBUjwDyquCBWzD00VhTJkbzEvvrxoYI0RUpvHJUjpTuoVvq
         YC7w==
X-Gm-Message-State: AOAM533dp3fLFBW3E4L9msLsww5vcBrxvzVzFWihdBig1Vv/cVcsNms1
        JuaMsOU3y/G+rElm+jvjqXY/ST1Jzj+vQqEWAUY=
X-Google-Smtp-Source: ABdhPJyrxcR1SLiUo4UZ7erTEWxlg4g+UPQ7F/dDTlt40QJQxGclfvzofpMXWRwWzpReqoXVmlmXSQ==
X-Received: by 2002:a05:6402:170a:: with SMTP id y10mr5919300edu.324.1636752390859;
        Fri, 12 Nov 2021 13:26:30 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id s4sm3087413ejn.25.2021.11.12.13.26.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 13:26:29 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id c8so42539990ede.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 13:26:29 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr22971280wrj.325.1636752379227;
 Fri, 12 Nov 2021 13:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20211027233215.306111-1-alex.popov@linux.com> <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
In-Reply-To: <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 13:26:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
Message-ID: <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:52 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Hello everyone!
> Friendly ping for your feedback.

I still haven't heard a compelling _reason_ for this all, and why
anybody should ever use this or care?

               Linus
