Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82CA4E231B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbiCUJQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 05:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiCUJQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:16:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A360F33EA1;
        Mon, 21 Mar 2022 02:15:14 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a11so7484251qtb.12;
        Mon, 21 Mar 2022 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UDlYPAQBAOlLXBbFBOerVAwIN2CtIDqxO6mOQnxtBt8=;
        b=W8Byhw7YaHbu5C9YCddrrjz9P8+J4EhFPoPEWcsXXW1b7sOaCfegJrcK6DZhkDyc9b
         oLOXTXJK4Zwtr09FZhmSM8CvJC5UsvlUnD4+gFWtW5P3H/4mED8PfbagF4rpjrP4sscJ
         TkFrT6KdhDKZbE5V3ifobaWetZJN+m9cbwz+7y8nvt6J7CEzH9FqnT5xZZRw0lDnwOkB
         ElqLVe8UQ7xPH3U4QDaagnvdD4rWNWZ8KjVFyqt30SqRzPlCSvdmE6QBH0NV97FP4+sX
         lTYsw79fgdj/V5IaeeTP1GQLrCOaMuxsmm2VHRFR1+Ebk39iDKdaOMkS7tBnujXM5+9+
         TmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UDlYPAQBAOlLXBbFBOerVAwIN2CtIDqxO6mOQnxtBt8=;
        b=MOmIY+3//3H6DrWMaMtUOTLfxRscQYZsVmU2C7wJvEfmDhNK/6A/cxjA0W7Eg1BI2Q
         A0s1f9Ombd8dPnE9g3ldSv6zqwv0dP9vaLMIAO4V/Sfw316gE+tA9GfopL0ksmoqv8V9
         xvQ2ZD2lmlKUchfGpXqZrA8xWYxQOGospJ0KQ0bi7JfX8SabZNHPQZ9bg+jx0Id5XK1U
         7W/cOB4U6mQ6bIehiwL6HMWo9flj6nOeL8k5rTFss1EBiIg8HeqrFD+3O3TVkL5sG2Uv
         RDu6ZChHaQr3lxxmbYW24gtlAqci1jXWkN/eva5wVXZNA3bubAADAA8Q0Qf8SIqw7+4L
         oxog==
X-Gm-Message-State: AOAM5315wCDWa7felJqPDRlF9O7zPxxCDBybiyl6SF7Hr3RX00yJUK5V
        KbsI/cH/1a+qEhM4xn9ik1vHXtdmri7xt4G5BligHGM6tuc=
X-Google-Smtp-Source: ABdhPJx6afM3anilCbMCFrKf4jg+CYfcVO0zYYZm56r5PmbeJlvV/EOJLyPGEyQCfRZG2xHq9Ghe76SJ3VlQC5uOtsY=
X-Received: by 2002:a05:622a:143:b0:2e0:b7c8:3057 with SMTP id
 v3-20020a05622a014300b002e0b7c83057mr15557151qtw.179.1647854113688; Mon, 21
 Mar 2022 02:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiUJVaACDyWkEhpC5Tfk233t-Tw6_f-Y99KLUDqv6dEq0tw@mail.gmail.com>
 <YjMFTSKZp9eX/c4k@localhost.localdomain> <CAPmgiUJsd-gdq=JG1rF8BHfpADeS45rcVWwnC2qKE=7W1EryiQ@mail.gmail.com>
 <YjdVHgildbWO7diJ@localhost.localdomain>
In-Reply-To: <YjdVHgildbWO7diJ@localhost.localdomain>
From:   hui li <juanfengpy@gmail.com>
Date:   Mon, 21 Mar 2022 17:15:02 +0800
Message-ID: <CAPmgiUK90T212icXkSJ2vSiCjXbUqO-fptNLL7NF6SMDAyTtRg@mail.gmail.com>
Subject: Re: [PATCH] proc: fix dentry/inode overinstantiating under /proc/${pid}/net
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

proc_misc_dentry_ops is a general ops for dentry under /proc, except
for "/proc/${pid}/net"=EF=BC=8Cother dentries may also use there own ops to=
o,
so I think change proc_misc_d_delete may be better?
see patch under: https://lkml.org/lkml/2022/3/17/319

Alexey Dobriyan <adobriyan@gmail.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=80 00:24=E5=86=99=E9=81=93=EF=BC=9A
>
> When a process exits, /proc/${pid}, and /proc/${pid}/net dentries are flu=
shed.
> However some leaf dentries like /proc/${pid}/net/arp_cache aren't.
> That's because respective PDEs have proc_misc_d_revalidate() hook which
> returns 1 and leaves dentries/inodes in the LRU.
>
> Force revalidation/lookup on everything under /proc/${pid}/net by inherit=
ing
> proc_net_dentry_ops.
>
> Fixes: c6c75deda813 ("proc: fix lookup in /proc/net subdirectories after =
setns(2)")
> Reported-by: hui li <juanfengpy@gmail.com>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  fs/proc/generic.c  |    4 ++++
>  fs/proc/proc_net.c |    3 +++
>  2 files changed, 7 insertions(+)
>
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -448,6 +448,10 @@ static struct proc_dir_entry *__proc_create(struct p=
roc_dir_entry **parent,
>         proc_set_user(ent, (*parent)->uid, (*parent)->gid);
>
>         ent->proc_dops =3D &proc_misc_dentry_ops;
> +       /* Revalidate everything under /proc/${pid}/net */
> +       if ((*parent)->proc_dops =3D=3D &proc_net_dentry_ops) {
> +               pde_force_lookup(ent);
> +       }
>
>  out:
>         return ent;
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -376,6 +376,9 @@ static __net_init int proc_net_ns_init(struct net *ne=
t)
>
>         proc_set_user(netd, uid, gid);
>
> +       /* Seed dentry revalidation for /proc/${pid}/net */
> +       pde_force_lookup(netd);
> +
>         err =3D -EEXIST;
>         net_statd =3D proc_net_mkdir(net, "stat", netd);
>         if (!net_statd)
