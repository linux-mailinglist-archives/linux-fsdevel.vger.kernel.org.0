Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300C029DFF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 02:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404193AbgJ2BHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 21:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404192AbgJ2BHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:07:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65217C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:07:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so1322682ljj.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HCMtPYSQmdkWkMdfUPS9qhZgy6rvCiiYHXXWXXWExD4=;
        b=TbN27kRAGWcOb6zj1yGKgJ9Ta+Yrz7blk1lWpHuC9+ZXxHiHOBdHY/aLF1MOu5le4k
         r8LtD8h7uYrbQ9r/z6Fwibgt+A2dl3SoYTaRk2at/TNalUAPKVdPV+MpPldq+aRJSC0C
         s7SrmmCILd0PHdCLcWEXTbR2NhPrbpZ+gLkliDqvtmh1MC9J0US8FDdp7cMpPQaca3mF
         3Cb2ryOLwtCVvYXmnAXIcXKXmkCr/HP6GMKNx8gCuWz+jEA+0ymOGT2SwiNrdYrkCaPh
         O7SE2pTYTD+BaxhYoewVYl0y4UPwe4vSXwfo6ScaguFfzCWnB1vW+hFDLtEeV5atG1iE
         rxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HCMtPYSQmdkWkMdfUPS9qhZgy6rvCiiYHXXWXXWExD4=;
        b=VmEh5KsjXpmDe1arqhVABKt1hWHzOyVFGjSEXtt/b7UFCcdI29MruNX01o2ZcfIt9j
         P9flUPjEQtHYLXu+nEdVereaoVapA1H3WVMkATROGShXgmWOam/aH6labyIBXvI7EGkM
         d8oyt/ZBH6tgn68bynXrtR6LdayBR+f9fq3rNt+tY+clYq693To7/oqbgq6Ps5YrkCaU
         c6i3EsrjvO9mxSdVwLi/iSE2bs9Nmjgs18bDQNzfQ20fpwW/YRI6IdS8PjQ+uFpWpHrL
         cXj3i/hyKIffQgbZEBIx2nGo+Z7qWknre+sQq1hLijSmdqYriCj3BmIY2+TOzLCUDQsB
         GF5Q==
X-Gm-Message-State: AOAM533vyUa15+1BXRLSRMBZO2KekDkCQ1ldnGlLSyyxHeNsWZ0xedUn
        MrqmaRzj8s2u3TbCxakQjkcbqniftFaIx1Mqzdm7Rw==
X-Google-Smtp-Source: ABdhPJwTA0CPa3QkmuY34yK5MoqLOiAts+WsDd5Nc6GziUS04Yva+U9JhD1UzSZvamXHxjkP9qKU6QWqrzrUITqj3lw=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr700720ljo.74.1603933631649;
 Wed, 28 Oct 2020 18:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-8-mic@digikod.net>
In-Reply-To: <20201027200358.557003-8-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:06:45 +0100
Message-ID: <CAG48ez1xMfxkwhXK4b1BB4GrTVauNzfwPoCutn9axKt_PFRSVQ@mail.gmail.com>
Subject: Re: [PATCH v22 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> Thanks to the Landlock objects and ruleset, it is possible to identify
> inodes according to a process's domain.  To enable an unprivileged
> process to express a file hierarchy, it first needs to open a directory
> (or a file) and pass this file descriptor to the kernel through
> landlock_add_rule(2).  When checking if a file access request is
> allowed, we walk from the requested dentry to the real root, following
> the different mount layers.  The access to each "tagged" inodes are
> collected according to their rule layer level, and ANDed to create
> access to the requested file hierarchy.  This makes possible to identify
> a lot of files without tagging every inodes nor modifying the
> filesystem, while still following the view and understanding the user
> has from the filesystem.
>
> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
> keep the same struct inodes for the same inodes whereas these inodes are
> in use.
>
> This commit adds a minimal set of supported filesystem access-control
> which doesn't enable to restrict all file-related actions.  This is the
> result of multiple discussions to minimize the code of Landlock to ease
> review.  Thanks to the Landlock design, extending this access-control
> without breaking user space will not be a problem.  Moreover, seccomp
> filters can be used to restrict the use of syscall families which may
> not be currently handled by Landlock.
[...]
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.=
h
[...]
> +/**
> + * DOC: fs_access
> + *
> + * A set of actions on kernel objects may be defined by an attribute (e.=
g.
> + * &struct landlock_path_beneath_attr) including a bitmask of access.
> + *
> + * Filesystem flags
> + * ~~~~~~~~~~~~~~~~
> + *
> + * These flags enable to restrict a sandbox process to a set of actions =
on

s/sandbox/sandboxed/

[...]
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
[...]
> +static const struct landlock_object_underops landlock_fs_underops =3D {
> +       .release =3D release_inode
> +};
[...]
> +/* Access-control management */
> +
> +static bool check_access_path_continue(
> +               const struct landlock_ruleset *const domain,
> +               const struct path *const path, const u32 access_request,
> +               bool *const allow, u64 *const layer_mask)
> +{
> +       const struct landlock_rule *rule;
> +       const struct inode *inode;
> +       bool next =3D true;
> +
> +       prefetch(path->dentry->d_parent);

IIRC software prefetch() turned out to only rarely actually have a
performance benefit, and they often actually make things worse; see
e.g. <https://lwn.net/Articles/444336/>. Unless you have strong
evidence that this actually brings a performance benefit, I'd probably
get rid of this.

> +       if (d_is_negative(path->dentry))
> +               /* Continues to walk while there is no mapped inode. */
> +               return true;
> +       inode =3D d_backing_inode(path->dentry);
> +       rcu_read_lock();
> +       rule =3D landlock_find_rule(domain,
> +                       rcu_dereference(landlock_inode(inode)->object));
> +       rcu_read_unlock();
> +
> +       /* Checks for matching layers. */
> +       if (rule && (rule->layers | *layer_mask)) {
> +               *allow =3D (rule->access & access_request) =3D=3D access_=
request;
> +               if (*allow) {
> +                       *layer_mask &=3D ~rule->layers;
> +                       /* Stops when a rule from each layer granted acce=
ss. */
> +                       next =3D !!*layer_mask;
> +               } else {
> +                       next =3D false;
> +               }
> +       }
> +       return next;
> +}
> +
> +static int check_access_path(const struct landlock_ruleset *const domain=
,
> +               const struct path *const path, u32 access_request)
> +{
> +       bool allow =3D false;
> +       struct path walker_path;
> +       u64 layer_mask;
> +
> +       if (WARN_ON_ONCE(!domain || !path))
> +               return 0;
> +       /*
> +        * Allows access to pseudo filesystems that will never be mountab=
le
> +        * (e.g. sockfs, pipefs), but can still be reachable through
> +        * /proc/self/fd .
> +        */
> +       if ((path->dentry->d_sb->s_flags & SB_NOUSER) ||
> +                       (d_is_positive(path->dentry) &&
> +                        unlikely(IS_PRIVATE(d_backing_inode(path->dentry=
)))))
> +               return 0;
> +       if (WARN_ON_ONCE(domain->nb_layers < 1))
> +               return -EACCES;
> +
> +       layer_mask =3D GENMASK_ULL(domain->nb_layers - 1, 0);
> +       /*
> +        * An access request which is not handled by the domain should be
> +        * allowed.
> +        */
> +       access_request &=3D domain->fs_access_mask;
> +       if (access_request =3D=3D 0)
> +               return 0;
> +       walker_path =3D *path;
> +       path_get(&walker_path);
> +       /*
> +        * We need to walk through all the hierarchy to not miss any rele=
vant
> +        * restriction.
> +        */
> +       while (check_access_path_continue(domain, &walker_path, access_re=
quest,
> +                               &allow, &layer_mask)) {

The logic in this code might be clearer if
check_access_path_continue() just returns whether the rule permitted
the access. Then it'd look like:

bool allow =3D false;
[...]
while (check_access_path_continue(domain, &walker_path,
access_request, &layer_mask)) {
  if (layer_mask =3D=3D 0) {
    allow =3D true;
    break;
  }
  [...]
}

I think that would make it clearer under which conditions we can end
up returning "true" from check_access_path().

(The current code also looks correct to me, I just think it'd be
clearer this way. If you disagree, you can keep it as-is.)


> +               struct dentry *parent_dentry;
> +
> +jump_up:
> +               /*
> +                * Does not work with orphaned/private mounts like overla=
yfs
> +                * layers for now (cf. ovl_path_real() and ovl_path_open(=
)).
> +                */
> +               if (walker_path.dentry =3D=3D walker_path.mnt->mnt_root) =
{
> +                       if (follow_up(&walker_path)) {
> +                               /* Ignores hidden mount points. */
> +                               goto jump_up;
> +                       } else {
> +                               /*
> +                                * Stops at the real root.  Denies access
> +                                * because not all layers have granted ac=
cess.
> +                                */
> +                               allow =3D false;
> +                               break;
> +                       }
> +               }
> +               if (unlikely(IS_ROOT(walker_path.dentry))) {
> +                       /*
> +                        * Stops at disconnected root directories.  Only =
allows
> +                        * access to internal filesystems (e.g. nsfs whic=
h is
> +                        * reachable through /proc/self/ns).
> +                        */
> +                       allow =3D !!(walker_path.mnt->mnt_flags & MNT_INT=
ERNAL);
> +                       break;
> +               }
> +               parent_dentry =3D dget_parent(walker_path.dentry);
> +               dput(walker_path.dentry);
> +               walker_path.dentry =3D parent_dentry;
> +       }
> +       path_put(&walker_path);
> +       return allow ? 0 : -EACCES;
> +}
[...]
> +static inline u32 get_file_access(const struct file *const file)
> +{
> +       u32 access =3D 0;
> +
> +       if (file->f_mode & FMODE_READ) {
> +               /* A directory can only be opened in read mode. */
> +               if (S_ISDIR(file_inode(file)->i_mode))
> +                       return LANDLOCK_ACCESS_FS_READ_DIR;
> +               access =3D LANDLOCK_ACCESS_FS_READ_FILE;
> +       }
> +       /*
> +        * A LANDLOCK_ACCESS_FS_APPEND could be added but we also need to=
 check
> +        * fcntl(2).
> +        */

Once https://lore.kernel.org/linux-api/20200831153207.GO3265@brightrain.aer=
ifal.cx/
lands, pwritev2() with RWF_NOAPPEND will also be problematic for
classifying "write" vs "append"; you may want to include that in the
comment. (Or delete the comment.)

> +       if (file->f_mode & FMODE_WRITE)
> +               access |=3D LANDLOCK_ACCESS_FS_WRITE_FILE;
> +       /* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
> +       if (file->f_flags & __FMODE_EXEC)
> +               access |=3D LANDLOCK_ACCESS_FS_EXECUTE;
> +       return access;
> +}
[...]
