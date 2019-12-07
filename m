Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC4115E35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 20:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLGTd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 14:33:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37330 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGTd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:33:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so7753798lfc.4;
        Sat, 07 Dec 2019 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZqeyKQuSHI4BOC48li9FJR/nDDNru9OxRd5ZcNFeOSo=;
        b=bcGFvZVGymPohW7Kz+0lmJh5NBMXwP13fhSiC2PMvT+x8BDSta9z4Gh62xDH0vMCNi
         b5EeQfy1P6DUlYctjiKYMxkWRI9S7M58N8Aw6EfsEjIm/a2mnKj/lfWJPOjSLKw227Bk
         y9uWb64wcTjjFlLGQHbHDbfzTzZr/e9TTkCIBixbHJOjP2aJlEvv1c7oW/50JE4tXaN8
         uwO9KgTarTW/LOoZblr9YEdjIzSjbzcKWFO2VqPf3F58L9c89A0EzMCCv5HlRQpX2YPq
         e5uEOITyeOHCtrgXAtgdaVRy7xouTdMeRd3iRQM2DxtyX6Ey+4G9SeRX3Sex7/epjxre
         nnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZqeyKQuSHI4BOC48li9FJR/nDDNru9OxRd5ZcNFeOSo=;
        b=mba/ZGlRTmQelMq4jfhJWh40VJxF1xuJ4+zEUQ9sqsHmbTO93easVjpput5xVYHUiF
         VBNSwxzdlBVCbF5jPPENE9T3PNdIi/IxiFNApzvqNvhws9z2TbyB3TsRG6bKGcB9Zzvd
         hRngaAVMdOjsfbkFfBaQPCanJiR694J+e0v82EhRQ8F1XtrCb6O0w0sffXxjOUoQ2afZ
         WRMWwXdpuqeTv3c7WmQTVp0OBGR4h/0QZWptSgFzCMUzCCztghFbKvSlxA5jHjaxMh8D
         E+mcf22rtRUgVNNgCYF+nlX6WTlxgd0KjTbHjsRw3oKWb8lIMbpkzfdroKqs8xk8KjD5
         B7dg==
X-Gm-Message-State: APjAAAWb8/cRv3s0va1czutKTE8K6iEhY1cdwvXIGpBwEXt9rUV0vQx9
        D9rqUMemFO8VK3B2mKpZbiSe801+UtRnWDItt8MSVhS2
X-Google-Smtp-Source: APXvYqz3Rv5lELnvMvYi9DJu3Ziq1/sgCxXk7sid2BZsdSs6O5IYnCn8sS4VOkosJsIOT9yMeYwn0gdm4efpu+NsnJM=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr11276098lfh.102.1575747234015;
 Sat, 07 Dec 2019 11:33:54 -0800 (PST)
MIME-Version: 1.0
References: <157566809107.17007.16619855857308884231.stgit@warthog.procyon.org.uk>
 <CAJTyqKNuv+5x7zUTT_O56h7cGOVSEergF+QDXGHCpxXygVG_CA@mail.gmail.com> <CAHk-=wiamjvQAw1y2ymstHbato_XtrkBeWYf1xbi1=94Zft2NA@mail.gmail.com>
In-Reply-To: <CAHk-=wiamjvQAw1y2ymstHbato_XtrkBeWYf1xbi1=94Zft2NA@mail.gmail.com>
Reply-To: mceier@gmail.com
From:   Mariusz Ceier <mceier@gmail.com>
Date:   Sat, 7 Dec 2019 19:33:42 +0000
Message-ID: <CAJTyqKO9FX+0TDWL8goY1O5hDsrgXbt1TTuABjcZW_Oi33vVrg@mail.gmail.com>
Subject: Re: [PATCH] pipe: Fix iteration end check in fuse_dev_splice_write()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I can't reproduce it with ad910e36da4ca3a1bd436989f632d062dda0c921,
seems it fixes the issue.

Best regards,
Mariusz Ceier

On Sat, 7 Dec 2019 at 18:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Dec 7, 2019 at 10:30 AM Mariusz Ceier <mceier@gmail.com> wrote:
> >
> > I believe it's still not complete fix for 8cefc107ca54. Loading videos
> > (or streams) on youtube, twitch in firefox (71 or nightly) on kernel
> > eea2d5da29e396b6cc1fb35e36bcbf5f57731015 still results in page
> > rendering getting stuck (switching between tabs shows spinner instead
> > of page content).
>
> Ok, so youtube (unlike facebook), I can test in firefox. Although it's
> 70, not 71 or nightly. And it doesn't seem to fail for me.
>
> Of course, maybe the reason it doesn't fail for me is that I have a
> patch in my tree that may be the fix. It's a very small race in
> select()/poll(), and it's small enough that I wonder if it's really
> the fix for this, but hey, it might be.
>
> It also might be that your version of firefox is different, or just
> that you're hitting something else that I'm just not hitting.
>
> But I committed my patch and pushed it out, so that you could see if
> that fixes it for you.
>
>                 Linus
