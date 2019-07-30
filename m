Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D827A25F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 09:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfG3HgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 03:36:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43342 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3HgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:36:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so17757351qto.10;
        Tue, 30 Jul 2019 00:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfrVJyXLBlSE9J2lD7NyucDQMOlxGjPdY+ssj9/d310=;
        b=ekg/TIdh/5CdjTpsKc8y61wYzehVJwT+LlG8dPrqCiCjB3VyDdJzW0PjSoD8TE0GSS
         TvocylAHjmGHvNpJ/TQxJudjfsAyPjsz3Gue57NEXpKP325F9eq6cf02WD5uQKRqF4s5
         6Vz99UKj+7/6RbZGAGVMANWyufR8ahxfROVYAi4IP1G7/AGSyPuZpTa3nbUby4Jhxmd2
         ku7zkfb8QnZuQEXR+hGCiL+XPKJ4uUpyG4UPVXCKOAowGP++agQ0cmKnbn0b4+bv1Jhe
         uteqf6aSKsYiTF5+klK/e1oO8vH61TZJg9TxiMxnsxBVAJHNkfCCdV3ZtDpgTO1BJ6Ge
         D/Pw==
X-Gm-Message-State: APjAAAWReeNUa2eXbv+a+f6lXNafhqiHOPMW5Cd6mtdQ6boGSvJNTX90
        hDEcQU6K/MS8bYiAe8v5EW9GOUhO8YL0s/lBa/k=
X-Google-Smtp-Source: APXvYqxMF2mFh+jvacCLXH4Q8wX+v35Rhqc4s/okUitEq0NfFz96icl/A98K5zPxFiZM3Zjr3+btQsm5HWzBXkh4esI=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr80607136qtf.204.1564472184297;
 Tue, 30 Jul 2019 00:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-20-deepa.kernel@gmail.com>
 <201907292129.AC796230@keescook>
In-Reply-To: <201907292129.AC796230@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 09:36:08 +0200
Message-ID: <CAK8P3a2rWEciT=PegCYUww-n-3smQHNjvW4duBqoS2PLSGdhYw@mail.gmail.com>
Subject: Re: [PATCH 19/20] pstore: fs superblock limits
To:     Kees Cook <keescook@chromium.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 6:31 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 29, 2019 at 06:49:23PM -0700, Deepa Dinamani wrote:
> > Also update the gran since pstore has microsecond granularity.
>
> So, I'm fine with this, but technically the granularity depends on the
> backend storage... many have no actual time keeping, though. My point is,
> pstore's timestamps are really mostly a lie, but the most common backend
> (ramoops) is seconds-granularity.
>
> So, I'm fine with this, but it's a lie but it's a lie that doesn't
> matter, so ...
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> I'm open to suggestions to improve it...

If we don't care about using sub-second granularity, then setting it
to one second unconditionally here will make it always use that and
report it correctly.

       Arnd
