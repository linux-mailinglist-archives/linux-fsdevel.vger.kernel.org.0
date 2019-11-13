Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23531FA931
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 05:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfKMEvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 23:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfKMEvE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 23:51:04 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C63F22469
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 04:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573620662;
        bh=2HR5j4jMQZ8XywHpceKqovMUe9E/Z2E3JHrn6nNK8II=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qu4dJD0Ni66AsrNrH/eEIXfa/16KZ7RZrotDsF6X9hceXsuaWXcl7wuQ7T/rYDBxl
         By7fSfDHWoWWQjnnO2PrLJWTvVfX3Y7TIuLKwVqfS7WLH2H6jyIEh/Y6m1lih/jDGM
         5Q5PY9YsYEMdHRvMYPLKPdGpB2dHJgQuoGNdPIJE=
Received: by mail-wm1-f45.google.com with SMTP id q70so491834wme.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 20:51:02 -0800 (PST)
X-Gm-Message-State: APjAAAUZn/2reVMR+85JUeXvqp5fQ5yRsyqhDDEpr2IVHIyt2+Ns9V6L
        WQyoZTLBKg29lMEh02Jk2/eVuX7nnL2lU/bRUzWqrw==
X-Google-Smtp-Source: APXvYqyc3oSgne3bep9Xp7B6mSwi2GF2tpFX9qEMJeGOYHuljwIi7kxpBBiOH4SJj7M2bzS/5n2f9qM3lSkXb7O7bOk=
X-Received: by 2002:a1c:16:: with SMTP id 22mr943595wma.0.1573620660911; Tue,
 12 Nov 2019 20:51:00 -0800 (PST)
MIME-Version: 1.0
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com> <20191112232239.yevpeemgxz4wy32b@wittgenstein>
In-Reply-To: <20191112232239.yevpeemgxz4wy32b@wittgenstein>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 20:50:50 -0800
X-Gmail-Original-Message-ID: <CALCETrUEQMdugz1t6HfK5MvDq_kOw13yuF+98euqVJgZ4WR1VA@mail.gmail.com>
Message-ID: <CALCETrUEQMdugz1t6HfK5MvDq_kOw13yuF+98euqVJgZ4WR1VA@mail.gmail.com>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 3:22 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> [Cc+ linux-api@vger.kernel.org]
>
> since that's potentially relevant to quite a few people.
>
> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> > Several items in /proc/sys need not be accessible to unprivileged
> > tasks. Let the system administrator change the permissions, but only
> > to more restrictive modes than what the sysctl tables allow.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> > ---
> >  fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index d80989b6c344..88c4ca7d2782 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
> > mask)
> >         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
> >                 return -EACCES;
> >
> > +       error = generic_permission(inode, mask);
> > +       if (error)
> > +               return error;
> > +
> >         head = grab_header(inode);
> >         if (IS_ERR(head))
> >                 return PTR_ERR(head);
> > @@ -837,9 +841,35 @@ static int proc_sys_setattr(struct dentry *dentry,
> > struct iattr *attr)
> >         struct inode *inode = d_inode(dentry);
> >         int error;
> >
> > -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> > +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
> >                 return -EPERM;

Supporting at least ATTR_GID would make this much more useful.

> >
> > +       if (attr->ia_valid & ATTR_MODE) {
> > +               struct ctl_table_header *head = grab_header(inode);
> > +               struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> > +               umode_t max_mode = 0777; /* Only these bits may change */
> > +
> > +               if (IS_ERR(head))
> > +                       return PTR_ERR(head);
> > +
> > +               if (!table) /* global root - r-xr-xr-x */
> > +                       max_mode &= ~0222;
> > +               else /*
> > +                     * Don't allow permissions to become less
> > +                     * restrictive than the sysctl table entry
> > +                     */
> > +                       max_mode &= table->mode;

Style nit: please put braces around multi-line if and else branches,
even if they're only multi-line because of comments.

> > +
> > +               sysctl_head_finish(head);
> > +
> > +               /* Execute bits only allowed for directories */
> > +               if (!S_ISDIR(inode->i_mode))
> > +                       max_mode &= ~0111;

Why is this needed?
