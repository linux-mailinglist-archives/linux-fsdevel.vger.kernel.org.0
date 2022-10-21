Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E582F607BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJUQFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJUQFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:05:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB71552D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 09:05:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m15so7577625edb.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81SQss1GBV7vV6S+0FxRP2b7mcaaA8q9Ha/eQ1PJyt0=;
        b=oOwZvecqglL1RVwiRXJ1umf6Huk9IZN6aLn82XEnEwz9t7ngnTLw1uYr8Ma3UWcYhW
         KFJrmTfn79fFVZdMIxIKh6p7GHtesZ+5/veAJ4BB+bvElZEBE1Zfbl+aXz/IT5Go9Ugp
         G5eEi9deUXpqLkY987wtf39hHGb/QY7E5Sz54vY8AOgz2sVfXM/x7LGCjKw1+Bzl0Tjd
         +BZibNxCGcbpNrv5jgyKH9mRwxGuWY/NgZtEhfwIB56qXicYmQUnFtFbfUwqPxQNQdL/
         fkzFJanZ/xDo+TCIYnh5c32bYAddmh2SG1sheo3agXf2nu1I8UfXhNm6zzPjvvg89gFU
         muIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81SQss1GBV7vV6S+0FxRP2b7mcaaA8q9Ha/eQ1PJyt0=;
        b=MOj3rJB80I22toFblFrj94+YjMURTcKLwFMRxSVsDbeS692qha6QMBEFxo4Ki1Eg9B
         slvUgxcNDEChkmUTLhSoosSGgv1JVLj1ZothnkrRcNuwsgNAn6ljt42iNkGX+inzpYWW
         FJ2r7uyjHbNeOq0sSBrv3jIMM066dYHyIUfBkbC5vhiz1JRbtAtvDWT1aCcA0zi7umkv
         kay3RrDTafstOLgFSqsK+gA/eTp4ZEqQ6z0Yv/XN3JMY8YTh7cL0L67JxoNkpRGd/vL1
         QpzDzDmOKGmx6UOnOPmcaYDFj9ENtm16rkQSxzxMmSYsoGdMV7egc8gaWNiYFEmzeqVU
         TXIg==
X-Gm-Message-State: ACrzQf3rXDGVorGh+OPBWhAgpLP1/7kg6uk/M/773lt9U7N54XzAqV5C
        YGwx9gCUqq6dtFYaWuLkN8xKsDrZ/eq4QM5wmipfpA77YLs=
X-Google-Smtp-Source: AMsMyM7qz7ANUcGISSzWjLaP1Ay9duwUY+F65jYHyeIjgfkfIuW3nqtAUMuEsZ7cB9Q1JiSFYcvJhi2/yexwUWF1fN4=
X-Received: by 2002:a17:906:dc8f:b0:78d:f675:226 with SMTP id
 cs15-20020a170906dc8f00b0078df6750226mr16256073ejc.745.1666368338026; Fri, 21
 Oct 2022 09:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221020201409.1815316-1-davemarchevsky@fb.com>
In-Reply-To: <20221020201409.1815316-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 09:05:26 -0700
Message-ID: <CAEf4BzZi4jnyXi1OAVrQ+k0qTJdRViU6-T+oeUUeTZXTF8V5bA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Rearrange fuse_allow_current_process checks
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christian Brauner <brauner@kernel.org>
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

On Thu, Oct 20, 2022 at 1:14 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
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
> hatch' is checked last. Previously, if allow_other is set on the
> fuse_conn, uid/gid checking doesn't happen as current_in_userns result
> is returned. It's necessary to add a 'goto' here to skip past uid/gid
> check to maintain those semantics here.
>
>   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> ---

LGTM!

Acked-by: Andrii Nakryiko <andrii@kernel.org>


But I would also be curious to hear from Miklos or others whether
skipping uid/gid check if fc->allow_other is true wa an intentional
logic, oversight, or just doesn't matter. Because doing:

if (fc->allow_other && current_in_userns(fc->user_ns))
    return 1;

/* do uid/gid check */

if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
    return 1;

Would be simpler and more linear logic, but I'm not sure if there are
subtle downsides to doing it this way.


> v1 -> v2: lore.kernel.org/linux-fsdevel/20221020183830.1077143-1-davemarchevsky@fb.com
>
>   * Add missing brackets to allow_other if statement (Andrii)
>
>  fs/fuse/dir.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 2c4b08a6ec81..2f14e90907a2 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1254,11 +1254,11 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>  {
>         const struct cred *cred;
>
> -       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> -               return 1;
> -
> -       if (fc->allow_other)
> -               return current_in_userns(fc->user_ns);
> +       if (fc->allow_other) {
> +               if (current_in_userns(fc->user_ns))
> +                       return 1;
> +               goto skip_cred_check;
> +       }
>
>         cred = current_cred();
>         if (uid_eq(cred->euid, fc->user_id) &&
> @@ -1269,6 +1269,10 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>             gid_eq(cred->gid,  fc->group_id))
>                 return 1;
>
> +skip_cred_check:
> +       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> +               return 1;
> +
>         return 0;
>  }
>
> --
> 2.30.2
>
