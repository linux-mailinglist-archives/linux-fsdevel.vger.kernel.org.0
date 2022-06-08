Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4154304E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiFHM3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 08:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiFHM3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:29:06 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A2197633;
        Wed,  8 Jun 2022 05:29:04 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id b81so8929394vkf.1;
        Wed, 08 Jun 2022 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f4V/IVq1SDeom2vqT5N+sNfIDOM6t2OTeeKHOwD8dgU=;
        b=pVjO1TAswW7Hhn2+lFzvRdcMwOw+WmK2bljOQKFQ+RAOtqLXCZ0F17V3HRHhYkFi9w
         MyIKoR2lZP3t1HsfLpIrB+Wcd2O8uON+0fA/fWHpqQIVFpxWkQR45PEusG15UdjyxVJ5
         9NAno4FgTzlwGxa3SKjPPeyNA7ZeAV4KLuDQavEHZIY5aqjPcv+wP0FuziBHxy+DVsSu
         ee0GH/81eTRUCUcalKp2ZboUIDhm2b7bKAD9WJbziuGlDQLvGa3OqLFNX+MdhiqFNp9x
         49Evmr88+qwbBSMfikgfmDDkuaMzSBR7yFSEcBKsTUHX/3SLmLnMyhW6eYr8Ts/2MjPx
         QPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f4V/IVq1SDeom2vqT5N+sNfIDOM6t2OTeeKHOwD8dgU=;
        b=BqHQMiECIei0LdGNv9bKplAkZ+6LCx7URkCdxv49usmButOURVngTjk1e6oQN4wSBr
         qdvTkSLpHXzd5JESfYpXBnAGLk1ajDKh3BtiNEg2IjW85rzet2T5OwB/pm6fbdzpAR3N
         tmcLmF6mkbDxiuIQqmAT7QT6qPz2GKSH/37x5KSnS/J5avx2VgY+H552dzvszwAzJO8p
         jyfUVyDHBVr/dmocqmBu1mmSNT89JyBcHhMwP4SV3KwN1QMXzJ7ZLLWlhdbOTsCkeqjr
         jdqx9rulSbZmEIjOYK/ktqgwBWAY+Rz46m39sELQRP/S6LCslFcEKb4wzTHBzsryE4gc
         8RHw==
X-Gm-Message-State: AOAM533KqNOLCQqR8gIPwM9FDj5Q8druLYZREqosu8QSxdTDB9wKIA8X
        Ii4Z+AoJ9cbN+zvIfZwFISURWAbO1UyFdPEeHgc=
X-Google-Smtp-Source: ABdhPJz+JRSH7Idqz2ZYYyaHo9knqc1AnXrfwLvNptq2n0uw8RR6U3EXffp2wvgixb9A4ygoHKoQfkN8+4owOPQWuU8=
X-Received: by 2002:a05:6122:2205:b0:321:230a:53e1 with SMTP id
 bb5-20020a056122220500b00321230a53e1mr18619635vkb.25.1654691343974; Wed, 08
 Jun 2022 05:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com> <20220608112728.b4xrdppxqmyqmtwf@wittgenstein>
In-Reply-To: <20220608112728.b4xrdppxqmyqmtwf@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jun 2022 15:28:52 +0300
Message-ID: <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Christian Brauner <brauner@kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kernel.org> wrote=
:
>
> On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian G=C3=B6ttsche wrote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >
> > Support file descriptors obtained via O_PATH for extended attribute
> > operations.
> >
> > Extended attributes are for example used by SELinux for the security
> > context of file objects. To avoid time-of-check-time-of-use issues whil=
e
> > setting those contexts it is advisable to pin the file in question and
> > operate on a file descriptor instead of the path name. This can be
> > emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
> > which might not be mounted e.g. inside of chroots, see[2].
> >
> > [1]: https://github.com/SELinuxProject/selinux/commit/7e979b56fd2cee28f=
647376a7233d2ac2d12ca50
> > [2]: https://github.com/SELinuxProject/selinux/commit/de285252a18013973=
06032e070793889c9466845
> >
> > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > https://patchwork.kernel.org/project/linux-fsdevel/patch/20200505095915=
.11275-6-mszeredi@redhat.com/
> >
> > > While this carries a minute risk of someone relying on the property o=
f
> > > xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
> > > introducing another set of syscalls.
> > >
> > > Only file->f_path and file->f_inode are accessed in these functions.
> > >
> > > Current versions return EBADF, hence easy to detect the presense of
> > > this feature and fall back in case it's missing.
> >
> > CC: linux-api@vger.kernel.org
> > CC: linux-man@vger.kernel.org
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
>
> I'd be somewhat fine with getxattr and listxattr but I'm worried that
> setxattr/removexattr waters down O_PATH semantics even more. I don't
> want O_PATH fds to be useable for operations which are semantically
> equivalent to a write.

It is not really semantically equivalent to a write if it works on a
O_RDONLY fd already.

>
> In sensitive environments such as service management/container runtimes
> we often send O_PATH fds around precisely because it is restricted what
> they can be used for. I'd prefer to not to plug at this string.

But unless I am mistaken, path_setxattr() and syscall_fsetxattr()
are almost identical w.r.t permission checks and everything else.

So this change introduces nothing new that a user in said environment
cannot already accomplish with setxattr().

Besides, as the commit message said, doing setxattr() on an O_PATH
fd is already possible with setxattr("/proc/self/$fd"), so whatever securit=
y
hole you are trying to prevent is already wide open.

In effect, I think containing setxattr() can only be accomplished with LSM.

Thanks,
Amir.
