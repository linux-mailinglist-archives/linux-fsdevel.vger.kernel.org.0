Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C963A4268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFKMxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 08:53:07 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:36376 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFKMxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:53:06 -0400
Received: by mail-vs1-f49.google.com with SMTP id z7so3683913vso.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbkj6T3T04z4JtJ0EN+yh0xReBYxOd5BeJrygN3ZyFY=;
        b=ZfzqvA87eAWrqj09uQ4GZgIXoBXccSg3LsgcMTGU218ej3xJW33GsxTxpHsa+Nmd+g
         TgP6Gi73TFHtlWaexLEsM/qBkIZ1AAaaKm4CHcjCmd6upG/IJkwmGUyahkzQspo+GD8c
         GouQVLzFTXA6ABz44/LJySj42I1eSqG5qBcLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbkj6T3T04z4JtJ0EN+yh0xReBYxOd5BeJrygN3ZyFY=;
        b=oxIkBatXqIgLJvWRuvZub1yYVJqS+CwXAOuCUeTbOWBq5IZtEWKTvBpdmtY4E+vSXG
         wRSnuqADz3NQnG94LyiEzvlFBQAVMRiDiZQu57quls5+p/t22uVNUylQ//4Uwq4d3IY5
         hehrV4oPr/uuu6+jeBsLW49E0GhCC8GjUUXTVzAquZ1vguDE2Nzz378t+Nvj/LjLJME1
         LhSb8/lf42Ycikxe8eh6gzDqCEau5DE0NpCANYvIqPM9njjpCfcDUuI246F0alrtL4Ny
         xdTEECQcLooxGA9BCBrACJqfKtb6aaHt0dyAkkaHe530kyfw3qpxE6G8RBVBUXQykzQe
         oMzQ==
X-Gm-Message-State: AOAM530gjrwN2bfKhxJXCr3kUf/jMo6Z4BR/k7fTmZ1kUT4ikSTshW1K
        OFwhkCdXw0YKCSFbLeJxeVdsN2mWL0DRB+jnZ/WN/A==
X-Google-Smtp-Source: ABdhPJw0DFrogEnGKXGUiNWZJkVClfZ9iOeK7L+TRdy022jkFc4LsDLAOKTMDsQKzgM8449FfUWM88Z7NtNavVP17ag=
X-Received: by 2002:a67:ffcc:: with SMTP id w12mr9555466vsq.47.1623415794229;
 Fri, 11 Jun 2021 05:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322859985.361452.14110524195807923374.stgit@web.messagingengine.com>
In-Reply-To: <162322859985.361452.14110524195807923374.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 14:49:43 +0200
Message-ID: <CAJfpeguzPEy+UAcyT4tcpvYxeTwB+64yxRw8Sh7UBROBuafYdw@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] kernfs: add a revision to identify directory node changes
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Jun 2021 at 10:50, Ian Kent <raven@themaw.net> wrote:
>
> Add a revision counter to kernfs directory nodes so it can be used
> to detect if a directory node has changed during negative dentry
> revalidation.
>
> There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
> on all architectures and as far as I know that assumption holds.
>
> So adding a revision counter to the struct kernfs_elem_dir variant of
> the kernfs_node type union won't increase the size of the kernfs_node
> struct. This is because struct kernfs_elem_dir is at least
> sizeof(pointer) smaller than the largest union variant. It's tempting
> to make the revision counter a u64 but that would increase the size of
> kernfs_node on archs where sizeof(pointer) is smaller than the revision
> counter.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c             |    2 ++
>  fs/kernfs/kernfs-internal.h |   23 +++++++++++++++++++++++
>  include/linux/kernfs.h      |    5 +++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 33166ec90a112..b3d1bc0f317d0 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
>         /* successfully added, account subdir number */
>         if (kernfs_type(kn) == KERNFS_DIR)
>                 kn->parent->dir.subdirs++;
> +       kernfs_inc_rev(kn->parent);
>
>         return 0;
>  }
> @@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
>
>         if (kernfs_type(kn) == KERNFS_DIR)
>                 kn->parent->dir.subdirs--;
> +       kernfs_inc_rev(kn->parent);
>
>         rb_erase(&kn->rb, &kn->parent->dir.children);
>         RB_CLEAR_NODE(&kn->rb);
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index ccc3b44f6306f..b4e7579e04799 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -81,6 +81,29 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
>         return d_inode(dentry)->i_private;
>  }
>
> +static inline void kernfs_set_rev(struct kernfs_node *kn,
> +                                 struct dentry *dentry)
> +{
> +       if (kernfs_type(kn) == KERNFS_DIR)
> +               dentry->d_time = kn->dir.rev;
> +}
> +
> +static inline void kernfs_inc_rev(struct kernfs_node *kn)
> +{
> +       if (kernfs_type(kn) == KERNFS_DIR)
> +               kn->dir.rev++;
> +}
> +
> +static inline bool kernfs_dir_changed(struct kernfs_node *kn,
> +                                     struct dentry *dentry)
> +{
> +       if (kernfs_type(kn) == KERNFS_DIR) {

Aren't these always be called on a KERNFS_DIR node?

You could just reduce that to a WARN_ON, or remove the conditions
altogether then.

Thanks,
Miklos
