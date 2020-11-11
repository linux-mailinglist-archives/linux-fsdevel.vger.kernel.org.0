Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1442AF4A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 16:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgKKPVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 10:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgKKPVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:21:08 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C89C0613D1;
        Wed, 11 Nov 2020 07:21:08 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n129so2646026iod.5;
        Wed, 11 Nov 2020 07:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YdeSYPUdMsbv9Ht0DhrnvlWMZUneO0/r6IjX9uZ0U70=;
        b=qYMfEdaHlw20bKvfMAeD4DLUWMkOTE0sWJy/OIifD9zv4QDSCJRn/6u/4s7cti3EcR
         3rYaS/lzi/IRgrAGLAUwrUhsOLKg7lspghF2SM3JSSEyMB3ak0znwBZAyJzoW3f1DGMG
         969aQQrSz572F/oAQYzyY4+E8IJUJ7FrpfLQq2kl48rKtDzwpIGo1GFlP1/9RCMtRwIJ
         0kFMOe8nuBUGWM8vcY2Qr1rxvzwmMfFN3nQwBPOraol9LVQgTVv4W6Yybe5fAoJUHJ58
         8yH+LJ13gB/a9QS6YSWNpz5XMx1GvHm2lXGpeo+CmdFh8LrCspPsfEwL13iVsTg/uafs
         G+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YdeSYPUdMsbv9Ht0DhrnvlWMZUneO0/r6IjX9uZ0U70=;
        b=a3jBG1JTB00ZhsUA8mW06I2C0e9xnpgy8zMWwxdRNJyjFwTkfBsZqT6ZFSYm79AENK
         VQX1IP/SKpLSgH+Q3d9QIX5vvTkji/v928VFdWKUlWHbEuWuvwGQBDbKBwPjRJ1NfKJu
         fKb/NyuoYjy7/Ai++WGdROAH8gNkDA1d92F35X/gdHJnCMVnFGkgWoYgIWj1saYWx1vn
         P1/nG+1D2Faxp8GAv6h5YnHTeMJ9uPGK5SMDaK4uTstqFKom6YmyOPkwg+bR6kNhgMEO
         9RCXxtTb0vyxVx7CnmXRUXG0lbFUzMTMWFEVL6z+8TPBM8qqvrhGJGSvpa4VUH22xGD/
         UvnQ==
X-Gm-Message-State: AOAM533x6h6+j9fYXGKv2jWzZc/3epcN1CxLJrNlm7e7PfSfzz70FnB1
        RXCto55Qsz8dBmcuLgwz/im5CRai2kHxlXhQuok=
X-Google-Smtp-Source: ABdhPJwg3UGmNk92V3xFF9gjz/I4MLhhGJ6F2P5a4p3UJDw/wFSlsChK2RjdWLVSHooBH/4JpNo6LHnW6brBsCSC9SE=
X-Received: by 2002:a02:70ce:: with SMTP id f197mr20807827jac.120.1605108067560;
 Wed, 11 Nov 2020 07:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-7-cgxu519@mykernel.net> <175b769393e.da9339695127.2777354745619336639@mykernel.net>
In-Reply-To: <175b769393e.da9339695127.2777354745619336639@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 Nov 2020 17:20:56 +0200
Message-ID: <CAOQ4uxhG__saz3qWpDUzXUNkBuueAAMzBoXXXOnmnAL2JMSKjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/10] ovl: mark overlayfs' inode dirty on shared mmap
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos <miklos@szeredi.hu>, jack <jack@suse.cz>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 3:05 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:03 Chenggua=
ng Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
>  > Overlayfs cannot be notified when mmapped area gets dirty,
>  > so we need to proactively mark inode dirty in ->mmap operation.
>  >
>  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > ---
>  >  fs/overlayfs/file.c | 2 ++
>  >  1 file changed, 2 insertions(+)
>  >
>  > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>  > index efccb7c1f9bc..662252047fff 100644
>  > --- a/fs/overlayfs/file.c
>  > +++ b/fs/overlayfs/file.c
>  > @@ -486,6 +486,8 @@ static int ovl_mmap(struct file *file, struct vm_a=
rea_struct *vma)
>  >          /* Drop reference count from new vm_file value */
>  >          fput(realfile);
>  >      } else {
>  > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE))
>
> Maybe it's better to mark dirty only having upper inode.
>

Yeh.

And since mapping_map_writable() is only called if VM_SHARED flag
is set (and not VM_MAYSHARE), we are not going to re-dirty an inode on
account of VM_MAYSHARE alone, so I wonder why we need to mark it
dirty here on account of VM_MAYSHARE?

Thanks,
Amir.
