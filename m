Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD211B9F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfLKRUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 12:20:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37129 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfLKRUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:20:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so17310776lfc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLrgzTUFBpKEKDqVCWUZZ1/wbtzXH039tj4vagWGMGg=;
        b=Nc8xSo/JfaYDi4Oz/DWIpDtDq6loKj0f0sSoSmwqGnkRytexbEyNqycOYwbfzKVi0J
         cSGVsT5W9MpTwY+UdZRBw3LsrkeoYgYwl0ZhxQ2o4YErz3CWWBXmZqc7NNPMVhSI8nRf
         vh7vqyXDlMy5+GQPAGclDZumV++kQ990r6WdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLrgzTUFBpKEKDqVCWUZZ1/wbtzXH039tj4vagWGMGg=;
        b=jjxEgX4/os76g1c+jTUGtvjd3P/jbh9pHR/FznSDvyFnKbLsR0BiVTOjfit/FkEraW
         6I6+ubbUW3CP6mBXS6ue0mArnnHr9EaV5tqdXprzMEp7AgXTsZocUnUbxskR/S5YtKFT
         69hKbdY02C0kxSdjPECngtCN1972GNge43TToju4zj6/JFLX0OzUYx2wOL4C1Sm0BL3s
         GfRf9HoKwg7csHoTnIXQbWZe46j2HlzY+bvkKIfAcdUhrBrDDP+aanhnsdYxNt1ZOVYj
         UloEMKO6CfZ+WJArOh6WY8vaEZ4n1nfhSI8VJi7e2JrpfW5xG7MIWWxSMndQinO8xr7w
         rkMg==
X-Gm-Message-State: APjAAAVODMs2udumIzV2sT5hrCjdxQcjxjQJfZ1R4P2sySvk306IX+lT
        Z1Qvh4tdkHHve0Krcs2ad+2ZON76eyw=
X-Google-Smtp-Source: APXvYqxyvlk20iBtwPmJftLH0CX7v0a6437+r7GFjkc9h9RJIhOXADAQz9O/PZ7FzYwftqvoaVs+Bg==
X-Received: by 2002:ac2:455c:: with SMTP id j28mr3065472lfm.184.1576084809626;
        Wed, 11 Dec 2019 09:20:09 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r26sm1512022lfm.82.2019.12.11.09.20.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:20:08 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m30so17282860lfp.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 09:20:08 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr2995836lfi.170.1576084808314;
 Wed, 11 Dec 2019 09:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <20191211152943.2933-5-axboe@kernel.dk>
In-Reply-To: <20191211152943.2933-5-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 09:19:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj07S-Ee4z6_L=7B=RvL96zZ6mXOTJqiUdyhji6503_yQ@mail.gmail.com>
Message-ID: <CAHk-=wj07S-Ee4z6_L=7B=RvL96zZ6mXOTJqiUdyhji6503_yQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] iomap: pass in the write_begin/write_end flags to iomap_actor
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 7:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> This is in preparation for passing in a flag to the iomap_actor, which
> currently doesn't support that.

This really looks like we should use a struct for passing the arguments, no?

Now on 64-bit, you the iomap_actor() has seven arguments, which
already means that it's passing some of them on the stack on most
architectures.

On 32-bit, it's even worse, because two of the arguments are "loff_t",
which means that they are 2 words each, so you have 9 words of
arguments. I don't know a single architecture that does register
passing for things like that.

If you were to change the calling convention _first_ to do a "struct
iomap_actor" or whatever, then adding the "flags" field would be a
trivial addition.

               Linus
