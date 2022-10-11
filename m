Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF65FAE45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJKISo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 04:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJKISh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:18:37 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CCF1EED1;
        Tue, 11 Oct 2022 01:18:35 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id a2so7852046vsc.13;
        Tue, 11 Oct 2022 01:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaheBaRp5TcVVpSBK7O5cM3Vq/ZCNTD9c/ziBAJcYIY=;
        b=OV1Gm89ah1AA3qB9b5GKrf8cD4ZV4MVFAOUe9RqhkyE2nuJX4kY+TUrin4jud4uR4r
         ghAjy4K/IHeHy3vgKP0ekA9L5rWX1a8UGKnKmi7634eS1mFpXpqXvjHiumTmQnVybWHW
         O6gQEshd0WuMIxgTGl4ZRf7F06scKTEl7lS6IlzDfF3N7CYS/XImvhekJEeaCx8LUfy6
         6+E54Xpdq/DZBilryl9QvCSef5pU2Y+cj0Q1tugMOC1BFMFT1FqrOgw96wJg/W6ABOsO
         4D3thfaCJrrYd1vL8/DbGIkaK05Y86JuwkkocWA7vkXxmMuGOwgZMsfecqV/kGQ5coda
         9gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaheBaRp5TcVVpSBK7O5cM3Vq/ZCNTD9c/ziBAJcYIY=;
        b=x8sRSMgqBHlXZ9NAwfIxfYcmOrPxAum4KvAzCJihf+vc5TU1JsiboeauAhrm/j89FP
         nS2TZksrbXmt3ZXdpcupBMREodCbpdHgHZp3Ygrvs94GE5PQ53bnqvnwYBMyRgDKsfAG
         8Xi3fpRduQ2SEkBh4E7zXl3ZF8delWZZwL8T6NpumnXoCQT+RD8KhxyyoZ63qfteoyxC
         CXWSO0y746gULFS0u7KcenApE1eb2UZUwbkj8JVXBpCptSAeIbCeL2NDjXvwhbxD1ynL
         90Vmw8EmqltI3vq9VFILzyj8dGakzYalpxQkcsEcVJV5hMsoBgh2EZuFQekQ5q0NrCZZ
         mH3g==
X-Gm-Message-State: ACrzQf2zulTvJlWjiViDDwUEe5GMsUjK9lpLWkt7ZvhfxTad1vfc09GT
        nu6PhmpEEfdRaHbFp+ZRfeDe2gtu46k3yoHNWhA=
X-Google-Smtp-Source: AMsMyM7EmK7eGxeRSkHBbpeDiVSKBTYd8bDEnPCqxh9N66MNy7O9ADE/rItk3lApm8fpKnjQuoxlYnDPQn9bziFrKkU=
X-Received: by 2002:a67:a248:0:b0:3a5:38a0:b610 with SMTP id
 t8-20020a67a248000000b003a538a0b610mr10438809vsh.2.1665476314211; Tue, 11 Oct
 2022 01:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221007140543.1039983-1-brauner@kernel.org> <20221007140543.1039983-3-brauner@kernel.org>
In-Reply-To: <20221007140543.1039983-3-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Oct 2022 11:18:22 +0300
Message-ID: <CAOQ4uxic0+=QH1-=zzHgNnn1KTpMuLK-j3-AXJtFe5+t9yWs+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] attr: add should_remove_sgid()
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

On Fri, Oct 7, 2022 at 5:06 PM Christian Brauner <brauner@kernel.org> wrote:
>
> The current setgid stripping logic during write and ownership change
> operations is inconsistent and strewn over multiple places. In order to
> consolidate it and make more consistent we'll add a new helper
> should_remove_sgid(). The function retains the old behavior where we
> remove the S_ISGID bit unconditionally when S_IXGRP is set but also when
> it isn't set and the caller is neither in the group of the inode nor
> privileged over the inode.
>
> We will use this helper both in write operation permission removal such
> as file_remove_privs() as well as in ownership change operations.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Looks good.
Some suggestions below.

> ---
>
> Notes:
>     /* v2 */
>     Dave Chinner <dchinner@redhat.com>:
>     - Use easier to follow logic in the new helper.
>
>  fs/attr.c     | 27 +++++++++++++++++++++++++++
>  fs/internal.h |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index b1cff6f5b715..d0bb1dae425e 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -39,6 +39,33 @@ static bool setattr_drop_sgid(struct user_namespace *mnt_userns,
>         return true;
>  }
>
> +/**
> + * should_remove_sgid - determine whether the setgid bit needs to be removed
> + * @mnt_userns:        User namespace of the mount the inode was created from
> + * @inode: inode to check
> + *
> + * This function determines whether the setgid bit needs to be removed.
> + * We retain backwards compatibility and require setgid bit to be removed
> + * unconditionally if S_IXGRP is set. Otherwise we have the exact same
> + * requirements as setattr_prepare() and setattr_copy().
> + *
> + * Return: ATTR_KILL_SGID if setgid bit needs to be removed, 0 otherwise.
> + */
> +int should_remove_sgid(struct user_namespace *mnt_userns,
> +                      const struct inode *inode)
> +{
> +       umode_t mode = inode->i_mode;
> +
> +       if (!(mode & S_ISGID))
> +               return 0;
> +       if (mode & S_IXGRP)
> +               return ATTR_KILL_SGID;
> +       if (setattr_drop_sgid(mnt_userns, inode,
> +                             i_gid_into_vfsgid(mnt_userns, inode)))
> +               return ATTR_KILL_SGID;
> +       return 0;

If you take my suggestion from patch 1/5, that would become:

    return setattr_should_remove_sgid(mnt_userns, inode,
                                 i_gid_into_vfsgid(mnt_userns, inode));

> +}
> +
>  /**
>   * chown_ok - verify permissions to chown inode
>   * @mnt_userns:        user namespace of the mount @inode was found from
> diff --git a/fs/internal.h b/fs/internal.h
> index 87e96b9024ce..9d165ab65a2a 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -221,3 +221,5 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
>  int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
>  int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>                 struct xattr_ctx *ctx);
> +int should_remove_sgid(struct user_namespace *mnt_userns,
> +                      const struct inode *inode);

I realize that you placed this helper in attr.c to make
setattr_drop_sgid() static, but IMO the code will be clearer to readers
if all the family of suig/sgid stripping helpers were clustered together
in inode.c where it will be easier to get the high level view.

Thanks,
Amir.
