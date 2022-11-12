Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260B626833
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiKLIxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 03:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLIxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:53:39 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED7311;
        Sat, 12 Nov 2022 00:53:34 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id l190so7124030vsc.10;
        Sat, 12 Nov 2022 00:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9Smjh/yGIKQ9krQ5WNJohFUdxfMO4/FTuEqmVDIdSI=;
        b=m0MWMmsQN8OOzl7hr70mlNQQeO74sQDayjqvXlFLKw0rhM5uP7n1NrSq6sFCTybolB
         PfPzYA6BicUZf07cXexKIjxRFL1cO9mjutjQwAwXC3oGX/Vb43o+smG76r9ilstOfnSA
         F3jsJTeXztjPowgN/baHAbZULTqqaORr3A6rfH+DXiAPOz7brxV+s1nHxt/LB8Fe4Wf4
         GA5PDOYTze1tXPVwDKnHO9xYHeoAhQaf0ugnbnl3DVpXvbpIHLe40y56jEUE7y8BF0KU
         SW3pLoQYNEaD+5yzCI43aCLamxaLEmOC6uETTw6mdsu3E6MSEHCTPS6T4nFjkKAq0fKb
         a2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9Smjh/yGIKQ9krQ5WNJohFUdxfMO4/FTuEqmVDIdSI=;
        b=bvuTNZrTDyFwKeLN1zbhp058SnLGJh2M7WHrkP23BJMVdY+Z3lTaNXSNEWQcuojl9Y
         sxVsU6rLjP0bPxh7yXnPBy8q933aUgvCEUGHGtyTZXFtICck0r0NjlAEwwtmAucneIbl
         HRJGWkdGJMXN6VBP+TaWDLGjkdHPU7pKCA6ASy8rC++jiMvu6AG16H7px5Ix7jWpvQms
         v4r1RxQ5p9M4lGkiMt0hHSJf4vZ+hoZEKwbwyPjgF9a6+oEoGZ7Nnh9fREllypR5ROpf
         6ShVY4akjxCWVC3CECcQKT8xkXNAUCrgP+uSbMNQc3BZkkHJGKFjGWzCoiRijsJEkvuV
         eA1g==
X-Gm-Message-State: ANoB5pn+dTpcyVMEumk0bzLJPv8QGfov9OuqipU5Arn3gBlgWM3bX30l
        ZWLbnNy0iDSbL/ai3vS2412W3rE+XtXcjZ61K/Y=
X-Google-Smtp-Source: AA0mqf4EQiVwR1Zj92rCfrBLAefHK2cCrMOui7i5AWdjmQlmIaG/2GIw92OOD8APZtjZEimVd+spTgwU5NSTinw3ZBE=
X-Received: by 2002:a05:6102:c03:b0:3aa:13b1:86e6 with SMTP id
 x3-20020a0561020c0300b003aa13b186e6mr2636272vss.36.1668243213045; Sat, 12 Nov
 2022 00:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com> <20221111220614.991928-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20221111220614.991928-3-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Nov 2022 10:53:21 +0200
Message-ID: <CAOQ4uxhXYzX=tKyY7BRp=KhuEZY6FrYsZYyD-rLiYfPJfh8WXg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] fsnotify: Use d_find_any_alias to get dentry
 associated with inode
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
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

On Sat, Nov 12, 2022 at 12:06 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Rather than iterating over the inode's i_dentry (requiring holding the
> i_lock for the entire duration of the function), we know that there
> should be only one item in the list. Use d_find_any_alias() and no
> longer hold i_lock.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Notes:
>     Changes in v4:
>     - Bail out if d_find_any_alias() returns NULL
>     - Rebase on Amir's patch
>     Changes in v3:
>     - Add newlines in block comment
>     - d_find_any_alias() returns a reference, which I was leaking. Add
>       a dput(alias) at the end.
>     - Add Amir's R-b
>
>  fs/notify/fsnotify.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 2c50e9e50d35..409d479cbbc6 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -105,35 +105,35 @@ void fsnotify_sb_delete(struct super_block *sb)
>   */
>  void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
>  {
> -       struct dentry *alias;
> +       struct dentry *alias, *child;
>
>         if (!S_ISDIR(inode->i_mode))
>                 return;
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
> +       if (!alias)
> +               return;
>
> -                       spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> -                       if (watched)
> -                               child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> -                       else
> -                               child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> -                       spin_unlock(&child->d_lock);
> -               }
> -               spin_unlock(&alias->d_lock);
> +       /*
> +        * run all of the children of the original inode and fix their
> +        * d_flags to indicate parental interest (their parent is the
> +        * original inode)

nit: this comment can probably fit in two nicer lines

> +        */
> +       spin_lock(&alias->d_lock);
> +       list_for_each_entry(child, &alias->d_subdirs, d_child) {
> +               if (!child->d_inode)
> +                       continue;
> +
> +               spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> +               if (watched)
> +                       child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> +               else
> +                       child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +               spin_unlock(&child->d_lock);
>         }
> -       spin_unlock(&inode->i_lock);
> +       spin_unlock(&alias->d_lock);
> +       dput(alias);
>  }
>
>  /*
> --
> 2.34.1
>
