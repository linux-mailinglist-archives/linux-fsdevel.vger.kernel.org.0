Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD84600E6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJQMA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJQMAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:00:49 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD562CE2A;
        Mon, 17 Oct 2022 05:00:41 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id x66so2510736vsb.3;
        Mon, 17 Oct 2022 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ISRtwPj9Tmi5akhQwYIhiWo2gl9XJ4+kMqUQVQ2ezcA=;
        b=b8FhTx8mJIvW3Gxp2Npq+FQ5x42W1SjbGmDB5gD8vZYjbqvMqenQk+R0XRem4pliKH
         83E7kAFxVFv4SWKRwQhXIsN+5iCdkLi/5y9CDOmY0jj7mqirC3R/xXyv8jPozIMSYRlP
         Uoti4l4NEvYWFMvp6hGc1EoyAGuE4OV6y+6iI7LivNSkAEwauD99diwiFyw8Fro8Jdux
         17e8NlA7ycZqYUY621dfD4RF8bovr0ufNpyleMIgYh0xsl+WQocwT4LWhTNTmlBrSKL2
         G2trCJZN1oNXPK+A8l+eUJ0vq3jUQFbcwvkw4Tp6uQV7qw4CZZR6lwhEVSFm0nK9epPY
         C7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISRtwPj9Tmi5akhQwYIhiWo2gl9XJ4+kMqUQVQ2ezcA=;
        b=AzXbE4FFzOutFT7vgmdPi4clngf9FQSbzsiOaBfjSAtYnqpFPxptVvziuKZZGFkezS
         nF59XD72pjKzWc3/SKWInAn9rm2sGJcGDViJDQNdBZuInqU4uDKSy308fp4utqQbYd1x
         EDp7++zAjp9KSsvOMJrS1iOE9jHsrG2RnMDcIf5BklH4W7SWSqRT+mH6+G8Bba8CXyHC
         W4SMlrGZFOmczYBtyEmlPSQXKJsUENlPTUjV36HpRSpl+eHH4IC/JbzpeoAprabO3iai
         qTKT0X9Ue8JwrV0+RDKMSbotPkMobo5+xgRbgYf7tT2D3OvUYYHF4wWX6rVfkzhxgKkh
         +zEA==
X-Gm-Message-State: ACrzQf1gmMOdQ21tviBezzC4WKxtj0/Vt5dryJSoxvIPHg9URPDyQ2dl
        Rdux+tixb4hJisB+fLB5bCfRGEFNcqqg8qzujcA=
X-Google-Smtp-Source: AMsMyM5DMQAPNgC7zJ1gBPsKuHTS+eFdTkJ0VuarVoMIotoXcxowOPIHciYsj0MgKS320bT5NOeaPtfljguyey3Hwcc=
X-Received: by 2002:a67:c190:0:b0:3a7:e91:9072 with SMTP id
 h16-20020a67c190000000b003a70e919072mr4186451vsj.36.1666008040567; Mon, 17
 Oct 2022 05:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221017100600.70269-1-brauner@kernel.org> <20221017100600.70269-2-brauner@kernel.org>
In-Reply-To: <20221017100600.70269-2-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Oct 2022 15:00:29 +0300
Message-ID: <CAOQ4uxhN9zrgH9YrAd1vj6W60jQ3dvBokT2DR1dwE-mg0Mj44A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] attr: add setattr_drop_sgid()
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
> In setattr_{copy,prepare}() we need to perform the same permission
> checks to determine whether we need to drop the setgid bit or not.
> Instead of open-coding it twice add a simple helper the encapsulates the
> logic. We will reuse this helpers to make dropping the setgid bit during
> write operations more consistent in a follow up patch.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>
> Notes:
>     /* v2 */
>     patch added
>
>     /* v3 */
>     Amir Goldstein <amir73il@gmail.com>:
>     - Return 0 or ATTR_KILL_SGID to make all dropping helpers behave similarly.
>
>  fs/attr.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 1552a5f23d6b..8bc2edd6bd3c 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -18,6 +18,27 @@
>  #include <linux/evm.h>
>  #include <linux/ima.h>
>
> +/**
> + * setattr_drop_sgid - check generic setgid permissions
> + * @mnt_userns:        user namespace of the mount @inode was found from
> + * @inode:     inode to check
> + * @vfsgid:    the new/current vfsgid of @inode
> + *
> + * This function determines whether the setgid bit needs to be removed because
> + * the caller lacks privileges over the inode.
> + *
> + * Return: ATTR_KILL_SGID if the setgid bit needs to be removed, 0 if not.
> + */
> +static int setattr_drop_sgid(struct user_namespace *mnt_userns,
> +                            const struct inode *inode, vfsgid_t vfsgid)
> +{
> +       if (vfsgid_in_group_p(vfsgid))
> +               return 0;
> +       if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +               return 0;
> +       return ATTR_KILL_SGID;
> +}
> +
>  /**
>   * chown_ok - verify permissions to chown inode
>   * @mnt_userns:        user namespace of the mount @inode was found from
> @@ -140,8 +161,7 @@ int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
>                         vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
>
>                 /* Also check the setgid bit! */
> -               if (!vfsgid_in_group_p(vfsgid) &&
> -                   !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +               if (setattr_drop_sgid(mnt_userns, inode, vfsgid))
>                         attr->ia_mode &= ~S_ISGID;
>         }
>
> @@ -251,9 +271,8 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
>                 inode->i_ctime = attr->ia_ctime;
>         if (ia_valid & ATTR_MODE) {
>                 umode_t mode = attr->ia_mode;
> -               vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
> -               if (!vfsgid_in_group_p(vfsgid) &&
> -                   !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +               if (setattr_drop_sgid(mnt_userns, inode,
> +                                     i_gid_into_vfsgid(mnt_userns, inode)))
>                         mode &= ~S_ISGID;
>                 inode->i_mode = mode;
>         }
> --
> 2.34.1
>
