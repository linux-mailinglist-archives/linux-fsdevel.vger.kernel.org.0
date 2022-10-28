Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED16111A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJ1MhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 08:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJ1MhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:37:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915CD1D0D4F
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 05:36:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt23so12560582ejc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lnBIvnEmu8md4JAy6d4IvtwIG1CiNt10YY8UZ7j8GLk=;
        b=MDD/oceh5Gr8PNpsmQxp3pN8f46/sCEwM/7FOc8tglZDF+63wUgujKHt7ltqyNyhth
         p4ru+oXDoaqqwdK4rP9p3GQ0E5Brd6dDuOIf/JB0d5e4yIlnDqq/Sf54JlTKIz6DQo3e
         TQm0ZLWKD7VHI3W+2TwRErF+lKpyKxd8cAOEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnBIvnEmu8md4JAy6d4IvtwIG1CiNt10YY8UZ7j8GLk=;
        b=IqarToAOj0l3cWGUD11iJM5sizA5xKh+dbSlyYcC5WfJoOTsShIyXhAftrjNlRRJHJ
         /NRtumtlQ4gcG/PL510lL/UTAbSV1P+2oisP6+47GXpn3UCQyVi3ggUpeMV2AMSgDOTJ
         r8Im0A2d/Dc23klVtn3lDwvPTiEXCZ+/P7I1zQL/JF+7Z04tBz3nvRhEpsxzb8kitw2f
         hXlYauQwL6KkEiXwvMpdg5BGnBnsHqwiSQ72hGKHylJvaFAH2qX+uWg71Qu3PveDn/2q
         EpowB12lk8GYwEK0YgthY+Oq9g/pGlNKgG1IBOYd4pDLzclaVZo6zMeHFb1RpTuC8tg3
         pHeg==
X-Gm-Message-State: ACrzQf07nik6N4Vtman3Nxkx2gAEAdvnya0lKQ7+M1FYXG9vTWwxhZp1
        BULyvmFMo8BEWZ6o7xx5UvENKmz6kJT1u2Su71FWmg==
X-Google-Smtp-Source: AMsMyM5fMigTnXceu/KFhGFPorWzK2cExcv4ByDUuzSCYNspLTBbaK4cPDDkXJO/3XsolrZO+uVNlxCdUR5cs190oEk=
X-Received: by 2002:a17:906:5dac:b0:791:93de:c61d with SMTP id
 n12-20020a1709065dac00b0079193dec61dmr45983131ejv.751.1666960617137; Fri, 28
 Oct 2022 05:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221025161017.3548254-1-davemarchevsky@fb.com>
In-Reply-To: <20221025161017.3548254-1-davemarchevsky@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Oct 2022 14:36:46 +0200
Message-ID: <CAJfpeguMhXMaJ4TDSgxmjQXCpTHfUe=Y96fyPWyPpp9sK+c+yA@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: Rearrange fuse_allow_current_process checks
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team <kernel-team@fb.com>,
        Seth Forshee <sforshee@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Oct 2022 at 18:10, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> This is a followup to a previous commit of mine [0], which added the
> allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
> rearranges the order of checks in fuse_allow_current_process without
> changing functionality.
>
> [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
> beginning of the function, with the reasoning that
> allow_sys_admin_access should be an 'escape hatch' for users with
> CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
>
> However, placing this new check first results in many capable() calls when
> allow_sys_admin_access is set, where another check would've also
> returned 1. This can be problematic when a BPF program is tracing
> capable() calls.
>
> At Meta we ran into such a scenario recently. On a host where
> allow_sys_admin_access is set but most of the FUSE access is from
> processes which would pass other checks - i.e. they don't need
> CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
> call for each fs op. We also have a daemon tracing capable() with BPF and
> doing some data collection, so tracing these extraneous capable() calls
> has the potential to regress performance for an application doing many
> FUSE ops.
>
> So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
> hatch' is checked last. Add a small helper, fuse_permissible_uidgid, to
> make the logic easier to understand. Previously, if allow_other is set
> on the fuse_conn, uid/git checking doesn't happen as current_in_userns
> result is returned. These semantics are maintained here:
> fuse_permissible_uidgid check only happens if allow_other is not set.
>
>   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>

Applied (with s/int ret/bool allow/)

Thanks,
Miklos
