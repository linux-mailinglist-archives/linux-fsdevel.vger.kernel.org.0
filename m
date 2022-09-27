Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C75EC33E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiI0Mss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiI0Msc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:48:32 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A51161CFC;
        Tue, 27 Sep 2022 05:48:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i16so5050520ilq.0;
        Tue, 27 Sep 2022 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9gDaL9YVBu3tbVyLgkWJ9ypm85wNRW4z2AjB7yERbF8=;
        b=Hj/xPB/IR2JzM5v82MR6Pc2QdWG//UCG+5mtmTep8jIUc/w2cJMsuuPs0BxE8mWkdd
         K0dKoPPcIKHeAsrM/4wjo82Zfji4FjDenmqXBslRRPQTHm8qzb40/eBEYrDnygOXaIdt
         BUexLU0SRUeFRdesx9EldFKhqGKCLf0NMzgSjjrPg/PVqafTYWv/+sFxDtS9DSijdBSg
         L+An79cFPMVZMBKIkeRZMfa+fsw4HgGl8CU5WReHpOhQ45/HtIwd2s3ue398TaxHc2n3
         t/T2QTx/ElFyGHws6MIpIrtOT9Gegim+OeGH+kZX9N66PmT5aER8N1tJZH3EocH5Ahtc
         ip8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9gDaL9YVBu3tbVyLgkWJ9ypm85wNRW4z2AjB7yERbF8=;
        b=NFJU2GIho+bNuMh7JiFxzoOc72RDOWj1nRwGwGmza8dnG7QaTe+DfJMT60mTH8DK+E
         fDoelcrRH/Kehd+ZfkmVS29NnxiqtcxvjM2I4Fr+hziqBaLnFnnjO0amPQPWlJ4GONas
         5xDwhcJ9yCY3TVwoFEWzdoYltXMUy9HKgVyOf2vupqfv7FbTqhIl4FhqFqCMzgjRV4aK
         M8Ch9xTKQhGoIq3Etd9/afwnsrpXC4DdcUG6t9FQ/ISknvZ66jTPCrass+Yr+eoJcrXh
         ppCX+6VHGMaWMKcCBRaRy/b1UvDHhaQlyqTRoS5dGD29pu3h/HzM9xRI72+y+g2YnipC
         6kIA==
X-Gm-Message-State: ACrzQf38v549MVFfqZy8xYWp3fEyMFGWWAe/LfYE1eE7Plj5eNJ38GiQ
        LBBBAy+extI1QDU7rmO7ck7q0spK8ThejsiK32Q=
X-Google-Smtp-Source: AMsMyM4S1pt68/znq8Dld0WeOSq5D8rhwB9oDs25ZTH2YllCybfv3fb1w/tu1Q7HwsOj2NUxlk8ypJkkUJ7hqMNRK2A=
X-Received: by 2002:a05:6e02:1aa5:b0:2f8:739:c48 with SMTP id
 l5-20020a056e021aa500b002f807390c48mr8060152ilv.72.1664282910137; Tue, 27 Sep
 2022 05:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-2-ojeda@kernel.org> <Yu2cYShT1h8gquW8@yadro.com>
 <202208171235.52D14C2A@keescook> <Yv4AaeUToxSJZK/v@yadro.com> <202208180902.48391E94@keescook>
In-Reply-To: <202208180902.48391E94@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 27 Sep 2022 14:48:19 +0200
Message-ID: <CANiq72nQJe4gHa2od3+MuRDbTQU7vvO1o9v1mHgmJcPST9VJZA@mail.gmail.com>
Subject: Re: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
To:     Kees Cook <keescook@chromium.org>
Cc:     Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        boqun.feng@gmail.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 6:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> Oh, that's an excellent point; I forgot it'll actually compile-time
> error if the var is a pointer. +1

In this case it doesn't, because `scripts/kallsyms.c` defines its own
`ARRAY_SIZE` that doesn't have the `__must_be_array`.

I have changed it for v10 anyway, since that way we may benefit in the
future if the `ARRAY_SIZE` here gains the check.

Cheers,
Miguel
