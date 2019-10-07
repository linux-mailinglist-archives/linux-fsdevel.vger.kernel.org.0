Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46A7CEC89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJGTOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 15:14:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35795 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGTOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:14:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so10078859lfl.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXTod068XsJ0/J/Qqj0/97Cyow7ru7du5wJrbrpf8I4=;
        b=VMe+eQLfh8WbO//QhhRZRR3AJUuhQ6YMQsuPufHVw3/oSqP7GkJb1KHifxQO5jSf17
         ZipMojysOuxRhaEDkhQaiJ3YNnCkQPYd57Y4JgtvTOvrZ4br1mebA4NG3Zg2WVG6nmaA
         c1kGI+h8Yt5V6m9E+KQeP/R/IvXp5VKHWEZ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXTod068XsJ0/J/Qqj0/97Cyow7ru7du5wJrbrpf8I4=;
        b=FKJP6kTnP/kRcu4DJsqUQ3B9Kcp5pVnxD/q82rdJMTvCFlFy14lPPkSdSgLNW5ZfOb
         lNHxS637ICq2pOHc0x997IY/qS4QsEqaOuPi0hVc44GPYTdbnls4+uUg94YzP6Pfz0pU
         s6OWwLrHuftsDM41zcE4pMvTHdETQse6r5w1e+LRwp/S6RKDrKfkHwOGJRBAithWbthX
         KuMeoCOc+5E/6RqFVfPwWfB1ShCFtf6KFpAzUtj5yZbXXMyonYteCljkMmyH7GaPGUVp
         p3w2++IaESQAO56pvAUr04YIdLzVY2yxenqNXUUqKGE+e7ojdINi2k9ku0cn6cEmXSdZ
         Hj8A==
X-Gm-Message-State: APjAAAXqLvNWW7zH42jhJSnnYtQ0EF/aU2mU70FSgbGTI1ob5qFQjBZ/
        Oz1qsJfkru+Y4o5oA/mqqV6NIzLgXfk=
X-Google-Smtp-Source: APXvYqxHC2H9GgBysNp/DXhmFmHGZN+PKb5FkGsEKs0xuli7XZDQdGmYDIMqJ7YY1OpsvoDY9Myunw==
X-Received: by 2002:ac2:43b8:: with SMTP id t24mr15988393lfl.24.1570475690708;
        Mon, 07 Oct 2019 12:14:50 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t10sm3334626ljt.68.2019.10.07.12.14.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:14:50 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w6so10078802lfl.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 12:14:49 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr17252511lfk.52.1570475689589;
 Mon, 07 Oct 2019 12:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006b7bfb059452e314@google.com> <20191007190747.GA16653@gmail.com>
In-Reply-To: <20191007190747.GA16653@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 12:14:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com>
Message-ID: <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com>
Subject: Re: WARNING in filldir64
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Seems this indicates a corrupt filesystem rather than a kernel bug, so using
> WARN_ON is not appropriate.  It should either use pr_warn_once(), or be silent.

I was going to silence it for the actual 5.4 release, but I wanted to
see if anybody actually triggers it.

I didn't really _expect_ it to be triggered, to be honest, so it's
interesting that it did. What is syzbot doing?

If this is syzbot doing filesystem image randomization, then it falls
under "ok, expected, ignore it, we'll silence it for 5.4"

But if it's syzbot doing something else, then it would be interesting
to hear what it's up to.

                Linus
