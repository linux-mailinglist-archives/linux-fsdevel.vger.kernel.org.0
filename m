Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9B6CF488
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjC2U3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 16:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC2U3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:29:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB24EF2;
        Wed, 29 Mar 2023 13:29:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so68316852edo.2;
        Wed, 29 Mar 2023 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680121760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PzO45Itb2rhyqvuxYhW+Lzip9Sn5S9p47n8/nUNslV4=;
        b=PAlLl8AeMeBq78D1ANa2vKZm2xx9C32v5VhgKyPwI6kR5eo1VkvG0dIj6RlfQSo50a
         WAhrsB8vXQdMfGek011eRWA44tIjAk0avPq/0Ek/29YmaBotOPSOMyC7j21UPnI9UIG7
         BNxjqgGHKXUBAkD7J5UYgdX4VEe9KHXQef9HmxclVnxurRrlT+JnAZIXh3XHSj9w/grP
         ovc+XMr7pguuuqJkPz48YnEwsNmwYA5xJ7DVp1jfqbIJAY2bknliBSs8HLLarXrtfL08
         0KtwCdiCSxe1Grk5SSONFGq8VaqVhuaPB5EVUB+kMj5pp+iYkSzX4RhknTV5B54CCjY3
         Ec2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680121760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzO45Itb2rhyqvuxYhW+Lzip9Sn5S9p47n8/nUNslV4=;
        b=fY+/lwwBLUYVRGXFW3AbSyq2pIYjhOJDZBjOs3n6nyHNndTvhhlPyGnY9KG/mtelJw
         nCqGYIEKGvNfMHB5sCwim6hYl6EPHo1ttoPn0XJESwkhOjDRvW+MisWZ928iefM31qr+
         QvHLGzltV9vfqWmVWmuPR5R1RQb2+V3mEepkEtHrBkR37HAyhHVEuYAr4Ila+Bhjbk61
         APYm6v1uW/FyKgyDyO9gbGNm8cF9EJ4I8tolzvcmOA91JtDkeSuqvsmpCqujKUd3R3EW
         fvLkgjXEY8gJDbQptrYKZHasM5gUbIuur0yHMoLOp0xeR0Kt3RCNfFg3dWbCcK9zHUYP
         Y+RQ==
X-Gm-Message-State: AAQBX9dHn6ROMSTMtBUDSfWhAfy6aeeIVeXDBpr3giA9fL+qHyywD9XF
        9r4eCLLqYVPF9ajJnARueZFzo/mM4f+IJcRc6W8NnZFt
X-Google-Smtp-Source: AKy350ZIQhFkWw+W1s3nEjbVfelaXBIeDZXZ7kuap/QQL1GT9LO34SBwNB4Z41s92akJsCUeXEx40kWeU741u3fqbpI=
X-Received: by 2002:a50:d705:0:b0:4fb:7ccf:337a with SMTP id
 t5-20020a50d705000000b004fb7ccf337amr2063532edi.3.1680121759989; Wed, 29 Mar
 2023 13:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202406.15762-1-ddiss@suse.de>
In-Reply-To: <20230329202406.15762-1-ddiss@suse.de>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Thu, 30 Mar 2023 06:29:07 +1000
Message-ID: <CAN05THRvaQ_8T3aMa-MZSniANizrqtO9UMJnhzZbfc4MPV3oyA@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix DFS traversal oops without CONFIG_CIFS_DFS_UPCALL
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

reviewed-by me

On Thu, 30 Mar 2023 at 06:23, David Disseldorp <ddiss@suse.de> wrote:
>
> When compiled with CONFIG_CIFS_DFS_UPCALL disabled, cifs_dfs_d_automount
> NULL. cifs.ko logic for mapping CIFS_FATTR_DFS_REFERRAL attributes to
> S_AUTOMOUNT and corresponding dentry flags is retained regardless of
> CONFIG_CIFS_DFS_UPCALL, leading to a NULL pointer dereference in
> VFS follow_automount() when traversing a DFS referral link:
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   ...
>   Call Trace:
>    <TASK>
>    __traverse_mounts+0xb5/0x220
>    ? cifs_revalidate_mapping+0x65/0xc0 [cifs]
>    step_into+0x195/0x610
>    ? lookup_fast+0xe2/0xf0
>    path_lookupat+0x64/0x140
>    filename_lookup+0xc2/0x140
>    ? __create_object+0x299/0x380
>    ? kmem_cache_alloc+0x119/0x220
>    ? user_path_at_empty+0x31/0x50
>    user_path_at_empty+0x31/0x50
>    __x64_sys_chdir+0x2a/0xd0
>    ? exit_to_user_mode_prepare+0xca/0x100
>    do_syscall_64+0x42/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> This fix adds an inline cifs_dfs_d_automount() {return -EREMOTE} handler
> when CONFIG_CIFS_DFS_UPCALL is disabled. An alternative would be to
> avoid flagging S_AUTOMOUNT, etc. without CONFIG_CIFS_DFS_UPCALL. This
> approach was chosen as it provides more control over the error path.
>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  fs/cifs/cifsfs.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
> index 71fe0a0a7992..415176b2cf32 100644
> --- a/fs/cifs/cifsfs.h
> +++ b/fs/cifs/cifsfs.h
> @@ -124,7 +124,10 @@ extern const struct dentry_operations cifs_ci_dentry_ops;
>  #ifdef CONFIG_CIFS_DFS_UPCALL
>  extern struct vfsmount *cifs_dfs_d_automount(struct path *path);
>  #else
> -#define cifs_dfs_d_automount NULL
> +static inline struct vfsmount *cifs_dfs_d_automount(struct path *path)
> +{
> +       return ERR_PTR(-EREMOTE);
> +}
>  #endif
>
>  /* Functions related to symlinks */
> --
> 2.35.3
>
