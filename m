Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31E4F8C18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiDHBWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 21:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiDHBWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:22:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9E14D03F
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 18:20:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n6so14237429ejc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Apr 2022 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CpBl2AGd626FECD+GIqEV6PBhceN/t8eGFzx+f7coUk=;
        b=3cPiceV6hD/ZvOf4gFgz+/Zbbb1qxTfbkNm4XV6V5+xHRZD/OwWXS0rT8rsxbHD5AA
         IXmkMGgR23uopQ7vhW5gxFcqnpbiYaxhY71cDh75hcRDbB3kJ98qpB6i+HBgSHyaFoAw
         poQe6uB/Nk6A7T1dk7kws1/GpzkcuhWzby3KtcTalLTu92PLzXSIfw+wihYnHcDRomq3
         XiVAzl5h9QxfyyG9nyGkjDICoKwRhiOjGRjpGaQPn70KJgqmpq99q4226V6jiemKN9kt
         Tc+H08w49VdTo/MxPl0R+CwjOzZO2Y/ATnGJGomCoLfbdpSKA6lue/maVB9gdrRAnUCm
         U7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CpBl2AGd626FECD+GIqEV6PBhceN/t8eGFzx+f7coUk=;
        b=G1vXLxPcm7Le2Zs2+uTmebUFoiLceXwk/+rk+1LS1xIX2vm/o7ierK/j165Zd5NUGt
         BovwmhQQD5JyGYwKAN3H5+Eqod7VjjhegP9eUGJvSifYf8Gl/LGuY7rY76XHwoMp6Y+O
         Vh/rL+nQT6LHhW25D0iBUv2d/ouZP4+J0SJ9MyOE3PFJpaVdUtYv0J4hZY0/wtQlTai5
         6sl7FlRVCR8DlMZH/fDCj688vRZdo2j6vglqbO50iS4ZapCNAOyyROsIFvE8teYNbjpM
         JGrJoLZHBTkHV7gL42Wv48TiGS2Lk2xbRLSPD0gTsm3V0pvV+Xc28L659Tjo2dLhJFts
         38uQ==
X-Gm-Message-State: AOAM532BmUAZ+xuCApOAMMcpEKIMI6ha73rYOu/yU1ged0yIhpg8jvgV
        nSDq0iPda8CKyyky5dYVIFXrq7XDsoO4p2+kVHTq
X-Google-Smtp-Source: ABdhPJwNkET74mR679RYTNFG2h05EKTSAGXbm9p/d1NNz5+zhishf2TSABELSlkCZxkK0XW+Qj9Ih8VcPHPiYGE0eec=
X-Received: by 2002:a17:907:9803:b0:6db:ab21:738e with SMTP id
 ji3-20020a170907980300b006dbab21738emr15515948ejc.112.1649380802771; Thu, 07
 Apr 2022 18:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220329125117.1393824-1-mic@digikod.net> <20220329125117.1393824-7-mic@digikod.net>
In-Reply-To: <20220329125117.1393824-7-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Apr 2022 21:19:51 -0400
Message-ID: <CAHC9VhQg0R5ddC_aLSAFyyf9OPs6wSyj3tqh1hwoN=RPpoDFuQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] LSM: Remove double path_rename hook calls for RENAME_EXCHANGE
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 8:51 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> In order to be able to identify a file exchange with renameat2(2) and
> RENAME_EXCHANGE, which will be useful for Landlock [1], propagate the
> rename flags to LSMs.  This may also improve performance because of the
> switch from two set of LSM hook calls to only one, and because LSMs
> using this hook may optimize the double check (e.g. only one lock,
> reduce the number of path walks).
>
> AppArmor, Landlock and Tomoyo are updated to leverage this change.  This
> should not change the current behavior (same check order), except
> (different level of) speed boosts.
>
> [1] https://lore.kernel.org/r/20220221212522.320243-1-mic@digikod.net
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220329125117.1393824-7-mic@digikod.net
> ---
>
> Changes since v1:
> * Import patch from
>   https://lore.kernel.org/r/20220222175332.384545-1-mic@digikod.net
> * Add Acked-by: Tetsuo Handa.
> * Add Acked-by: John Johansen.
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/lsm_hooks.h     |  1 +
>  security/apparmor/lsm.c       | 30 +++++++++++++++++++++++++-----
>  security/landlock/fs.c        | 12 ++++++++++--
>  security/security.c           |  9 +--------
>  security/tomoyo/tomoyo.c      | 11 ++++++++++-
>  6 files changed, 48 insertions(+), 17 deletions(-)

Seems like a nice improvement to me, and while I'm not an AppArmor,
Tomoyo, or Landlock expert the changes looked pretty straightforward.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
