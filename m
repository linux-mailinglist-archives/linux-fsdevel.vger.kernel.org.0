Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4564820D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 00:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhL3XOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 18:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhL3XOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 18:14:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5EAC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 15:14:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so104426678edc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvbY16E8oyZuQmwhENSd6ZR/AetXrgDul+iMAR9/AXs=;
        b=gsA1hbhaKjRlq/54Zv3QJKllmFQb5RPA+G1TyRwBsE4AzpCgAo/4F3ioK+1ebe/okE
         4HQ3TvTmGY4Afv+EqtL6dlSH5k52i3ITIF93hq69VFAoKVpFih4aZ/xyH5P9SfjjeuyC
         L3ZChkTaAXYVV1/AVuj2/5QthCNYPd85oz6MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvbY16E8oyZuQmwhENSd6ZR/AetXrgDul+iMAR9/AXs=;
        b=t5cr9pxB6TC0hHIgHV4+WpbLhciYBLrqs5JoHKOH7+P2vYEi+zmyEcX2naw4/69FNJ
         /Ou1ZyCrfFgavkL4qneqez5USIUCIrhFzvWpqmbQPgKVUEdM+V79srdDE3fTu1/LE8zV
         YjxogkIF7Qq1LlbiJRwnc7Q61Pu9MO6UAn8AsFlgTdBOWXzMl1Ew9N80UTbH0JvGIU9X
         RpVhQJvlyLYu+Jk6xBD4W/FaUVIB973YZBa7Hj9GqOihgJJqi72vPmUTuWExIsoG/IY1
         dWiU0lTWN9lLkjyhgW8NdSAB0zH91aSPuEGv0MOcWOr/E/ayQkYagdMweTpXN3YKENPh
         KXNQ==
X-Gm-Message-State: AOAM533UCLOP12EFUFq+fn5q8vBTSPBoiMaGY4/Iz4nfCqGvQ2zkMiHo
        RG3QLL1GCV5CXNSt03UxCnjS66129qvSSiwD
X-Google-Smtp-Source: ABdhPJxLtX1i17aOLhKjd1rLCbkF43AKOBfguwB+yRoLRExJQO/a7AkCOhKTgGka2vvOQ458sng+zA==
X-Received: by 2002:a05:6402:35d2:: with SMTP id z18mr32021090edc.100.1640906090506;
        Thu, 30 Dec 2021 15:14:50 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id g10sm7986551eja.80.2021.12.30.15.14.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 15:14:49 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id v11so53079952wrw.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 15:14:49 -0800 (PST)
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr26006959wrc.274.1640906089307;
 Thu, 30 Dec 2021 15:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20211230192309.115524-1-christian.brauner@ubuntu.com>
In-Reply-To: <20211230192309.115524-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Dec 2021 15:14:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=winoYrnz+KQA5Mqrw9f=PeyvKT2SsyAx=ZCUoBxm4kDpA@mail.gmail.com>
Message-ID: <CAHk-=winoYrnz+KQA5Mqrw9f=PeyvKT2SsyAx=ZCUoBxm4kDpA@mail.gmail.com>
Subject: Re: [PATCH] fs/mount_setattr: always cleanup mount_kattr
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:23 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Would you be ok with applying this fix directly? I

Done.

That said, I would have liked a "Fixes:" tag, or some indication of
how far back the stable people should take this..

I assume it's 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP"), and
that's what I added manually to it as I applied it, but relying on me
noticing and getting things right can be a risky business..

              Linus
