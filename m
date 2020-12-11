Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3E2D6CD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 02:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbgLKBDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 20:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgLKBCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:02:44 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050F8C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 17:02:03 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so11056925lfg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 17:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eL+h7xeFX3PxTC7wOBMQFR0+2THjd1Dky1cIThWDYyQ=;
        b=h+6i4V+xCVtPhqyQ5W+p+kPGcRM0UqI/VgG0mk0VJ42AvTM1RMPxswzs9OIiYBv5Bk
         lKzqn0O9h080zfeq9Qj0Bonkh9cLgcEO2VtIDzC1Wwd5kmcRPGDRcJNpmXICTNURnzJW
         cOHs+SDNcu+K7A6j05UOGU6eXLCbDqnhzn4JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eL+h7xeFX3PxTC7wOBMQFR0+2THjd1Dky1cIThWDYyQ=;
        b=Kysjii8rekHwPIrRf7Ga8qthx2ZiwE7rQTYIFymVab57ycPXSiYiqg9eXCK93nRQLz
         njVTqkXrCKiFp8qdwLwfbMiykmrVAnnh59XagNvIRfvOkTeXzNzbMyiWmi46iVPFDqhr
         6aYElkbnxUkRPS8EJSZTd4ox4bYUSIcuLNgK1HUsdW8JeHQCnfJkHwfr5/sKz23LVpsa
         nm+k+vWnpDE46g8lsoL79/qP+utUlecmX+qFMcm0k9CqnU8bDBL18yH8lHciDK4J8dAH
         Hu/hDaCtSpHFmMVfdfnL+qsDQAED1sj4papESM+xuVS9W5cbA5gAmtZcYe+FPnGzxPfe
         KBUg==
X-Gm-Message-State: AOAM533+zx9trPUCbF8k8YVW780micIIWSF4bCtvFD6/82GYzXsdhAxJ
        v3pZEJVtfm3dbIjUxL3Q0d41ZiVFI3sjtg==
X-Google-Smtp-Source: ABdhPJxL+5oWevrX5LXEzEl9tmrZLAG7FnvpnTwJePgctBHU/33LIVUGapbsPXckOVMCMq75igKmRA==
X-Received: by 2002:a19:f241:: with SMTP id d1mr3631544lfk.241.1607648522019;
        Thu, 10 Dec 2020 17:02:02 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id b29sm697913lfc.12.2020.12.10.17.02.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 17:02:01 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id m25so10992959lfc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 17:02:01 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr3448854lfd.201.1607648520738;
 Thu, 10 Dec 2020 17:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20201210200114.525026-1-axboe@kernel.dk> <20201210200114.525026-3-axboe@kernel.dk>
 <20201210222934.GI4170059@dread.disaster.area> <CAHk-=wiee7xKitbX74NvjcKDHLiE21=SbO9_urWBnvm=nSZAFQ@mail.gmail.com>
 <20201211005830.GD3913616@dread.disaster.area>
In-Reply-To: <20201211005830.GD3913616@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Dec 2020 17:01:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQTK74ZwP7W9oMZFYZH=_t-1po75ajxQQAf-R945zhRA@mail.gmail.com>
Message-ID: <CAHk-=whQTK74ZwP7W9oMZFYZH=_t-1po75ajxQQAf-R945zhRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 4:58 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Umm, yes, that is _exactly_ what I just said. :/

.,. but it _sounded_ like you would actually want to do the whole
filesystem thing, since why would you have piped up otherwise. I just
wanted to clarify that the onle sane model is the one that patch
actually implements.

Otherwise, your email was just nit-picking about a single word in a
comment in a header file.

Was that really what you wanted to do?

            Linus
