Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9518535F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 01:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCNAkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 20:40:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43491 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCNAkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:40:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so12514483ljp.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqSpkfWgbM1F3EW77t+yz+x0olHI1MIS3rmLQvUjsfY=;
        b=h0Tz0gWq3PbDuwAlu8mqUD6SjZrPMaRqc/j4UZj9jQmUowcFOJJIi9ZCL8z83J1tXE
         7Au04VqmCECr7JqBbrxgltGl9GD8U4c5Fd2GyuYbKWoDz44wGtx5f6hrTX4vk7/Z25K2
         eP89+Og4D6pSQCoVRZqpyW94FiDJOnuSc0uxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqSpkfWgbM1F3EW77t+yz+x0olHI1MIS3rmLQvUjsfY=;
        b=sSogjalaYFtPrrgFAmIPQyWEhKCgqH9g0am8/FmwFRKg3fL02KBXip/vycAa2Gr9ST
         s/uQq4fSzwQmrqnnrWPl4mkAI2oyIiv1M6sTtqP7VnIGsl3fbZanYxlvPLqPMn7BBd2f
         oz1hPflY092UStA3P4N6DzTo6hLQK8ea/tZ5TnydeS3tkj2UYJ8dYf/pP7GnpCLh+pHt
         w1sl+6HV6mvUmhi2g3NjN4872lmfS+ndJNjNvygOQVJeWwnqI2nl5T/09k8rg/39CDoO
         It5dS+jSHLJM17aQFdlPKsT7WKg803RYF/Vcj9984FUKFwCSW2G2T2t9KA4fW77zrvu8
         nrCw==
X-Gm-Message-State: ANhLgQ3hBpP1AjpFb3r8sUgDJuLmBqD7+lzaL3jRGIaJpYRnUy6fvmPp
        lYOqC58mIFtUKFOjBUcBcLRGwxX4OGg=
X-Google-Smtp-Source: ADFU+vuwEh0qCdpB8eGCSaIjhPAUZ9GY6N+9hl4C9spWsEcdJZyimnP/Cbi6UAHOFCnP97PuQPMwCw==
X-Received: by 2002:a2e:b0c7:: with SMTP id g7mr10063656ljl.255.1584146420329;
        Fri, 13 Mar 2020 17:40:20 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p27sm2361986lfo.63.2020.03.13.17.40.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:40:19 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id j11so9349404lfg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:40:19 -0700 (PDT)
X-Received: by 2002:ac2:5508:: with SMTP id j8mr10082934lfk.31.1584146418864;
 Fri, 13 Mar 2020 17:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-20-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-20-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:40:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQjL+W66NZ=+Rc_ibEznmt9bcY5MjxgLkqV1DtrFM4ow@mail.gmail.com>
Message-ID: <CAHk-=wjQjL+W66NZ=+Rc_ibEznmt9bcY5MjxgLkqV1DtrFM4ow@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 20/69] merging pick_link() with get_link(), part 2
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm..

On Fri, Mar 13, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>@@ -2370,10 +2375,9 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
> +       while (!(err = link_path_walk(s, nd)) &&
> +              (s = lookup_last(nd)) != NULL)
> +               ;

There's two copies of that loop (the other being in path_openat()). Is
there a reason why it's written that odd way?

Why is the loop body empty, when the *natural* way to write that would
seem to be

        while (!(err = link_path_walk(s, nd))) {
                s = lookup_last(nd));
                if (!s)
                        break;
        }

which may be a few lines longer, but a lot more legible.

I don't think you should use assignments in tests, unless strictly
required. Yes, that "err = ..." part almost has to be written that
way, but the "s = ..." part doesn't seem to have any reason for being
in the conditional.

And I'm only reading the patches, so once again: maybe I'm messing up
by mis-reading something. And maybe you have some reason for that
pattern.

                     Linus
