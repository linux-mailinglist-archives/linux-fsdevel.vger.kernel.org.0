Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3A607400
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJUJ0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJUJ0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:26:16 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4CD14DF37;
        Fri, 21 Oct 2022 02:26:09 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id p7so629633vsr.7;
        Fri, 21 Oct 2022 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRt0MF7331zR5Ag7+1JIjxszPiAdl3Ci8P/Vs3dYn0o=;
        b=dv1bg3qY6nmZbE4+Okgh9ftZiz8zOpsZ7LlWiMZEe3yqXOl7940q7I7tIF+cPqaQxB
         gZlm7cN43XgbRTPkJhW7Ia92bdDNcGZKaB7t87ZtpeHzNSb0trKkEdiAw3PkZeudHmiE
         +0l3UAXXVYN7GACkX1COcSS5NUEmLVgL8ThqfKsC8+JYCxsv3TWE0rcg7+9BYrQ2J20v
         uNS4cFz+0B7+mJL8wOgXkj3XSSktwnp/pSJhgX+MHLPf1019pgarYERBZ6OC/C4RSLwp
         fGKczS3IiztCgWXWDhYuSBzj8mmu2jjF6GSOOuwVMNslo1cJLFizJXc0M0iWLY8Q52qG
         ZhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRt0MF7331zR5Ag7+1JIjxszPiAdl3Ci8P/Vs3dYn0o=;
        b=SfAjF8MMXae/7wErag2MI2aP1dcE9wVc+0Arc5rajsYHCAabEgkpiNmSvh9j7QcF8m
         rkoQo3Qv2an/Y7Dv8XGMJN+TByFGt9eSkVkLXo+1z8Wzh0EbUhzl4udCMpVGvfEwhEHu
         Q2aBMajsvo0a6+/SWBuJFX77aLkauhQEpgcETkQaIwdYCkzOlFTjhmkOb7lpsBWiRPzH
         hJMfefb7N5lk96zTxsVaD08SUtqyJM2/KzKhpzhcpWICFYt8EX8Ro8XOrpqqK+u+FTBh
         umq1OMyo2z1EaMPea7eQ7MsPZPwOIMDKmNgUdKvrHL/TEKH1BmlkF3PItcjJXaiBd/EN
         YF0w==
X-Gm-Message-State: ACrzQf2LrBVKcfhQhfF3UHOO2UAM6gIZ1WZYCFBxay1GpmvlFNpqZOr/
        6ZW/rdkSXlbomwQilLYoVk9rEgkYhMpzFKNBerbRoehqmdg=
X-Google-Smtp-Source: AMsMyM5nKN5s646XTnQU4lqNZbJvzYobVrd5JslImVEs9THy7vWttLpi0XHRXW/bkUaPhaZikLYXRmyLzmkLHwQWu78=
X-Received: by 2002:a67:c190:0:b0:3a7:e91:9072 with SMTP id
 h16-20020a67c190000000b003a70e919072mr11412420vsj.36.1666344368464; Fri, 21
 Oct 2022 02:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com> <20221021010310.29521-2-stephen.s.brennan@oracle.com>
In-Reply-To: <20221021010310.29521-2-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 Oct 2022 12:25:57 +0300
Message-ID: <CAOQ4uxgxN+-Q+C7fHJ7PwEbM0GVH9mVKiAzdpCb+wFd6M=zsuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fsnotify: Use d_find_any_alias to get dentry
 associated with inode
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 4:03 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Rather than iterating over the inode's i_dentry (requiring holding the
> i_lock for the entire duration of the function), we know that there
> should be only one item in the list. Use d_find_any_alias() and no
> longer hold i_lock.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

one nit below

> ---
>  fs/notify/fsnotify.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7974e91ffe13..6c338322f0c3 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -105,7 +105,7 @@ void fsnotify_sb_delete(struct super_block *sb)
>   */
>  void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  {
> -       struct dentry *alias;
> +       struct dentry *alias, *child;
>         int watched;
>
>         if (!S_ISDIR(inode->i_mode))
> @@ -114,30 +114,25 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>         /* determine if the children should tell inode about their events */
>         watched = fsnotify_inode_watches_children(inode);
>
> -       spin_lock(&inode->i_lock);
> -       /* run all of the dentries associated with this inode.  Since this is a
> -        * directory, there damn well better only be one item on this list */
> -       hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
> -               struct dentry *child;
> -
> -               /* run all of the children of the original inode and fix their
> -                * d_flags to indicate parental interest (their parent is the
> -                * original inode) */
> -               spin_lock(&alias->d_lock);
> -               list_for_each_entry(child, &alias->d_subdirs, d_child) {
> -                       if (!child->d_inode)
> -                               continue;
> +       /* Since this is a directory, there damn well better only be one child */
> +       alias = d_find_any_alias(inode);
>
> -                       spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> -                       if (watched)
> -                               child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> -                       else
> -                               child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> -                       spin_unlock(&child->d_lock);
> -               }
> -               spin_unlock(&alias->d_lock);
> +       /* run all of the children of the original inode and fix their
> +        * d_flags to indicate parental interest (their parent is the
> +        * original inode) */

Please add new lines at the beginning and end of this multi line comment.

Thanks,
Amir.
