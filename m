Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F195D462D45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 08:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbhK3HGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 02:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhK3HGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:06:04 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB3C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 23:02:46 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id k21so24796266ioh.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 23:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hM1ogBYXjtQkJEuAZFZmFXiZfVR84ZDrd3/Dtkx7jFo=;
        b=WUc4cN2BOf99/OZuj1E3T94Cet2eOq3bXA6fsbdx64lGm4xkuw0d4mPbTYbJoBfwAS
         NJP8TaYDtdIcDxo4eo8bQ5jqXLzNPLcvfkXF+MnyCe69UMZJXTIUla9WrRSz7O02lKZb
         SFTfja/KjX60ZYGt0XZcczr2XNrpB4smn3mjCJO6sogFv6jwK9YOrx+aFJAeqGi4zAQA
         hMiKcyrBBCbl9gmDGI+8D3KmdC/HoupSWRhIrU6Rd4cFJARLKKhzahmIrmw3VitVXR0u
         P/ZcGNua4KczrOZjJcUiPSriLxgNhvULbz+gKI5eqfad6CeReOVlTMMB3jsIDOIkXtK6
         LwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hM1ogBYXjtQkJEuAZFZmFXiZfVR84ZDrd3/Dtkx7jFo=;
        b=JyM8QfU1yhG+z7I5mWDjFv4onaay3i3RWmShN5fUIydJRzC75JAN9oKAhUsbil1PO3
         EIUGoEuKbsE7iQZI0MVLdo+Ygn9OE0EM2o3aNJ8IC7KMDWjqrIE7usNaZJa7ek0/zFPz
         /qnyx1C4NsORrB2FHrLZcP8FwI6tm4+AaJj9Y6fWGFvybwZR/2mbMj5nxta8j3VUUYKb
         00I6OcFMlaHqj1CE6n7GCKXPMRAnJAlpFHV0A3875/oLo7yetAHwfFP0Pp5j5azL7pLK
         wOgNu/wCNzzQevhLEs79/uGjnUpC5yNKen8TgWgbOGE0kZs0G7l+nlfxywD3uyplUzkz
         usuw==
X-Gm-Message-State: AOAM531Kl7Pjw0BHDpCDLA8EoriR4uvIsbyQGBfQAtEa5iYk1XFFzMUg
        d8t3dVXjqExkhLvKfAbYByNOeAZrQBd75xBwvbvhSu6c8Rg=
X-Google-Smtp-Source: ABdhPJycECxc+NoBjyL2pY47O/r3HSjUHHf6+rVQnAU59iLpfWnkLkxhrsBkoaDMIgvMMk6B2/Ub1lwj98OQKo2J+TE=
X-Received: by 2002:a05:6602:2a4e:: with SMTP id k14mr62303153iov.197.1638255765757;
 Mon, 29 Nov 2021 23:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20211123114227.3124056-1-brauner@kernel.org> <20211123114227.3124056-10-brauner@kernel.org>
In-Reply-To: <20211123114227.3124056-10-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 09:02:34 +0200
Message-ID: <CAOQ4uxidcYH8NRGaVgEHamsMjpKPaGvKvu0sqw8_bjZg=igmuQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] fs: add i_user_ns() helper
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 3:29 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Since we'll be passing the filesystem's idmapping in even more places in
> the following patches and we do already dereference struct inode to get
> to the filesystem's idmapping multiple times add a tiny helper.
>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  include/linux/fs.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6ccb0e7f8801..c1780be923fa 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1600,6 +1600,11 @@ struct super_block {
>         struct list_head        s_inodes_wb;    /* writeback inodes */
>  } __randomize_layout;
>
> +static inline struct user_namespace *i_user_ns(const struct inode *inode)
> +{
> +       return inode->i_sb->s_user_ns;
> +}
> +
>  /* Helper functions so that in most cases filesystems will
>   * not need to deal directly with kuid_t and kgid_t and can
>   * instead deal with the raw numeric values that are stored
> @@ -1607,22 +1612,22 @@ struct super_block {
>   */
>  static inline uid_t i_uid_read(const struct inode *inode)
>  {
> -       return from_kuid(inode->i_sb->s_user_ns, inode->i_uid);
> +       return from_kuid(i_user_ns(inode), inode->i_uid);
>  }
>
>  static inline gid_t i_gid_read(const struct inode *inode)
>  {
> -       return from_kgid(inode->i_sb->s_user_ns, inode->i_gid);
> +       return from_kgid(i_user_ns(inode), inode->i_gid);
>  }
>
>  static inline void i_uid_write(struct inode *inode, uid_t uid)
>  {
> -       inode->i_uid = make_kuid(inode->i_sb->s_user_ns, uid);
> +       inode->i_uid = make_kuid(i_user_ns(inode), uid);
>  }
>
>  static inline void i_gid_write(struct inode *inode, gid_t gid)
>  {
> -       inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
> +       inode->i_gid = make_kgid(i_user_ns(inode), gid);
>  }
>
>  /**
> --
> 2.30.2
>
