Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BBD185346
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 01:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCNA0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 20:26:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39218 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgCNA0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:26:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id f10so12499552ljn.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSh28SDxVzmezso0eCx9OLP79cE1ODkRapdHxbtQ29k=;
        b=BNv0AIG2vvEkCJhWjYAFISduPkxT8Ox6Ts9OSN0YQy6/mTiU5c1VgmXW9TIdC5BBr0
         KYAilKkOKlN+NxaDs6MkVZ5h/TBABtDs3eTS4Nt7RYDT2QWUsCchxU4pciiLd08QlnBa
         KZT/V9/rFMliX2+Xv/SYsgO+HqZN1TDNaV7gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSh28SDxVzmezso0eCx9OLP79cE1ODkRapdHxbtQ29k=;
        b=O4bgh3+MXusSxyF2ZFx4OMw/Rx1V2fZnX096v3BGiMw08d6YXBjiXP48wjqxe1x0of
         4CG0vfHL94+lU+uSMui4NL9MdCrO1lm392tc/9a+5RJObsowGjhLtUDKqzJK2S6HzYhY
         J2DFGfKyjy2x+CpN7cbgnIJDbuKSReO6UUDvf/IbqZun+/ykp6lGv2n+sA+NlICWdaz+
         alcyPGMzz+Skjs1sqLoOO1cLwrcaYghSE67y8mZXCqrYFcg9KNfa4pKTmETM2NTogupq
         2Xovyw1BRyxG7GlK+c48QR9AHl/6W+VOfW3HR3hcMBnhWovz1FjGPxvvwLhU3fHBOsvV
         ivxg==
X-Gm-Message-State: ANhLgQ1zhjDnJ+iOHSBJdenv6je5KIqkXlgAOo46d617YEscqaHAIMXf
        p4va5QouNWCM9ZyZbq2E5BobsaEVokA=
X-Google-Smtp-Source: ADFU+vtXzoajAfKJjAr/0m0xqdhtIJYisWYEsyWKEqRb0zPOTrfu/PDn58j3xty3EEeWWTb1vhHrHA==
X-Received: by 2002:a2e:b4b1:: with SMTP id q17mr8900712ljm.22.1584145563729;
        Fri, 13 Mar 2020 17:26:03 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id p133sm14297456lfa.82.2020.03.13.17.26.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:26:02 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r9so3812962lff.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:26:02 -0700 (PDT)
X-Received: by 2002:ac2:5986:: with SMTP id w6mr9900471lfn.30.1584145562223;
 Fri, 13 Mar 2020 17:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-11-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-11-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:25:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnpnUy7OiiDbE+Bd=x-K6YyRV_1mvsoP-fhTC2=ez=+A@mail.gmail.com>
Message-ID: <CAHk-=wgnpnUy7OiiDbE+Bd=x-K6YyRV_1mvsoP-fhTC2=ez=+A@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 11/69] lookup_fast(): consolidate the RCU success case
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -                       if (unlikely(negative))
> +                       if (unlikely(!inode))
>                                 return -ENOENT;

Isn't that buggy?

Despite the name, 'inode' isn't an inode pointer. It's a pointer to
the return location.

I think the test should be

        if (unlikely(!*inode))
                return -ENOENT;

and I also suspect that the argument name should be fixed (maybe
"inodepp", maybe something better).

Because the "inode" pointer itself always exists. The callers will
have something like

        struct inode *inode;

and then pass in "&inode" to the function.

And it's possible that I'm talking complete garbage.

               Linus
