Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697379FBAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjINGLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjINGL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:11:29 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C285DF;
        Wed, 13 Sep 2023 23:11:25 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-493639d6173so295663e0c.3;
        Wed, 13 Sep 2023 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694671884; x=1695276684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5UvKEzTwm2kuyoAgceo57yvAJk0Uxn/UduRgxLfOo4=;
        b=CzaAyYj5+BtemXdR2+C5uEwCHbl/rfU61WN8yplHLiqf8smueLIS4KiABTh9a+KW82
         fQYFUn1fdN5RbdCezbUwswPjBW8zMfTOG9l5/eSGlSQ8EZDG2JewoTInsk8DPFEJj07a
         HixdSR5Eob41I1vPD9Pi4Z2y7b/3XHWhzsb/H2thv0d6etuOEhwFYK/qBb8/JdIo2lDh
         4Grv3N9FEXWPIhngqNUobW3oJWQwZkhr7Nk8iyJHYtjxE5SSf3Aeyw+GaVS+3iXcebj/
         GKzCKElBHzfE4w1AhdmHqEhpcVcLjDgd68yLO798urycRxrTdxAPfRNIcI5hEqlytYYZ
         JhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694671884; x=1695276684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5UvKEzTwm2kuyoAgceo57yvAJk0Uxn/UduRgxLfOo4=;
        b=ks+VuIGj05Tqj+YjYP9yYUBEChHF5dpONjST3nwm9bJPy7pFaGlVfZQg8X+zwYxbA4
         TA7RI5eexYsqOWagLjDHQ74p3m/FVfkJC/DzIWQ4d1/4xE0i1m3y8Ju19+KXSgTXUt9D
         02PEwc0QP4SGXKocDyEPnhm5EjF5oBMsQ8jJXHkxnUAKywdwNhaVmLnaVFNo0jO8tf87
         F6P2f7EbolXeb9VJDJW1IsVU46soaPPW7OwTL9jb9EY4Adg131oc7XTXi/WGLqCphvsK
         55n3wVfm1wddTw9OyPFrqwe6xzzWUMRYAuV6rl9P1Vt94JY+u09ro6KtnRNhzPsUgmSH
         xHqQ==
X-Gm-Message-State: AOJu0YzWMNgv34ilrbHXYhfwtp05GU/g2gOiqU+WD5IfwGAJGfH0fwpD
        TVtIxy0f5qAlyobE2XbSm1bLE2LX29Fi5TSNSKc=
X-Google-Smtp-Source: AGHT+IGjYsOPoUqUMFQgCNhqYoO1gbrm9WGmvVkqm8Dun10L+GUz0oLYjGIfnMvB6OVC5cFSA+VA2eoiRxT0EoX/rMM=
X-Received: by 2002:a1f:dd82:0:b0:48f:c07e:433a with SMTP id
 u124-20020a1fdd82000000b0048fc07e433amr4498025vkg.11.1694671884183; Wed, 13
 Sep 2023 23:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
In-Reply-To: <20230913152238.905247-3-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Sep 2023 09:11:13 +0300
Message-ID: <CAOQ4uxireYvc-+peft9RdYi+UzNSBsgNZN2Je+y_qnS578Cxfg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 6:22=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add a way to query attributes of a single mount instead of having to pars=
e
> the complete /proc/$PID/mountinfo, which might be huge.
>
> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> needs to be queried based on path, then statx(2) can be used to first que=
ry
> the mount ID belonging to the path.
>
> Design is based on a suggestion by Linus:
>
>   "So I'd suggest something that is very much like "statfsat()", which ge=
ts
>    a buffer and a length, and returns an extended "struct statfs" *AND*
>    just a string description at the end."
>
> The interface closely mimics that of statx.
>
> Handle ASCII attributes by appending after the end of the structure (as p=
er
> above suggestion).  Allow querying multiple string attributes with
> individual offset/length for each.  String are nul terminated (terminatio=
n
> isn't counted in length).
>
> Mount options are also delimited with nul characters.  Unlike proc, speci=
al
> characters are not quoted.
>
> Link: https://lore.kernel.org/all/CAHk-=3Dwh5YifP7hzKSbwJj94+DZ2czjrZsczy=
6GBimiogZws=3Drg@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  fs/internal.h                          |   5 +
>  fs/namespace.c                         | 312 ++++++++++++++++++++++++-
>  fs/proc_namespace.c                    |  19 +-
>  fs/statfs.c                            |   1 +
>  include/linux/syscalls.h               |   3 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/mount.h             |  36 +++
>  8 files changed, 373 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index 1d6eee30eceb..6d807c30cd16 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -375,6 +375,7 @@
>  451    common  cachestat               sys_cachestat
>  452    common  fchmodat2               sys_fchmodat2
>  453    64      map_shadow_stack        sys_map_shadow_stack
> +454    common  statmnt                 sys_statmnt
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> diff --git a/fs/internal.h b/fs/internal.h
> index d64ae03998cc..8f75271428aa 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -83,6 +83,11 @@ int path_mount(const char *dev_name, struct path *path=
,
>                 const char *type_page, unsigned long flags, void *data_pa=
ge);
>  int path_umount(struct path *path, int flags);
>
> +/*
> + * proc_namespace.c
> + */
> +int show_path(struct seq_file *m, struct dentry *root);
> +
>  /*
>   * fs_struct.c
>   */
> diff --git a/fs/namespace.c b/fs/namespace.c
> index de47c5f66e17..088a52043bba 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -69,7 +69,8 @@ static DEFINE_IDA(mnt_id_ida);
>  static DEFINE_IDA(mnt_group_ida);
>
>  /* Don't allow confusion with mount ID allocated wit IDA */
> -static atomic64_t mnt_id_ctr =3D ATOMIC64_INIT(1ULL << 32);
> +#define OLD_MNT_ID_MAX UINT_MAX
> +static atomic64_t mnt_id_ctr =3D ATOMIC64_INIT(OLD_MNT_ID_MAX);
>
>  static struct hlist_head *mount_hashtable __read_mostly;
>  static struct hlist_head *mountpoint_hashtable __read_mostly;
> @@ -4678,6 +4679,315 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const ch=
ar __user *, path,
>         return err;
>  }
>
> +static bool mnt_id_match(struct mount *mnt, u64 id)
> +{
> +       if (id <=3D OLD_MNT_ID_MAX)
> +               return id =3D=3D mnt->mnt_id;
> +       else
> +               return id =3D=3D mnt->mnt_id_unique;
> +}
> +
> +struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
> +{
> +       struct mount *mnt;
> +       struct vfsmount *res =3D NULL;
> +
> +       lock_ns_list(ns);
> +       list_for_each_entry(mnt, &ns->list, mnt_list) {
> +               if (!mnt_is_cursor(mnt) && mnt_id_match(mnt, id)) {
> +                       res =3D &mnt->mnt;
> +                       break;
> +               }
> +       }
> +       unlock_ns_list(ns);
> +       return res;
> +}
> +
> +struct stmt_state {
> +       void __user *const buf;
> +       size_t const bufsize;
> +       struct vfsmount *const mnt;
> +       u64 const mask;
> +       struct seq_file seq;
> +       struct path root;
> +       struct statmnt sm;
> +       size_t pos;
> +       int err;
> +};
> +
> +typedef int (*stmt_func_t)(struct stmt_state *);
> +
> +static int stmt_string_seq(struct stmt_state *s, stmt_func_t func)
> +{
> +       struct seq_file *seq =3D &s->seq;
> +       int ret;
> +
> +       seq->count =3D 0;
> +       seq->size =3D min_t(size_t, seq->size, s->bufsize - s->pos);
> +       seq->buf =3D kvmalloc(seq->size, GFP_KERNEL_ACCOUNT);
> +       if (!seq->buf)
> +               return -ENOMEM;
> +
> +       ret =3D func(s);
> +       if (ret)
> +               return ret;
> +
> +       if (seq_has_overflowed(seq)) {
> +               if (seq->size =3D=3D s->bufsize - s->pos)
> +                       return -EOVERFLOW;
> +               seq->size *=3D 2;
> +               if (seq->size > MAX_RW_COUNT)
> +                       return -ENOMEM;
> +               kvfree(seq->buf);
> +               return 0;
> +       }
> +
> +       /* Done */
> +       return 1;
> +}
> +
> +static void stmt_string(struct stmt_state *s, u64 mask, stmt_func_t func=
,
> +                      stmt_str_t *str)
> +{
> +       int ret =3D s->pos >=3D s->bufsize ? -EOVERFLOW : 0;
> +       struct statmnt *sm =3D &s->sm;
> +       struct seq_file *seq =3D &s->seq;
> +
> +       if (s->err || !(s->mask & mask))
> +               return;
> +
> +       seq->size =3D PAGE_SIZE;
> +       while (!ret)
> +               ret =3D stmt_string_seq(s, func);
> +
> +       if (ret < 0) {
> +               s->err =3D ret;
> +       } else {
> +               seq->buf[seq->count++] =3D '\0';
> +               if (copy_to_user(s->buf + s->pos, seq->buf, seq->count)) =
{
> +                       s->err =3D -EFAULT;
> +               } else {
> +                       str->off =3D s->pos;
> +                       str->len =3D seq->count - 1;
> +                       s->pos +=3D seq->count;
> +               }
> +       }
> +       kvfree(seq->buf);
> +       sm->mask |=3D mask;
> +}
> +
> +static void stmt_numeric(struct stmt_state *s, u64 mask, stmt_func_t fun=
c)
> +{
> +       if (s->err || !(s->mask & mask))
> +               return;
> +
> +       s->err =3D func(s);
> +       s->sm.mask |=3D mask;
> +}
> +
> +static u64 mnt_to_attr_flags(struct vfsmount *mnt)
> +{
> +       unsigned int mnt_flags =3D READ_ONCE(mnt->mnt_flags);
> +       u64 attr_flags =3D 0;
> +
> +       if (mnt_flags & MNT_READONLY)
> +               attr_flags |=3D MOUNT_ATTR_RDONLY;
> +       if (mnt_flags & MNT_NOSUID)
> +               attr_flags |=3D MOUNT_ATTR_NOSUID;
> +       if (mnt_flags & MNT_NODEV)
> +               attr_flags |=3D MOUNT_ATTR_NODEV;
> +       if (mnt_flags & MNT_NOEXEC)
> +               attr_flags |=3D MOUNT_ATTR_NOEXEC;
> +       if (mnt_flags & MNT_NODIRATIME)
> +               attr_flags |=3D MOUNT_ATTR_NODIRATIME;
> +       if (mnt_flags & MNT_NOSYMFOLLOW)
> +               attr_flags |=3D MOUNT_ATTR_NOSYMFOLLOW;
> +
> +       if (mnt_flags & MNT_NOATIME)
> +               attr_flags |=3D MOUNT_ATTR_NOATIME;
> +       else if (mnt_flags & MNT_RELATIME)
> +               attr_flags |=3D MOUNT_ATTR_RELATIME;
> +       else
> +               attr_flags |=3D MOUNT_ATTR_STRICTATIME;
> +
> +       if (is_idmapped_mnt(mnt))
> +               attr_flags |=3D MOUNT_ATTR_IDMAP;
> +
> +       return attr_flags;
> +}
> +
> +static u64 mnt_to_propagation_flags(struct mount *m)
> +{
> +       u64 propagation =3D 0;
> +
> +       if (IS_MNT_SHARED(m))
> +               propagation |=3D MS_SHARED;
> +       if (IS_MNT_SLAVE(m))
> +               propagation |=3D MS_SLAVE;
> +       if (IS_MNT_UNBINDABLE(m))
> +               propagation |=3D MS_UNBINDABLE;
> +       if (!propagation)
> +               propagation |=3D MS_PRIVATE;
> +
> +       return propagation;
> +}
> +
> +static int stmt_sb_basic(struct stmt_state *s)
> +{
> +       struct super_block *sb =3D s->mnt->mnt_sb;
> +
> +       s->sm.sb_dev_major =3D MAJOR(sb->s_dev);
> +       s->sm.sb_dev_minor =3D MINOR(sb->s_dev);
> +       s->sm.sb_magic =3D sb->s_magic;
> +       s->sm.sb_flags =3D sb->s_flags & (SB_RDONLY|SB_SYNCHRONOUS|SB_DIR=
SYNC|SB_LAZYTIME);
> +
> +       return 0;
> +}
> +
> +static int stmt_mnt_basic(struct stmt_state *s)
> +{
> +       struct mount *m =3D real_mount(s->mnt);
> +
> +       s->sm.mnt_id =3D m->mnt_id_unique;
> +       s->sm.mnt_parent_id =3D m->mnt_parent->mnt_id_unique;
> +       s->sm.mnt_id_old =3D m->mnt_id;
> +       s->sm.mnt_parent_id_old =3D m->mnt_parent->mnt_id;
> +       s->sm.mnt_attr =3D mnt_to_attr_flags(&m->mnt);
> +       s->sm.mnt_propagation =3D mnt_to_propagation_flags(m);
> +       s->sm.mnt_peer_group =3D IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
> +       s->sm.mnt_master =3D IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_i=
d : 0;
> +
> +       return 0;
> +}
> +
> +static int stmt_propagate_from(struct stmt_state *s)
> +{
> +       struct mount *m =3D real_mount(s->mnt);
> +
> +       if (!IS_MNT_SLAVE(m))
> +               return 0;
> +
> +       s->sm.propagate_from =3D get_dominating_id(m, &current->fs->root)=
;
> +
> +       return 0;
> +}
> +
> +static int stmt_mnt_root(struct stmt_state *s)
> +{
> +       struct seq_file *seq =3D &s->seq;
> +       int err =3D show_path(seq, s->mnt->mnt_root);
> +
> +       if (!err && !seq_has_overflowed(seq)) {
> +               seq->buf[seq->count] =3D '\0';
> +               seq->count =3D string_unescape_inplace(seq->buf, UNESCAPE=
_OCTAL);
> +       }
> +       return err;
> +}
> +
> +static int stmt_mountpoint(struct stmt_state *s)
> +{
> +       struct vfsmount *mnt =3D s->mnt;
> +       struct path mnt_path =3D { .dentry =3D mnt->mnt_root, .mnt =3D mn=
t };
> +       int err =3D seq_path_root(&s->seq, &mnt_path, &s->root, "");
> +
> +       return err =3D=3D SEQ_SKIP ? 0 : err;
> +}
> +
> +static int stmt_fs_type(struct stmt_state *s)
> +{
> +       struct seq_file *seq =3D &s->seq;
> +       struct super_block *sb =3D s->mnt->mnt_sb;
> +
> +       seq_puts(seq, sb->s_type->name);
> +       if (sb->s_subtype) {
> +               seq_putc(seq, '.');
> +               seq_puts(seq, sb->s_subtype);
> +       }
> +       return 0;
> +}
> +
> +static int stmt_sb_opts(struct stmt_state *s)
> +{
> +       struct seq_file *seq =3D &s->seq;
> +       struct super_block *sb =3D s->mnt->mnt_sb;
> +       char *p, *end, *next, *u =3D seq->buf;
> +       int err;
> +
> +       if (!sb->s_op->show_options)
> +               return 0;
> +
> +       err =3D sb->s_op->show_options(seq, s->mnt->mnt_root);
> +       if (err || seq_has_overflowed(seq) || !seq->count)
> +               return err;
> +
> +       end =3D seq->buf + seq->count;
> +       *end =3D '\0';
> +       for (p =3D seq->buf + 1; p < end; p =3D next + 1) {
> +               next =3D strchrnul(p, ',');
> +               *next =3D '\0';
> +               u +=3D string_unescape(p, u, 0, UNESCAPE_OCTAL) + 1;
> +       }
> +       seq->count =3D u - 1 - seq->buf;
> +       return 0;
> +}
> +
> +static int do_statmnt(struct stmt_state *s)
> +{
> +       struct statmnt *sm =3D &s->sm;
> +       struct mount *m =3D real_mount(s->mnt);
> +
> +       if (!capable(CAP_SYS_ADMIN) &&
> +           !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> +               return -EPERM;
> +
> +       stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
> +       stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
> +       stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
> +       stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
> +       stmt_string(s, STMT_MOUNTPOINT, stmt_mountpoint, &sm->mountpoint)=
;
> +       stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
> +       stmt_string(s, STMT_SB_OPTS, stmt_sb_opts, &sm->sb_opts);
> +
> +       if (s->err)
> +               return s->err;
> +
> +       if (copy_to_user(s->buf, sm, min_t(size_t, s->bufsize, sizeof(*sm=
))))
> +               return -EFAULT;
> +
> +       return 0;

Similar concern as with listmnt, I think that users would
want to have a way to get the fixed size statmnt part that fits
in the buffer, even if the variable length string values do not fit
and be able to query the required buffer size to get the strings.

The API could be either to explicitly request
STMT_MNT_ROOT_LEN | STMT_MOUNTPOINT_LEN ...
without allowing mixing of no-value and value requests,
or to out-out from any string values using a single flag,
which is probably more simple for API and implementation.

Thanks,
Amir.

> +}
> +
> +SYSCALL_DEFINE5(statmnt, u64, mnt_id,
> +               u64, mask, struct statmnt __user *, buf,
> +               size_t, bufsize, unsigned int, flags)
> +{
> +       struct vfsmount *mnt;
> +       int err;
> +
> +       if (flags)
> +               return -EINVAL;
> +
> +       down_read(&namespace_sem);
> +       mnt =3D lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
> +       err =3D -ENOENT;
> +       if (mnt) {
> +               struct stmt_state s =3D {
> +                       .mask =3D mask,
> +                       .buf =3D buf,
> +                       .bufsize =3D bufsize,
> +                       .mnt =3D mnt,
> +                       .pos =3D sizeof(*buf),
> +               };
> +
> +               get_fs_root(current->fs, &s.root);
> +               err =3D do_statmnt(&s);
> +               path_put(&s.root);
> +       }
> +       up_read(&namespace_sem);
> +
> +       return err;
> +}
> +
>  static void __init init_mount_tree(void)
>  {
>         struct vfsmount *mnt;
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 250eb5bf7b52..20681d1f6798 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -132,6 +132,15 @@ static int show_vfsmnt(struct seq_file *m, struct vf=
smount *mnt)
>         return err;
>  }
>
> +int show_path(struct seq_file *m, struct dentry *root)
> +{
> +       if (root->d_sb->s_op->show_path)
> +               return root->d_sb->s_op->show_path(m, root);
> +
> +       seq_dentry(m, root, " \t\n\\");
> +       return 0;
> +}
> +
>  static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
>  {
>         struct proc_mounts *p =3D m->private;
> @@ -142,13 +151,9 @@ static int show_mountinfo(struct seq_file *m, struct=
 vfsmount *mnt)
>
>         seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
>                    MAJOR(sb->s_dev), MINOR(sb->s_dev));
> -       if (sb->s_op->show_path) {
> -               err =3D sb->s_op->show_path(m, mnt->mnt_root);
> -               if (err)
> -                       goto out;
> -       } else {
> -               seq_dentry(m, mnt->mnt_root, " \t\n\\");
> -       }
> +       err =3D show_path(m, mnt->mnt_root);
> +       if (err)
> +               goto out;
>         seq_putc(m, ' ');
>
>         /* mountpoints outside of chroot jail will give SEQ_SKIP on this =
*/
> diff --git a/fs/statfs.c b/fs/statfs.c
> index 96d1c3edf289..cc774c2e2c9a 100644
> --- a/fs/statfs.c
> +++ b/fs/statfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/security.h>
>  #include <linux/uaccess.h>
>  #include <linux/compat.h>
> +#include <uapi/linux/mount.h>
>  #include "internal.h"
>
>  static int flags_by_mnt(int mnt_flags)
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 22bc6bc147f8..1099bd307fa7 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -408,6 +408,9 @@ asmlinkage long sys_statfs64(const char __user *path,=
 size_t sz,
>  asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
>  asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
>                                 struct statfs64 __user *buf);
> +asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
> +                           struct statmnt __user *buf, size_t bufsize,
> +                           unsigned int flags);
>  asmlinkage long sys_truncate(const char __user *path, long length);
>  asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
>  #if BITS_PER_LONG =3D=3D 32
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index abe087c53b4b..640997231ff6 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -823,8 +823,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
>  #define __NR_fchmodat2 452
>  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
>
> +#define __NR_statmnt   454
> +__SYSCALL(__NR_statmnt, sys_statmnt)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 453
> +#define __NR_syscalls 455
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index bb242fdcfe6b..4ec7308a9259 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -138,4 +138,40 @@ struct mount_attr {
>  /* List of all mount_attr versions. */
>  #define MOUNT_ATTR_SIZE_VER0   32 /* sizeof first published struct */
>
> +struct stmt_str {
> +       __u32 off;
> +       __u32 len;
> +};
> +
> +struct statmnt {
> +       __u64 mask;             /* What results were written [uncond] */
> +       __u32 sb_dev_major;     /* Device ID */
> +       __u32 sb_dev_minor;
> +       __u64 sb_magic;         /* ..._SUPER_MAGIC */
> +       __u32 sb_flags;         /* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIM=
E} */
> +       __u32 __spare1;
> +       __u64 mnt_id;           /* Unique ID of mount */
> +       __u64 mnt_parent_id;    /* Unique ID of parent (for root =3D=3D m=
nt_id) */
> +       __u32 mnt_id_old;       /* Reused IDs used in proc/.../mountinfo =
*/
> +       __u32 mnt_parent_id_old;
> +       __u64 mnt_attr;         /* MOUNT_ATTR_... */
> +       __u64 mnt_propagation;  /* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} *=
/
> +       __u64 mnt_peer_group;   /* ID of shared peer group */
> +       __u64 mnt_master;       /* Mount receives propagation from this I=
D */
> +       __u64 propagate_from;   /* Propagation from in current namespace =
*/
> +       __u64 __spare[20];
> +       struct stmt_str mnt_root;       /* Root of mount relative to root=
 of fs */
> +       struct stmt_str mountpoint;     /* Mountpoint relative to root of=
 process */
> +       struct stmt_str fs_type;        /* Filesystem type[.subtype] */
> +       struct stmt_str sb_opts;        /* Super block string options (nu=
l delimted) */
> +};
> +
> +#define STMT_SB_BASIC          0x00000001U     /* Want/got sb_... */
> +#define STMT_MNT_BASIC         0x00000002U     /* Want/got mnt_... */
> +#define STMT_PROPAGATE_FROM    0x00000004U     /* Want/got propagate_fro=
m */
> +#define STMT_MNT_ROOT          0x00000008U     /* Want/got mnt_root  */
> +#define STMT_MOUNTPOINT                0x00000010U     /* Want/got mount=
point */
> +#define STMT_FS_TYPE           0x00000020U     /* Want/got fs_type */
> +#define STMT_SB_OPTS           0x00000040U     /* Want/got sb_opts */
> +
>  #endif /* _UAPI_LINUX_MOUNT_H */
> --
> 2.41.0
>
