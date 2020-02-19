Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66BC165111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBSVCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:02:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35250 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgBSVCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:02:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so1577553otd.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMA3zBv2A115ds+hzoqNf5TDlp6zZsu8bzv4LFjiJu8=;
        b=cpQE1OrZGA1xh87Y+uWpubPmTXlJYRti4DUcDQEtqvFdVkENzdZzpZId854qxpcWmO
         m3Ks9Ivwu2kWRwpi9sDkJMDiROaz365WLRe5JX9h2NC2sGrk6GM0wgREVFAnq7XO/uQb
         QkyeQ32WU6GKzqc4p6pe5tf1IfZHhkflKdni5X2T/3x4LBtO6F518BKm2bC9AA10hrSA
         Y3bRFoWjAFlDjlvor5mZXfHpDcDq1TK9de5ZphZrju/ffQjjERRd7n6dQMJbN+dYesOG
         0rUJ/m/4ZLfBeuEzuyiAcVhoiCNztLJ4jHCwLdMAAlMSvKXLP4ISGQfOcG5BOS6uC1YJ
         LzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMA3zBv2A115ds+hzoqNf5TDlp6zZsu8bzv4LFjiJu8=;
        b=n2INo+Opjr3Xhz6m8jW42iz9w4nNVTzmRRDL8S+Pn9jGT4Kr170/gG2qUn/4ddi1K7
         9CRqGZutxlUeRjrFvTQgV4uTxnTPrvTJDDTSY14KuCr7rqP5iUScQ2c0cbxERWoBp/0U
         97jNJl0WJh1TX6x37JYRd1ubP4P5taPVxYFWIy53fzojtrGOvIpDEkm8BWGpg+xKLRvu
         53Pp7rlN4+uW19BUFMO+464/Rs+GEWHCjD/79S26mW0l9TgY/TzqeIz/sOQF+CTKV0oO
         3Se51SwNV7sn5nPIWHLjcekhZW+zS9yTr1dXN9MMWYb8czljDT2MSvWkDTBD3JMYDzxo
         bB9A==
X-Gm-Message-State: APjAAAV9ky5298nvszEd6eAfgVnWfUwHoqlyYKfJlTTGj8xGkSz6cKMM
        31CNtHJ1KQnKxMkOX9SjbYYXievni0lIOAnwv9KAsQ==
X-Google-Smtp-Source: APXvYqyRsA8WbMF9F4f2P6kxim/bq5zHCtu45yJLdbVFnT0FcSyvm95fJo2P1wZJesmzKXq4rDEttnM3pJxxoeiq8ss=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr20488389oti.32.1582146133397;
 Wed, 19 Feb 2020 13:02:13 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204558110.3299825.5080605285325995873.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204558110.3299825.5080605285325995873.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 22:01:47 +0100
Message-ID: <CAG48ez0fsB_XTmNfE-2tuabH7JHyQdih8bu7Qwu9HGWJXti7tQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] afs: Support fsinfo() [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
> Add fsinfo support to the AFS filesystem.
[...]
>  static const struct super_operations afs_super_ops = {
>         .statfs         = afs_statfs,
> +#ifdef CONFIG_FSINFO
> +       .fsinfo_attributes = afs_fsinfo_attributes,
> +#endif
> +       .alloc_inode    = afs_alloc_inode,
> +       .drop_inode     = afs_drop_inode,
> +       .destroy_inode  = afs_destroy_inode,
> +       .free_inode     = afs_free_inode,
> +       .evict_inode    = afs_evict_inode,
> +       .show_devname   = afs_show_devname,
> +       .show_options   = afs_show_options,
> +};
> +
> +static const struct super_operations afs_dyn_super_ops = {
> +       .statfs         = afs_statfs,
> +#ifdef CONFIG_FSINFO
> +       .fsinfo_attributes = afs_dyn_fsinfo_attributes,
> +#endif
>         .alloc_inode    = afs_alloc_inode,
>         .drop_inode     = afs_drop_inode,
>         .destroy_inode  = afs_destroy_inode,
[...]
> @@ -432,9 +454,12 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
>         sb->s_blocksize_bits    = PAGE_SHIFT;
>         sb->s_maxbytes          = MAX_LFS_FILESIZE;
>         sb->s_magic             = AFS_FS_MAGIC;
> -       sb->s_op                = &afs_super_ops;
> -       if (!as->dyn_root)
> +       if (!as->dyn_root) {
> +               sb->s_op        = &afs_super_ops;
>                 sb->s_xattr     = afs_xattr_handlers;
> +       } else {
> +               sb->s_op        = &afs_dyn_super_ops;
> +       }

Ewww. So basically, having one static set of .fsinfo_attributes is not
sufficiently flexible for everyone, but instead of allowing the
filesystem to dynamically provide a list of supported attributes, you
just duplicate the super_operations? Seems to me like it'd be cleaner
to add a function pointer to the super_operations that can dynamically
fill out the supported fsinfo attributes.

It seems to me like the current API is going to be a dead end if you
ever want to have decent passthrough of these things for e.g. FUSE, or
overlayfs, or VirtFS?

>         ret = super_setup_bdi(sb);
>         if (ret)
>                 return ret;
> @@ -444,7 +469,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
>         if (as->dyn_root) {
>                 inode = afs_iget_pseudo_dir(sb, true);
>         } else {
> -               sprintf(sb->s_id, "%llu", as->volume->vid);
> +               sprintf(sb->s_id, "%llx", as->volume->vid);

(This is technically a (small) UAPI change for audit logging of AFS
filesystems, right? You may want to note that in the commit message.)

>                 afs_activate_volume(as->volume);
>                 iget_data.fid.vid       = as->volume->vid;
>                 iget_data.fid.vnode     = 1;
[...]
> +static int afs_fsinfo_get_supports(struct path *path, struct fsinfo_context *ctx)
> +{
> +       struct fsinfo_supports *sup = ctx->buffer;
> +
> +       sup = ctx->buffer;

Duplicate assignment to "sup".

> +       sup->stx_mask = (STATX_TYPE | STATX_MODE |
> +                        STATX_NLINK |
> +                        STATX_UID | STATX_GID |
> +                        STATX_MTIME | STATX_INO |
> +                        STATX_SIZE);
> +       sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
> +       return sizeof(*sup);
> +}
[...]
> +static int afs_fsinfo_get_server_address(struct path *path, struct fsinfo_context *ctx)
> +{
> +       struct fsinfo_afs_server_address *addr = ctx->buffer;
> +       struct afs_server_list *slist;
> +       struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
> +       struct afs_addr_list *alist;
> +       struct afs_volume *volume = as->volume;
> +       struct afs_server *server;
> +       struct afs_net *net = afs_d2net(path->dentry);
> +       unsigned int i;
> +       int ret = -ENODATA;
> +
> +       read_lock(&volume->servers_lock);
> +       slist = afs_get_serverlist(volume->servers);
> +       read_unlock(&volume->servers_lock);
> +
> +       if (ctx->Nth >= slist->nr_servers)
> +               goto put_slist;
> +       server = slist->servers[ctx->Nth].server;
> +
> +       read_lock(&server->fs_lock);
> +       alist = afs_get_addrlist(rcu_access_pointer(server->addresses));

Documentation for rcu_access_pointer() says:

 * Return the value of the specified RCU-protected pointer, but omit the
 * lockdep checks for being in an RCU read-side critical section.  This is
 * useful when the value of this pointer is accessed, but the pointer is
 * not dereferenced, for example, when testing an RCU-protected pointer
 * against NULL.  Although rcu_access_pointer() may also be used in cases
 * where update-side locks prevent the value of the pointer from changing,
 * you should instead use rcu_dereference_protected() for this use case.
 *
 * It is also permissible to use rcu_access_pointer() when read-side
 * access to the pointer was removed at least one grace period ago, as
 * is the case in the context of the RCU callback that is freeing up
 * the data, or after a synchronize_rcu() returns.  This can be useful
 * when tearing down multi-linked structures after a grace period
 * has elapsed.

> +       read_unlock(&server->fs_lock);
