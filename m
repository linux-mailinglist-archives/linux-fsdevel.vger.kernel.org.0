Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851B417778D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgCCNnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 08:43:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgCCNnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583242984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qYqCecXVRlR+2rlzLpmUVtnJB+J6hg7uQq9+x2JC+eo=;
        b=IjrOwimKM9NHSrUhT8ASdS92J2AWI4EI0aqDEzgPEqsMzlVWDH9MMFBDQIZc3nlYtS3Hgu
        YM7X0tQHbxFpq5JpQGnax04TWaHxtJFptMxeuewFc1ZPhBu1vf9N+TXziyeFWB+bVXz+MT
        vc3JdAsozFgJVPpRLbe7XKisWNIoOOE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-A0vyfd6HMsy3QARGvXoNJg-1; Tue, 03 Mar 2020 08:43:02 -0500
X-MC-Unique: A0vyfd6HMsy3QARGvXoNJg-1
Received: by mail-ot1-f69.google.com with SMTP id x21so1887189otp.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 05:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYqCecXVRlR+2rlzLpmUVtnJB+J6hg7uQq9+x2JC+eo=;
        b=Ut2qTlXf9O9tTONa3kgqeAVpnrjP7zSO3MP2R4dmuyoUZEbCXWpG8kJXVXtNnhqruq
         aTd7ZxgIId6x3+IJP2O53LfgiGVKgvIbvFujsWK51LYDZPmKiVetr3uSnkv/00uX6FAC
         DkYBoJXt+yoTyltdQKrpPBpzK7ukM9Zs/0GfOVboneiNFmbM8VEvCkTLGkXHX2BiX8WQ
         ZPh4oboBPq9i+RvjYlBHoWLTTNKkxPVDtyl3/I11WkB3Z0Qe9hk+T5g5Wh36pWtlO+2R
         vxzH2dLHmyuFUXWzI951Ne9Axt+0Kvy8lOiSzYiXioX9ou/SAOBbw4+YLLl25Z+ykiui
         wqgQ==
X-Gm-Message-State: ANhLgQ1Znz0zfrtZYl1o5THLToqToAxapECVRXNGJ5FdEVO0YkA+/JVO
        aIzh0A4dzzMCPpuoCeTc2kYTKeTk0eYoaW5TOHIbk9NW2XIbD5lhcjJm3Xo1wFaTa2rSzjbw9Uf
        jJyWyT/ZFgrXKGuMA5SqCv4+Ysiv3MB1mKJueUeDZHQ==
X-Received: by 2002:a05:6830:14cc:: with SMTP id t12mr3202783otq.95.1583242981536;
        Tue, 03 Mar 2020 05:43:01 -0800 (PST)
X-Google-Smtp-Source: ADFU+vudt52Af+flRk9YuhIuciNYNsv/YASW8si71vo633TKOR2fCs3v2DVvffyzzCffmDmisvHy2i6IW7ibHQG+Gsc=
X-Received: by 2002:a05:6830:14cc:: with SMTP id t12mr3202766otq.95.1583242981228;
 Tue, 03 Mar 2020 05:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20200221173722.538788-1-hch@lst.de>
In-Reply-To: <20200221173722.538788-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 Mar 2020 14:42:50 +0100
Message-ID: <CAHc6FU5RM5c0dopuJmCEJmPkwM6TUy60xnSWRpH2qHdX09B1pw@mail.gmail.com>
Subject: Re: [PATCH] fs: move the posix_acl_fix_xattr_{to_from}_user out of
 xattr code
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

On Fri, Feb 21, 2020 at 7:01 PM Christoph Hellwig <hch@lst.de> wrote:
> There is no excuse to ever perform actions related to a specific handler
> directly from the generic xattr code as we have handler that understand
> the specific data in given attrs.  As a nice sideeffect this removes
> tons of pointless boilerplate code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

can you please review this change from an overlayfs point of view?

Thanks,
Andreas

> ---
>  fs/posix_acl.c                  | 62 ++-------------------------------
>  fs/xattr.c                      |  8 +----
>  include/linux/posix_acl_xattr.h | 12 -------
>  3 files changed, 3 insertions(+), 79 deletions(-)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 249672bf54fe..09f1b7d186f0 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -663,64 +663,6 @@ int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
>  }
>  EXPORT_SYMBOL(posix_acl_update_mode);
>
> -/*
> - * Fix up the uids and gids in posix acl extended attributes in place.
> - */
> -static void posix_acl_fix_xattr_userns(
> -       struct user_namespace *to, struct user_namespace *from,
> -       void *value, size_t size)
> -{
> -       struct posix_acl_xattr_header *header = value;
> -       struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
> -       int count;
> -       kuid_t uid;
> -       kgid_t gid;
> -
> -       if (!value)
> -               return;
> -       if (size < sizeof(struct posix_acl_xattr_header))
> -               return;
> -       if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
> -               return;
> -
> -       count = posix_acl_xattr_count(size);
> -       if (count < 0)
> -               return;
> -       if (count == 0)
> -               return;
> -
> -       for (end = entry + count; entry != end; entry++) {
> -               switch(le16_to_cpu(entry->e_tag)) {
> -               case ACL_USER:
> -                       uid = make_kuid(from, le32_to_cpu(entry->e_id));
> -                       entry->e_id = cpu_to_le32(from_kuid(to, uid));
> -                       break;
> -               case ACL_GROUP:
> -                       gid = make_kgid(from, le32_to_cpu(entry->e_id));
> -                       entry->e_id = cpu_to_le32(from_kgid(to, gid));
> -                       break;
> -               default:
> -                       break;
> -               }
> -       }
> -}
> -
> -void posix_acl_fix_xattr_from_user(void *value, size_t size)
> -{
> -       struct user_namespace *user_ns = current_user_ns();
> -       if (user_ns == &init_user_ns)
> -               return;
> -       posix_acl_fix_xattr_userns(&init_user_ns, user_ns, value, size);
> -}
> -
> -void posix_acl_fix_xattr_to_user(void *value, size_t size)
> -{
> -       struct user_namespace *user_ns = current_user_ns();
> -       if (user_ns == &init_user_ns)
> -               return;
> -       posix_acl_fix_xattr_userns(user_ns, &init_user_ns, value, size);
> -}
> -
>  /*
>   * Convert from extended attribute to in-memory representation.
>   */
> @@ -851,7 +793,7 @@ posix_acl_xattr_get(const struct xattr_handler *handler,
>         if (acl == NULL)
>                 return -ENODATA;
>
> -       error = posix_acl_to_xattr(&init_user_ns, acl, value, size);
> +       error = posix_acl_to_xattr(current_user_ns(), acl, value, size);
>         posix_acl_release(acl);
>
>         return error;
> @@ -889,7 +831,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
>         int ret;
>
>         if (value) {
> -               acl = posix_acl_from_xattr(&init_user_ns, value, size);
> +               acl = posix_acl_from_xattr(current_user_ns(), value, size);
>                 if (IS_ERR(acl))
>                         return PTR_ERR(acl);
>         }
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f0eb27..c31e9a9ea172 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -437,10 +437,7 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
>                         error = -EFAULT;
>                         goto out;
>                 }
> -               if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
> -                   (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
> -                       posix_acl_fix_xattr_from_user(kvalue, size);
> -               else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
> +               if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
>                         error = cap_convert_nscap(d, &kvalue, size);
>                         if (error < 0)
>                                 goto out;
> @@ -537,9 +534,6 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
>
>         error = vfs_getxattr(d, kname, kvalue, size);
>         if (error > 0) {
> -               if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
> -                   (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
> -                       posix_acl_fix_xattr_to_user(kvalue, error);
>                 if (size && copy_to_user(value, kvalue, error))
>                         error = -EFAULT;
>         } else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
> diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
> index 2387709991b5..8f5e70a1bd05 100644
> --- a/include/linux/posix_acl_xattr.h
> +++ b/include/linux/posix_acl_xattr.h
> @@ -32,18 +32,6 @@ posix_acl_xattr_count(size_t size)
>         return size / sizeof(struct posix_acl_xattr_entry);
>  }
>
> -#ifdef CONFIG_FS_POSIX_ACL
> -void posix_acl_fix_xattr_from_user(void *value, size_t size);
> -void posix_acl_fix_xattr_to_user(void *value, size_t size);
> -#else
> -static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
> -{
> -}
> -static inline void posix_acl_fix_xattr_to_user(void *value, size_t size)
> -{
> -}
> -#endif
> -
>  struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns,
>                                        const void *value, size_t size);
>  int posix_acl_to_xattr(struct user_namespace *user_ns,
> --
> 2.24.1
>

