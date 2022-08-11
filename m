Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9033E58FC31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiHKM2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiHKM2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E636694EDB
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660220931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ldt5YH2vUdUY3Rfwj7va1rTsTGCGWHudQKX+6U+hrBE=;
        b=d+myHAn2iP16J0PoQoWFOGevUrg4/5XDT7vi/kuaBYGDiN/6xqC6s2Tixgi/NxUflAseK1
        rLi2f8FvOgzXhZtjwA4LpZ0zmh7dOZxtpj9OgpQhhN0v8J+3cWWmwDrMaxJ6IyteTOyZGp
        hhyZ2JViTHquv5WlmdXkpyQyzRhRRjk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-C9lQoREiPQuW5piMihK0yw-1; Thu, 11 Aug 2022 08:28:49 -0400
X-MC-Unique: C9lQoREiPQuW5piMihK0yw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-3225b644be1so148668497b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 05:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ldt5YH2vUdUY3Rfwj7va1rTsTGCGWHudQKX+6U+hrBE=;
        b=bDiGxQQPQBSlYbIg9F7EJWKDRsx4peI7vK6GhpxpCOQdOgJN8Ku0gdHkFe8kfT2ruV
         G0onWDInoHdwGP1Ltn4WyeOmqVYBOGkUwP2WzoqOHBuQJgsw2g8H0syXjr+WjdB0ee7o
         JmOgcgXMz13+jOKdBsqTjUBa7ibf/PAOzsnjvoDgltI37X1D3qiPAEvX6ho5Glg0yIzd
         KgTWzLMlevxpu0OgNdm0ekHtObIrmlvD40ZxbxYIywY4L/LiEZZ1Lafv9gaOeOdEJAuj
         ysUFgEIMNga0r+cBB2Hp8S1hTtMZQezSyIXRwWxsdHFzhwXigz6160HA6KJVoi52Dd6e
         KLHQ==
X-Gm-Message-State: ACgBeo3QRQGo1kFWwaPfuyamBLTXy2fOvOhU/TR/LG4PcKnvbuMw338E
        WduCcG0062ZZu0BKtcXDNDR04xDaFvRKOlII3jhfkQeTvSXPVzhv35XArb7l7Z5He7fcLNKQrPR
        aZmpg/YJb0kHZqVyb0q/tZ8tmToBNkp8fTz41Gb9vqA==
X-Received: by 2002:a0d:f6c4:0:b0:328:2c56:6463 with SMTP id g187-20020a0df6c4000000b003282c566463mr35602501ywf.459.1660220929343;
        Thu, 11 Aug 2022 05:28:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7i/yLgTzvo55oX3D4yxqarpwhjtEMknT6HPFwQbuQSzI78hubppBmLMXchXKyrb6WYwsWpPElHXQtb2k2pY1U=
X-Received: by 2002:a0d:f6c4:0:b0:328:2c56:6463 with SMTP id
 g187-20020a0df6c4000000b003282c566463mr35602473ywf.459.1660220929084; Thu, 11
 Aug 2022 05:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk>
In-Reply-To: <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Aug 2022 14:28:38 +0200
Message-ID: <CAFqZXNv+ahpN3Hdv54ixa4u-LKaqTtCyjtkpzKGbv7x4dzwc0Q@mail.gmail.com>
Subject: Re: [PATCH v3] nfs: Fix automount superblock LSM init problem,
 preventing sb sharing
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dwysocha@redhat.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 5, 2022 at 3:36 PM David Howells <dhowells@redhat.com> wrote:
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
> ver #2)
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
> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Scott Mayhew <smayhew@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Paul Moore <paul@paul-moore.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-nfs@vger.kernel.org
> cc: selinux@vger.kernel.org
> cc: linux-security-module@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>
>  fs/fs_context.c               |    4 +++
>  fs/nfs/getroot.c              |    1 +
>  fs/super.c                    |   10 ++++---
>  include/linux/fs_context.h    |    1 +
>  include/linux/lsm_hook_defs.h |    1 +
>  include/linux/lsm_hooks.h     |    6 +++-
>  include/linux/security.h      |    6 ++++
>  security/security.c           |    5 +++
>  security/selinux/hooks.c      |   29 +++++++++++++++++++
>  security/smack/smack_lsm.c    |   61 +++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 119 insertions(+), 5 deletions(-)

<snip>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1bbd53321d13..ddeaff4f3bb1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2768,6 +2768,34 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
>                                    FILESYSTEM__UNMOUNT, NULL);
>  }
>
> +static int selinux_fs_context_init(struct fs_context *fc,
> +                                  struct dentry *reference)
> +{
> +       const struct superblock_security_struct *sbsec;
> +       const struct inode_security_struct *root_isec;
> +       struct selinux_mnt_opts *opts;
> +
> +       if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
> +               opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +               if (!opts)
> +                       return -ENOMEM;
> +
> +               root_isec = backing_inode_security(reference->d_sb->s_root);
> +               sbsec = selinux_superblock(reference->d_sb);
> +               if (sbsec->flags & FSCONTEXT_MNT)
> +                       opts->fscontext_sid     = sbsec->sid;
> +               if (sbsec->flags & CONTEXT_MNT)
> +                       opts->context_sid       = sbsec->mntpoint_sid;
> +               if (sbsec->flags & ROOTCONTEXT_MNT)
> +                       opts->rootcontext_sid   = root_isec->sid;

I wonder if this part is correct... The rootcontext=... mount option
relates to the root inode of the mount where it is specified - i.e. in
case of NFS only to the toplevel inode of the initial mount. Setting
the same context on the root inode of submounts, which AFAIK are
supposed to be transparent to the user, doesn't seem correct to me -
i.e. it should just be left unset for the automatically created
submounts.

That said, I always feel lost in the super-complex LSM-VFS
interactions, so I'd welcome it if someone gives a second opinion
here.

> +               if (sbsec->flags & DEFCONTEXT_MNT)
> +                       opts->defcontext_sid    = sbsec->def_sid;
> +               fc->security = opts;
> +       }
> +
> +       return 0;
> +}
> +
>  static int selinux_fs_context_dup(struct fs_context *fc,
>                                   struct fs_context *src_fc)
>  {
> @@ -7239,6 +7267,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         /*
>          * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
>          */
> +       LSM_HOOK_INIT(fs_context_init, selinux_fs_context_init),
>         LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>         LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>         LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 6207762dbdb1..6ba32bb097b5 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -612,6 +612,66 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
>         return -EINVAL;
>  }
>
> +/**
> + * smack_fs_context_init - Initialise security data for a filesystem context
> + * @fc: The filesystem context.
> + * @reference: Reference dentry (automount/reconfigure) or NULL
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_init(struct fs_context *fc,
> +                                struct dentry *reference)
> +{
> +       struct superblock_smack *sbsp;
> +       struct smack_mnt_opts *ctx;
> +       struct inode_smack *isp;
> +
> +       ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +       fc->security = ctx;
> +
> +       if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
> +               sbsp = smack_superblock(reference->d_sb);
> +               isp = smack_inode(reference->d_sb->s_root->d_inode);
> +
> +               if (sbsp->smk_default) {
> +                       ctx->fsdefault = kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
> +                       if (!ctx->fsdefault)
> +                               return -ENOMEM;
> +               }
> +
> +               if (sbsp->smk_floor) {
> +                       ctx->fsfloor = kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
> +                       if (!ctx->fsfloor)
> +                               return -ENOMEM;
> +               }
> +
> +               if (sbsp->smk_hat) {
> +                       ctx->fshat = kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
> +                       if (!ctx->fshat)
> +                               return -ENOMEM;
> +               }
> +
> +

^ double empty line, FWIW

> +               if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
> +                       if (sbsp->smk_root) {
> +                               ctx->fstransmute = kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
> +                               if (!ctx->fstransmute)
> +                                       return -ENOMEM;
> +                       }
> +               } else {
> +                       if (sbsp->smk_root) {
> +                               ctx->fsroot = kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
> +                               if (!ctx->fsroot)
> +                                       return -ENOMEM;
> +                       }
> +               }

Similar concerns may or may not apply here, but I know too little
about how Smack handles mount options to be sure.


> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * smack_fs_context_dup - Duplicate the security data on fs_context duplication
>   * @fc: The new filesystem context.
> @@ -4755,6 +4815,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>         LSM_HOOK_INIT(syslog, smack_syslog),
>
> +       LSM_HOOK_INIT(fs_context_init, smack_fs_context_init),
>         LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
>         LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
>
>
>

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

