Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC20A5F5E51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJFBLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 21:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJFBLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:11:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320544150A
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 18:10:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-354c7abf786so5156257b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Oct 2022 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd6uSgjH1+Yt+U7MvGJA0bVOBesvmMMXybPQlHwpLU8=;
        b=dQD5/Hi56H7YE2l1G+d6UMrNAiTB/eymMdbuJOr7YWNuCh4+aDTv4xamvZrzrdhw5Z
         5Q2akDPDSTkI+2UDB2B85ky7RGLQKdxmFEutX6OjSHHEJv0CculN0D3r0zVIwO71SMjS
         9gQmBpCWPrr0V3q2OxUGGDW6Kte2uJvBGKpBHhinReEa0AtW+HydOieI+iIgc1ey/0lR
         6P14xyNSrX0BsYl0IoUItQYuas3adwL8FVP1BlgwYsIl9idxE5qJzs9/qmf2BnpqPSCa
         j+CypBSy6MVEas51zjYtlduisMIM3xpeBhzGa8kj5b5zn/t8kwBo6IFN9d3FQbpnpJS9
         3F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd6uSgjH1+Yt+U7MvGJA0bVOBesvmMMXybPQlHwpLU8=;
        b=7xP+PFZVmGfXI22+aHIb1jaa23AxyTproeOHgPjGlTzlwgLPnNntT7eP+HuVFn0e1O
         J6rSexP1aeuGDsgOSjr4GwOZHg0vA73nCuzt+6W6sFoyoGd6wtwwrwnTQ5VK0S2HbHls
         vP86ksDlZIuPE5D1pLjfeku13uzkcfGQxWy+7h/gOzihvM5cN87hQeMZa/UpfZRMB0W8
         u9pMVX71bTdtXPAjJdI0TQuxH8eHUwy0QJrKZdgi4Rfe4Zje10bmXwT8ZSjYeVldaOOT
         kiaFbJi0DF8tK+hGkUlDlmENwK1e6zAbefYjafXSQJnQqdwnEp5ozHk9oovSqRKGuUDS
         erYA==
X-Gm-Message-State: ACrzQf1iskOhVY3nVmSCzUAiJOR7y9SmwsbihasX++IX+iLg0mK37QSb
        7RbWu7xubiTE/5cJqt3eH9cQIyPgfvB3j1SBukrQ
X-Google-Smtp-Source: AMsMyM4xPUs8z6Cc1VNpk6wu4Gy3keHf3cvXZlVatZFo61KH/uy5JR1qmd8ZH0BhcOeT9mVzAt8Ryr3VwA2/4zeI1Vs=
X-Received: by 2002:a81:1b09:0:b0:35d:cf91:aadc with SMTP id
 b9-20020a811b09000000b0035dcf91aadcmr2440333ywb.47.1665018657331; Wed, 05 Oct
 2022 18:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221001154908.49665-1-gnoack3000@gmail.com> <20221001154908.49665-2-gnoack3000@gmail.com>
In-Reply-To: <20221001154908.49665-2-gnoack3000@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 21:10:46 -0400
Message-ID: <CAHC9VhRB1h4syH_5=Ezg5uAvxbVQ-Va8eRhW5rdLJZQ-GafqEA@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] security: Create file_truncate hook from
 path_truncate hook
To:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 1, 2022 at 11:49 AM G=C3=BCnther Noack <gnoack3000@gmail.com> w=
rote:
>
> Like path_truncate, the file_truncate hook also restricts file
> truncation, but is called in the cases where truncation is attempted
> on an already-opened file.
>
> This is required in a subsequent commit to handle ftruncate()
> operations differently to truncate() operations.
>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  fs/namei.c                    |  2 +-
>  fs/open.c                     |  2 +-
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     | 10 +++++++++-
>  include/linux/security.h      |  6 ++++++
>  security/apparmor/lsm.c       |  6 ++++++
>  security/security.c           |  5 +++++
>  security/tomoyo/tomoyo.c      | 13 +++++++++++++
>  8 files changed, 42 insertions(+), 3 deletions(-)

I agree with Micka=C3=ABl's comments regarding the formatting, but
otherwise it looks okay to me from a LSM perspective.  If you make the
whitespace changes you can add my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
