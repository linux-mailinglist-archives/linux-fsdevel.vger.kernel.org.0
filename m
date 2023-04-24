Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0736ED683
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDXVFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXVFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:05:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1B6184
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:05:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so7587781a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682370335; x=1684962335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8tba+uDpkEW7dJT6XcMTrVp0OQq/mPaxrVBHBih1WQ=;
        b=VX8v4h3N/14yvstAMpfQ/TxNsG6TZa2MTPUeVu66hXV8uwCYMq5vGq+feQ1yaUQgJO
         Vq52tfGGw549jFbJJ/sDwZrM5Y1LjW9jzrrMKR4fDFc11IXc70/FRo8oqmYKIhP7mIgY
         kkvbjGEWVf/FraDkCD+AXyi8chYjXjDI68PJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682370335; x=1684962335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8tba+uDpkEW7dJT6XcMTrVp0OQq/mPaxrVBHBih1WQ=;
        b=O+WAQreIn8fIbFE79uP7ovfL6EccXS/Potmj+q7HIyKOTSFdLwfurIchN0PspP/sGA
         UBMuEjHwU6lrfvByLfF7VGB0bzpuxS2MMH0x1lrTLP2VJkPA2GOfZZA0ZXpXtVIwzKD8
         /fChRZtEXHpWvX3bHyOxiOSkyGsilyqqqPov9Z7vdakGr2DHs8zd9D36POFrkGnvgZGU
         5EMWBuJfrJuztT22UK2TnrHa7cmXrnsCiyVDv/jiySZxI5uJcMILzvyPlZNQTFZymdmv
         F5yIRrGomkQ6U/trwJZLNRoYW/ATrMg/HDvW67O7fvvpBkoFt9DK5smBsoHp3v65xfIs
         4CZQ==
X-Gm-Message-State: AAQBX9d6EitmnNrSEkwsaQ8avDDqg0eVej7D7haQPVdmKQYWEPcz5IvJ
        /2Uf6htqY2nVL6PPANmZAJDdrEphBGuFChIiEAzZQEOr
X-Google-Smtp-Source: AKy350bqYMCyDg8aQ7H3IJCxi11H+AhWTcls41ZgYRRhYLnvwIAwftrzdnjT4wHvsX8WZlwhaZHSrw==
X-Received: by 2002:a17:906:e097:b0:94f:1b9d:f5ba with SMTP id gh23-20020a170906e09700b0094f1b9df5bamr11941815ejb.62.1682370335090;
        Mon, 24 Apr 2023 14:05:35 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b0094ee3e4c934sm5946178ejf.221.2023.04.24.14.05.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:05:34 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50674656309so7593067a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:05:34 -0700 (PDT)
X-Received: by 2002:a05:6402:151:b0:508:41df:b276 with SMTP id
 s17-20020a056402015100b0050841dfb276mr13756695edu.22.1682370334079; Mon, 24
 Apr 2023 14:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
In-Reply-To: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 14:05:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
Message-ID: <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 7:02=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This contains Jens' work to support FMODE_NOWAIT and thus IOCB_NOWAIT
> for pipes ensuring that all places can deal with non-blocking requests.
>
> To this end, pass down the information that this is a nonblocking
> request so that pipe locking, allocation, and buffer checking correctly
> deal with those.

Ok, I pulled this, but then I unpulled it again.

Doing conditional locking for O_NONBLOCK and friends is not ok. Yes,
it's been done, and I may even have let some slip through, but it's
just WRONG.

There is absolutely no situation where a "ok, so the lock on this data
structure was taken, we'll go to some async model" is worth it.

Every single time I've seen this, it's been some developer who thinks
that O_NONBLOCk is somehow some absolute "this cannot schedule" thing.
And every single time it's been broken and horrid crap that just made
everything more complicated and slowed things down.

If some lock wait is a real problem, then the lock needs to be just
fixed. Not "ok, let's make a non-blocking version and fall back if
it's held".

Note that FMODE_NOWAIT does not mean (and *CANNOT* mean) that you'd
somehow be able to do the IO in some atomic context anyway. Many of
our kernel locks don't even support that (eg mutexes).

So thinking that FMODE_NOWAIT is that kind of absolute is the wrong
kind of thinking entirely.

FMODE_NOWAIT should mean that no *IO* gets done. And yes, that might
mean that allocations fail too. But not this kind of "let's turn
locking into 'trylock' stuff".

The whoe flag is misnamed. It should have been FMODE_NOIO, the same
way we have IOCB_NOIO.

If you want FMODE_ATOMIC, then that is something entirely and
completely different, and is probably crazy.

We have done it in one area (RCU pathname lookup), and it was worth it
there, and it was a *huge* undertaking. It was worth it, but it was
worth it because it was a serious thing with some serious design and a
critical area.

Not this kind of "conditional trylock" garbage which just means that
people will require 'poll()' to now add the lock to the waitqueue, or
make all callers go into some "let's use a different thread instead"
logic.

                             Linus
