Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA074169310
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 03:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBWCPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 21:15:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42792 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgBWCPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:15:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so6203320ljl.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usCPDZzqoEQffaBHKz63gbophNqdIvzMOB5/yaDj3Ek=;
        b=Ft335B/q4kOGEdbWJ0HffT8n8Ks0hvRKKjTvQ3F6wbdJ99TgY+eIt6+6Fy0GK774yr
         tYPrBAkT6L2g0sIK/wKLCIs8tAZgXl0SjKxSY3CbR9SbAlgPerdD0j+hCaheptaAknOt
         +y1EqTRtlN7zsr7V1qD6Wtb4ddO2Rwm46DDMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usCPDZzqoEQffaBHKz63gbophNqdIvzMOB5/yaDj3Ek=;
        b=eF5nOLZ5GUtj83hQz6NAuVMILLdz0XLY6y7hc7qaaDgfS/1cOM2SxvC/wwbDILoeYX
         Yh1dnvmxF218Y5hLQo1uPQdvTL0QcoC6ajAf/vdV0zjG3MpQguT6a0RbBx7mno5xvbEy
         YacpAIYeyJe3xT6x3msjOmsnD4Za/TnUwUCj12qjUdaIK9cmASbUViIh9RFDd73s5qdi
         n4H1X4GubFtvOAMa6VCJU/0ihf4PhzdTJ4rK7RwKwvUU2onIQy2zTpmXJ7wAafMk9wkF
         nTHuPgime7niguCBf3ncH3ClTfO1x9b+HGdBCpZ6wRzlbDSNAFWJUUbuynhpulJPzXae
         IH1g==
X-Gm-Message-State: APjAAAWF/dHDDgeUgE38F4UJtJOkEuPRAafQLa4iSYUTXn9oBkxzDKFU
        EGkpW2WaaYSITsTN50DrFJOeexdmoF4=
X-Google-Smtp-Source: APXvYqxIFJiLI/X+c0JFR8IWkPdbxf8jhbn7jA2LlYvAwnKblat556ssh3WiMOJRJhRvQ9Kjk5lBBA==
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr27333401ljc.158.1582424102136;
        Sat, 22 Feb 2020 18:15:02 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i1sm3937201lji.71.2020.02.22.18.15.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:15:01 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id a13so6196961ljm.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:15:01 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr26872226ljk.201.1582424100766;
 Sat, 22 Feb 2020 18:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-14-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-14-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:14:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzmY4RdkqtitWVB=OJvHG-8_VLZrU1oXBX8b+5qJKBag@mail.gmail.com>
Message-ID: <CAHk-=whzmY4RdkqtitWVB=OJvHG-8_VLZrU1oXBX8b+5qJKBag@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 14/34] new step_into() flag: WALK_NOFOLLOW
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         if (likely(!d_is_symlink(path->dentry)) ||
> -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
> +          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> +          flags & WALK_NOFOLLOW) {

Humor me, and don't mix bitwise ops with logical boolean ops without
parentheses, ok?

And yes, the old code did it too, so it's not a new thing.

But as it gets even more complex, let's just generally strive for doing

   (a & b) || (c & d)

instead of

   a & b || c & d

to make it easier to mentally see the grouping.

               Linus
