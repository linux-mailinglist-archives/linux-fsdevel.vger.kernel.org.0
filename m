Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611792F1F55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 20:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbhAKT33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 14:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390753AbhAKT3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:29:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EBEC06179F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 11:28:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b26so1179481lff.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Tp1CGhJDFL4hgGIL8xslWOihsjK3eOprCj/WLppzps=;
        b=ML0r1fT+wR7NtNVlMdlZHIe4UissEnqDL34cuvHaQ+q+iwfYKsU56CdvfQBzd/0p3f
         MCOhQ9UBhoSfNFNie8airMQbLkuQDkCUkzF81CH/QJ4XpMormgfvf9DcLurK0xxgbmG0
         I/9zNWGUYDW7Z56YICFkYCWMwOC8lIFw23Vbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Tp1CGhJDFL4hgGIL8xslWOihsjK3eOprCj/WLppzps=;
        b=dY5P3SdsssZM4eA0Hg4S+5dTPq1ZTR7pgXhR6J+2i+iPmHNCWe3K212h0yBmfrpYA6
         +BIGxkNYIrTYt4mRrqA7Mm4Qzt8yd98UtCT/cGGtXxzqyer6BZu83hgbJxvE+MT0ZRBz
         ieG36ouUYSQUPyNqN0aDzVDLJD5Im4bBJMtGpmM62vJDLwSVWpZHQ8Y+kyIQm+h7bn15
         H4pCPVourIArpuMcOd6Xha7OlrycS7tlR6sX/IY1ohkwuu7IhLv0yHWzKnIvZus3JH88
         c3HDtit9y6iomMXyI30THBLH6q3F5YbeoslJJLpv6LlXw9FvNxo7njBQPMhBmDSZKxxi
         N94Q==
X-Gm-Message-State: AOAM530rVWznUYjWJGLlxR24/gh3hLPa0g98v6zI4EgXnyoHROattCXW
        h3ERDbdK6669JkZ09QB/+cgrkGP1IK30Qw==
X-Google-Smtp-Source: ABdhPJxalCozsAUPUJh1Za4cgOh8EVMW7ITCRZAwVkp+V0Ny2sgNFadAKkhLPGb9DcUi4/9Lnwx+lQ==
X-Received: by 2002:ac2:4a9a:: with SMTP id l26mr448415lfp.90.1610393323000;
        Mon, 11 Jan 2021 11:28:43 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w20sm87366lfk.67.2021.01.11.11.28.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:28:42 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id u11so106270ljo.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 11:28:41 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr464710ljj.220.1610393321545;
 Mon, 11 Jan 2021 11:28:41 -0800 (PST)
MIME-Version: 1.0
References: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
In-Reply-To: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jan 2021 11:28:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6ri9S7Nj1VZuA_pKOV3mEfH=-magLf_J_F=qhiFcKdw@mail.gmail.com>
Message-ID: <CAHk-=wi6ri9S7Nj1VZuA_pKOV3mEfH=-magLf_J_F=qhiFcKdw@mail.gmail.com>
Subject: Re: [PATCH V1 resend] dcookies: Make dcookies depend on CONFIG_OPROFILE
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The dcookies stuff is used only with OPROFILE and there is no need to
> build it if CONFIG_OPROFILE isn't enabled. Build it depending on
> CONFIG_OPROFILE instead of CONFIG_PROFILING.

Umm. I think we should remove CONFIG_OPROFILE entirely, and then
dcookies as part of it.

We discussed removing CONFIG_OPROFILE for 5.9 (I htink) already - the
oprofile user land tools don't use the kernel OPROFILE support any
more, and haven't in a long time. User land has been converted to the
perf interfaces.

             Linus
