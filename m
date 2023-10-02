Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3AD7B4B3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 07:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjJBFwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 01:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBFwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:52:10 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBECAC
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 22:52:07 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45281e0b1cbso7634447137.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Oct 2023 22:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696225927; x=1696830727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPF2JrzMLrpjSNOh/QwQNQRdDUu3VGGsdP7xdlHzhxE=;
        b=RIvWz38HGUPZUfta3iFyCdQNDK1vuaZntk56WBDJIQbMo7zztW1oCt7+hyy69tBAug
         4M0oMQlChevLWKcJufg7dYGd5l0LyV4nBftM3I7ro9cMMfrM7zHDEamkMqoZNgP9gUAQ
         4eY1d10mrydRNOf0/itlrBIhU/OLrLHxXEaoPHaybmk7yORNOYJ3UEn2GH3UmEmKfjzw
         qP8ZAnoAKrbJ2GdPpZipRoc1LZvJh8ykZdplnHETZM3eCUHG53veS4ZHpMZdiw70CPtG
         E7VyFjgX0e00k+4Sc33nh+kWrG0PnP9ZD0VGxVWafpjRBcmanP8E5txXlam7cIsr+Qy2
         ce7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696225927; x=1696830727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPF2JrzMLrpjSNOh/QwQNQRdDUu3VGGsdP7xdlHzhxE=;
        b=ai3B9x3URDrL2vwX7A8fwyU11x7cmHkEujaCNoiedbEyNgngLlQeyjVqcx7uBgqO4/
         2bXwn50dUzgbiSShqB3gP74EkvvuKrOzr6V24btzvwmNzbYFe0L31KKslQIqyI3R43Uy
         6QoHONg0j6clBsGLSfVDjN3K0NQuAetd0QBtHDay0s0BV9klCfADf4rDrFYLGHOh7oL9
         AGptEjp6/NXHjFh0A6SwybIFG7AXZ8obZ9hhHSKY1Fr/CBA054/cbm6OqW6xSFupiWnY
         VLrNTwvnfCYl/fVjaJkUXmmdT2Rkde1lblUadxpiyOEWO48w9diWFUuiEmJgx1ittqiu
         tdfg==
X-Gm-Message-State: AOJu0Ywp+GWacXTyEzdcBropAd3VrAbqiDdvr4DFvsBOjaHCr4nDaBDZ
        z4FXp/MoftIdI9E1fI9u8d/zN+ns88ea2wO+PCo=
X-Google-Smtp-Source: AGHT+IHula8tWu/42ZMU6QADTU6S2k1XNDtwa1m4CRidbp6MYLDuTiJQiM7HrV7vONUcqJLy6iiglouIYp71qRGNan4=
X-Received: by 2002:a67:fc19:0:b0:452:b574:3c9e with SMTP id
 o25-20020a67fc19000000b00452b5743c9emr9177541vsq.6.1696225926695; Sun, 01 Oct
 2023 22:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV> <20231002023613.GN3389589@ZenIV>
In-Reply-To: <20231002023613.GN3389589@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 08:51:55 +0300
Message-ID: <CAOQ4uxhrKG-xB05Y-SMyYps3boraG40CzNCP+KhkKzBA5vtbCg@mail.gmail.com>
Subject: Re: [PATCH 13/15] overlayfs: move freeing ovl_entry past rcu delay
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 5:36=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> ... into ->free_inode(), that is.
>
> Fixes: 0af950f57fef "ovl: move ovl_entry into ovl_inode"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index def266b5e2a3..f09184b865ec 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -167,6 +167,7 @@ static void ovl_free_inode(struct inode *inode)
>         struct ovl_inode *oi =3D OVL_I(inode);
>
>         kfree(oi->redirect);
> +       kfree(oi->oe);
>         mutex_destroy(&oi->lock);
>         kmem_cache_free(ovl_inode_cachep, oi);
>  }
> @@ -176,7 +177,7 @@ static void ovl_destroy_inode(struct inode *inode)
>         struct ovl_inode *oi =3D OVL_I(inode);
>
>         dput(oi->__upperdentry);
> -       ovl_free_entry(oi->oe);
> +       ovl_stack_put(ovl_lowerstack(oi->oe), ovl_numlower(oi->oe));
>         if (S_ISDIR(inode->i_mode))
>                 ovl_dir_cache_free(inode);
>         else
> --
> 2.39.2
>
