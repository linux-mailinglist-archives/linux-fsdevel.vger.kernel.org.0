Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC078FF79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbjIAOvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIAOvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:51:09 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197A8E7E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Sep 2023 07:51:05 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64f3ad95ec0so11649076d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Sep 2023 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693579864; x=1694184664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+Vg8RKjnZm0MdBVeotaim9wQ28HoXAXQAGIgDSwDvc=;
        b=Tv5z/YwkHkThQEQq6QpYYA+/9Nj2DVoKVNnXR+5gQuyw9jU0c8zMBy9IC6vRneK0hj
         yI/1joWECQpTB7zJIDKUVGIqRHHgeagAwraZ3H0l09HFDTIanFlKMK+lk38RZ5/eQLtO
         l7pdzAmsa78P/GzNST1DzUcNSVbfgT52RvmnGwwJZcWWtPaQiUX015BypIjv0+u8aSVL
         yMgWFOcQu0zkraSJixJX9pHBozQwKjkdP4UYNb+723LVy8PjEbwh1LuXthplLZYE4zCi
         ClVXA4CpE/VuANHElCLPB6e4AY1teUGkGg6LkC+abnA5CLxsS9WO6M0x92/jyzDygQHi
         jjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693579864; x=1694184664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+Vg8RKjnZm0MdBVeotaim9wQ28HoXAXQAGIgDSwDvc=;
        b=HtTpvbxp44hNCeFi6XFZ/2Dr7YKtVs72DqEp655xuTEbNQ8hOHG/Kqyc6ZtzAa0a/y
         Cc2Z0nsXPIN5V048C4aklX0wRpaTacAR4ribFCWz00Ph/ddkVx54Ju5wYus1Lplo9WOi
         3W2zdIT/oRse2eS92ncLOKh+capxCPUit8BdB2pTUv0z2csuY0LwF/ndlp6m49cPfxnc
         QBf5flfJ8LRRPu2+XFUtdenADup+DeuNiLkTLLdyFrWOYCqRSgUN999E6/Maj1gUy3do
         UpNPpjVSklZJzveRy7wzUYReY/B61kKSjKFXvQKsxaDc0wrTrAwN1CZh8OlgHOy3/i/H
         0cNA==
X-Gm-Message-State: AOJu0YytqW8HWPRkaVUMY9KwtHcnd6eYH11Ahdv/uTDwidvWvjL/a+dW
        fWYNqjojwCikFxTnvqhYLNxjfgQoVxb0/7+W4g8arw==
X-Google-Smtp-Source: AGHT+IGt6vgaVsXTsBi+UPDBHzORzZrCU8BtLF5CuWK7yQLdQ9iNgvQ0h8CZqcsGkenoaFmo4fmlzP5HFdi/x+/ykO4=
X-Received: by 2002:a0c:a99e:0:b0:626:f3d:9e46 with SMTP id
 a30-20020a0ca99e000000b006260f3d9e46mr2236138qvb.18.1693579864076; Fri, 01
 Sep 2023 07:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230831203647.558079-1-mclapinski@google.com>
 <20230831203647.558079-2-mclapinski@google.com> <20230901-lockt-erbfolge-e1f9a26f0d63@brauner>
In-Reply-To: <20230901-lockt-erbfolge-e1f9a26f0d63@brauner>
From:   =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date:   Fri, 1 Sep 2023 16:50:53 +0200
Message-ID: <CAAi7L5f1KYrAyCYLzUN0dSy6xuQCGcC7SQML4+KUdxnQ6RaFfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 1, 2023 at 2:56=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Aug 31, 2023 at 10:36:46PM +0200, Michal Clapinski wrote:
> > Add a way to check if an fd points to the memfd's original open fd
> > (the one created by memfd_create).
> > Useful because only the original open fd can be both writable and
> > executable.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> >  fs/fcntl.c                 | 3 +++
> >  include/uapi/linux/fcntl.h | 9 +++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index e871009f6c88..301527e07a4d 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -419,6 +419,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsi=
gned long arg,
> >       case F_SET_RW_HINT:
> >               err =3D fcntl_rw_hint(filp, cmd, arg);
> >               break;
> > +     case F_CHECK_ORIGINAL_MEMFD:
> > +             err =3D !(filp->f_mode & FMODE_WRITER);
> > +             break;
>
> Honestly, make this an ioctl on memfds. This is so specific that it
> really doesn't belong into fcntl().

I've never touched ioctls but if I'm correct, I can't just add it to
memfd. I would have to add it to the underlying fs, so hugetlbfs and
shmem (which I think can be defined as ramfs so also there). File
sealing fcntl is already memfd specific. Are you sure ioctl will be a
better idea?
