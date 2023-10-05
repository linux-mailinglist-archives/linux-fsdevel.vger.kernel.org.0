Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1617BA2DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJEPsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJEPsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:04 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E749E0;
        Wed,  4 Oct 2023 22:09:11 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4526d872941so301257137.1;
        Wed, 04 Oct 2023 22:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696482550; x=1697087350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXtjeW9JdbsAOiLNM143QmEMkW6sJ8krIsKqBhO1k2A=;
        b=PzLvWkjjabIF9ofjpZO+ShzuGPsvzk60jFD2cwuIkh8JRpShJFXIRUD3cjXuvaUvE2
         aHETRpqhiqROo9FuKx5j9ktm4+GaFYIN4xL/izUGLp2d1w4zJrqZ1jQEfqpIhjykcinQ
         oD+Cv02i/tim1dDZPBuFC6g2INQe7ae8+vY9w1/Kvv/QbFEfht+WuDmEMSSQbxFNGruy
         y5OFlo6NsgqoBM5JL45IU9E0vgHbcAdEFUn6CK8s6uSaYx6+2aKEl2ZvxSdQokhaowqf
         wkFXOW3SAm8yTOPcubQ/uD99lKmUPQbj+tX6ZdVxaUChx9UpigjYvIdGL3m3pMUqanjV
         ruGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482550; x=1697087350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXtjeW9JdbsAOiLNM143QmEMkW6sJ8krIsKqBhO1k2A=;
        b=G73tjMOGSi+MSa0URag05LZIvqXYAo9VKMRqpgn1laR1m8Udr51+csOQ4b1rNuC5S4
         Y12E6IwhrIiQR4x4V45NyZaUWEEFo5VOmOuv83MLlLr7Kx8hvyHb7GMMIydIdQ1MY82V
         XvkJBCErNuSgicSdfcHkjTYFzA0cmJ8kzkX8e2rOTkKvXiPYguR4LHAEi+wk9OaQtmhh
         NdD6Z9QM0UKDu+JZ+JiA7Sz8J/2RCr1THrIDSAJh7cKETk4EVF1S6zmZFXrSHo7hMnRU
         mMR9Sb6G1Q0w/+ZFFUSMo2e1yxoGVc3yfl6SCJheI1nRUNTZYqGTSoOKNbQWnlIYnsjw
         ZoRw==
X-Gm-Message-State: AOJu0Yw82GrGBH6ROWMalzo6y0Sa4zq+ZwnnSmGAs35Wnca1NOmQCDNb
        eT9u+qK52K2aBk3VP3nKu92xWNb2DjCNypZIHvw=
X-Google-Smtp-Source: AGHT+IGwgYXJ62dNQlWEcT3vnSbRBGwbK+d6IBa0dPOpYJYEtDFz1+H9jTI8mC7Xi5XdJPcWxpnnjRSxUHP7L7Z0TNA=
X-Received: by 2002:a67:f64e:0:b0:452:60c5:20b with SMTP id
 u14-20020a67f64e000000b0045260c5020bmr4338723vso.15.1696482550170; Wed, 04
 Oct 2023 22:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231004185530.82088-1-jlayton@kernel.org> <20231004185530.82088-3-jlayton@kernel.org>
In-Reply-To: <20231004185530.82088-3-jlayton@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Oct 2023 08:08:59 +0300
Message-ID: <CAOQ4uxgtyaBTM1bOSSGmsk+F4ZwsK+-N5ZZ3wAt_nv_E6G3C7Q@mail.gmail.com>
Subject: Re: [PATCH v2 89/89] fs: move i_generation into new hole created
 after timestamp conversion
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 4, 2023 at 9:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> The recent change to use discrete integers instead of struct timespec64
> shaved 8 bytes off of struct inode, but it also moves the i_lock
> into the previous cacheline, away from the fields that it protects.
>
> Move i_generation above the i_lock, which moves the new 4 byte hole to
> just after the i_fsnotify_mask in my setup.

Might be good to mention that this hole has a purpose...

>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 485b5e21c8e5..686c9f33e725 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -677,6 +677,7 @@ struct inode {
>         u32                     i_atime_nsec;
>         u32                     i_mtime_nsec;
>         u32                     i_ctime_nsec;
> +       u32                     i_generation;
>         spinlock_t              i_lock; /* i_blocks, i_bytes, maybe i_siz=
e */
>         unsigned short          i_bytes;
>         u8                      i_blkbits;
> @@ -733,7 +734,6 @@ struct inode {
>                 unsigned                i_dir_seq;
>         };
>
> -       __u32                   i_generation;
>
>  #ifdef CONFIG_FSNOTIFY
>         __u32                   i_fsnotify_mask; /* all events this inode=
 cares about */

If you post another version, please leave a comment here

+         /* 32bit hole reserved for expanding i_fsnotify_mask to 64bit */

Thanks,
Amir.
