Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A351459FB77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiHXNgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 09:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiHXNgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:36:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5718B786C6;
        Wed, 24 Aug 2022 06:35:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h22so23313818ejk.4;
        Wed, 24 Aug 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YJF/VwA2mzDN6MSkPG2T+mKWxJTEYBZ1TSfzmhRiSak=;
        b=R9gl5wXeQfCG8uiYehnAeR3v/OEYCuTPDmd/1TNe0sotS6OatzHswNMV+vpydDeuZ+
         Nry6Uw7h6RaXcLOXUdUP1JO3/cqsz8UaaPA3D9ek55/RD3uHWHAz3nmJ4sfnx/uRPS57
         FsNKpwySB94vkx6KFQlV1JRnY1hoWZziD1C8HUquIpxYa0DNSP/np0MVmb9NzrMi/FNt
         H/p29EYX8l8mNG3XdMcZz8XTPlfHM8MP9K2VLaWA7J1trYkBBmpGqkrlqXCGoCQuTm0c
         ek833ROccmN71xDurLvPkf5+d06+GDQnhcXcvyGV5i0MKsyfz2nUo6Es5k1kjReVjE1t
         H71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YJF/VwA2mzDN6MSkPG2T+mKWxJTEYBZ1TSfzmhRiSak=;
        b=XYoNwsDNrIOWFLN2PoCQtacOt891x4TSDICzx7qgXhUUeOVm8thXy64B9XjHNUNNPF
         UQWHG8qt1gzjGB7rp0g4zb+odWAhdaZTNCy2QSw8wXJX8/sDIX4qyqicALSSHwa1D/FZ
         h/3A/ezQ2+bOcZR3dWAjecbt8BV88j6Fhqj795klxm/rvjOzt2I6sjGTRW6BAN1SDaGI
         7HINU/stLwBfl/6xniYrZDr80eZOjZm51rwsO/OiE+ZAW5p5DXyQU4kPK46QEeAYo8pn
         iKLVOcV+jFv5QPqbROi3WtkfICNlt2R92uoxk/NEbnkQfwbH8SBbnrPmxNhfS+SsD8lR
         YxrQ==
X-Gm-Message-State: ACgBeo3a2uc6bgk71wNrdVFZezFGSisyPtsiaXD4z9nhI/NktVKAMAhk
        3xh15C5mtks6Sm+bdHxQY7zRcXpes4CW2NxKWpo=
X-Google-Smtp-Source: AA6agR7lw/fobBjH73PzZWmf8nrsUxZFGAqZHhPw1j17fQTgk9/IfDwNCuXesiIgyvgw7r26L2bSENsYjKb7Qm06zF0=
X-Received: by 2002:a17:907:60c7:b0:731:2be4:f72d with SMTP id
 hv7-20020a17090760c700b007312be4f72dmr3004924ejc.639.1661348156634; Wed, 24
 Aug 2022 06:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220824044013.29354-1-qkrwngud825@gmail.com> <CAJZ5v0jmDeGn-L6U-=JOxOHVy3CRS8T5Y_06F50cL9bjUhgbPQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmDeGn-L6U-=JOxOHVy3CRS8T5Y_06F50cL9bjUhgbPQ@mail.gmail.com>
From:   Juhyung Park <qkrwngud825@gmail.com>
Date:   Wed, 24 Aug 2022 22:35:45 +0900
Message-ID: <CAD14+f1YEoqdnM8eTd2hUHSy+M4+AKQp6_FjV03TK=TSDxPfYw@mail.gmail.com>
Subject: Re: [PATCH] PM: suspend: select SUSPEND_SKIP_SYNC too if
 PM_USERSPACE_AUTOSLEEP is selected
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        chrome-platform@lists.linux.dev, Len Brown <len.brown@intel.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Rafael,

On Wed, Aug 24, 2022 at 10:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 24, 2022 at 6:41 AM Juhyung Park <qkrwngud825@gmail.com> wrote:
> >
> > Commit 2fd77fff4b44 ("PM / suspend: make sync() on suspend-to-RAM build-time
> > optional") added an option to skip sync() on suspend entry to avoid heavy
> > overhead on platforms with frequent suspends.
> >
> > Years later, commit 261e224d6a5c ("pm/sleep: Add PM_USERSPACE_AUTOSLEEP
> > Kconfig") added a dedicated config for indicating that the kernel is subject to
> > frequent suspends.
> >
> > While SUSPEND_SKIP_SYNC is also available as a knob that the userspace can
> > configure, it makes sense to enable this by default if PM_USERSPACE_AUTOSLEEP
> > is selected already.
> >
> > Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> > ---
> >  kernel/power/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index 60a1d3051cc7..5725df6c573b 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -23,6 +23,7 @@ config SUSPEND_SKIP_SYNC
> >         bool "Skip kernel's sys_sync() on suspend to RAM/standby"
> >         depends on SUSPEND
> >         depends on EXPERT
> > +       default PM_USERSPACE_AUTOSLEEP
>
> Why is this better than selecting SUSPEND_SKIP_SYNC from PM_USERSPACE_AUTOSLEEP?

That won't allow developers to opt-out from SUSPEND_SKIP_SYNC when
they still want PM_USERSPACE_AUTOSLEEP. (Can't think of a valid reason
for this though, as PM_USERSPACE_AUTOSLEEP is only used by Android and
probably Chromium, afaik.)

I don't think SUSPEND_SKIP_SYNC is critical enough to enforce when
PM_USERSPACE_AUTOSLEEP is enabled, but I don't have a strong opinion
on this either.
(We could do `imply SUSPEND_SKIP_SYNC` from PM_USERSPACE_AUTOSLEEP,
but that doesn't look good semantically imho.)

If you want, I can send a v2 with 'PM_USERSPACE_AUTOSLEEP select
SUSPEND_SKIP_SYNC'.

Thanks.

>
> >         help
> >           Skip the kernel sys_sync() before freezing user processes.
> >           Some systems prefer not to pay this cost on every invocation
> > --
