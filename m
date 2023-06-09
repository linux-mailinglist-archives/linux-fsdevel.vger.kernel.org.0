Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5E729838
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjFILbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbjFILbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:31:01 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FB72722;
        Fri,  9 Jun 2023 04:30:56 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78a065548e3so664820241.0;
        Fri, 09 Jun 2023 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686310255; x=1688902255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwVZ/XGE5c1QHahOLiLLnyyW3+3Yf1nA497g14ni8wc=;
        b=oDqrXSOs+YFWq/Q8G9zFbNPBovK5/HQNmpxPRsFtGWflpChzj0woCBmxikTPH16ewP
         YZVI7O+PtKUQXtK5dEbfquybUSJ/NaSAsIIMWroXk4ZvsrWy6Ca3gxW/fIP0llwltxgD
         uUBddVB29ViEVhLq+VUsKhf2XYKtERnjjiqbHYU2qMZJe8uK0YodWnEf1b+KGjSTkcz1
         J89xAOcEAVjWxvCYraKTB1kpinzVg0/72O+MM4SoWjDj2zcn7WSTs/rQhe3bCjYWDtyV
         1LbLtOxBifkcN2SOlftFFvZsw7Ak2MIstiw/lKoeqgOPFX4jNYrAmxOXWLuTwe3EkVY/
         ad5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310255; x=1688902255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwVZ/XGE5c1QHahOLiLLnyyW3+3Yf1nA497g14ni8wc=;
        b=SFxR4FqQrQqCja0SixoU8/JyjdAzCjrPSCV5BCYThhwmdfSs+jMgccrqKb5rXgMYYb
         J89WCfQ606le2XoQNMoLJcO3v1/+gAInuMlf8VyOusXK8Gv0vqR7ADc2VFsnv3Ojy6Dz
         NLGa/HRxYKbyqxUMMuM9rAZuCs0JkFyfbUiWGfziwEEvIC0+klcBGyzWKuGvuVDhMDlR
         fkBR+CmpmB6FxjqJN+RsiCU0fxuBAvLg1kqIp2ZletOAlBP6cIATzfRpKsYfRO3qMTce
         N6UYDEUs1Zl8mr8NUiAMWJo76FwxJ/3z9O8d+iDz1bmJueKTuHz7TccxSHuV1FTDXH6u
         ZUWg==
X-Gm-Message-State: AC+VfDwrgLT9XZPcp8DEsdXnuge5I6EK0TF927RD+YbKdOYgnym+dxtM
        dSNblldU2jSIVIl3H70WghykTqYDEZe2gWAaIRELZ9O3
X-Google-Smtp-Source: ACHHUZ4TC6JTFaTdFc3WPfcfbb4LsGKQWCQT7OENifXBua54rpFYDeaR/2ZeZS0ZRe/zB/oejiriYWqwhFh8tEOoVEo=
X-Received: by 2002:a67:fd52:0:b0:43c:8c56:14a9 with SMTP id
 g18-20020a67fd52000000b0043c8c5614a9mr773863vsr.9.1686310255422; Fri, 09 Jun
 2023 04:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <20230609073239.957184-4-amir73il@gmail.com>
 <20230609-bannmeile-speziell-54dc72b5008c@brauner>
In-Reply-To: <20230609-bannmeile-speziell-54dc72b5008c@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 14:30:44 +0300
Message-ID: <CAOQ4uxjC_VpdKFmWKghLGv-CczfeZRbZAXrdztSctZPnx+2rTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] fs: store fake path in file_fake along with real path
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
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

On Fri, Jun 9, 2023 at 2:12=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 09, 2023 at 10:32:39AM +0300, Amir Goldstein wrote:
> > Instead of storing only the fake path in f_path, store the real path
> > in f_path and the fake path in file_fake container.
> >
> > Call sites that use the macro file_fake_path() continue to get the fake
> > path from its new location.
> >
> > Call sites that access f_path directly will now see the overlayfs real
> > path instead of the fake overlayfs path, which is the desired bahvior
> > for most users, because it makes f_path consistent with f_inode.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> If you resend, can you take the chance and refactor this into a slightly =
more
> readable pattern, please? So something like
>

Sure!
I like this better myself.

Thanks,
Amir.

> struct file *open_with_fake_path(const struct path *fake_path, int flags,
>                                  const struct path *path,
>                                  const struct cred *cred)
> {
>         int error;
>         struct file *f;
>
>         f =3D alloc_empty_file_fake(fake_path, flags, cred);
>         if (IS_ERR(f))
>                 return f;
>
>         f->f_path =3D *path;
>         error =3D do_dentry_open(f, d_inode(path->dentry), NULL);
>         if (error) {
>                 fput(f);
>                 return ERR_PTR(error);
>         }
>
>         return f;
> }
