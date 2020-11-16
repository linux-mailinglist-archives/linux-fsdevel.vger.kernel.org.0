Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF42B4271
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 12:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgKPLSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 06:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKPLSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:18:05 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C5AC0613CF;
        Mon, 16 Nov 2020 03:18:05 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n12so16980523ioc.2;
        Mon, 16 Nov 2020 03:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzZkj+YXGG5w16LievkEMetTq761TFkjogWW9ybAr3w=;
        b=uml0QSDZDjYFjYcOxlvBwY3zvvNXtlpqIOyGHHFQXeB0oj7vuFtwVjXbjgH/6usZK2
         HpznBKmNUGtZdQkXNzLuBBklrGw5gGsmcWwtLliJCe+Vwn841qNQtF2v2VkcgwqKnUB3
         ASmbNPvk3cAkNfaQQxePe3dKx4hIw/NyrFuPCGehLAXCITRif641UEvV3GMEtBp4Cq26
         sRbK9sb4XU+sNNUV7hc6X8fnrxKvTdDmplc21krJquay+70AnScNX7FNC3DPcsQ2do/J
         tQ4E9Y8ZRc2Qovw0HdmWmKvR8+NXXIDPzaNwZTec+jRTXHQ0Q+dmip1nyetkpy5si9Aq
         VFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzZkj+YXGG5w16LievkEMetTq761TFkjogWW9ybAr3w=;
        b=fzyN0RxUrTcgDBINDsUnCPl1TCy9sIxNfF5b3HntHuwARJkP2kUtdFRy/9/hXqwD+L
         1fG1gt2ergE+8IhlOmT8TML04jK9Th2hCijHwyQvtTZEz/BOPW5NLYYC6uZ4KBtPkqOQ
         RPUKEWdGEIHwYfHlI0AgLtZmAjr2ZbWDFxYSPi+Xu8XvJdpYTRBZxWlT7iWGb9PQVy2e
         eB1f4XHyJ2yCuIRaIae6NK2hLLxe/CnHT2qqEBeYuHoGJn6m4R8aZi9jIR2vwJ/A2leN
         wHKmVKOJT7/cVcSH0LNQxlUVF7T4JLJCeBd/Hb4WBKXzkCGisNfBnQZtfH5c9vBhvykf
         FQ6w==
X-Gm-Message-State: AOAM531qyLgST1mgvfh4f30NvnuT50NvGsszkpYfZ94qQQKSliNrLANa
        lN17jH4Sl5Z6TuvNsZTKl8s466/2x27dU6K7ozCET5Vc6WY=
X-Google-Smtp-Source: ABdhPJxCl1t3OgLkSX2JWUSRKyYoN4hrVy0cdXupzwn//ayNjcCIKgg8hWLWUs+jjyn8c3aErjog9LRB50t3VI3QdXU=
X-Received: by 2002:a02:70ce:: with SMTP id f197mr10748332jac.120.1605525484521;
 Mon, 16 Nov 2020 03:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <CAOQ4uxh9oa5TWNY4byNyeBGUe7wyON2NJ2_rj5GiYD_0wBOXGA@mail.gmail.com> <20201116103013.GA13259@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20201116103013.GA13259@ircssh-2.c.rugged-nimbus-611.internal>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Nov 2020 13:17:53 +0200
Message-ID: <CAOQ4uxjmKewbdwCQgGb4ERJXX_oA+dyOjc9M-Y0AWdNo73Xz-A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > +       inode_lock_nested(d_dirty->d_inode, I_MUTEX_XATTR);
> >
> > What's this lock for?
> >
> I need to take a lock on this inode to prevent modifications to it, right, or is
> getting the xattr safe?

No. see Documentation/filesystems/locking.rst.

>
> > > +       err = ovl_do_getxattr(d_dirty, OVL_XATTR_VOLATILE, &info, sizeof(info));
> > > +       inode_unlock(d_dirty->d_inode);
> > > +       if (err != sizeof(info))
> > > +               goto out_putdirty;
> > > +
> > > +       if (!uuid_equal(&overlay_boot_id, &info.overlay_boot_id)) {
> > > +               pr_debug("boot id has changed (reboot or module reloaded)\n");
> > > +               goto out_putdirty;
> > > +       }
> > > +
> > > +       if (d_dirty->d_inode->i_sb->s_instance_id != info.s_instance_id) {
> > > +               pr_debug("workdir has been unmounted and remounted\n");
> > > +               goto out_putdirty;
> > > +       }
> > > +
> > > +       err = errseq_check(&d_dirty->d_inode->i_sb->s_wb_err, info.errseq);
> > > +       if (err) {
> > > +               pr_debug("workdir dir has experienced errors: %d\n", err);
> > > +               goto out_putdirty;
> > > +       }
> >
> > Please put all the above including getxattr in helper ovl_verify_volatile_info()
> >
> Is it okay if the helper stays in super.c?
>

Yes.

>
> > > +
> > > +       /* Dirty file is okay, delete it. */
> > > +       ret = ovl_do_unlink(d_volatile->d_inode, d_dirty);
> >
> > That's a problem. By doing this, you have now approved a regular overlay
> > re-mount, but you need only approve a volatile overlay re-mount.
> > Need to pass ofs to ovl_workdir_cleanup{,_recurse}.
> >
> I can add a check to make sure this behaviour is only allowed on remounts back
> into volatile. There's technically a race condition here, where if there
> is an error between this check, and the mounting being finished, the FS
> could be dirty, but that already exists with the impl today.
>

If you follow my suggestion below and never unlink dirty file,
the filesystem will never be not-dirty so it is safer.

> > > +
> > > +out_putdirty:
> > > +       dput(d_dirty);
> > > +out_putvolatile:
> > > +       inode_unlock(d_volatile->d_inode);
> > > +       dput(d_volatile);
> > > +       return ret;
> > > +}
> > > +
> > > +/*
> > > + * check_incompat checks this specific incompat entry for incompatibility.
> > > + * If it is found to be incompatible -EINVAL will be returned.
> > > + *
> > > + * Any other -errno indicates an unknown error, and filesystem mounting
> > > + * should be aborted.
> > > + */
> > > +static int ovl_check_incompat(struct ovl_cache_entry *p, struct path *path)
> > > +{
> > > +       int err = -EINVAL;
> > > +
> > > +       if (!strcmp(p->name, OVL_VOLATILEDIR_NAME))
> > > +               err = ovl_check_incompat_volatile(p, path);
> > > +
> > > +       if (err == -EINVAL)
> > > +               pr_err("incompat feature '%s' cannot be mounted\n", p->name);
> > > +       else
> > > +               pr_debug("incompat '%s' handled: %d\n", p->name, err);
> > > +
> > > +       return err;
> > > +}
> > >
> > >  static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> > >  {
> > > @@ -1098,10 +1175,9 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> > >                         if (p->len == 2 && p->name[1] == '.')
> > >                                 continue;
> > >                 } else if (incompat) {
> > > -                       pr_err("overlay with incompat feature '%s' cannot be mounted\n",
> > > -                               p->name);
> > > -                       err = -EINVAL;
> > > -                       break;
> > > +                       err = ovl_check_incompat(p, path);
> > > +                       if (err)
> > > +                               break;
> >
> > The call to ovl_check_incompat here is too soon and it makes
> > you need to lookup both the volatile dir and dirty file.
> > What you need to do and let cleanup recurse into the next level
> > while letting it know that we are now traversing the "incompat"
> > subtree.
> >
> Maybe a dumb question but why is it incompat/volatile/dirty, rather than just
> incompat/volatile, where volatile is a file?

Not dumb. It's so old kernels cannot mount with this workdir,
because recursive cleanup never recursed more than 2 levels.
If it were just incompat/volatile old kernels would have cleaned it
and allowed it to mount.

> Are there any caveats with putting the xattr on the directory

Not that I can think of.

> , or alternatively are there any reasons not to make
> the structure incompat/volatile/dirty?
>

Old kernels as I wrote above.
The sole purpose of the dirty file is to cause rmdir on volatile to fail
in old kernels.

Thanks,
Amir.
