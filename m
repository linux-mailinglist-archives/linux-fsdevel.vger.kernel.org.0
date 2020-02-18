Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F076B16218B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 08:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgBRHiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 02:38:19 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45874 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgBRHiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:38:19 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so8222485ioi.12;
        Mon, 17 Feb 2020 23:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bxr9mF5iPNxZICjr4TwWUDKMSfE5w6C5zg0lbVOeWVQ=;
        b=SYuNZ8uOYDzsDY5wvuCVheI8k67Iapr8BtLgKIxyqEY/AIb3oGSHE/wF8B0h9Hj6Wi
         CbMuQBrMCm/YHrgP0acs6/UuY896xnHyrk3io+VSZaKetGNMYZEC335fnb031rFclPop
         aLGIbLA7wYnHrhWQNaFh3RzuaHLWWhEsE5G3FuYVFQN0k3gYpa9H0GwnL8e5lQysTZ34
         jKpFtBPYxmzbJoaFVO42GkHFKia5GfYGu/eY58OzpdKsnIP1cuSoMvwTqYT7bjarOwJp
         Qc097/rN7nazPdsnR5LxhLhs2iK53CBzIWnfOby3vcshLX1LDmBmp0zgt9trp1jXpiqj
         GKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bxr9mF5iPNxZICjr4TwWUDKMSfE5w6C5zg0lbVOeWVQ=;
        b=org8Crag58znF/ntkPT+ba2cX6ZBxvVEKLetmM07Nelwnb+kPJS/18SgGZ+lk1LInO
         uFwifsJeUvLrr+/nJCuXBnFnBqDJzlbPdVLcmLQMe5+T8BEUZT290RKTXDLZz5mKuGOJ
         JKnXwD1/2IEQCfoALrLVBK+xM6qwe5txBaeZkLUT+ucPHcQMBduXEHyw2aQFyf8KGlvJ
         IdZSAZR6LbzRzxyK3MMReCFCUTqbaOgYNm3fBSIytrYK4wc7RmHDFuO52CWrnbaPQs/T
         ei/DOnwOHRgZUtTaztM41hBPtT6vr2qAQbZmTVBdMZShvnBp+0uGizpSd21AE8uQCm0u
         uCsg==
X-Gm-Message-State: APjAAAWPir0e50c14sdqb0Pg3xhkhm26pmrLxCfWNFUriS7JKKN+LlSI
        U2pDx4KTdB+nOzZiVvrJTCjf7eHEy0Q7qEoDDRE=
X-Google-Smtp-Source: APXvYqw688Dk2oK9FO4lCTqf4tJ4Li7CcIVPkW0SiAKDYHpz+ydKmQKxM0P5oeLuUMa8J0bjMVtbko+ds9uGlaEhkqw=
X-Received: by 2002:a6b:d019:: with SMTP id x25mr14715162ioa.275.1582011498272;
 Mon, 17 Feb 2020 23:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com> <20200217205307.32256-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200217205307.32256-3-James.Bottomley@HansenPartnership.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Feb 2020 09:38:07 +0200
Message-ID: <CAOQ4uxjdj7WavgifTf5GL+zPqnT0YVCSR9o7R1W2BZ6BjxF-2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: introduce uid/gid shifting bind mount
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:58 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This implementation reverse shifts according to the user_ns belonging
> to the mnt_ns.  So if the vfsmount has the newly introduced flag
> MNT_SHIFT and the current user_ns is the same as the mount_ns->user_ns
> then we shift back using the user_ns and an optional mnt_userns (which
> belongs to the struct mount) before committing to the underlying
> filesystem.
>
> For example, if a user_ns is created where interior (fake root, uid 0)
> is mapped to kernel uid 100000 then writes from interior root normally
> go to the filesystem at the kernel uid.  However, if MNT_SHIFT is set,
> they will be shifted back to write at uid 0, meaning we can bind mount
> real image filesystems to user_ns protected faker root.
>
> In essence there are several things which have to be done for this to
> occur safely.  Firstly for all operations on the filesystem, new
> credentials have to be installed where fsuid and fsgid are set to the
> *interior* values. Next all inodes used from the filesystem have to
> have i_uid and i_gid shifted back to the kernel values and attributes
> set from user space have to have ia_uid and ia_gid shifted from the
> kernel values to the interior values.  The capability checks have to
> be done using ns_capable against the kernel values, but the inode
> capability checks have to be done against the shifted ids.
>
> Since creating a new credential is a reasonably expensive proposition
> and we have to shift and unshift many times during path walking, a
> cached copy of the shifted credential is saved to a newly created
> place in the task structure.  This serves the dual purpose of allowing
> us to use a pre-prepared copy of the shifted credentials and also
> allows us to recognise whenever the shift is actually in effect (the
> cached shifted credential pointer being equal to the current_cred()
> pointer).
>
> To get this all to work, we have a check for the vfsmount flag and the
> user_ns gating a shifting of the credentials over all user space
> entries to filesystem functions.  In theory the path has to be present
> everywhere we do this, so we can check the vfsmount flags.  However,
> for lower level functions we can cheat this path check of vfsmount
> simply to check whether a shifted credential is in effect or not to
> gate things like the inode permission check, which means the path
> doesn't have to be threaded all the way through the permission
> checking functions.  if the credential is shifted check passes, we can
> also be sure that the current user_ns is the same as the mnt->user_ns,
> so we can use it and thus have no need of the struct mount at the
> point of the shift.
>
> Although the shift can be effected simply by executing
> do_reconfigure_mnt with MNT_SHIFT in the flags, this patch only
> contains the shifting mechanisms.  The follow on patch wires up the
> user visible API for turning the flag on.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
[...]

> @@ -3828,6 +3884,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> +       cred = change_userns_creds(&path);
>         if (!IS_POSIXACL(path.dentry->d_inode))
>                 mode &= ~current_umask();
>         error = security_path_mknod(&path, dentry, mode, dev);
[...]

> +       cred = change_userns_creds(&path);
>         if (!IS_POSIXACL(path.dentry->d_inode))
>                 mode &= ~current_umask();
>         error = security_path_mkdir(&path, dentry, mode);
[...]

> +       cred = change_userns_creds(&path);
>         error = security_path_symlink(&path, dentry, from->name);

I see a pattern above.

Perhaps change_userns_creds() should be inside security_path_XXX hooks?
Perhaps auto-shifting bind mount should be implemented by an LSM?
After, all "gating" access to filesystem, is part of what LSMs do and
uid (or fsid)
shifting is a sort of "gating".
Heck, there should already be a way to attach a security context to a mount,
right? So you don't even need a new UAPI in order to configure the auto-shifting
LSM. And you could use standard security.* xattr for persistent configuration
of the auto-shifting filesystem sections, which is something that you wanted
to solve anyway, right?

Apologies if my suggestions are flawed with misunderstanding of the feature.

Thanks,
Amir.
