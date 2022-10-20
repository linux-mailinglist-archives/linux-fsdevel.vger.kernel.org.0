Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D5606857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 20:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJTSlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJTSle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:41:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B17207534
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 11:41:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s30so907170eds.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qtnB/MwvbTjXeKKfpQsFeKxiqtv7J6lbuiX2ef347f8=;
        b=JEzVASD5hQSQCFMbjuxU4kIkd4dfE3gGlj6XapIM9gQnvQ2D/77370KfKsyAzmKZpU
         yGsi7msFDBs9JXuMZblq6ZKGs2vcHE7SdZCsFck+fxswIdVNs1rw/9iomevy8XryvP8o
         qKLDP2lN2K3N9SpEunEdtw346WZI0y6r0fMYv57v++ay52CYXtY1Jrcclc3K65V0BQEz
         MVmj7wndJxH9pHA1Rao7yfOtm/gMsi55s5J+deBtMUbhDfi7VQCQ5HuBK/si+/hfxwsZ
         gqc2Ry99ffDqZDnSm8ICz83E+20CTf80PqaL5vNlcea2HiKknE/EMTRhAQIIM9wS14V2
         VbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtnB/MwvbTjXeKKfpQsFeKxiqtv7J6lbuiX2ef347f8=;
        b=XgQc9hdWk8sXzeR2D6cfpViJwtact9caQnCC5O2r+ZfR6c0qpJ7OE1yf36EukCUvhR
         9HFNXpF/T6Dfwc8FQR2MR2g7s6r6iVPRP9CCzVMuQJgyFSz0DFScl2WI66Ea5tWajsIW
         sUxoFXqbUszzQoW8hJuMwxLAKkFsY1ds7j4fRCen93rxUCFf8q63l4nVTkNZjC2RHy9L
         Z3KCplgtHP+vzPCpsBFhZWmETpC9bUJKFjEm78bwxNENNyPk76nOXcYKwSqUAvS+c5jc
         Kx15ze+SL4iChDfDUDlbwpiMcG+9AC1dh3Ir12u9TYx/fqhTwvkDuGvKGvjPn+PvWnmy
         oXeg==
X-Gm-Message-State: ACrzQf0hde8NqZfENwfTkT9uOS85+WwQh/ZzhjRDjvbFAWk09BzCBnMe
        LJb4rDlJcojXjBd5Uq6cO3xYJP4Z28CR14Le7k0=
X-Google-Smtp-Source: AMsMyM7uJ2erWZ+H89szHmQKRP3kQr++ZMg88dSxK5e+UkCTueaFhC6wWdEpdoXhL3zsJIC/QPRpzVLhfnFS9txH8+s=
X-Received: by 2002:aa7:cd10:0:b0:45c:2c83:1208 with SMTP id
 b16-20020aa7cd10000000b0045c2c831208mr13169675edw.81.1666291291020; Thu, 20
 Oct 2022 11:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221020183830.1077143-1-davemarchevsky@fb.com>
In-Reply-To: <20221020183830.1077143-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Oct 2022 11:41:19 -0700
Message-ID: <CAEf4BzZE9Sq-Ho=64F=B1C_k-wN4Wkk75j3qJrWRbjDFW3YbUw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Rearrange fuse_allow_current_process checks
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

On Thu, Oct 20, 2022 at 11:39 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
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
>  fs/fuse/dir.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 2c4b08a6ec81..070e1beba838 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1254,11 +1254,10 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>  {
>         const struct cred *cred;
>
> -       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> -               return 1;
> -
>         if (fc->allow_other)

{

> -               return current_in_userns(fc->user_ns);
> +               if (current_in_userns(fc->user_ns))
> +                       return 1;
> +               goto skip_cred_check;

} ?


Otherwise, makes sense, thanks!

>
>         cred = current_cred();
>         if (uid_eq(cred->euid, fc->user_id) &&
> @@ -1269,6 +1268,10 @@ int fuse_allow_current_process(struct fuse_conn *fc)
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
