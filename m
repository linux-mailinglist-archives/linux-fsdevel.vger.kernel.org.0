Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60B2DD46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfE2Mip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 08:38:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44789 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfE2Mip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 08:38:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id z65so1852317oia.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDUDeCcdkQRbyuDM8qhH2Znf4RJm622zVFVk61i9LUg=;
        b=ZCKuRAAryeW8Ea5a25JWdvwmbrdGZA5xPyltiLcgx4QtORZxZ6KJmJtbQxtoNP19Wo
         Xg/dLGf55jPQVSu5FE5JfFK7fc0xjH0pJJreCdlCoRyFKz1S/c3xX7x4shGTa6cUqGTp
         oKnE3uqlDQkPvz9on04775F383vDunb9m+/zLQD6JDlSiH24sbrzBPKZNp3EvsYjVGVi
         Cc5R78VuDWIlrimSCIawnfCim8ruhA683p9xsCjmSGXf5CCEqHbNvBge06/nfVQsMrgB
         FRpBhADe6tsO9JhX7ewzY9eZg/ESAX6zHUISb4osC6OllGV3iXF9sfvcuTLkaZ4LocgQ
         GxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDUDeCcdkQRbyuDM8qhH2Znf4RJm622zVFVk61i9LUg=;
        b=EIS+R3xeeK3nAzkvHOM/75Tap3aQQY5s/Gkw06BaR5KXJJX2KeOvhFpiUBncQxDVw7
         CV9HvvwfxjpqKf0uw8wxMGi0HTRlH1cG9eC/+aPe/ig7xkZaY8Lo5750SIfIdvyc/4q1
         SadOC0hYnSEBGmqu8e66Ni0XxPAp8eAO7P68PYNn7n9ia7AjKpIerRRPx0XQ43qcZsiY
         G0JJtF2dLqrWNekIO3ZmlqVuQ1wg/9XK3G3Fe8OEJq1pC0Itey5HXWDVrD00JnflK9/e
         yZuBslIENEqZ2aVWF09Two53ivQi2C8qKdP0XgQE06PdsR103tRWjw/7JsaBvb0VmhmH
         8RGg==
X-Gm-Message-State: APjAAAWInSkvQh8KT7NJxA/RODSj6dMdlOXx7Ig2LtNBuAqAoEM2Ij+/
        PhubODvB5OH5+0uoFouJojF+WqOthzt0GUqspEvIbQ==
X-Google-Smtp-Source: APXvYqwJ2gAc1xrWfg14y07pweZqCRi8/M2bmVC0WruolqfhcH6WYYDvGNBDBrird7ra9WnVYsJgm/yAFEM1C3i9OeY=
X-Received: by 2002:aca:f308:: with SMTP id r8mr1273650oih.39.1559133524190;
 Wed, 29 May 2019 05:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
 <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org> <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de>
In-Reply-To: <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 14:38:17 +0200
Message-ID: <CAG48ez1xe0MFrECFHAtiiTn1V0+yvJazuCNEiWWAm-kvUwG4nQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 2:32 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/28/19 12:56 PM, Greg Ungerer wrote:
> >> Maybe... but I didn't want to rip it out without having one of the
> >> maintainers confirm that this really isn't likely to be used anymore.
> >
> > I have not used shared libraries on m68k non-mmu setups for
> > a very long time. At least 10 years I would think.
> We use shared libraries in Debian on m68k and Andreas Schwab uses them
> on openSUSE/m68k.

And you're using FLAT shared libraries, not ELF / FDPIC ELF shared
libraries? See <https://lore.kernel.org/lkml/20190524201817.16509-1-jannh@google.com/>
for context - this thread is about CONFIG_BINFMT_SHARED_FLAT.
