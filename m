Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F6CED6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 22:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfJGU3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 16:29:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42632 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGU3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:29:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so7400790pls.9;
        Mon, 07 Oct 2019 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZFOuCP3sXp2fsVblkrQwOzoxyHvp4R+XuB9fZ/Vu8ZU=;
        b=VGdsksVW71vX+BKGmieMYsDbkj+u4cErcNDxcLs/bf+5iEU9IgY0PBFsgW//Tf8icY
         2yOZFk2xNEqog8+dzpp1YNhc62r5kvFydUJNKVxRljxr51BNtmwP3ins+jSyc7WPcoRy
         /bsv6q2rVaUn8Sra88nEx+TWNY/6Cxqo8+w3tTys/Da6PS3vCSmPjKVNaen+FbcYEEuf
         uFU+G/ZCW75DVFQbzkJlCkjpWz7W/AQg2S0yPiUkmskSlwsEbqLexHs+HhnNOZnmKocH
         8+n6LbgvLBmf4YcL6pB3LNng4KO/sO0N060xnXOHfSOFgewF8FQqWBy1a4uL3q/rkubm
         rewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFOuCP3sXp2fsVblkrQwOzoxyHvp4R+XuB9fZ/Vu8ZU=;
        b=kZ0aIfWJ7GuPk1BAWeORWk4LnY28ZdJetDUorC7evLABkJhcLeEFIonvUG5ynpBvPj
         DWJKRGUK/SLMo7MCHzqcbj62btrCZ/RadWAuDdG4NoBsqppCYtbo90SjnZEJZn8IRj9x
         vb5/skiWG5ZtTG0i79BhZbQ+XzKEZ8FfwtNzyV8Er4cLgyJKUimbSnOo+EMuMbOR26tI
         lA8bm0BxVFg0FROS+10Ua36d34E57IeNXnuvoK8NeBAaA0ikLxTpuh8ETF2YOxVNdO4q
         UaEfv9HMFNXXK2L+q5vvV/OinAF1T0cBrEqH8k3GF2Wo9pEL4lJmo/XMYGR/+fY9ahrj
         lrpA==
X-Gm-Message-State: APjAAAVSODJJt5MJhVJVV8mIfnsUtBDRAttAS+pBzmEjeFO68geIxK8x
        98QOTjmMHYuz5sf9OurCkjTikgq2
X-Google-Smtp-Source: APXvYqwDWUZfyQRMAyTAupcgfticr2Sdb3AIDgS7NpQGWVW7eojrRg8fSpIArfAhhv1BnkYMkano1A==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr31425916plo.248.1570480147298;
        Mon, 07 Oct 2019 13:29:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm15578806pfe.1.2019.10.07.13.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 13:29:05 -0700 (PDT)
Date:   Mon, 7 Oct 2019 13:29:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Cree <mcree@orcon.net.nz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191007202904.GA6883@roeck-us.net>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:21:25PM -0700, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > this patch causes all my sparc64 emulations to stall during boot. It causes
> > all alpha emulations to crash with [1a] and [1b] when booting from a virtual
> > disk, and one of the xtensa emulations to crash with [2].
> 
> So I think your alpha emulation environment may be broken, because
> Michael Cree reports that it works for him on real hardware, but he
> does see the kernel unaligned count being high.
> 
Yes, that possibility always exists, unfortunately.

> But regardless, this is my current fairly minimal patch that I think
> should fix the unaligned issue, while still giving the behavior we
> want on x86. I hope Al can do something nicer, but I think this is
> "acceptable".
> 
> I'm running this now on x86, and I verified that x86-32 code
> generation looks sane too, but it woudl be good to verify that this
> makes the alignment issue go away on other architectures.
> 
>                 Linus

I started a complete test run with the patch applied. I'll let you know
how it went after it is complete - it should be done in a couple of hours.

Guenter
