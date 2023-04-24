Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC826ED698
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjDXVMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjDXVMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:12:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3249E4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:12:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so8821505a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682370723; x=1684962723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0flSybpT7aXUdx24UhagQw7vrZguz1V40kdNmALOE5o=;
        b=fAqPJPpPvaW8/dtXVRaoTRpLJVvlHJpiYTXU8HWdSLAOMrxIXuYEWVMQhn4Qk67HVc
         7e+h+9qAOyQRe57t9KglGAw/H0KroCnOUc/R4wWLah5+LdCqaFcH8MG4zpGx8GFlkuKT
         Qc0VWt0xsSE6hxDgp6mRIf6MrdCbKaAHo2BUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682370723; x=1684962723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0flSybpT7aXUdx24UhagQw7vrZguz1V40kdNmALOE5o=;
        b=lQMfSqP+oxiizKmBjoiGiVQ3XtQIjS0vtECJUWaI5JjgoE35abfbNwHsIukklC/LAE
         64fnuIEujXtBouWbrpD1T72WohMGiLhyagvyKi6fMNyadmqYEKExYO44dct+MyG1y8EN
         FuzfN7K1B5pGoWCb+Y2OXANRGOvrOz9fhC2hPFqzIvFx4WhpSuwenQl75mZJLxsSY9O5
         kZ8g1PIlijJrAuRYYx9pS+8YckxJj27MoLuANx5R7inKwWJW0wmlHG54jRWxA7UDrc4r
         VjDUR28BszY2P9wGDj6J1TneLAEk+40B9MiwcMFtrc43cwfR2ehk9OPEKtd36wZl3UcU
         WozQ==
X-Gm-Message-State: AAQBX9fls4yo07eGIcnDiY+hECTBF1rPS6ZH5xrvjgUiTEF717gOtVi0
        kpuFikFMC4lkyKtp8GJ/V9J2rmVMzQxrBrYG/Csw4d2p
X-Google-Smtp-Source: AKy350bfqZ58Bvm/SggANzo7wPCBZzqR001ctYQmEKGD4R9ZOckG60vDkS6A6H/qR0AzLqRc2yUGfA==
X-Received: by 2002:a05:6402:641:b0:504:921b:825 with SMTP id u1-20020a056402064100b00504921b0825mr13071264edx.36.1682370723418;
        Mon, 24 Apr 2023 14:12:03 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id t25-20020a17090616d900b009534603453dsm5853733ejd.131.2023.04.24.14.12.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:12:02 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so8821459a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:12:02 -0700 (PDT)
X-Received: by 2002:aa7:d5d4:0:b0:504:ba4f:3450 with SMTP id
 d20-20020aa7d5d4000000b00504ba4f3450mr11017273eds.30.1682370722384; Mon, 24
 Apr 2023 14:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
In-Reply-To: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 14:11:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whykVNoCGj3UC=b0O7V0P-MWDaKz_2r+_yGxyXoEMmL8w@mail.gmail.com>
Message-ID: <CAHk-=whykVNoCGj3UC=b0O7V0P-MWDaKz_2r+_yGxyXoEMmL8w@mail.gmail.com>
Subject: Re: [GIT PULL] open: fix O_DIRECTORY | O_CREAT
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 21, 2023 at 7:03=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> EINVAL ist keinmal: This contains the changes to make O_DIRECTORY when
> specified together with O_CREAT an invalid request.

Ok, that intro makes little sense unless you speak German ;)

I cut the explanation down radically, it's there in the original
commit, I don't think we need quite this much detail for a merge
commit for a change that is ~10 lines of code and not _that_ complex.

I did keep this link:

> This has also been covered in
>
>         https://lwn.net/Articles/926782/
>
> which should be publicly available by now. It provides an excellent
> summary of the discussion.

although it's behind a paywall, which isn't optimal.

              Linus
