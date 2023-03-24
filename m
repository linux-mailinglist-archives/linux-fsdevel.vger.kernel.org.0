Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1B6C8759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 22:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCXVPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 17:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCXVPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:15:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812511EA6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 14:15:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so12932911edd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679692516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn1VMftCU2wccLoRUjjDC7/RS1kW8D9l9MfK+gvDeEE=;
        b=hx3qSfQuA/ooCvOGT3qtjnG8D2r6/kpjrTkalHlbb8wj/Iif5lN7/TKQqtyXwePwMk
         5/Dcc1B4Jwa32UafAdNvrhznivEhs8l9aKvzhZFeTOrxLX1lCBLz3bCRBJgX1YqkmIHS
         TI3lkyJzlHnm35QCWyS9l5HiTFsg+2zO/NusE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679692516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fn1VMftCU2wccLoRUjjDC7/RS1kW8D9l9MfK+gvDeEE=;
        b=WtFTTgMKIIICC6PoQXx7T3cRd1nZKVpoVZ1/1/V2AG5X+ofO9bQw48OsWKFbtibqWk
         q/TJwG+A9ZS+I3Dt+VEXeFjjgfaVaGHausTcjN2w5CSOrX3lm2gbtkkwkizXHqUGAJwM
         vxDqqMOzncfR3e3+V7OBpVZiPpgha8EmqyAVwrjWTpguZjV8SDArp//jPNtsQNEWpqx/
         5iy+CUOUcid/S9N9xrwvpGMV3D6jk6oCvtTaA9C2SOIXGVuLz1FFaSrxUYZsYa/zQejK
         +UQCQupzOk/RIJpHW3JoxYzs+EMGqNDHO3zBeJoa/bo+ohiytiVVamFn2DixFYulr0pP
         0Uuw==
X-Gm-Message-State: AAQBX9fpIZTYP1PA7aQR/mB6DG+eVtnPypoPDtf9lvJA5CHahOtoD0Lk
        CNCwttAnknfYDeVpsgI2ltxWu5GgotzEGh+hIVCc7b5J
X-Google-Smtp-Source: AKy350Yjq2C5wS0LcJoFYE+rCdhI/iOakHwtQmMDXR/jvjAOOb09CV0Bc8yvHxjIqJJ7e7yRYkRpEg==
X-Received: by 2002:a17:906:d283:b0:925:b187:ce5f with SMTP id ay3-20020a170906d28300b00925b187ce5fmr4062096ejb.35.1679692516352;
        Fri, 24 Mar 2023 14:15:16 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id d14-20020a1709064c4e00b009336df45226sm8381769ejw.64.2023.03.24.14.15.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 14:15:15 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id i5so13053701eda.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 14:15:15 -0700 (PDT)
X-Received: by 2002:a50:9f66:0:b0:502:227a:d0d9 with SMTP id
 b93-20020a509f66000000b00502227ad0d9mr1508268edf.2.1679692515353; Fri, 24 Mar
 2023 14:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230324204443.45950-1-axboe@kernel.dk>
In-Reply-To: <20230324204443.45950-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 14:14:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjPAUwbQ9bf764x6xL8Ht56CGX79OLTG-fCS6u8yLaCA@mail.gmail.com>
Message-ID: <CAHk-=wgjPAUwbQ9bf764x6xL8Ht56CGX79OLTG-fCS6u8yLaCA@mail.gmail.com>
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 1:44=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
> spots, as the latter is cheaper to iterate and hence saves some cycles.
> I recently experimented [1] with io_uring converting single segment READV
> and WRITEV into non-vectored variants, as we can save some cycles through
> that as well.
>
> But there's really no reason why we can't just do this further down,
> enabling it for everyone. It's quite common to use vectored reads or
> writes even with a single segment, unfortunately, even for cases where
> there's no specific reason to do so. From a bit of non-scientific
> testing on a vm on my laptop, I see about 60% of the import_iovec()
> calls being for a single segment.

I obviously think this is the RightThing(tm) to do, but it's probably
too late for 6.3 since there is the worry that somebody "knows" that
it's a IOVEC somewhere.

Even if it sounds unlikely, and wrong.

Adding Al, who tends to be the main iovec person.

Al, see

   https://lore.kernel.org/all/20230324204443.45950-1-axboe@kernel.dk/

for the series if you didn't already see it on fsdevel.

                  Linus
