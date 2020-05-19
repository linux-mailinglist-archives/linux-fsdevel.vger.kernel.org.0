Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100781DA182
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgESTzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESTzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:55:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244BCC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:55:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q2so1045231ljm.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REdFGTptWqU1qPX4qurL4342JovwYtU3BmwaSdni0jo=;
        b=W9vfQUXrQkvO4DXovXCeM4zoltpY1ZvWxEMenkkAoYs6zHAKFOlS07VVGBZxcFHdnr
         5UDWGSQ+Y1VhNSe2vl8jU8Abr4KLfjA+1Yw3wmcLWjiZR9tzxuzbfsBm4Q3VARObsqvY
         bKB2U0d4amvLqbkcAdva8jfUvV9Pe5jyvgAh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REdFGTptWqU1qPX4qurL4342JovwYtU3BmwaSdni0jo=;
        b=CRzRxY40P0k1lQl+dCk/EJ+0PPWjXq/4cAd01Um5ZBYn2B/FcDNpqsezx3fnAUXP04
         C2yg/cWzMshD9xFuLeAj0OGs2zQIGjLWKWgQmdS70UmUrj0TSCkfUT/PvoljIXVqEwbh
         +grFCqkDZechz4HoCr1X8IutkfL7NIAHv3BzdaJh3+loiSzTPtxic7XHs0O2KhmTR5sk
         jQcSdxE5dff1VHnemM9any4wvnPtOr4H9DqFL7WLQcrX04CbmaDeY0OJ0Z+cDBPOmRht
         WCIr7f/3N5/l+FoKTLHzSooj5P9FJdVWh6cFnidcM/0YkYnPugEzMTss9lualebmQxE0
         OkXA==
X-Gm-Message-State: AOAM531WWLFx7ndg58JBBfo4iiagqne5QuvlyGJgrfuLZ448c40uln8D
        1nWgGHAVQJRdzhs04yOK7fyRguXsyOw=
X-Google-Smtp-Source: ABdhPJzGQlRP/rXUKXHVUD/fp2+mgr+n4SlxTC1w1jbNC/VXYnI2UiGJwvd2VoOmu5v0rexD/vHbqw==
X-Received: by 2002:a2e:8897:: with SMTP id k23mr608533lji.184.1589918097696;
        Tue, 19 May 2020 12:54:57 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k1sm198930lfc.40.2020.05.19.12.54.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 12:54:56 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u15so1096032ljd.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:54:56 -0700 (PDT)
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr641496ljo.265.1589918096078;
 Tue, 19 May 2020 12:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87y2poyd91.fsf_-_@x220.int.ebiederm.org> <202005191220.2DB7B7C7@keescook>
In-Reply-To: <202005191220.2DB7B7C7@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 12:54:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
Message-ID: <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
>
> Though frankly, I wonder if interp_flags could just be removed in favor
> of two new bit members, especially since interp_data is gone:

Yeah, I think that might be a good cleanup - but please keep it as a
separate thing at the end of the series (or maybe the beginning)

                Linus
