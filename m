Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728203DBDA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhG3RYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhG3RYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 13:24:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05EC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 10:24:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h2so19325689lfu.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5XV6WBhPw1h0fTI0SqmJhAQIDZcprvflesFAjdSnoI=;
        b=dXFvwrV3SI/JNYdq8jhdZqWKkwAX9QYglLSHeaLk0UQDPF6IKqBiGAAgibfahd+2kJ
         qZLaden8dpyXuskq1d+8EOHt62kMntdXl+AhI1Q5gXf1QcjvHWIsH2dQsI4OQNl7PtkW
         wI1p33v6yrQavv7i5BfBnqZNhtIhcGDvYh3p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5XV6WBhPw1h0fTI0SqmJhAQIDZcprvflesFAjdSnoI=;
        b=LhYkWlgxV/mXJFJNgqf54PaejOkganSMZ+A0VtynqBSYcpzTD+WfM2zgYcOC8a2I8T
         kqHr9KdRwpo47HXTL2Tacbx9xfPaL3aiKUmhssrwYgGDFb72MgW+22tkPVy50/k2l7DJ
         V0VVDzg7XH6N9JH5AT5DqGrYZ+JqINq451n5sMX3d/EMJcdWldlCjFXql8XfRaLOMZra
         C6BcxanCKOEIsMeK03yS1dPkAvN1rk9ZK0cWn6A98BBemgSo0NZG5unmo3K39O9IhFb8
         cLSllfDgdiuHzUapz/2BRzOvIppgyOS7YaXAsruFVmgPAaO3UCASpLKrTSTuRYqWAKrt
         kY7w==
X-Gm-Message-State: AOAM532pII5UA/1/ghcfKPYoekIHv7TOIVtK5i3Tfk/ejIW6iGVLAETo
        m8PB/gwiC1UtG7QEi1Z1CEB70w0/Yp5K/W4y
X-Google-Smtp-Source: ABdhPJytZf8DRFMgHqWzGtvN+sFpOQXnA7pOnx8etwRcUcnfEtittCBuJGLcnxwCwYhio5rv4XhBFQ==
X-Received: by 2002:ac2:520c:: with SMTP id a12mr2658975lfl.67.1627665849255;
        Fri, 30 Jul 2021 10:24:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id bp29sm199274lfb.58.2021.07.30.10.24.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 10:24:07 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e5so13378468ljp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 10:24:07 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr2294792ljh.61.1627665847174;
 Fri, 30 Jul 2021 10:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com> <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com>
In-Reply-To: <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jul 2021 10:23:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
Message-ID: <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
Subject: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 8:55 AM Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> We've just sent the 27th patch series which fixes to the buildability against
> current linux-next. And we'll need several days to prepare a proper pull request
> before sending it to you.

Well, I won't pull until the next merge window opens anyway (about a
month away). But it would be good to have your tree in linux-next for
at least a couple of weeks before that happens.

Added Stephen to the participants list as a heads-up for him - letting
him know where to fetch the git tree from will allow that to happen if
you haven't done so already.

The one other thing I do want when there's big new pieces like this
being added is to ask you to make sure that everything is signed-off
properly, and that there is no internal confusion about the GPLv2
inside Paragon, and that any legal people etc are all aware of this
all and are on board. The last thing we want to see is some "oops, we
didn't mean to do this" brouhaha six months later.

I doubt that's an issue, considering how public this all has been, but
I just wanted to mention it just to be very obvious about it.

                  Linus
