Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC02140CC99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhIOSdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIOSdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:33:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E69C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 11:32:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i25so8074529lfg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWp4thBEdYZ99D5nCeA+V8YsS07M5e6rGbv4Aq7Iet8=;
        b=HalyG+FVMw3visRGX1bmrefSnjLCZhBbehZI0kg00cDKwjuz2c8l1jrB3yTLdN6HzM
         wLSwqjmTaCJhS/qifbhRMBvYnBUxJmE+i4EbFCIwNnSDDScCJNo2zGH4PpYHO+5VlCM7
         FEkGaA3KDrddjkhQfGEfbtXf0UlRkAKctoNLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWp4thBEdYZ99D5nCeA+V8YsS07M5e6rGbv4Aq7Iet8=;
        b=1IkGtoeonG43AZW41Hs7IGHaMQQWhBnYXJwX4Vfam8B6UdPzjSmwH6jshBeyEQulJU
         EHvXmwXu0cXiWF4FvNCntWCxKg1cdxhF37TqZ7vx2rCzEwjhcudW3XKydu6YdSxuFpOO
         ZNEXj+ds0SmQ8qy8XN+zVrkeKCKRhaabX8UU4UqbMpA13oOgmta1Vv4xJOU480dn5e+S
         /Js27E3UyxTg7Oo4WcDY5b9fr8rlR12fFgiu6LlxcNSuN02rT0X62exVXpSKNC4DPpYx
         pc7bjW1WjVAaHM0x8nKWZnBZ7W627Bu66aElksH0pYhv78ITyHWgz19IEIdp/vqnR06D
         dTFw==
X-Gm-Message-State: AOAM531wXSWDaLfZjUSPuXsSHjbEir5EFPyrK+DFsLxzHQkgUGxR4jfw
        B7APfxNZlI5DBKncRBNCaoIqLIiYvue6Uh/XJb4=
X-Google-Smtp-Source: ABdhPJwD+ArUuPhzMgZLMcrK2TFzwiQdV1GxZKdIIXjnmtR00fxHi6MrO1ELUTUWrUMn60+PqjQlUQ==
X-Received: by 2002:ac2:5fc8:: with SMTP id q8mr997629lfg.612.1631730748045;
        Wed, 15 Sep 2021 11:32:28 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k38sm48338lfv.128.2021.09.15.11.32.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 11:32:27 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b18so6847868lfb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 11:32:27 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr981143lft.173.1631730746978;
 Wed, 15 Sep 2021 11:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162937.777002-1-axboe@kernel.dk>
In-Reply-To: <20210915162937.777002-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 11:32:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtROzcks4cozeEYG33UU1Q3T4RM-k3kv-GqrdLKFMoLw@mail.gmail.com>
Message-ID: <CAHk-=wgtROzcks4cozeEYG33UU1Q3T4RM-k3kv-GqrdLKFMoLw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/3] Add ability to save/restore iov_iter state
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 9:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I've run this through vectored read/write with io_uring on the commonly
> problematic cases (dm and low depth SCSI device) which trigger these
> conditions often, and it seems to pass muster. I've also hacked in
> faked randomly short reads and that helped find on issue with double
> accounting. But it did validate the state handling otherwise.

Ok, so I can't see anything obviously wrong with this, or anything I
can object to. It's still fairly complicated, and I don't love how
hard it is to follow some of it, but I do believe it's better.

IOW, I don't have any objections. Al was saying he was looking at the
io_uring code, so maybe he'll find something.

Do you have these test-cases as some kind of test-suite so that this
all stays correct?

            Linus
