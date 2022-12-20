Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5923B6529DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 00:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiLTXbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 18:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiLTXbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:31:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D31FF8D
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Dec 2022 15:31:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v23so8755779pju.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Dec 2022 15:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zre1kotzR+gyUnyjZM5SkqNzTaEPBauNGGmkiFmJLxA=;
        b=Nf1RbDbe6Y7p3znBVUX7koicto5J7BA6jgcX2c87vxea33bkv885eV83wfLPpyOMZX
         FPwkPEZYpZIEIEUQjPIVz5H2c9MVNo82yrmz8ZPbwQigqsTOIDcGNVH7wkSEssQ8Pl99
         u/q9rzfa2e3pi0GXOnhRM9WLI8JoeUI5Lx8PpVTz6+AkAYPQZvO67Bog+UXvM490HitC
         Mj6HC927l+M2MGRLlR07qQgp+ObRq4x/YEemGN4ULFMdxTHJzoIO1zc4urBglPkPkWDG
         tnT7vR0Lhix+ILtzZUJEqSvCWy76VA7dSJhWfywRVAwnMNJFKscL+XE0pduN+GsViM81
         WVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zre1kotzR+gyUnyjZM5SkqNzTaEPBauNGGmkiFmJLxA=;
        b=7TaGHkP0AOBKdAEFq6c215OlRBs46ILgD1VF9eUXomSwbPzzRh14uht0zvPn6+DtqU
         rUtMAbIYDpfd+ZmYSwfj8UJg5H91hSZJ3G66mT8nQtinvbBwnjX7M87MLEqFVma1aU8S
         rqnMVDfWuQLfO/wDt+mchrYbfhOIzcv4/9vRToYUfseISqhik6bxu0Gr8HphD0O7MPkf
         BVcg4rc6cHM/05nWV9hZo8vuCqpmvxuGau4iyWyN/7DWp4Yby2e9vGNL3Oa9Kv9j9HpT
         aP0a5LA12vABBBM3lErQSAKNP7qRZGX4EiG1QOCQi7/IX9bPDAa4ivoJOutF4L3GsLsq
         /YsA==
X-Gm-Message-State: ANoB5pm/yrFniAkbZGzd2Qz/ClVy14OTsXRHegGifEyXhjahs48PQdIt
        Pybr+R3VwaDt7WcYuxHPTqUjQXoLQ+gXqBvpufJo
X-Google-Smtp-Source: AA0mqf7+YJR0aQlb22cA8u1ukv0bd+pXUGYeqBMNcL0hZcYc3FUyoIGarrrn28B0nOfNbTsag/TgPOEscRMb7Pf8iqk=
X-Received: by 2002:a17:902:9892:b0:186:c3b2:56d1 with SMTP id
 s18-20020a170902989200b00186c3b256d1mr81913259plp.15.1671579067046; Tue, 20
 Dec 2022 15:31:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670606054.git.rgb@redhat.com> <33f683794883676be88e503594ba094db2ff6bbb.1670606054.git.rgb@redhat.com>
In-Reply-To: <33f683794883676be88e503594ba094db2ff6bbb.1670606054.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Dec 2022 18:30:56 -0500
Message-ID: <CAHC9VhTyqAvevFFBwB0NLGRB9wwgp22VH_vDXq-FbjzL63A2cg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fanotify: Ensure consistent variable type for response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 12, 2022 at 9:06 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The user space API for the response variable is __u32. This patch makes
> sure that the whole path through the kernel uses u32 so that there is
> no sign extension or truncation of the user space response.
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/12617626.uLZWGnKmhe@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.h      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 6 +++---
>  include/linux/audit.h              | 6 +++---
>  kernel/auditsc.c                   | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (audit)

--
paul-moore.com
