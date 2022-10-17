Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E4600E84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJQMD1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 08:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJQMDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:03:24 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3D5925F;
        Mon, 17 Oct 2022 05:03:22 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id p89so4258295uap.12;
        Mon, 17 Oct 2022 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pWKnKWGzl3h2/GbRMuMzvHrgaAw7SEjx04wq/pIPoa0=;
        b=XXI9WQMBoBrY492ICxxnlCOKTgNQXZhx5yVGHCxwaYBgOzcVz6AxzsiI7+PqdIlFIz
         U5m/oL82LOov3Avr8Z2HT3FRXDQkmDHM6glJEWrKKKrKvF9TNQMmW4SDn0cW8iBaXHoz
         Yrf2fQ/kdp0kohA4mZxBWI2pmZna5jTT+Uulz2FYS1WOcP5DjYWzsjpbT0bKm2k0XZKc
         d5C3KRMC9f7CromDHB66mTSSa6fxwaaKXtBiEzrO3r0OOKnKT4cG01TcsCGo7Ov5S9OU
         dH5X6sQjMf75dKmask0O1eZHfAxOV+mSq5AiqxL13FpA91xFN3fVQQf+Ur0OQqZieOhd
         orkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWKnKWGzl3h2/GbRMuMzvHrgaAw7SEjx04wq/pIPoa0=;
        b=x3XGf3kBwwImgkcJzD/4Qj+wU0+7140OOI4+EWMwvRRMSU84elNuU3xTQMrhXfg7jq
         u4y31AGDMahA95vU3qpHJ6KRodZcfUvFAH70O/3dZnubgdNfSIugDNmtfYSSpvJ0A+0X
         zBDyqRf/R0vdR/2hgZt5stuL5PZGmubaDpXcACb0YQrT4+2Qi5epwwhrY2h3NSwHDIgd
         2cP8ZjFXRowLTt1hLGi6iyev0k75nKvSeVV3FhFVQFGIf2iG1vUM28IaNKahWXZ6vriK
         ilx7uKypuvgN7YgMOIS8/i1aKAdMoX5k8y1v8m+NCgwa7F8Au24UxPpCwI/Xj6dJCKAl
         eSYA==
X-Gm-Message-State: ACrzQf34NwOuI0ye5oksuG/DC2MWaeF2UoJQ66nUrZC6s8pfUEs/4PQY
        zw76/nJyjgfaii8YwZlKbvDWlxtw2ObUrZ5e9GE=
X-Google-Smtp-Source: AMsMyM6aJsVZFWaW4dic4cmw/sjcGlgpVPJg5mCwxvAdVE71c7SEjo5mdMkqwsnHDN4O3/64hhaqy4R5EtzsrOYo4Eo=
X-Received: by 2002:ab0:4715:0:b0:3ea:d249:de4c with SMTP id
 h21-20020ab04715000000b003ead249de4cmr4365820uac.80.1666008201641; Mon, 17
 Oct 2022 05:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017100600.70269-1-brauner@kernel.org> <20221017100600.70269-3-brauner@kernel.org>
In-Reply-To: <20221017100600.70269-3-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Oct 2022 15:03:10 +0300
Message-ID: <CAOQ4uxhwGZ6HWHOUS+eyzSUgVregLde5Wy_LjdefKC3Stm0ePQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] attr: add setattr_should_drop_sgid()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Mon, Oct 17, 2022 at 1:06 PM Christian Brauner <brauner@kernel.org> wrote:
>
> The current setgid stripping logic during write and ownership change
> operations is inconsistent and strewn over multiple places. In order to
> consolidate it and make more consistent we'll add a new helper
> setattr_should_drop_sgid(). The function retains the old behavior where
> we remove the S_ISGID bit unconditionally when S_IXGRP is set but also
> when it isn't set and the caller is neither in the group of the inode
> nor privileged over the inode.
>
> We will use this helper both in write operation permission removal such
> as file_remove_privs() as well as in ownership change operations.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Some nits, but otherwise

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>
> Notes:
>     /* v2 */
>     Dave Chinner <dchinner@redhat.com>:
>     - Use easier to follow logic in the new helper.
>
>     /* v3 */
>     Amir Goldstein <amir73il@gmail.com>:
>     - Rename helper from should_remove_sgid() to setattr_should_drop_sgid() to
>       better indicate its semantics.
>     - Return setattr_should_drop_sgid() directly now that it returns ATTR_KILL_SGID
>       instead of a boolean.
>
>  fs/attr.c     | 26 ++++++++++++++++++++++++++
>  fs/internal.h |  2 ++
>  2 files changed, 28 insertions(+)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 8bc2edd6bd3c..3d03ceb332e5 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -39,6 +39,32 @@ static int setattr_drop_sgid(struct user_namespace *mnt_userns,
>         return ATTR_KILL_SGID;
>  }
>
> +/**
> + * setattr_should_drop_sgid - determine whether the setgid bit needs to be
> + *                            removed
> + * @mnt_userns:        user namespace of the mount @inode was found from
> + * @inode:     inode to check
> + *
> + * This function determines whether the setgid bit needs to be removed.
> + * We retain backwards compatibility and require setgid bit to be removed
> + * unconditionally if S_IXGRP is set. Otherwise we have the exact same
> + * requirements as setattr_prepare() and setattr_copy().
> + *
> + * Return: ATTR_KILL_SGID if setgid bit needs to be removed, 0 otherwise.
> + */
> +int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
> +                            const struct inode *inode)
> +{
> +       umode_t mode = inode->i_mode;
> +
> +       if (!(mode & S_ISGID))
> +               return 0;
> +       if (mode & S_IXGRP)
> +               return ATTR_KILL_SGID;
> +       return setattr_drop_sgid(mnt_userns, inode,
> +                                i_gid_into_vfsgid(mnt_userns, inode));
> +}
> +
>  /**
>   * chown_ok - verify permissions to chown inode
>   * @mnt_userns:        user namespace of the mount @inode was found from
> diff --git a/fs/internal.h b/fs/internal.h
> index 6f0386b34fae..988e123d3885 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -234,3 +234,5 @@ int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>                 struct xattr_ctx *ctx);
>
>  ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
> +int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
> +                            const struct inode *inode);

Please add a section:
/*
 * fs/attr.c:
 */

Might as well as the missing section for read_write.c
above __kernel_write_iter() while at it.

Thanks,
Amir.
