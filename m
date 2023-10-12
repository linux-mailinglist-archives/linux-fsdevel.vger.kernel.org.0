Return-Path: <linux-fsdevel+bounces-142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4E7C61CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322E7282882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36E7FC;
	Thu, 12 Oct 2023 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrbYGf+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB796652;
	Thu, 12 Oct 2023 00:31:20 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1159DC;
	Wed, 11 Oct 2023 17:31:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo762711a12.3;
        Wed, 11 Oct 2023 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070674; x=1697675474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX022Kjtq8dmydC7KvtxTJQHCPvATIQPjmDaRtLZ8to=;
        b=SrbYGf+hViAcToamTzUG3Lgr5TsnzDKsWibxSpe3DoG3LX14YjnsOz7neQl9k07mot
         aHDFCIJyk55Lgg6zwbJdezhWAr8l7EIu79+IagZIulLJTEVe/EaxVJ4L2baW4WB3c7b0
         FqrlDdcpEG0k64WfNev3ukBHdzXUcyj7y91uKJdqsmxa6i1LT0xg0X9XzeULcg0K1vHM
         jIHc8w1KOtt+vbtcpjh77OV/TqX29p1Devqjxr1BpWXJmCdUAY7rgFQ+YIbxke02Q+nW
         8b5lIHD5YX6qc4iP+R+MWA8AmKpbmmIP4oW12ebV4KBA08f5pzSqJtdy7I7g2u4M0Z3v
         6peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070674; x=1697675474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX022Kjtq8dmydC7KvtxTJQHCPvATIQPjmDaRtLZ8to=;
        b=ZujSmZPrpyASXnmxH2rlRvuwRS1kw52qhEvdHORcLUJnvl9w9Pa/yhSADfr9rvD2S2
         c5ck3fJOYGi0uX7fHWvZ4orqkr6eZ9Kd3ZX/v6VPksXwPmB65Q/bql8oNVmFXg4gsOmb
         SDLduoNsYwduMmD1naUAfGa/f28YfDzOOsLUvUjo2CybOzzoM4QgYKeeQAoXLEuw//2E
         XVInXAgY+DOtvI0Vv6zZz3eSosm0zLOx4yOcORgnQFgyn+972TS3Kh7Sx0wS95yZwN1M
         F8rmLOh2vvyvvGVNQ9NhwUqlOe8Hy8PcrzadGUeasv9RgNcQy/w7AgRWjs5Ap+TDcbMI
         MvlA==
X-Gm-Message-State: AOJu0YyolgA2TXbOgC5yN39tct++Pu+04b8mtZVu/uc0+7A1BxP2oXc3
	FEUftuBQLF7KpNT2TYZX1Q+/8biDtOS6wHh7sn0cYb9y
X-Google-Smtp-Source: AGHT+IHLbLbMRRVvYmAoHmjryDSZts/mHdcwYHUWEPL3ZfZIvK73XfM6/oKvh/ifvJ5VtuQE0azcBU+nvjmqetDQiU4=
X-Received: by 2002:a05:6402:134a:b0:534:63e:d0b7 with SMTP id
 y10-20020a056402134a00b00534063ed0b7mr21127359edw.23.1697070673981; Wed, 11
 Oct 2023 17:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-1-andrii@kernel.org> <20230927225809.2049655-4-andrii@kernel.org>
 <be371dfe-d297-7de3-0812-eb069232f410@huaweicloud.com>
In-Reply-To: <be371dfe-d297-7de3-0812-eb069232f410@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 17:31:02 -0700
Message-ID: <CAEf4BzZpbh=_CVmhJGc6_v7YTFKJEOJ=6B6=3g57Cr-NwNmdVw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 03/13] bpf: introduce BPF token object
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 7:35=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 9/28/2023 6:57 AM, Andrii Nakryiko wrote:
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while have a good amount of control over whic=
h
> > privileged operations could be performed using provided BPF token.
> >
> > This is achieved through mounting BPF FS instance with extra delegation
> > mount options, which determine what operations are delegatable, and als=
o
> > constraining it to the owning user namespace (as mentioned in the
> > previous patch).
> SNIP
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 70bfa997e896..78692911f4a0 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -847,6 +847,37 @@ union bpf_iter_link_info {
> >   *           Returns zero on success. On error, -1 is returned and *er=
rno*
> >   *           is set appropriately.
> >   *
> > + * BPF_TOKEN_CREATE
> > + *   Description
> > + *           Create BPF token with embedded information about what
> > + *           BPF-related functionality it allows:
> > + *           - a set of allowed bpf() syscall commands;
> > + *           - a set of allowed BPF map types to be created with
> > + *           BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allow=
ed;
> > + *           - a set of allowed BPF program types and BPF program atta=
ch
> > + *           types to be loaded with BPF_PROG_LOAD command, if
> > + *           BPF_PROG_LOAD itself is allowed.
> > + *
> > + *           BPF token is created (derived) from an instance of BPF FS=
,
> > + *           assuming it has necessary delegation mount options specif=
ied.
> > + *           BPF FS mount is specified with openat()-style path FD + s=
tring.
> > + *           This BPF token can be passed as an extra parameter to var=
ious
> > + *           bpf() syscall commands to grant BPF subsystem functionali=
ty to
> > + *           unprivileged processes.
> > + *
> > + *           When created, BPF token is "associated" with the owning
> > + *           user namespace of BPF FS instance (super block) that it w=
as
> > + *           derived from, and subsequent BPF operations performed wit=
h
> > + *           BPF token would be performing capabilities checks (i.e.,
> > + *           CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) withi=
n
> > + *           that user namespace. Without BPF token, such capabilities
> > + *           have to be granted in init user namespace, making bpf()
> > + *           syscall incompatible with user namespace, for the most pa=
rt.
> > + *
> > + *   Return
> > + *           A new file descriptor (a nonnegative integer), or -1 if a=
n
> > + *           error occurred (in which case, *errno* is set appropriate=
ly).
> > + *
> >   * NOTES
> >   *   eBPF objects (maps and programs) can be shared between processes.
> >   *
> > @@ -901,6 +932,8 @@ enum bpf_cmd {
> >       BPF_ITER_CREATE,
> >       BPF_LINK_DETACH,
> >       BPF_PROG_BIND_MAP,
> > +     BPF_TOKEN_CREATE,
> > +     __MAX_BPF_CMD,
> >  };
> >
> >  enum bpf_map_type {
> > @@ -1694,6 +1727,12 @@ union bpf_attr {
> >               __u32           flags;          /* extra flags */
> >       } prog_bind_map;
> >
> > +     struct { /* struct used by BPF_TOKEN_CREATE command */
> > +             __u32           flags;
> > +             __u32           bpffs_path_fd;
> > +             __u64           bpffs_pathname;
>
> Because bppfs_pathname is a string pointer, so __aligned_u64 is preferred=
.

ok, I'll use __aligned_u64, even though it can never be unaligned in this c=
ase


> > +     } token_create;
> > +
> >  } __attribute__((aligned(8)));
> >
> >  /* The description below is an attempt at providing documentation to e=
BPF
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index f526b7573e97..4ce95acfcaa7 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fn=
o-gcse
> >  endif
> >  CFLAGS_core.o +=3D $(call cc-disable-warning, override-init) $(cflags-=
nogcse-yy)
> >
> > -obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o =
tnum.o log.o
> > +obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o =
tnum.o log.o token.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_=
iter.o link_iter.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o =
bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ring=
buf.o
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 24b3faf901f4..de1fdf396521 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -99,9 +99,9 @@ static const struct inode_operations bpf_prog_iops =
=3D { };
> >  static const struct inode_operations bpf_map_iops  =3D { };
> >  static const struct inode_operations bpf_link_iops  =3D { };
> >
> > -static struct inode *bpf_get_inode(struct super_block *sb,
> > -                                const struct inode *dir,
> > -                                umode_t mode)
> > +struct inode *bpf_get_inode(struct super_block *sb,
> > +                         const struct inode *dir,
> > +                         umode_t mode)
> >  {
> >       struct inode *inode;
> >
> > @@ -603,11 +603,13 @@ static int bpf_show_options(struct seq_file *m, s=
truct dentry *root)
> >  {
> >       struct bpf_mount_opts *opts =3D root->d_sb->s_fs_info;
> >       umode_t mode =3D d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
> > +     u64 mask;
> >
> >       if (mode !=3D S_IRWXUGO)
> >               seq_printf(m, ",mode=3D%o", mode);
> >
> > -     if (opts->delegate_cmds =3D=3D ~0ULL)
> > +     mask =3D (1ULL << __MAX_BPF_CMD) - 1;
> > +     if ((opts->delegate_cmds & mask) =3D=3D mask)
> >               seq_printf(m, ",delegate_cmds=3Dany");
>
> Should we add a BUILD_BUG_ON assertion to guarantee __MAX_BPF_CMD is
> less than sizeof(u64) * 8 ?

yep, good idea, will add for CMD and all others

> >       else if (opts->delegate_cmds)
> >               seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_c=
mds);
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 7445dad01fb3..b47791a80930 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -5304,6 +5304,20 @@ static int bpf_prog_bind_map(union bpf_attr *att=
r)
> >       return ret;
> >  }
> >
> > +#define BPF_TOKEN_CREATE_LAST_FIELD token_create.bpffs_pathname
> > +
> > +static int token_create(union bpf_attr *attr)
> > +{
> > +     if (CHECK_ATTR(BPF_TOKEN_CREATE))
> > +             return -EINVAL;
> > +
> > +     /* no flags are supported yet */
> > +     if (attr->token_create.flags)
> > +             return -EINVAL;
> > +
> > +     return bpf_token_create(attr);
> > +}
> > +
> >  static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
> >  {
> >       union bpf_attr attr;
> > @@ -5437,6 +5451,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, uns=
igned int size)
> >       case BPF_PROG_BIND_MAP:
> >               err =3D bpf_prog_bind_map(&attr);
> >               break;
> > +     case BPF_TOKEN_CREATE:
> > +             err =3D token_create(&attr);
> > +             break;
> >       default:
> >               err =3D -EINVAL;
> >               break;
> > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > new file mode 100644
> > index 000000000000..779aad5007a3
> > --- /dev/null
> > +++ b/kernel/bpf/token.c
> SNIP
> > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > +
> > +static const struct inode_operations bpf_token_iops =3D { };
> > +
> > +static const struct file_operations bpf_token_fops =3D {
> > +     .release        =3D bpf_token_release,
> > +     .show_fdinfo    =3D bpf_token_show_fdinfo,
> > +};
> > +
> > +int bpf_token_create(union bpf_attr *attr)
> > +{
> > +     struct bpf_mount_opts *mnt_opts;
> > +     struct bpf_token *token =3D NULL;
> > +     struct inode *inode;
> > +     struct file *file;
> > +     struct path path;
> > +     umode_t mode;
> > +     int err, fd;
> > +
> > +     err =3D user_path_at(attr->token_create.bpffs_path_fd,
> > +                        u64_to_user_ptr(attr->token_create.bpffs_pathn=
ame),
> > +                        LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
> > +     if (err)
> > +             return err;
>
> Need to check the mount is a bpffs mount instead of other filesystem moun=
t.

yep, missed that. Fixed, will check `path.mnt->mnt_sb->s_op !=3D &bpf_super=
_ops`.

> > +
> > +     if (path.mnt->mnt_root !=3D path.dentry) {
> > +             err =3D -EINVAL;
> > +             goto out_path;
> > +     }
> > +     err =3D path_permission(&path, MAY_ACCESS);
> > +     if (err)
> > +             goto out_path;
> > +
> > +     mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
> > +     inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
> > +     if (IS_ERR(inode)) {
> > +             err =3D PTR_ERR(inode);
> > +             goto out_path;
> > +     }
> > +
> > +     inode->i_op =3D &bpf_token_iops;
> > +     inode->i_fop =3D &bpf_token_fops;
> > +     clear_nlink(inode); /* make sure it is unlinked */
> > +
> > +     file =3D alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,=
 O_RDWR, &bpf_token_fops);
> > +     if (IS_ERR(file)) {
> > +             iput(inode);
> > +             err =3D PTR_ERR(file);
> > +             goto out_file;
>
> goto out_path ?

eagle eye, fixed, thanks!


> > +     }
> > +
> > +     token =3D bpf_token_alloc();
> > +     if (!token) {
> > +             err =3D -ENOMEM;
> > +             goto out_file;
> > +     }
> > +
> > +     /* remember bpffs owning userns for future ns_capable() checks */
> > +     token->userns =3D get_user_ns(path.dentry->d_sb->s_user_ns);
> > +
> > +     mnt_opts =3D path.dentry->d_sb->s_fs_info;
> > +     token->allowed_cmds =3D mnt_opts->delegate_cmds;
> > +
> > +     fd =3D get_unused_fd_flags(O_CLOEXEC);
> > +     if (fd < 0) {
> > +             err =3D fd;
> > +             goto out_token;
> > +     }
> > +
> > +     file->private_data =3D token;
> > +     fd_install(fd, file);
> > +
> > +     path_put(&path);
> > +     return fd;
> > +
> > +out_token:
> > +     bpf_token_free(token);
> > +out_file:
> > +     fput(file);
> > +out_path:
> > +     path_put(&path);
> > +     return err;
> > +}
> > +
> .
>

