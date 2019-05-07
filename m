Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23A16AC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfEGSyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 14:54:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33807 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfEGSym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 14:54:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id v18so10430577lfi.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03Uys/LodQHobuNrmkDI+EEraEEB0uwMGVfOXBSwJiE=;
        b=K1WZMlTVwBp3Swx98o8GlV/oq7Kzpl3yWUPGTOhlU/o7eYV9nXLTyb0enpz+tbwcox
         0SbmYut9wMOX54HOmv8M3sEYWlC+Sw5C6fheSJdC8bky7ZBNWJBbxH7K9aJ3h+s9oDK8
         PSQaBWp2nTgkevaKHVc7kCihTZotTYFSmUBug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03Uys/LodQHobuNrmkDI+EEraEEB0uwMGVfOXBSwJiE=;
        b=euqWV/Fh0aIJEOsGVlrjZCJwKO7LgYMhT9Sz/bNyrwJAybnXfQRTDbZ6mS7hG3mOLd
         pIaaGAj4u68sqwk75byKCw7wZSC0XWqIVuYHNrRbtMUcejuo8dWNU9IFuEYClu99ewJf
         7Er5u++g7jVs1Nf76IZ/zKiKNNxZacx0yjYBohIprkUn2tUj4ttXALwDikZL5V1Pjdi5
         ASsgFnWuzWtA8b+679AQRg53oem6GIBSVqmXWbHBer4wbHRuSbD70l2mdypYqwmvbN9i
         OKDiO2VoJ4purQ+raI0p5qy1DLzcd0JXSXdMlhvFBtFZ4+FK2ShAB3e/x2o/A8LWNKLZ
         SxNA==
X-Gm-Message-State: APjAAAXyoUNawGFiW9AUghnMVSrQXatWZCEhB4wGJgYh36ayvIZf5eHS
        XmltweEebXpMPovRgdy+XhYFHBNPVRE=
X-Google-Smtp-Source: APXvYqyDrRGNVQkVBePHsS85SZE9+GsZGrJbclMx+JUevJWIEtds9A0KjyyrpH9di004rQDRTYKh1g==
X-Received: by 2002:ac2:4192:: with SMTP id z18mr17446536lfh.96.1557255280658;
        Tue, 07 May 2019 11:54:40 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b25sm3516164lji.50.2019.05.07.11.54.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 11:54:37 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id y10so8772593lji.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 11:54:37 -0700 (PDT)
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr16188873ljj.135.1557255277072;
 Tue, 07 May 2019 11:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557162679.git.kirr@nexedi.com>
In-Reply-To: <cover.1557162679.git.kirr@nexedi.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 11:54:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
Message-ID: <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
Subject: Re: [PATCH 0/3] stream_open bits for Linux 5.2
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 6, 2019 at 10:20 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Maybe it will help: the patches can be also pulled from here:
>
>         git pull https://lab.nexedi.com/kirr/linux.git y/stream_open-5.2

I'll take this, but I generally *really* want a signed tag for
non-kernel.org git tree sources. The gpg key used for signing doesn't
necessarily even have to be signed by others yet, but just the fact
that there's a pgp key means that then future pulls at least verify
that it's the sam,e controlling entity, and we can get the signatures
later.

For something one-time where I will then look through the details of
each commit it's not like I absolutely require it, which is why I'm
pulling it, but just in general I wanted to point this out.

                        Linus
