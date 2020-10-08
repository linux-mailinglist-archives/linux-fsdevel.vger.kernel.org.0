Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A0287C40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgJHTPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbgJHTPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:15:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC0AC061755
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 12:15:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g4so7000232edk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfZfZnaERkqPGB2gGvHnDF9tWhylzGCwvN0kr160d3o=;
        b=EU3IvPZT1qrarikUHrvLKAxBGi3bVKJs0zCSZlivvI6umTuzeH4Wvdmad20HGIqsjp
         gzhFpLD9thpIBdRIhY+D4YGrpLSSySZkS2KDuuvmpT0YaFHE259gf8BLBo3oTIiY2Yv/
         ye/GJnVVhgy5RozPa4nO0EA/PpFrkyapQ8wFgmT8Ggh0g9z8/uX98SnXSPZRL7Gw/7II
         Fb+sekakOy/Bd5nkEluPT0I2WBptg8Cqzq+3vRMOHKcMI04zj/J5aKTaOiyTTFhFu5Bg
         KnrklRQL9VteQbPeTa35T7QEYo30iWp53uP8Z3oVLd/RHZJ49N5CaKz5tyEsqHHzJD5g
         VOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfZfZnaERkqPGB2gGvHnDF9tWhylzGCwvN0kr160d3o=;
        b=NfeI/e9Z6mcaFyspWuMr5KakTLuCev88m2eTV9KXtHWShPbdhoXzjXr7qLDN5eVV49
         GxOUxUhQepCGbH+0lS3K2uSNMZJT6QdTlYfdgLYsU9yX4vH7cmRn7H3OvB2kJyv5uEXa
         d8P7hXxpPaZ6bH9C2aIERWm3nWnZYQ9URLNTLXW83uEVJBrftiiVraS0SZOAA+6Ku+3l
         WyG3X/4XfNc+huv3SSaLMEpO3WjywEVAgvYtXIopikrrfG9ax7cpsP4pEodmv7CP/eMG
         xH0YPVe37l8mh4wZbTI2FMTmcsmUURSI/n6T+KHBvmooksFFmnzY8uF6v1UfTzG5Ntzs
         rvlA==
X-Gm-Message-State: AOAM530Sbh7LyZvTlPTwEnhMAPutDmo4h72RSkhKIN34rYfXW2meS4ip
        UftpU8cP91zXx2AwAUhLT+HxN416h3YMTHKodJpSTw==
X-Google-Smtp-Source: ABdhPJyFBlN7boUQCesb35wLUZR3ZBS6yJ+NQq18F8P2ms8O/FcyKZgkHVXpn/LRi65HGJKo/6aCP+dzJHDcLp6c2D0=
X-Received: by 2002:aa7:dd01:: with SMTP id i1mr10907549edv.84.1602184508070;
 Thu, 08 Oct 2020 12:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <f7ac4874-9c6c-4f41-653b-b5a664bfc843@canonical.com> <CAG48ez1i9pTYihJAd8sXC5BdP+5fLO-mcqDU1TdA2C3bKTXYCw@mail.gmail.com>
In-Reply-To: <CAG48ez1i9pTYihJAd8sXC5BdP+5fLO-mcqDU1TdA2C3bKTXYCw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Oct 2020 21:14:42 +0200
Message-ID: <CAG48ez0pLGtc6_NPcYa0nVPexrSOJvfKgArgY6OT4AXS5tOF4A@mail.gmail.com>
Subject: Re: io_uring: process task work in io_uring_register()
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 8, 2020 at 9:13 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Oct 8, 2020 at 8:24 PM Colin Ian King <colin.king@canonical.com> wrote:
> > Static analysis with Coverity has detected a "dead-code" issue with the
> > following commit:
> >
> > commit af9c1a44f8dee7a958e07977f24ba40e3c770987
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Thu Sep 24 13:32:18 2020 -0600
> >
> >     io_uring: process task work in io_uring_register()
> >
> > The analysis is as follows:
> >
> > 9513                do {
> > 9514                        ret =
> > wait_for_completion_interruptible(&ctx->ref_comp);
> >
> > cond_const: Condition ret, taking false branch. Now the value of ret is
> > equal to 0.
>
> Does this mean Coverity is claiming that
> wait_for_completion_interruptible() can't return non-zero values? If
> so, can you figure out why Coverity thinks that? If that was true,
> it'd sound like a core kernel bug, rather than a uring issue...

Ah, nevermind, I missed the part where we only break out of the loop
if ret==0... sorry for the noise, ignore me.
