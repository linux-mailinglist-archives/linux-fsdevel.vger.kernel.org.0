Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B721732A522
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443416AbhCBLri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbhCBH0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:26:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF787C06178B;
        Mon,  1 Mar 2021 23:13:39 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p10so4983015ils.9;
        Mon, 01 Mar 2021 23:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuLAMcz1+lviLyTE92nA9aBXQm55vMuIO4Bg9pZZ2+Q=;
        b=MZW199tfAJwlKH4nXcgOeOo+BuUF+n6iMcMOBfkGAEATvqbRb+FWErsbMvWJuRWSRd
         tMyzgh7iZBwH4u5mEhOg4VsHMAg1pqv5SDNrOF2h0zU2eJuUVo3LB6UMGE9cutemOd0a
         CTrqOsro+Kvi9KkB3t7EUucMqhBw+WuHDFJWsZ8lDSj8i7zgabhV6rvlBKpj+FDgy175
         jwhjOOgMPuvFqogW1X15L9l9lJ3RHJMEadnu5rs3+8/fSYO3SjU5oUzo3oFcHCyOOhI4
         8b8QOiMLll/BgqC0TfndC3ifag9ay3EbnsfAssldxJ5nJA0bhDnXvzEJ8gpX6JLxPhaK
         7PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuLAMcz1+lviLyTE92nA9aBXQm55vMuIO4Bg9pZZ2+Q=;
        b=rcQLe2i61FuK0VBEqn3qW+ZMx4ftoU0lxXJaOpyL0XLA+6V+m4l4y7+bghHO2Y0iZi
         9kxkYqTsGZgGFmC9qk6D9dparG3VduVHdQI24hozU58ekEZphHCFOmGLsG6y79k9/gNd
         Nq4ZfLGBNy/VJ9d8Eov5oKBnWyFrQcN4+nDx8vJDa+DFLUcdwWUUV2Cf5aElevB0sO/N
         o9eKcLVfO+yFu6tVaQb0WJsp/h2LMR0nJ69F3vbKITfctTIsgwOQ7IvmuKvRklqsxgcp
         mlCM4wFlJNoqEZ6v7nBjYEGhCk54gUFjihDfdoBTWVEO9hLsYF2U5SOXZskPV9p0fzmB
         SkZQ==
X-Gm-Message-State: AOAM532w7ZeuZuuCP9lkDIALSGvF3PFWNFfYjEpk84Lr5YfzdwWM93nL
        iwJR66Xjl3hF0dm8dLJW7aIiP0BG1gEO89BgPDc=
X-Google-Smtp-Source: ABdhPJzLc6m0BkMuRGfiWTndOApB/IZJ3pFhctHvoj/A/T8ur+VIsGl2hrfGsJYfdxisA/DjoFbY59qgXA4GyJF4jqg=
X-Received: by 2002:a05:6e02:8ab:: with SMTP id a11mr15981590ilt.137.1614669219319;
 Mon, 01 Mar 2021 23:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20210228002500.11483-1-sir@cmpwn.com> <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga> <20210228040345.GO2723601@casper.infradead.org>
 <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
In-Reply-To: <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 2 Mar 2021 09:13:28 +0200
Message-ID: <CAOQ4uxgbt5fdx=5_QKJZm1y7hZn5-84NkBzcLWjHL3eAzdML0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 4:02 PM Drew DeVault <sir@cmpwn.com> wrote:
>
> On Sat Feb 27, 2021 at 11:03 PM EST, Matthew Wilcox wrote:
> > > 1. Program A creates a directory
> > > 2. Program A is pre-empted
> > > 3. Program B deletes the directory
> > > 4. Program A creates a file in that directory
> > > 5. RIP
> >
> > umm ... program B deletes the directory. program A opens it in order to
> > use openat(). program A gets ENOENT and exits, confused. that's the
> > race you're removing here -- and it seems fairly insignificant to me.
>
> Yes, that is the race being eliminated here. Instead of this, program A
> has an fd which holds a reference to the directory, so it just works. A
> race is a race. It's an oversight in the API.

I think you mixed in confusion with "program B deletes the directory".
That will result, as Matthew wrote in ENOENT because that dir is now
IS_DEADDIR().

I think I understand what you mean with the oversight in the API, but
the use case should involve mkdtemp(3) - make it more like tmpfile(3).
Not that *I* can think of the races this can solve, but I am pretty sure
that people with security background will be able to rationalize this.

You start your pitch by ruling out the option of openat2() with
O_CREAT | O_DIRECTORY, because you have strong emotions
against it (loathe).
I personally do not share this feeling with you, because:
1. The syscall is already used to open directories as well as files
2. The whole idea of openat2() is that you can add new behaviors
    with new open_how flags, so no existing app will be surprised from
    behavior change of  O_CREAT | O_DIRECTORY combination.

For your consideration.

Thanks,
Amir.
