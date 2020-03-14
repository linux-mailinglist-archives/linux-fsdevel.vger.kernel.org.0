Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECEC18534D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 01:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgCNA2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 20:28:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44505 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgCNA2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:28:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id b186so9223819lfg.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRmNolcxLqc+tNnnflJ/n3joETbYpRnOE13OAQ+0j2c=;
        b=cRJcS5iL6D7pulFWso9kzk1dWyABFXOyNGG88VjNsF84X0gt+v0c11QVPFVDYWRXf8
         CSOkNeWYjeGmaUh0kvfgC6E3MPHJd255SwAfMJz6MgK/ZxktMeYvYYYvDiu8QvNb7sTV
         +GznvZmF4/9MkIGyzdbamSO0U+8fhQMTk7x0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRmNolcxLqc+tNnnflJ/n3joETbYpRnOE13OAQ+0j2c=;
        b=GGj9aiXyimAezzpcYCoWMioz1rkXbGVK3wyacyI25yeBn2WFjelxfaTWzWvfVW5TKM
         b/EXLsQWHBlbm4nVT52dNn7kIaSXlAL9Fm5c7FEqj8cQv66X8HUcYO0qql9jHbuok5x1
         JbeaXwrUQXtZC4A+iZHhpOlVQkhTPhB+3r2pOCjlt6+D/+aioznzE1AMapuvkMBbGmHo
         uoiBSfLvzH0jV+7FcphX8IWmF7bymkTvHTR+Y2+zDQnS1gVcmXNLz/GMrV29Vc1VvNmN
         4w3UwgAEf/QJZvNafIvF6FAvPI6eXHIY8pz1Gx/JEW/v3OEOqzya+AVCePxvJJL31OMw
         Tcug==
X-Gm-Message-State: ANhLgQ0sny+bT8qocjE4NRl3YThsR05Q+lZYC6Wix28iIOPJyKgw188i
        5kq5uR9FZr0Q7iB/V3rErwO+lgRZqvY=
X-Google-Smtp-Source: ADFU+vvpqWRCx8eMLUFLzKNbTHcTqcoUzoEhh49aXi9KD/0WVH9MVsjri8mLXAqJKxkddprN+xhJMw==
X-Received: by 2002:a05:6512:2018:: with SMTP id a24mr5297133lfb.175.1584145709184;
        Fri, 13 Mar 2020 17:28:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id w14sm28054357ljo.80.2020.03.13.17.28.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:28:28 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id r9so3815586lff.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:28:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3044:: with SMTP id b4mr1855996lfb.10.1584145708028;
 Fri, 13 Mar 2020 17:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-12-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-12-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:28:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
Message-ID: <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 12/69] teach handle_mounts() to handle RCU mode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oh, and here you accidentally fix the problem I pointed out about
patch 11, as you move the code:

On Fri, Mar 13, 2020 at 4:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +               if (unlikely(!*inode))
> +                       return -ENOENT;

Correct test added.

> -                       if (unlikely(!inode))
> -                               return -ENOENT;

Incorrect test removed.

And again, maybe I'm misreading the patch. But it does look like it's
wrong in the middle of the series, which would make bisection if
there's some related bug "interesting".

                Linus
