Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B506263888
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 23:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIIVd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 17:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgIIVd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:33:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F163C061756
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 14:33:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n25so5481542ljj.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0+jz5nEBaWAhh7n7Hp1qz3wUrloORRxGTRRlKkQIgM=;
        b=ZC+O3RgWhIgNKsFzAoxkbel7tu0gOmF8ciyCULsTleltXACSMEUPzu0YhQCYyxG+n0
         fRQ2KEHRUpo3+MHY+wuhqjq5jU82lgflP0z62nRjLA58w/Z1YR52q8f3ta82dR9XKkQK
         4JeSuKlLlKaSmxiZJnS7lLTjpttmYgqxvU9OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0+jz5nEBaWAhh7n7Hp1qz3wUrloORRxGTRRlKkQIgM=;
        b=JD3v+/BDsG7BohMEJgrvnxHSa2l9Mez8gkxDCbmhGqY/6TFhDvllr+U676u5oqoOfI
         DJwsa+1EJg6IelfiQ7TVALOm7nETWYZrKAejZSlR2pZ7dP7MumTPdQPYq/E31L+13WER
         vUnI46mH06mfZLpn88SYSa0P8kmmGZUATMCehvgDp2sV9/zUa0tzE9QoBC/188aCGkr3
         mb9mBGyqFu1RbPzHVrd9dTTgAZmqXS9siXvYOKsrCkNmMLGPHhOIu1oTuOOD+mt41IW1
         EQ1IDrnUxYB6yGtyG9m0psmmp82lWq1PPznQ57L8EIDcE1Zto6KO1htShSwEJFFve7Ls
         DF1Q==
X-Gm-Message-State: AOAM5318DmcW/P5gYt0n4/DJwIjDgL7I/H1mNI8wQeynRepY0bj6KAb4
        RUmqJUoL4u3+Kb6GYxtjSBNSQA+OnNUb6A==
X-Google-Smtp-Source: ABdhPJwfZF/HEC7G7efT3JGJeFj2Lo157se3lPljuqmYRPwp+1NNV7Ozh2KohA11Euwg/g7a2RwGnQ==
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr2915563lji.378.1599687234312;
        Wed, 09 Sep 2020 14:33:54 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t19sm1021808ljj.100.2020.09.09.14.33.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y4so5449561ljk.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr2679648ljh.70.1599687232145;
 Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com> <20200909184001.GB28786@gate.crashing.org>
In-Reply-To: <20200909184001.GB28786@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Sep 2020 14:33:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Message-ID: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 9, 2020 at 11:42 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> It will not work like this in GCC, no.  The LLVM people know about that.
> I do not know why they insist on pushing this, being incompatible and
> everything.

Umm. Since they'd be the ones supporting this, *gcc* would be the
incompatible one, not clang.

Like it or not, clang is becoming a major kernel compiler. It's
already basically used for all android uses afaik.

So I'd phrase it differently. If gcc is planning on doing some
different model for asm goto with outputs, that would be the
incompatible case.

I'm not sure how gcc could do it differently. The only possible
difference I see is

 (a) not doing it at all

 (b) doing the "all goto targets have the outputs" case

and honestly, (b) is actually inferior for the error cases, even if to
a compiler person it might feel like the "RightThing(tm)" to do.
Because when an exception happens, the outputs simply won't be
initialized.

Anyway, for either of those cases, the kernel won't care either way.
We'll have to support the non-goto case for many years even if
everybody were to magically implement it today, so it's not like this
is a "you have to do it" thing.

           Linus
