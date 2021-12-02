Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE24668D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351720AbhLBRNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhLBRNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:13:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277AEC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:10:17 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o4so408976oia.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EXuO7zAjWe5osqgH1NJT6fj/LpdM5SpUnvtuE1U5/Ts=;
        b=dVy7uS8ABPFVdEePtUrAb8I16EUe6/8fR7I7crtNEeYO94AU0D4TlL+zAl9J36Mi50
         PtAnpFfCPHQUmDZjEB9s1hOsHqkmcEiV4S5kaLlI1xkHd7fmf6S5UVc0QYP7/Mr5/bsL
         Ngh3mAsEaVPcvTOuLzzij78uYxeOlRQEbDAbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EXuO7zAjWe5osqgH1NJT6fj/LpdM5SpUnvtuE1U5/Ts=;
        b=TPnyAjza2XWV0KNYb2mFss+qLRiFJcTs3zRmK5WIivCKBdrvYDPnL7viYpKE5QNT/9
         20s/Dw8zLWGlxely1YsVhK5fNuurGg6UjCsV8zYt5kxs37idAWFe1rZShOOs7KrLzKvz
         bf1VeE9OJ0asaba2P/bsLvTcLpEaRgwX8IwjnKGcFZPltqgisu66Q/ka1qI+F+1B5OGd
         tuCtRnNYLtdTZhMZE8jNqsLMkN/u2rzNBr059fjFL0YyLIyjNL+sm7RxGDWrD/xTLTQu
         DSjF8xZpmBndWX1tb/p0ddp044+/fyxnleCsD0UtppBjsT+dObFhx0c1yM695gPMoauI
         jbdw==
X-Gm-Message-State: AOAM530ClrlatPvY64TEIK0NVEfNQuIxmxIakQDhtJAd9VAHnaY4ztzb
        eO6zcR11EPfjWE0VY7kqUUeWIw==
X-Google-Smtp-Source: ABdhPJxXMpHs3WLqcCBq7+ryB1Qw2cje1R9ofj3Cm8tqQ7y73I5wFPScQYAQ45WZ6y3XNiDn6hBDCQ==
X-Received: by 2002:aca:d704:: with SMTP id o4mr5448810oig.99.1638465016502;
        Thu, 02 Dec 2021 09:10:16 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id f20sm163237oiw.48.2021.12.02.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:10:16 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:10:15 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 02/10] fs: move mapping helpers
Message-ID: <Yaj998vN32Q0krKl@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-3-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:24PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> The low-level mapping helpers were so far crammed into fs.h. They are
> out of place there. The fs.h header should just contain the higher-level
> mapping helpers that interact directly with vfs objects such as struct
> super_block or struct inode and not the bare mapping helpers. Similarly,
> only vfs and specific fs code shall interact with low-level mapping
> helpers. And so they won't be made accessible automatically through
> regular {g,u}id helpers.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-3-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Rename header to mnt_idmapping.h
>   - Include mnt_idmapping.h header in all files where it is used to
>     avoid unnecessary recompliation on header change.
> ---
>  fs/ksmbd/smbacl.c             |   1 +
>  fs/ksmbd/smbacl.h             |   1 +
>  fs/open.c                     |   1 +
>  fs/posix_acl.c                |   1 +
>  fs/xfs/xfs_linux.h            |   1 +
>  include/linux/fs.h            |  91 +-----------------------------
>  include/linux/mnt_idmapping.h | 101 ++++++++++++++++++++++++++++++++++
>  security/commoncap.c          |   1 +
>  8 files changed, 108 insertions(+), 90 deletions(-)
>  create mode 100644 include/linux/mnt_idmapping.h
> 
> diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
> index bd792db32623..ab8099e0fd7f 100644
> --- a/fs/ksmbd/smbacl.c
> +++ b/fs/ksmbd/smbacl.c
> @@ -9,6 +9,7 @@
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include "smbacl.h"
>  #include "smb_common.h"
> diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
> index 73e08cad412b..eba1ebb9e92e 100644
> --- a/fs/ksmbd/smbacl.h
> +++ b/fs/ksmbd/smbacl.h
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/namei.h>
>  #include <linux/posix_acl.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include "mgmt/tree_connect.h"
>  
> diff --git a/fs/open.c b/fs/open.c
> index f732fb94600c..2450cc1a2f64 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -32,6 +32,7 @@
>  #include <linux/ima.h>
>  #include <linux/dnotify.h>
>  #include <linux/compat.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include "internal.h"
>  
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 9323a854a60a..632bfdcf7cc0 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -23,6 +23,7 @@
>  #include <linux/export.h>
>  #include <linux/user_namespace.h>
>  #include <linux/namei.h>
> +#include <linux/mnt_idmapping.h>
>  
>  static struct posix_acl **acl_by_type(struct inode *inode, int type)
>  {
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index c174262a074e..09a8fba84ff9 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -61,6 +61,7 @@ typedef __u32			xfs_nlink_t;
>  #include <linux/ratelimit.h>
>  #include <linux/rhashtable.h>
>  #include <linux/xattr.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include <asm/page.h>
>  #include <asm/div64.h>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 426cc7bcbeb8..f5d1ae0a783a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -41,6 +41,7 @@
>  #include <linux/stddef.h>
>  #include <linux/mount.h>
>  #include <linux/cred.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> @@ -1624,34 +1625,6 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
>  	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
>  }
>  
> -/**
> - * kuid_into_mnt - map a kuid down into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kuid: kuid to be mapped
> - *
> - * Return: @kuid mapped according to @mnt_userns.
> - * If @kuid has no mapping INVALID_UID is returned.
> - */
> -static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
> -				   kuid_t kuid)
> -{
> -	return make_kuid(mnt_userns, __kuid_val(kuid));
> -}
> -
> -/**
> - * kgid_into_mnt - map a kgid down into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kgid: kgid to be mapped
> - *
> - * Return: @kgid mapped according to @mnt_userns.
> - * If @kgid has no mapping INVALID_GID is returned.
> - */
> -static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
> -				   kgid_t kgid)
> -{
> -	return make_kgid(mnt_userns, __kgid_val(kgid));
> -}
> -
>  /**
>   * i_uid_into_mnt - map an inode's i_uid down into a mnt_userns
>   * @mnt_userns: user namespace of the mount the inode was found from
> @@ -1680,68 +1653,6 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
>  	return kgid_into_mnt(mnt_userns, inode->i_gid);
>  }
>  
> -/**
> - * kuid_from_mnt - map a kuid up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kuid: kuid to be mapped
> - *
> - * Return: @kuid mapped up according to @mnt_userns.
> - * If @kuid has no mapping INVALID_UID is returned.
> - */
> -static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
> -				   kuid_t kuid)
> -{
> -	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
> -}
> -
> -/**
> - * kgid_from_mnt - map a kgid up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kgid: kgid to be mapped
> - *
> - * Return: @kgid mapped up according to @mnt_userns.
> - * If @kgid has no mapping INVALID_GID is returned.
> - */
> -static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
> -				   kgid_t kgid)
> -{
> -	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
> -}
> -
> -/**
> - * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - *
> - * Use this helper to initialize a new vfs or filesystem object based on
> - * the caller's fsuid. A common example is initializing the i_uid field of
> - * a newly allocated inode triggered by a creation event such as mkdir or
> - * O_CREAT. Other examples include the allocation of quotas for a specific
> - * user.
> - *
> - * Return: the caller's current fsuid mapped up according to @mnt_userns.
> - */
> -static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
> -{
> -	return kuid_from_mnt(mnt_userns, current_fsuid());
> -}
> -
> -/**
> - * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - *
> - * Use this helper to initialize a new vfs or filesystem object based on
> - * the caller's fsgid. A common example is initializing the i_gid field of
> - * a newly allocated inode triggered by a creation event such as mkdir or
> - * O_CREAT. Other examples include the allocation of quotas for a specific
> - * user.
> - *
> - * Return: the caller's current fsgid mapped up according to @mnt_userns.
> - */
> -static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
> -{
> -	return kgid_from_mnt(mnt_userns, current_fsgid());
> -}
> -
>  /**
>   * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
>   * @inode: inode to initialize
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
> new file mode 100644
> index 000000000000..7ff8b66b80cb
> --- /dev/null
> +++ b/include/linux/mnt_idmapping.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MNT_MAPPING_H
> +#define _LINUX_MNT_MAPPING_H
> +
> +#include <linux/types.h>
> +#include <linux/uidgid.h>
> +
> +struct user_namespace;
> +extern struct user_namespace init_user_ns;
> +
> +/**
> + * kuid_into_mnt - map a kuid down into a mnt_userns
> + * @mnt_userns: user namespace of the relevant mount
> + * @kuid: kuid to be mapped
> + *
> + * Return: @kuid mapped according to @mnt_userns.
> + * If @kuid has no mapping INVALID_UID is returned.
> + */
> +static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
> +				   kuid_t kuid)
> +{
> +	return make_kuid(mnt_userns, __kuid_val(kuid));
> +}
> +
> +/**
> + * kgid_into_mnt - map a kgid down into a mnt_userns
> + * @mnt_userns: user namespace of the relevant mount
> + * @kgid: kgid to be mapped
> + *
> + * Return: @kgid mapped according to @mnt_userns.
> + * If @kgid has no mapping INVALID_GID is returned.
> + */
> +static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
> +				   kgid_t kgid)
> +{
> +	return make_kgid(mnt_userns, __kgid_val(kgid));
> +}
> +
> +/**
> + * kuid_from_mnt - map a kuid up into a mnt_userns
> + * @mnt_userns: user namespace of the relevant mount
> + * @kuid: kuid to be mapped
> + *
> + * Return: @kuid mapped up according to @mnt_userns.
> + * If @kuid has no mapping INVALID_UID is returned.
> + */
> +static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
> +				   kuid_t kuid)
> +{
> +	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
> +}
> +
> +/**
> + * kgid_from_mnt - map a kgid up into a mnt_userns
> + * @mnt_userns: user namespace of the relevant mount
> + * @kgid: kgid to be mapped
> + *
> + * Return: @kgid mapped up according to @mnt_userns.
> + * If @kgid has no mapping INVALID_GID is returned.
> + */
> +static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
> +				   kgid_t kgid)
> +{
> +	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
> +}
> +
> +/**
> + * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
> + * @mnt_userns: user namespace of the relevant mount
> + *
> + * Use this helper to initialize a new vfs or filesystem object based on
> + * the caller's fsuid. A common example is initializing the i_uid field of
> + * a newly allocated inode triggered by a creation event such as mkdir or
> + * O_CREAT. Other examples include the allocation of quotas for a specific
> + * user.
> + *
> + * Return: the caller's current fsuid mapped up according to @mnt_userns.
> + */
> +static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
> +{
> +	return kuid_from_mnt(mnt_userns, current_fsuid());
> +}
> +
> +/**
> + * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
> + * @mnt_userns: user namespace of the relevant mount
> + *
> + * Use this helper to initialize a new vfs or filesystem object based on
> + * the caller's fsgid. A common example is initializing the i_gid field of
> + * a newly allocated inode triggered by a creation event such as mkdir or
> + * O_CREAT. Other examples include the allocation of quotas for a specific
> + * user.
> + *
> + * Return: the caller's current fsgid mapped up according to @mnt_userns.
> + */
> +static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
> +{
> +	return kgid_from_mnt(mnt_userns, current_fsgid());
> +}
> +
> +#endif /* _LINUX_MNT_MAPPING_H */
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3f810d37b71b..09479f71ee2e 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -24,6 +24,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/binfmts.h>
>  #include <linux/personality.h>
> +#include <linux/mnt_idmapping.h>
>  
>  /*
>   * If a non-root user executes a setuid-root binary in
> -- 
> 2.30.2
> 
