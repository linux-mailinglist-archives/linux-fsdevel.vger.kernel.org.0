Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3C59FAED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiHXNLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 09:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiHXNLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:11:17 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92A1EEC4;
        Wed, 24 Aug 2022 06:11:07 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3321c2a8d4cso458804777b3.5;
        Wed, 24 Aug 2022 06:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PBMgiKITqVFe9ipKJMfcHRkx37YurSW2KouZuSOxvmo=;
        b=zllMmw78L9nbU/nNazuF8ix2jRzBRssjJ7xVWzHgMeCTlxfIxrekLTlKN4elP2EIF3
         MYelY3Yq1wVUIqcXBCCIYtZ625+Bio/OFGtb1GORuPt7HEYtYAL7xA0E6LUg6AZ0ZtyN
         SmBORz+7/Fqx/EazdjmapPXrMNRLjWkqZpYzoBUhq/vFMsWAc6zTcZ/8ujyaYAu+EE48
         3DuIxoD3AHq2E6GZnfo6aumVyOrsUJHizKEJ4GCkDKY+5bqXwWbxxpxyS8y8R+kiR5mD
         EQ9ki6x84vSOQgxfGIetIsOF2ffTkgki9KkPYHkUnkQoAWjajvSov5pNKXCHV4rRYHqK
         X6fA==
X-Gm-Message-State: ACgBeo0lAPFVimdTjik4rjXh9iQMj3cHXloATHDgxlbSrLGoelbKClHM
        dE+n6ai+KYnwM8HVpb6g69VFnmZv4k16zOjzBPk=
X-Google-Smtp-Source: AA6agR62tJ8S9HOpJZQz5VLSfKhkCpn7RiNHfYE77AQwGBkfA6rm8VSjZhA9q+pokze+xAMH6HUruQA79TgT4Qa34xo=
X-Received: by 2002:a0d:da83:0:b0:329:9c04:fe6d with SMTP id
 c125-20020a0dda83000000b003299c04fe6dmr31037608ywe.196.1661346667024; Wed, 24
 Aug 2022 06:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220824044013.29354-1-qkrwngud825@gmail.com>
In-Reply-To: <20220824044013.29354-1-qkrwngud825@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Aug 2022 15:10:54 +0200
Message-ID: <CAJZ5v0jmDeGn-L6U-=JOxOHVy3CRS8T5Y_06F50cL9bjUhgbPQ@mail.gmail.com>
Subject: Re: [PATCH] PM: suspend: select SUSPEND_SKIP_SYNC too if
 PM_USERSPACE_AUTOSLEEP is selected
To:     Juhyung Park <qkrwngud825@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        chrome-platform@lists.linux.dev, Len Brown <len.brown@intel.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 6:41 AM Juhyung Park <qkrwngud825@gmail.com> wrote:
>
> Commit 2fd77fff4b44 ("PM / suspend: make sync() on suspend-to-RAM build-time
> optional") added an option to skip sync() on suspend entry to avoid heavy
> overhead on platforms with frequent suspends.
>
> Years later, commit 261e224d6a5c ("pm/sleep: Add PM_USERSPACE_AUTOSLEEP
> Kconfig") added a dedicated config for indicating that the kernel is subject to
> frequent suspends.
>
> While SUSPEND_SKIP_SYNC is also available as a knob that the userspace can
> configure, it makes sense to enable this by default if PM_USERSPACE_AUTOSLEEP
> is selected already.
>
> Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> ---
>  kernel/power/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 60a1d3051cc7..5725df6c573b 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -23,6 +23,7 @@ config SUSPEND_SKIP_SYNC
>         bool "Skip kernel's sys_sync() on suspend to RAM/standby"
>         depends on SUSPEND
>         depends on EXPERT
> +       default PM_USERSPACE_AUTOSLEEP

Why is this better than selecting SUSPEND_SKIP_SYNC from PM_USERSPACE_AUTOSLEEP?

>         help
>           Skip the kernel sys_sync() before freezing user processes.
>           Some systems prefer not to pay this cost on every invocation
> --
