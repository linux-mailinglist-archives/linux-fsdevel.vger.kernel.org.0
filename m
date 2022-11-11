Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728AF626094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiKKRlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 12:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiKKRlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:41:09 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1173623B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 09:41:07 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so6147158fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 09:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4FMbovKeaf0ACEXQ0YanGO9/PhL7FDv4zcGvp9Jqeb8=;
        b=VC2441h1K58QJkK+WGDca1W1zE89fQLTCiI2j9YZF8c7kZutY8qZa37OsZfchHaWPS
         rhMk5/lHhhn0VVnapdeeJdbRT73kCMs+fjJf2MKXFrEUUsifRb5msz4ssklMNJBwC7eh
         Chg1S4lbsZ4dVFWnrIXNGPFFAx0LNq8OQ9MXm+IBeMhVnfnt6VtiEwgM8nb0msLSnp58
         pb2LkeEZ2gFqjfjK6C7Sx0bex21qNoK1D05X39ls8QGfZpothPC5BYnsb9IAdN1Lxyps
         Lisi72JrvKVaXERa9xDqo4MVML53UfqJmtjTDFPiT07Yk9rhBBSBf+xxCAGylshMQU5N
         DFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FMbovKeaf0ACEXQ0YanGO9/PhL7FDv4zcGvp9Jqeb8=;
        b=njrEsou0dJYXYKbTIU0m8DVPWIRQqwdWY/VViqNjY5Yq+enPXPlUn6zOE8u3snsZeM
         UmV5WNEnDYy9roU+ONzlIsMz+QbFo2G0BuYi1AX61hWiuOR/zL6P6SZNMGtrHAM4YBjM
         udjjjl/J2jFzHG7SlDDFcBnFxSFNjTVQMSSgNU/sOC35cRpy3ehNksvIvpWO9Zm6D/l2
         z4rMEL2ddBvcLP5MBN8BQiWrPRTG1yQan4DvoXk9GyiJXBFu/yb+55N33uIc0kYoyW7O
         17IZV26XmWgJPGCq62ux+7WpiaBzytzyhoLkw7IoLj3xtRJDjCtC5YZkbAmtcgfWQqg/
         pClA==
X-Gm-Message-State: ANoB5plFJ59BX/d1q/xGyqfsbJgbD/3k3wzPARRN6cHh8i87Cqse8wP0
        PKbh8VfFQTiB/RHNZ8xHHO0lJzlxcOXAQ16HTCB9
X-Google-Smtp-Source: AA0mqf655iw4JsNFSaXUguP05uOdtX8Svtt265PQFwzqFM6wcQ7IAUleTmgJzrbkAjGYudkUtWM48pVP5eznaOTF3uA=
X-Received: by 2002:a05:6870:4304:b0:13b:d015:f1b5 with SMTP id
 w4-20020a056870430400b0013bd015f1b5mr1591387oah.51.1668188467074; Fri, 11 Nov
 2022 09:41:07 -0800 (PST)
MIME-Version: 1.0
References: <166807856758.2972602.14175912201162072721.stgit@warthog.procyon.org.uk>
In-Reply-To: <166807856758.2972602.14175912201162072721.stgit@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Nov 2022 12:40:56 -0500
Message-ID: <CAHC9VhTJh2tFbvOMzpGw7VSnHHb=boNhL5c7a1Ed+iHNFwWwqg@mail.gmail.com>
Subject: Re: [PATCH v5] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 6:09 AM David Howells <dhowells@redhat.com> wrote:
>
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
>
> Fix this by adding a new LSM hook to load fc->security for submount
> creation when alloc_fs_context() is creating the fs_context for it.
>
> However, this uncovers a further bug: nfs_get_root() initialises the
> superblock security manually by calling security_sb_set_mnt_opts() or
> security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> complaining.
>
> Fix that by adding a flag to the fs_context that suppresses the
> security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
> when it sets the LSM context on the new superblock.
>
> The first bug leads to messages like the following appearing in dmesg:
>
>         NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
>
> Changes
> =======
> ver #5)
>  - Removed unused variable.
>  - Only allocate smack_mnt_opts if we're dealing with a submount.
>
> ver #4)
>  - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or
>    Smack.
>
> ver #3)
>  - Made LSM parameter extraction dependent on fc->purpose ==
>    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
>
> ver #2)
>  - Added Smack support
>  - Made LSM parameter extraction dependent on reference != NULL.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Scott Mayhew <smayhew@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Paul Moore <paul@paul-moore.com>
> cc: linux-nfs@vger.kernel.org
> cc: selinux@vger.kernel.org
> cc: linux-security-module@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
> ---
>
>  fs/fs_context.c               |    4 +++
>  fs/nfs/getroot.c              |    1 +
>  fs/super.c                    |   10 +++++---
>  include/linux/fs_context.h    |    1 +
>  include/linux/lsm_hook_defs.h |    1 +
>  include/linux/lsm_hooks.h     |    6 ++++-
>  include/linux/security.h      |    6 +++++
>  security/security.c           |    5 ++++
>  security/selinux/hooks.c      |   25 +++++++++++++++++++
>  security/smack/smack_lsm.c    |   54 +++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 108 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 24ce12f0db32..22248b8a88a8 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
>                 break;
>         }
>
> +       ret = security_fs_context_init(fc, reference);
> +       if (ret < 0)
> +               goto err_fc;
> +
>         /* TODO: Make all filesystems support this unconditionally */
>         init_fs_context = fc->fs_type->init_fs_context;
>         if (!init_fs_context)
> diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
> index 11ff2b2e060f..651bffb0067e 100644
> --- a/fs/nfs/getroot.c
> +++ b/fs/nfs/getroot.c
> @@ -144,6 +144,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
>         }
>         if (error)
>                 goto error_splat_root;
> +       fc->lsm_set = true;
>         if (server->caps & NFS_CAP_SECURITY_LABEL &&
>                 !(kflags_out & SECURITY_LSM_NATIVE_LABELS))
>                 server->caps &= ~NFS_CAP_SECURITY_LABEL;
> diff --git a/fs/super.c b/fs/super.c
> index 8d39e4f11cfa..f200ae0549ca 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1553,10 +1553,12 @@ int vfs_get_tree(struct fs_context *fc)
>         smp_wmb();
>         sb->s_flags |= SB_BORN;
>
> -       error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> -       if (unlikely(error)) {
> -               fc_drop_locked(fc);
> -               return error;
> +       if (!(fc->lsm_set)) {
> +               error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> +               if (unlikely(error)) {
> +                       fc_drop_locked(fc);
> +                       return error;
> +               }
>         }

Thinking about all the different things that an LSM could do, would it
ever be possible that a LSM would want the security_sb_set_mnt_opts()
call to happen here?  I'm wondering if we are better off leaving it up
to the LSM by passing the fs_context in the security_sb_set_mnt_opts()
hook; those that want to effectively skip this call due to a submount
setup already done in security_fs_context_init() can check the
fs_context::purpose value in the security_sb_set_mnt_opts() hook.

Thoughts?

-- 
paul-moore.com
