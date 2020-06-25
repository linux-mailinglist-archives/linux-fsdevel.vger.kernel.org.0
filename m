Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3002720A62D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406858AbgFYTy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 15:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406743AbgFYTy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:54:26 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415EBC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2020 12:54:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g1so5175802edv.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2020 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gsR88dXRXrxqIfCdYlR2EMrxX0Ncu9KrZcleqtp0/8=;
        b=TFgQXYn+uJ24sVrCB4MGxYIIT/3OnW3Mt9pT9vHWc0dbSKMzY9j1xCv53tICODroMV
         x1Xm7cgqwj60k/vdc9lGPmmfIEJHtKXa9g0fqa5wvSDHQZtd1A1TbmhiCHqUZ4gIIbNJ
         LDfVem08GML3ConNcITYiyKyju3nOGZ+A/ZMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gsR88dXRXrxqIfCdYlR2EMrxX0Ncu9KrZcleqtp0/8=;
        b=rh38PvS0CFppSNIP+YGcrn8nxV/5bUNho+GFwUgYN+Dslj9E3R8jpjhAQksQicSEho
         2wFlTLbYjIUpLRvtiLFgIn6rpNSjRQ+1078Eu8ncaraVOTO2uF4JKBe7ILK4SuVYEs+R
         TpsdScJxSABIb/83XKB4cSz+C/Qb0iA+c8CXRVvknveCWJYn+yq20ghOvsSY0GFp5Ze2
         IelopaaEC53BzYRqlRnPHHX//Iy661e78xnlN55MXhmKVP5xWQCTH4V602aTo+rmIqIW
         D0lIiZGFdgGprM0HOrkjAwPNNBH8RSmYfvYC/TsqOw4cVrqWZMVva5kgwiuEKjkMZOg+
         HRbA==
X-Gm-Message-State: AOAM530w3SUI4RAIFUvpxd/vpfTtmt4nycS3PKAxO4a0jFQdu2y/09Zd
        R+5pVTlpr0xEpgAYp09nw1NaNYOeKWE4ssS0jAEz5Q==
X-Google-Smtp-Source: ABdhPJwjdI6/YONFgm8UUCa75SSH/kbJUCT0P+sRxzFCf9pkU0XpjzGJN0nMLYarEVGGczoeDp+dofNI2LX++oeJwv8=
X-Received: by 2002:a05:6402:1687:: with SMTP id a7mr623286edv.358.1593114864984;
 Thu, 25 Jun 2020 12:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk> <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
 <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag>
In-Reply-To: <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 25 Jun 2020 21:54:14 +0200
Message-ID: <CAJfpegvLJBAzGCpR6CQ1TG8-fwMB9oN8kVFijs7vK+dvQ6Tm5w@mail.gmail.com>
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 21, 2020 at 9:33 PM Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>
> Hi David,
>
> i did a git bisect and the breaking commit is:
>
> commit c30da2e981a703c6b1d49911511f7ade8dac20be
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon Mar 25 16:38:31 2019 +0000
>
>     fuse: convert to use the new mount API
>
>     Convert the fuse filesystem to the new internal mount API as the old
>     one will be obsoleted and removed.  This allows greater flexibility in
>     communication of mount parameters between userspace, the VFS and the
>     filesystem.
>
>     See Documentation/filesystems/mount_api.txt for more information.
>
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>
> most probably due to the following diffences:
>
>
> old default:
>                default:
> -                       return 0;
>
>
> new default:
> +       default:
> +               return -EINVAL;
>
>
> it seems the old API silently did ignore unknown parameters while the
> new one fails with EINVAL.

v4.19 has this:

static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
                          struct user_namespace *user_ns)
{
[...]
        while ((p = strsep(&opt, ",")) != NULL) {
[...]
                token = match_token(p, tokens, args);
                switch (token) {
[...]
                default:
                        return 0;

and

static int fuse_fill_super(struct super_block *sb, void *data, int silent)
{
[...]
        err = -EINVAL;
        if (sb->s_flags & SB_MANDLOCK)
                goto err;

        sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);

        if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
                goto err;
[...]
 err:
        return err;
}

That looks like it returns -EINVAL for unknown options.  Can you
perform a "strace" on the old and the new kernel to see what the
difference is?

BTW, the hard rule is: userspace regressions caused by kernel changes
must be fixed.  It's just not clear where exactly this is coming from.

Thanks,
Miklos
