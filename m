Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A877A175097
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 23:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCAWe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 17:34:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33976 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCAWe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 17:34:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id w27so6428200lfc.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2020 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocqRb7d75cCd4WWUoRkxgNPbXtSjwtIPTt/0KThKpgE=;
        b=TKFtxdV2BajveGBQ5nXkbQS8BtNEg2/h92w4Eq13y9E182WzlTMQcFcfdVicOJWci4
         QGe9f8rSd1qRr3rMv0YVVAbPfSTGon99nPST9N9YvnSTFZJNIj4k5J/S6Kb05Tjkr8/E
         eI+gkv5J0ueKbE9DmjV5+GcuW9KrX9639Ibck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocqRb7d75cCd4WWUoRkxgNPbXtSjwtIPTt/0KThKpgE=;
        b=RjrBK7BMPQXdOjBPw2iAcUhWVurGrwlgQgwwTgNjRiN98JSgYr+ZwyVqHWUFFw5EUX
         irF7ZzHY0JKTuXT3h4LleINGCJA3J13bWPiefo1JQ/tGOTPpfT6swpkkcC1nMu5/eNEQ
         XiOSiHg/Pn6zWcPHP9Na0bnMpIv/3slUHi0V23IMhIfS7UOerl2JFLW9RNjJakdsp5IF
         McL125TTPE15quD1ZHtjKHDPHOeXhcl7cuWdHCa8aYUNEV1IM0kknznjPqneTUzQN4jg
         g+/WsfgUpcedAH/oTIR9jCVrd6nbjkyUFoNzi0j1CiG7n6Z6+MrAfmKJ3w6i/Qo1Vq6/
         nZwQ==
X-Gm-Message-State: ANhLgQ2qCaMyG+vK/womXIYaxzRD2Xcx8GdYStJJp9D3D8VjufvAQaa1
        0WpyejnJ22+KLm5jgmC9LG7j17LKMph63w==
X-Google-Smtp-Source: ADFU+vs0OJ1BbwjjilpEj0A4U4vI0p4/7DGgFbU3ijmcyqj8V+cAiPdJ+Kxh0Hdb6NzSXF96qjTiyw==
X-Received: by 2002:a05:6512:31a:: with SMTP id t26mr8382311lfp.146.1583102063945;
        Sun, 01 Mar 2020 14:34:23 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q6sm9382555lfo.69.2020.03.01.14.34.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 14:34:23 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 143so9627869ljj.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2020 14:34:23 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr9960735ljj.265.1583102062599;
 Sun, 01 Mar 2020 14:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200301215125.GA873525@ZenIV.linux.org.uk>
In-Reply-To: <20200301215125.GA873525@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Mar 2020 16:34:06 -0600
X-Gmail-Original-Message-ID: <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
Message-ID: <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 1, 2020 at 3:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Extended since the last repost.  The branch is in #work.dotdot;
> #work.do_last is its beginning (about 2/3 of the total), slightly
> reworked since the last time.

I'm traveling, so only a quick read-through.

One request: can you add the total diffstat to the cover letter (along
with what you used as a base)? I did apply it to a branch just to look
at it more closely, so I can see the final diffstat that way:

 Documentation/filesystems/path-lookup.rst |    7 +-
 fs/autofs/dev-ioctl.c                     |    6 +-
 fs/internal.h                             |    1 -
 fs/namei.c                                | 1333 +++++++++------------
 fs/namespace.c                            |   96 +-
 fs/open.c                                 |    4 +-
 include/linux/namei.h                     |    4 +-
 7 files changed, 642 insertions(+), 809 deletions(-)

but it would have been nice to see in your explanation too.

Anyway, from a quick read-through, I don't see anything that raises my
hackles - you've fixed the goto label naming, and I didn't notice
anything else odd.

Maybe that was because I wasn't careful enough. But the final line
count certainly speaks for the series..

             Linus
