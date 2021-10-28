Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A967043DD10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 10:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJ1IqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 04:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhJ1IqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635410635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KccYG4rSdcXMoVRo53pQg4Ozdzh38yw0Q7oh7hWL/OA=;
        b=W53oVEaDQzM8VF6YoIGich0YcmQU7TxrAmiqolsqmbApNLJD5N0jCCnjEoOjGsd2oNqg2x
        vIjegVBS5fClyOdzmOHGzoycz8fSkZNNJeLO3f3KXjBC6eJoGv/qXcsDF6b5+9+qTc7Z4K
        Tn72LK5p6uxxzsfaHbRvF0tZfq88XiU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-2-Ea0XXNNDmdKjjx0Wq8Rw-1; Thu, 28 Oct 2021 04:43:54 -0400
X-MC-Unique: 2-Ea0XXNNDmdKjjx0Wq8Rw-1
Received: by mail-qk1-f198.google.com with SMTP id w11-20020a05620a128b00b00462a7984b96so3403091qki.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 01:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KccYG4rSdcXMoVRo53pQg4Ozdzh38yw0Q7oh7hWL/OA=;
        b=yFXswgfIDE/uMU/UQfQZbHC0tu8ydyXuVckGN8/uAd8nRmJHH0ZX5eCZdb/NaCGfm4
         zAd18uEP22SwtszE7FLMihYQ/qj6VuFOdFKTOxOqSm6V3xic85jhq6dmouNzDRWuvah3
         fejBfKBBvGvxXVFKVgQpA8+aVq3H1KWJUBVHpXy/njh42CdBvokyWLS+DB8OJABYztWi
         r9mQKUM47HOhTOb6aGedXABJFxqT9V/zTFTkImKi7ql/isH0AuGDEhbfnt3orcV6tGUY
         tOX2xH9mAAn/10xlIXcIwdj93eu2ylJHsmgW91oqpKAUeMEMqTx0V1DmpNkvIgsEpFt9
         KFig==
X-Gm-Message-State: AOAM5323dJk2wKRBT3UJRh5jSSHGVDZ+mjCA31O8HDkyctbk3E4eitr6
        Judxx2lHcooA3p6Y/KjWL5h0ouDjknZ2E+uQa7t1FhAXajWTIXt+exF8qRuW+p36M6WWjk4S7I6
        +r0WL3UtiTyLSnt7UNlrnyfACQeYxyLA+CNeg15urpQ==
X-Received: by 2002:a05:620a:15f3:: with SMTP id p19mr2422628qkm.337.1635410634134;
        Thu, 28 Oct 2021 01:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzArBk6z7YGdByxd/X+igic/KcScZxC371ErWZ5REyS2JhtSA3Npou6sTwbdZL/ZSDM/1i2lyGhR3evMJPw0lI=
X-Received: by 2002:a05:620a:15f3:: with SMTP id p19mr2422618qkm.337.1635410633974;
 Thu, 28 Oct 2021 01:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211021151528.116818-1-lmb@cloudflare.com> <20211021151528.116818-2-lmb@cloudflare.com>
 <b215bb8c-3ffd-2b43-44a3-5b25243db5be@iogearbox.net>
In-Reply-To: <b215bb8c-3ffd-2b43-44a3-5b25243db5be@iogearbox.net>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu, 28 Oct 2021 10:43:43 +0200
Message-ID: <CAOssrKciL5EDhrbQe1mkOrtD1gwkrEBRQyQmVhRE8Z-Kjb0WGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] libfs: support RENAME_EXCHANGE in simple_rename()
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 1:46 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> [ Adding Miklos & Greg to Cc for review given e0e0be8a8355 ("libfs: support RENAME_NOREPLACE in
>    simple_rename()"). If you have a chance, would be great if you could take a look, thanks! ]
>
> On 10/21/21 5:15 PM, Lorenz Bauer wrote:
> > Allow atomic exchange via RENAME_EXCHANGE when using simple_rename.
> > This affects binderfs, ramfs, hubetlbfs and bpffs. There isn't much
> > to do except update the various *time fields.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >   fs/libfs.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index 51b4de3b3447..93c03d593749 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -455,9 +455,12 @@ int simple_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
> >       struct inode *inode = d_inode(old_dentry);
> >       int they_are_dirs = d_is_dir(old_dentry);
> >
> > -     if (flags & ~RENAME_NOREPLACE)
> > +     if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
> >               return -EINVAL;
> >
> > +     if (flags & RENAME_EXCHANGE)
> > +             goto done;
> > +

This is not sufficient.   RENAME_EXCHANGE can swap a dir and a
non-dir, in which case the parent nlink counters need to be fixed up.

See shmem_exchange().   My suggestion is to move that function to
libfs.c:simple_rename_exchange().

Thanks,
Miklos

