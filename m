Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA646C28C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 19:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhLGSVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 13:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhLGSVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:21:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525AC061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 10:18:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b1so188225lfs.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 10:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WE2EyhdaIKRgniT2lkFi3qndNcuUWHIlT44HhHt4xhI=;
        b=CNOUylDm39x63E41s5OZ8UaB156/vDwnH5BuYVCS8wlXEnQiVie4bOumiPwXCR+JOV
         XXGREV0opDGhSHyCgsI7srvQtyHyH/MwrczP4Bhi6Hm6XvnbnNlFfuze5pZC15/KqjEg
         QJiwXlXdECQ5sYq86gaZjnpO/UzJc/dNbZB2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WE2EyhdaIKRgniT2lkFi3qndNcuUWHIlT44HhHt4xhI=;
        b=QI2kJ4vaEQ7umLGH1Hb6Ffz5wiT9S8QEkIr80AYn6998ea7KjNJWJkvktzvYhkNbHu
         OoIvb2cyj/RveJ99v4ITO51RucYTYMgC8daSsyPxxuJ6jj8j7yERVuKk9AAjpoJ4BoUx
         jO5xI2fCUlrzKlHcB25LMAqKDi+SD9N44nxauhXSx1GjnF/5YEf4sBSdANjYym2qDv6b
         TRXBxaZmVWc8nmNG0C4nLDykPKyazV2zD3NoixNZBHnfD0lk439MMwghKsdfg10q7DYg
         QC6pFt7j7Dx/gA/0fG9NIiDJbQLwyzfUi6Is1rSWp10zWtlYjqAP+4GIF+o+Kksk9Klv
         C19g==
X-Gm-Message-State: AOAM530bcmUH9VPOnwM8kDxz5FTFCTi/sCKoZUSDZg9fh7s89wayHPCY
        wl+xBDcfOiVMIgljkaka+cRzEKKv9bAFXSxv
X-Google-Smtp-Source: ABdhPJy5Pe906Pq0Ys/yF0XDakLBVlPEDIHdFb9iFJEU+YWxusMOOchQ+NxB7hrAS/JzUXkbMiawCQ==
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr11535690lff.607.1638901092805;
        Tue, 07 Dec 2021 10:18:12 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q14sm31300lfo.143.2021.12.07.10.18.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:18:12 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id i63so29035965lji.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 10:18:12 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr54060146wrn.318.1638901081204;
 Tue, 07 Dec 2021 10:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20211207150927.3042197-1-arnd@kernel.org> <20211207150927.3042197-3-arnd@kernel.org>
In-Reply-To: <20211207150927.3042197-3-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 10:17:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
Message-ID: <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
Subject: Re: [RFC 2/3] headers: introduce linux/struct_types.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 7, 2021 at 7:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Working towards a cleaner header structure, start by moving the most
> commonly embedded structures into a single header file that itself
> has only a minimum set of indirect includes. At this moment, this
> include structures for

Ugh. I liked your 1/3 patch, but I absolutely detest this one.

It makes no sense to me, and just makes that header file a completely
random collection of some random structure types.

And I absolutely hate how it splits out the definition of the struct
from basic core infrastructure (initializers etc random inline
functions) for said structures.

So no. NAK on this one. I think it's a disaster.

              Linus
