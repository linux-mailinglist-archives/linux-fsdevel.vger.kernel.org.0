Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B227601FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 00:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGXWE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGXWE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:04:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D446A10D9
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 15:04:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so6113903e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 15:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690236265; x=1690841065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi9QF+ezCeeyehvtVZ4C7/mvj+DDfBkK4HVduZqN9YM=;
        b=VlCmbuWK7dSqWRI5Eg+b7TWUQktclr/SkHYXZrKnYik2x0aBvELIjYCRsCd26iv8T0
         i88uGHFfnkcjmWjvZhUUqrDPQ9HPuMuDAkEumLwrU3h/KMs5mQIwKJ9+y6f3bASs8oOm
         /cseRaC7aK3i5QscJgbEl/aAqA4goAwnQ+4WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690236265; x=1690841065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi9QF+ezCeeyehvtVZ4C7/mvj+DDfBkK4HVduZqN9YM=;
        b=I3Fr7MaHKWzfNcLgKWgYZuaRE4dnDe0EQYQFPBS3DdNRc6p04twNj6Hk5O/4s8kJvP
         sXCwyddZi6EaXQmV4LsUBGrd6oWauLQjTXoKL+PhMWnbWqjRm+WEDYQfuse5k9KAI979
         0KDNFFItDMD8KtpBQmj52/Y8JJMWOD6GgL8dO97RVi2Er3DJVp6pSinhe+7M+SHXf9Yu
         4w9UBRcoi06gpBkriT94lBg79bj74ry+ps8beItnTeVC+lL+8Z1xW6Grh9m+0RLzPhYL
         wELKYFJsPA/VnSgqK/3ewg2+rKb2hHNk0d7xzhvFKWlR8uwl1hX2XjJifCMGhWksnpZT
         I8eg==
X-Gm-Message-State: ABy/qLaIpT3+BvOOm8CUubE8K5bMVanB05tEjMAmlb9Dh4q/LhQvDlBG
        jp2/mjT95PDdvUamOpsloYikzOKtG0bAUmEmxVzG3wroY+0YI22Tbwk=
X-Google-Smtp-Source: APBJJlFlKDSHef/dw8Nqo573c6JM9iKNIp+ELSXm/aT1ZNYrMaUlfCXk+81jiLMMFNB/icAOAykjFEsklFxJ6PMmk54=
X-Received: by 2002:a05:6512:108d:b0:4fd:d1a0:ec8f with SMTP id
 j13-20020a056512108d00b004fdd1a0ec8fmr170469lfg.13.1690236264996; Mon, 24 Jul
 2023 15:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <CA+wXwBR6S3StBwJJmo8Fu6KdPW5Q382N7FwnmfckBJo4e6ZD_A@mail.gmail.com> <ZL7w9dEH8BSXRzyu@dread.disaster.area>
In-Reply-To: <ZL7w9dEH8BSXRzyu@dread.disaster.area>
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Mon, 24 Jul 2023 23:04:13 +0100
Message-ID: <CA+wXwBQmusp49-b6cU-hPAoOnpTiuvA2QrjaOSyb-EvKigC_Ug@mail.gmail.com>
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:45=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Mon, Jul 24, 2023 at 12:23:31PM +0100, Daniel Dao wrote:
> > Hi again,
> >
> > We had another example of xarray corruption involving xfs and zsmalloc.=
 We are
> > running zram as swap. We have 2 tasks deadlock waiting for page to be r=
eleased
>
> Do your problems on 6.1 go away if you stop using zram as swap?

We had xarray corruptions even on nodes without swap, so I'm not sure
if swap matters.
The corruption on those nodes were noted in the first email with the
following trace

 BUG: kernel NULL pointer dereference, address: 0000000000000036
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 18806c5067 P4D 18806c5067 PUD 188ed48067 PMD 0
    Oops: 0000 [#1] PREEMPT SMP NOPTI
    CPU: 73 PID: 3579408 Comm: prometheus Tainted: G           O
6.1.34-cloudflare-2023.6.7 #1
    Hardware name: GIGABYTE R162-Z12-CD1/MZ12-HD4-CD, BIOS M03 11/19/2021
    RIP: 0010:__filemap_get_folio (arch/x86/include/asm/atomic.h:29
include/linux/atomic/atomic-arch-fallback.h:1242
include/linux/atomic/atomic-arch-fallback.h:1267
include/linux/atomic/atomic-instrumented.h:608
include/linux/page_ref.h:238 include/linux/page_ref.h:247
include/linux/page_ref.h:280 include/linux/page_ref.h:313
mm/filemap.c:1863 mm/filemap.c:1915)

It's hard for us to run tests without zram swap at scale since the
benefits are significant with a lot of
workloads.

Daniel.
