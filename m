Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFF145CF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 21:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAVUQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 15:16:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45139 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAVUQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:16:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id j26so439316ljc.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLaXGgH4O8WRc84Pr2qZRgc6Y4dR2xbO1cV7z28yhvw=;
        b=c6/3aq9HZcbkVeterj3636njxvpxgw2prgy9shUHvAD8OXcz0f+wkIkYAuQbjGEWBg
         wVKr74EpV63VLAZVJqyVwqQj1WCI2m0sZGTgzXF83HkQ+44OAwRd+/sOaE20vmKvYmlT
         36kGk2sd4GMMWPOxwa4EBhU0TxNUpffdyIDvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLaXGgH4O8WRc84Pr2qZRgc6Y4dR2xbO1cV7z28yhvw=;
        b=img77OCIfguXGznCrvEz0xol6fKLvFk7QlbLewbjk6sjGXfPJGZge2IsYEU5u8Ft6x
         k9E8I1joXisQgHD75L9bGltnOFwP0MaELjiMbvVKg4Sj6qQQtaeWA9K+EEflYLEWw63O
         /X/5+UEp/EkvxRCBqL5p+Ey8EBxmZXxUSYtFNrkpTANijTWOXUhrxO5WsQO4rM+aO8mb
         OJTiVTmPcK6tW48+Czx+2jqshdWQa79VKChe5A2ScI2aCI16fXfkFz7g3PGBWCw95h9E
         xms5zHEJ6vpVSZ25F68eNTlIDFY/SZ4ljRx3LP+lywinMjkDup2EZpvMNJy0/q884M0V
         OWRA==
X-Gm-Message-State: APjAAAWz4W3LJk6HjtmsDBk0Wiz7KkjSgyzakUafWsGfCPKVrlkiPeJS
        gCLvT0rcLYA1Ep0KpbudgOadrEV5gOc=
X-Google-Smtp-Source: APXvYqx1YR1Nqnb2TN/nMB7N9pZIMwLJzI39XU58chksVbzDNrqfL2UiKuyUeacFcE1hR1P/tya+/w==
X-Received: by 2002:a2e:9804:: with SMTP id a4mr19995493ljj.10.1579724159326;
        Wed, 22 Jan 2020 12:15:59 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p136sm21570756lfa.8.2020.01.22.12.15.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:15:58 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y6so523010lji.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 12:15:58 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr20649915ljo.41.1579724158165;
 Wed, 22 Jan 2020 12:15:58 -0800 (PST)
MIME-Version: 1.0
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <CAHk-=wgNQ-rWoLg0OCJYYYbKBnRAUK4NPU-OD+vv-6fWnd=8kA@mail.gmail.com> <CAHk-=winQ_607Sp09H1w70A_WPmt7ydxrNrwvk=N29S=FpASZw@mail.gmail.com>
In-Reply-To: <CAHk-=winQ_607Sp09H1w70A_WPmt7ydxrNrwvk=N29S=FpASZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jan 2020 12:15:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgK1Pbj4DD4OLFuFg1Tgvup85h9W5ZroCOwAE1qCDWuBg@mail.gmail.com>
Message-ID: <CAHk-=wgK1Pbj4DD4OLFuFg1Tgvup85h9W5ZroCOwAE1qCDWuBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> A bit more re-organization also allows us to do the unsafe_put_user()
> unconditionally.

I meant the "user_access_begin()", of course.

Code was right, explanation was wrong.

That said, with this model, we _could_ make the

        unsafe_put_user(offset, &prev->d_off, efault_end);

be unconditional too, since now 'prev' will actually be a valid
pointer - it will match 'dirent' if there was no prev.

But since we want to test whether we had a previous entry anyway (for
the signal handling latency issue), making the write to the previous
d_reclen unconditional (and then overwriting it the next iteration)
doesn't actually buy us anything.

It was the user_access_begin() I'd rather have unconditional, since
otherwise it gets duplicated in two (very slightly) different versions
and we have unnecessary code bloat.

           Linus
