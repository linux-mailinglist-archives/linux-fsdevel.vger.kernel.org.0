Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00939B232
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 07:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFDF4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 01:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFDF4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:56:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB7C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jun 2021 22:54:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso8064717otu.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 22:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s006idCoojr2jJ8QdaJf4VEixIzc94xt+tDzBqU8cPk=;
        b=uTFU7vK1vBckKcoyEsNg3Vn2q+BMLItUy/iXLu3kEWoBiM3+UcpQBTV9w4esXfS+FA
         YOFP24wKEOsZhL0lydipSDXjCj2b6PGbmq018PcCLF1ZQCr+fAqmrzBoQGKRPHkj/Tjo
         GE/JFEvUacQ4ELG8Xus8wNQy88BwYTiX/LIMCwH/9QX1MJXr6yCK8jEpCYIz6FhCm8hI
         PgbZQ/2ApudPj3f3jKx27FX+B9W3sFwtzXVZWHqUUpAVZSfswJ3CbE6gMX19JkztLcWd
         V52Ba/Zj1wQ51wfDEdBri/xXVNY7OlPMjcJaAPmQHr/MdXaN46v7A3E/XaoEYGbYryK6
         5Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s006idCoojr2jJ8QdaJf4VEixIzc94xt+tDzBqU8cPk=;
        b=oWmnSCSseARvVN2znaFBoNx6mTHt2cdYoittk2+1HBDacpAovQNccSge034fy1nd8y
         rQcR89zSBjb+p+Z+Tl185/ZNe1NHyF/J7xNtwHXVAOWAJVRawjhBiWc5iUu2j5Z5449G
         5Xg1uhXtGWQFoEgo5vgMt+NQcZeF1Ra5g8BKTxk7y+AfC/q2OZSSvr6jRlIBQUpkVhdx
         zDglY8z/5Od7dR33+uh0M6rv263gmgkDORvnFrR8mYJHmut6OCltjRZG1qAchfhdGV+X
         6HsRycn6SvDfUzKge+qglv6x4UZvfW3PL+DaDtWZakm79UqLk4G71Q5x/bSaYx/eol+K
         2y4A==
X-Gm-Message-State: AOAM530EFvNopBcVBGyeMlK/1HAPhHJFuLP1adH4lHncvGAwsMVv+2/h
        DV0dd+W3Psb19i2eEJszejDiMsttQnzFyM0JPA9G9w==
X-Google-Smtp-Source: ABdhPJwGWRPvPMIN8OgwyDuOuM+Wo5CoYGxkMillRS2TPqQKzaFBnLherOQn9+h6FspuZ+JM+swQcD0pUGctYZThbWc=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr2400445otl.18.1622786062749;
 Thu, 03 Jun 2021 22:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210603095038.314949-1-drosen@google.com> <20210603095038.314949-3-drosen@google.com>
 <YLlj+h4RiT6FvyK6@sol.localdomain> <YLmv5Ykb3QUzDOlL@google.com>
 <YLmzkzPZwBVYf5LO@sol.localdomain> <YLm8aOs6Sc/CLaAv@google.com>
In-Reply-To: <YLm8aOs6Sc/CLaAv@google.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 3 Jun 2021 22:54:11 -0700
Message-ID: <CA+PiJmTcE8ULNoUXH=u-r=rFXjVG_7okaBYgngsFvhjWkYzsLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] f2fs: Advertise encrypted casefolding in sysfs
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 3, 2021 at 10:38 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> On 06/03, Eric Biggers wrote:
> > On Thu, Jun 03, 2021 at 09:45:25PM -0700, Jaegeuk Kim wrote:
> > > On 06/03, Eric Biggers wrote:
> > > > On Thu, Jun 03, 2021 at 09:50:38AM +0000, Daniel Rosenberg wrote:
> > > > > Older kernels don't support encryption with casefolding. This adds
> > > > > the sysfs entry encrypted_casefold to show support for those combined
> > > > > features. Support for this feature was originally added by
> > > > > commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > > >
> > > > > Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > > > Cc: stable@vger.kernel.org # v5.11+
> > > > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > > > ---
> > > > >  fs/f2fs/sysfs.c | 15 +++++++++++++--
> > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > > index 09e3f258eb52..6604291a3cdf 100644
> > > > > --- a/fs/f2fs/sysfs.c
> > > > > +++ b/fs/f2fs/sysfs.c
> > > > > @@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
> > > > >         if (f2fs_sb_has_compression(sbi))
> > > > >                 len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > >                                 len ? ", " : "", "compression");
> > > > > +       if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
> > > > > +               len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > > +                               len ? ", " : "", "encrypted_casefold");
> > > > >         len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > >                                 len ? ", " : "", "pin_file");
> > > > >         len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> > > > > @@ -579,6 +582,7 @@ enum feat_id {
> > > > >         FEAT_CASEFOLD,
> > > > >         FEAT_COMPRESSION,
> > > > >         FEAT_TEST_DUMMY_ENCRYPTION_V2,
> > > > > +       FEAT_ENCRYPTED_CASEFOLD,
> > > > >  };
> > > >
> > > > Actually looking at it more closely, this patch is wrong.
> > > >
> > > > It only makes sense to declare "encrypted_casefold" as a feature of the
> > > > filesystem implementation, i.e. /sys/fs/f2fs/features/encrypted_casefold.
> > > >
> > > > It does *not* make sense to declare it as a feature of a particular filesystem
> > > > instance, i.e. /sys/fs/f2fs/$disk/features, as it is already implied by the
> > > > filesystem instance having both the encryption and casefold features enabled.
> > > >
> > > > Can we add /sys/fs/f2fs/features/encrypted_casefold only?
> > >
> > > wait.. /sys/fs/f2fs/features/encrypted_casefold is on by
> > > CONFIG_FS_ENCRYPTION && CONFIG_UNICODE.
> > > OTOH, /sys/fs/f2fs/$dis/feature_list/encrypted_casefold is on by
> > > on-disk features: F2FS_FEATURE_ENCRYPT and F2FS_FEATURE_CASEFOLD.
> > >
> >
> > Yes, but in the on-disk case, encrypted_casefold is redundant because it simply
> > means encrypt && casefold.  There is no encrypted_casefold flag on-disk.
>
> I prefer to keep encrypted_casefold likewise kernel feature, which is more
> intuitive to users.
>
> >
> > - Eric

When I added the feature_show one, I had been mistakenly thinking of
cases where both were enabled in the filesystem, but not on the same
directory. That case doesn't actually exist, since before the patch to
support both on the same directory, we just wouldn't mount a
filesystem that reported both as on. I think it'd make more sense
without that part. The kernel feature one definitely makes sense,
since previously the kernel could support either, but not both.

-Daniel
