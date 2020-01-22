Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25A114598C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAVQNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 11:13:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45279 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVQNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:13:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so7414661ljc.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxCSo2JcEGlTJhdmVOOHLpuyjFAWieC3FhzbX6ms3Bk=;
        b=WVzg/4mZaQ3ubctvikpmoB2+8YZnmRK2+VSYiWGQ33nJZL1OeIGMyFE3sBcuqoQVbi
         rwpNneTfpLB3RAwTWttAZsxz4mdwPNf2Y8+kgY4tYIeLbjPU7jrBtLrLWh4mnN0ddI2k
         Y06yr95wD8GFqmmXgcgeinrku41v7nODIWRxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxCSo2JcEGlTJhdmVOOHLpuyjFAWieC3FhzbX6ms3Bk=;
        b=CeMwYHb5NgkTFM9N22rlzrrr7PmcEL1cOPJ9aze0lPwwmIbohrxVmJ7GnOOZI+rbk8
         3Iej8C79EK+X9sbKub55/wbsGSvtlOJ/9d6esn7Jk/S77UJOts5H0bN8GipZJu3VCWLS
         4RtI8X1Bbpp2Jj+wDDZ17lcyHfHnD5vl+eNEwTjysvTeShcSXyUlZd/WrBotC+rLFe4c
         lZ57umtLV9mHv8+vjRcVQuKxTrsdYfY9Zo+Z8v/MFYniTgNdJvvhk+ukFnIplz04qfrp
         RXLelgOqa1rue9xoj8Pb+VrylbUsL1H5hE4kb2fxD32+42UIEIuZWLtJ34qfXaHJCzmH
         TgiQ==
X-Gm-Message-State: APjAAAXVa+I1XFnSded44XN2ve0BiyNzhceZe4IM0s5UZnTDCwo8i7gc
        /NfcUFYFsJGoO0dliii/AbkXxYEmQpk=
X-Google-Smtp-Source: APXvYqxZVrrouGpqlq/+aSQla2RuISGl8xNJzb6BZ76V4QLgLJP9CuE5VM9EraHrq2dDEZeD1wy6lQ==
X-Received: by 2002:a2e:3504:: with SMTP id z4mr20332186ljz.273.1579709609937;
        Wed, 22 Jan 2020 08:13:29 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r12sm20388863ljh.105.2020.01.22.08.13.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:13:29 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id y6so7486052lji.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 08:13:28 -0800 (PST)
X-Received: by 2002:a2e:9510:: with SMTP id f16mr19943444ljh.249.1579709608444;
 Wed, 22 Jan 2020 08:13:28 -0800 (PST)
MIME-Version: 1.0
References: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
In-Reply-To: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jan 2020 08:13:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTzEu5=sMEVLzuf7uOnoCyUs8wbfw87njes9FyE=mj1w@mail.gmail.com>
Message-ID: <CAHk-=whTzEu5=sMEVLzuf7uOnoCyUs8wbfw87njes9FyE=mj1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 5:00 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Modify filldir() and filldir64() to request the real area they need
> to get access to.

Not like this.

This makes the situation for architectures like x86 much worse, since
you now use "put_user()" for the previous dirent filling. Which does
that expensive user access setup/teardown twice again.

So either you need to cover both the dirent's with one call, or you
just need to cover the whole (original) user buffer passed in. But not
this unholy mixing of both unsafe_put_user() and regular put_user().

              Linus
