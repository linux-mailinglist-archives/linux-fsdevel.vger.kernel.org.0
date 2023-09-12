Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339F79DB1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjILVqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjILVqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:46:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDEC10CC;
        Tue, 12 Sep 2023 14:46:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso8115138a12.2;
        Tue, 12 Sep 2023 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694555200; x=1695160000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJdk9NZ8Turn42ErLT8E51OzpROy82JrcOtqkBELc1M=;
        b=Ls9qgnj8Kmf2XfMlXjgwFRRDCVVFx/WnibCOAtDk90J76iOtsL2QNZf+ThSdogtV7P
         +MQcq989JdCQd04HfU3ZSPyOmFpO7yOzKpGMjHVWfsa6hwYLefs6F5xDUdGkniQR+CeH
         3XWMZWkr3gqM0xFVv+0eHNCa69UZvry9PbwGs2rRuJllES/0t+dhka8XIuEy3oWKnhUQ
         SdqBSzTRqDzLT8r03m27eImeDIFDL8trEKVbswrvtqmrRkzpDRfgi5hY20HtNtPCg7JU
         p5llt5OYgkSL4nHkwjzb41cVNTAwZhV0RXUDVpEHyGAYoWHlligIfpaGfUeDcSH4cSmo
         qA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694555200; x=1695160000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJdk9NZ8Turn42ErLT8E51OzpROy82JrcOtqkBELc1M=;
        b=aBXhmVoRTdtAu+deOismNm0brf8zZqTSapqhV51bTXbG4Yt6TZmBHej7sQBvw0jjh6
         vqChhQ8QhIQnNfVUlzgkZwi8lGLfTXgSarUjVoyvenKKa95jN7x5RsNtgjNcRwX4TR2L
         0mhy2R9UPvtNECtlVEMO2hYOAUF/DNWwVl665vv+gIP9bXH0nppXdb6qjvvPEZnfDzfE
         YJ8VwSsnjsK6098nF8a2ez0bDHoWmIJmf3Yy6ecgzbF/mPihhPG49Aa5SLwPQH6WbUaX
         gJXfT7IMH0E7QOcB9sovqdYuttJKnLtzFn1Hwf4DGuQQKLIfcDVTWsW/2nnO2aWYFaT2
         GOog==
X-Gm-Message-State: AOJu0Yx8B8vD+o1KmgH7OsJtqM0wmEou+KwpQJGx9GJVgnciwD53Y3Gm
        Q6oQS4ZZGHeEyE3z+lMtRq8ugrb83jy0I/NX6NI=
X-Google-Smtp-Source: AGHT+IG4ks0pwaYDWU7+rMBBVD1LXxvU1FqAf/deXSqqAk/CCO/9JyEEwE1Y1J2e8gcTzBy+bUszx6WqtTOgOZ0s8/4=
X-Received: by 2002:aa7:d384:0:b0:52e:d32d:89a1 with SMTP id
 x4-20020aa7d384000000b0052ed32d89a1mr777545edq.13.1694555199706; Tue, 12 Sep
 2023 14:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-1-andrii@kernel.org> <20230912212906.3975866-3-andrii@kernel.org>
In-Reply-To: <20230912212906.3975866-3-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Sep 2023 14:46:27 -0700
Message-ID: <CAEf4BzbQPqSevg2VpLHGP1NTPpR2S6n0K=Tkx5tudgNFJOdmOQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 02/12] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 12, 2023 at 2:30=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add new kind of BPF kernel object, BPF token. BPF token is meant to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while have a good amount of control over which
> privileged operations could be performed using provided BPF token.
>
> This is achieved through mounting BPF FS instance with extra delegation
> mount options, which determine what operations are delegatable, and also
> constraining it to the owning user namespace (as mentioned in the
> previous patch).
>
> BPF token itself is just a derivative from BPF FS and can be created
> through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
> a path specification (using the usual fd + string path combo) to a BPF
> FS mount. Currently, BPF token "inherits" delegated command, map types,
> prog type, and attach type bit sets from BPF FS as is. In the future,
> having an BPF token as a separate object with its own FD, we can allow
> to further restrict BPF token's allowable set of things either at the cre=
ation
> time or after the fact, allowing the process to guard itself further
> from, e.g., unintentionally trying to load undesired kind of BPF
> programs. But for now we keep things simple and just copy bit sets as is.
>
> When BPF token is created from BPF FS mount, we take reference to the
> BPF super block's owning user namespace, and then use that namespace for
> checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> capabilities that are normally only checked against init userns (using
> capable()), but now we check them using ns_capable() instead (if BPF
> token is provided). See bpf_token_capable() for details.
>
> Such setup means that BPF token in itself is not sufficient to grant BPF
> functionality. User namespaced process has to *also* have necessary
> combination of capabilities inside that user namespace. So while
> previously CAP_BPF was useless when granted within user namespace, now
> it gains a meaning and allows container managers and sys admins to have
> a flexible control over which processes can and need to use BPF
> functionality within the user namespace (i.e., container in practice).
> And BPF FS delegation mount options and derived BPF tokens serve as
> a per-container "flag" to grant overall ability to use bpf() (plus furthe=
r
> restrict on which parts of bpf() syscalls are treated as namespaced).
>
> The alternative to creating BPF token object was:
>   a) not having any extra object and just pasing BPF FS path to each
>      relevant bpf() command. This seems suboptimal as it's racy (mount
>      under the same path might change in between checking it and using it
>      for bpf() command). And also less flexible if we'd like to further
>      restrict ourselves compared to all the delegated functionality
>      allowed on BPF FS.
>   b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
>      a dedicated FD that would represent a token-like functionality. This
>      doesn't seem superior to having a proper bpf() command, so
>      BPF_TOKEN_CREATE was chosen.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  36 +++++++
>  include/uapi/linux/bpf.h       |  39 +++++++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/inode.c             |   4 +-
>  kernel/bpf/syscall.c           |  17 +++
>  kernel/bpf/token.c             | 189 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  39 +++++++
>  7 files changed, 324 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/bpf/token.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e9a3ab390844..6abd2b96e096 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -51,6 +51,8 @@ struct module;
>  struct bpf_func_state;
>  struct ftrace_ops;
>  struct cgroup;
> +struct bpf_token;
> +struct user_namespace;
>
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
> @@ -1568,6 +1570,13 @@ struct bpf_mount_opts {
>         u64 delegate_attachs;
>  };
>
> +struct bpf_token {
> +       struct work_struct work;
> +       atomic64_t refcnt;
> +       struct user_namespace *userns;
> +       u64 allowed_cmds;
> +};
> +
>  struct bpf_struct_ops_value;
>  struct btf_member;
>
> @@ -2192,6 +2201,15 @@ int bpf_link_new_fd(struct bpf_link *link);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>
> +void bpf_token_inc(struct bpf_token *token);
> +void bpf_token_put(struct bpf_token *token);
> +int bpf_token_create(union bpf_attr *attr);
> +int bpf_token_new_fd(struct bpf_token *token);
> +struct bpf_token *bpf_token_get_from_fd(u32 ufd);
> +
> +bool bpf_token_capable(const struct bpf_token *token, int cap);
> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
> +
>  int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
>  int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
>
> @@ -2551,6 +2569,24 @@ static inline int bpf_obj_get_user(const char __us=
er *pathname, int flags)
>         return -EOPNOTSUPP;
>  }
>
> +static inline void bpf_token_inc(struct bpf_token *token)
> +{
> +}
> +
> +static inline void bpf_token_put(struct bpf_token *token)
> +{
> +}
> +
> +static inline int bpf_token_new_fd(struct bpf_token *token)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline void __dev_flush(void)
>  {
>  }
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 73b155e52204..36e98c6f8944 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -847,6 +847,37 @@ union bpf_iter_link_info {
>   *             Returns zero on success. On error, -1 is returned and *er=
rno*
>   *             is set appropriately.
>   *
> + * BPF_TOKEN_CREATE
> + *     Description
> + *             Create BPF token with embedded information about what
> + *             BPF-related functionality it allows:
> + *             - a set of allowed bpf() syscall commands;
> + *             - a set of allowed BPF map types to be created with
> + *             BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allow=
ed;
> + *             - a set of allowed BPF program types and BPF program atta=
ch
> + *             types to be loaded with BPF_PROG_LOAD command, if
> + *             BPF_PROG_LOAD itself is allowed.
> + *
> + *             BPF token is created (derived) from an instance of BPF FS=
,
> + *             assuming it has necessary delegation mount options specif=
ied.
> + *             BPF FS mount is specified with openat()-style path FD + s=
tring.
> + *             This BPF token can be passed as an extra parameter to var=
ious
> + *             bpf() syscall commands to grant BPF subsystem functionali=
ty to
> + *             unprivileged processes.
> + *
> + *             When created, BPF token is "associated" with the owning
> + *             user namespace of BPF FS instance (super block) that it w=
as
> + *             derived from, and subsequent BPF operations performed wit=
h
> + *             BPF token would be performing capabilities checks (i.e.,
> + *             CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) withi=
n
> + *             that user namespace. Without BPF token, such capabilities
> + *             have to be granted in init user namespace, making bpf()
> + *             syscall incompatible with user namespace, for the most pa=
rt.
> + *
> + *     Return
> + *             A new file descriptor (a nonnegative integer), or -1 if a=
n
> + *             error occurred (in which case, *errno* is set appropriate=
ly).
> + *
>   * NOTES
>   *     eBPF objects (maps and programs) can be shared between processes.
>   *
> @@ -901,6 +932,8 @@ enum bpf_cmd {
>         BPF_ITER_CREATE,
>         BPF_LINK_DETACH,
>         BPF_PROG_BIND_MAP,
> +       BPF_TOKEN_CREATE,
> +       __MAX_BPF_CMD,
>  };
>
>  enum bpf_map_type {
> @@ -1694,6 +1727,12 @@ union bpf_attr {
>                 __u32           flags;          /* extra flags */
>         } prog_bind_map;
>
> +       struct { /* struct used by BPF_TOKEN_CREATE command */
> +               __u32           flags;
> +               __u32           bpffs_path_fd;
> +               __u64           bpffs_pathname;
> +       } token_create;
> +
>  } __attribute__((aligned(8)));
>
>  /* The description below is an attempt at providing documentation to eBP=
F
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index f526b7573e97..4ce95acfcaa7 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno-=
gcse
>  endif
>  CFLAGS_core.o +=3D $(call cc-disable-warning, override-init) $(cflags-no=
gcse-yy)
>
> -obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o token.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 8f66b57d3546..82f11fbffd3e 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -603,11 +603,13 @@ static int bpf_show_options(struct seq_file *m, str=
uct dentry *root)
>  {
>         struct bpf_mount_opts *opts =3D root->d_sb->s_fs_info;
>         umode_t mode =3D d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
> +       u64 mask;
>
>         if (mode !=3D S_IRWXUGO)
>                 seq_printf(m, ",mode=3D%o", mode);
>
> -       if (opts->delegate_cmds =3D=3D ~0ULL)
> +       mask =3D (1ULL << __MAX_BPF_CMD) - 1;
> +       if ((opts->delegate_cmds & mask) =3D=3D mask)
>                 seq_printf(m, ",delegate_cmds=3Dany");
>         else if (opts->delegate_cmds)
>                 seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_c=
mds);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6a692f3bea15..4fae678c1f48 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5297,6 +5297,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>         return ret;
>  }
>
> +#define BPF_TOKEN_CREATE_LAST_FIELD token_create.bpffs_pathname
> +
> +static int token_create(union bpf_attr *attr)
> +{
> +       if (CHECK_ATTR(BPF_TOKEN_CREATE))
> +               return -EINVAL;
> +
> +       /* no flags are supported yet */
> +       if (attr->token_create.flags)
> +               return -EINVAL;

A question to people looking at this: should BPF_TOKEN_CREATE be
guarded with ns_capable(CAP_BPF) or it's fine to rely on FS
permissions alone for this? It can't be capable(CAP_BPF), obviously,
but having it guarded by ns_capable(CAP_BPF) would make it impossible
to even construct a BPF token without having namespaced CAP_BPF inside
the container.

> +
> +       return bpf_token_create(attr);
> +}
> +
>  static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
>  {
>         union bpf_attr attr;
> @@ -5430,6 +5444,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsig=
ned int size)
>         case BPF_PROG_BIND_MAP:
>                 err =3D bpf_prog_bind_map(&attr);
>                 break;
> +       case BPF_TOKEN_CREATE:
> +               err =3D token_create(&attr);
> +               break;
>         default:
>                 err =3D -EINVAL;
>                 break;
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> new file mode 100644
> index 000000000000..f6ea3eddbee6
> --- /dev/null
> +++ b/kernel/bpf/token.c
> @@ -0,0 +1,189 @@
> +#include <linux/bpf.h>
> +#include <linux/vmalloc.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/fdtable.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/idr.h>
> +#include <linux/namei.h>
> +#include <linux/user_namespace.h>
> +
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +       /* BPF token allows ns_capable() level of capabilities */
> +       if (token) {
> +               if (ns_capable(token->userns, cap))
> +                       return true;
> +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, C=
AP_SYS_ADMIN))
> +                       return true;
> +       }
> +       /* otherwise fallback to capable() checks */
> +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS=
_ADMIN));
> +}
> +
> +void bpf_token_inc(struct bpf_token *token)
> +{
> +       atomic64_inc(&token->refcnt);
> +}
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{
> +       put_user_ns(token->userns);
> +       kvfree(token);
> +}
> +
> +static void bpf_token_put_deferred(struct work_struct *work)
> +{
> +       struct bpf_token *token =3D container_of(work, struct bpf_token, =
work);
> +
> +       bpf_token_free(token);
> +}
> +
> +void bpf_token_put(struct bpf_token *token)
> +{
> +       if (!token)
> +               return;
> +
> +       if (!atomic64_dec_and_test(&token->refcnt))
> +               return;
> +
> +       INIT_WORK(&token->work, bpf_token_put_deferred);
> +       schedule_work(&token->work);
> +}
> +
> +static int bpf_token_release(struct inode *inode, struct file *filp)
> +{
> +       struct bpf_token *token =3D filp->private_data;
> +
> +       bpf_token_put(token);
> +       return 0;
> +}
> +
> +static ssize_t bpf_dummy_read(struct file *filp, char __user *buf, size_=
t siz,
> +                             loff_t *ppos)
> +{
> +       /* We need this handler such that alloc_file() enables
> +        * f_mode with FMODE_CAN_READ.
> +        */
> +       return -EINVAL;
> +}
> +
> +static ssize_t bpf_dummy_write(struct file *filp, const char __user *buf=
,
> +                              size_t siz, loff_t *ppos)
> +{
> +       /* We need this handler such that alloc_file() enables
> +        * f_mode with FMODE_CAN_WRITE.
> +        */
> +       return -EINVAL;
> +}
> +
> +static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
> +{
> +       struct bpf_token *token =3D filp->private_data;
> +       u64 mask;
> +
> +       mask =3D (1ULL << __MAX_BPF_CMD) - 1;
> +       if ((token->allowed_cmds & mask) =3D=3D mask)
> +               seq_printf(m, "allowed_cmds:\tany\n");
> +       else
> +               seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_c=
mds);
> +}
> +
> +static const struct file_operations bpf_token_fops =3D {
> +       .release        =3D bpf_token_release,
> +       .read           =3D bpf_dummy_read,
> +       .write          =3D bpf_dummy_write,
> +       .show_fdinfo    =3D bpf_token_show_fdinfo,
> +};
> +
> +static struct bpf_token *bpf_token_alloc(void)
> +{
> +       struct bpf_token *token;
> +
> +       token =3D kvzalloc(sizeof(*token), GFP_USER);
> +       if (!token)
> +               return NULL;
> +
> +       atomic64_set(&token->refcnt, 1);
> +
> +       return token;
> +}
> +
> +int bpf_token_create(union bpf_attr *attr)
> +{
> +       struct path path;
> +       struct bpf_mount_opts *mnt_opts;
> +       struct bpf_token *token;
> +       int ret;
> +
> +       ret =3D user_path_at(attr->token_create.bpffs_path_fd,
> +                          u64_to_user_ptr(attr->token_create.bpffs_pathn=
ame),
> +                          LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
> +       if (ret)
> +               return ret;
> +
> +       if (path.mnt->mnt_root !=3D path.dentry) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       ret =3D path_permission(&path, MAY_ACCESS);
> +       if (ret)
> +               goto out;
> +
> +       token =3D bpf_token_alloc();
> +       if (!token) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       /* remember bpffs owning userns for future ns_capable() checks */
> +       token->userns =3D get_user_ns(path.dentry->d_sb->s_user_ns);
> +
> +       mnt_opts =3D path.dentry->d_sb->s_fs_info;
> +       token->allowed_cmds =3D mnt_opts->delegate_cmds;
> +
> +       ret =3D bpf_token_new_fd(token);
> +       if (ret < 0)
> +               bpf_token_free(token);
> +out:
> +       path_put(&path);
> +       return ret;
> +}
> +
> +#define BPF_TOKEN_INODE_NAME "bpf-token"
> +
> +/* Alloc anon_inode and FD for prepared token.
> + * Returns fd >=3D 0 on success; negative error, otherwise.
> + */
> +int bpf_token_new_fd(struct bpf_token *token)
> +{
> +       return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, to=
ken, O_CLOEXEC);
> +}
> +
> +struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> +{
> +       struct fd f =3D fdget(ufd);
> +       struct bpf_token *token;
> +
> +       if (!f.file)
> +               return ERR_PTR(-EBADF);
> +       if (f.file->f_op !=3D &bpf_token_fops) {
> +               fdput(f);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       token =3D f.file->private_data;
> +       bpf_token_inc(token);
> +       fdput(f);
> +
> +       return token;
> +}
> +
> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
)
> +{
> +       if (!token)
> +               return false;
> +
> +       return token->allowed_cmds & (1ULL << cmd);
> +}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 73b155e52204..36e98c6f8944 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -847,6 +847,37 @@ union bpf_iter_link_info {
>   *             Returns zero on success. On error, -1 is returned and *er=
rno*
>   *             is set appropriately.
>   *
> + * BPF_TOKEN_CREATE
> + *     Description
> + *             Create BPF token with embedded information about what
> + *             BPF-related functionality it allows:
> + *             - a set of allowed bpf() syscall commands;
> + *             - a set of allowed BPF map types to be created with
> + *             BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allow=
ed;
> + *             - a set of allowed BPF program types and BPF program atta=
ch
> + *             types to be loaded with BPF_PROG_LOAD command, if
> + *             BPF_PROG_LOAD itself is allowed.
> + *
> + *             BPF token is created (derived) from an instance of BPF FS=
,
> + *             assuming it has necessary delegation mount options specif=
ied.
> + *             BPF FS mount is specified with openat()-style path FD + s=
tring.
> + *             This BPF token can be passed as an extra parameter to var=
ious
> + *             bpf() syscall commands to grant BPF subsystem functionali=
ty to
> + *             unprivileged processes.
> + *
> + *             When created, BPF token is "associated" with the owning
> + *             user namespace of BPF FS instance (super block) that it w=
as
> + *             derived from, and subsequent BPF operations performed wit=
h
> + *             BPF token would be performing capabilities checks (i.e.,
> + *             CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) withi=
n
> + *             that user namespace. Without BPF token, such capabilities
> + *             have to be granted in init user namespace, making bpf()
> + *             syscall incompatible with user namespace, for the most pa=
rt.
> + *
> + *     Return
> + *             A new file descriptor (a nonnegative integer), or -1 if a=
n
> + *             error occurred (in which case, *errno* is set appropriate=
ly).
> + *
>   * NOTES
>   *     eBPF objects (maps and programs) can be shared between processes.
>   *
> @@ -901,6 +932,8 @@ enum bpf_cmd {
>         BPF_ITER_CREATE,
>         BPF_LINK_DETACH,
>         BPF_PROG_BIND_MAP,
> +       BPF_TOKEN_CREATE,
> +       __MAX_BPF_CMD,
>  };
>
>  enum bpf_map_type {
> @@ -1694,6 +1727,12 @@ union bpf_attr {
>                 __u32           flags;          /* extra flags */
>         } prog_bind_map;
>
> +       struct { /* struct used by BPF_TOKEN_CREATE command */
> +               __u32           flags;
> +               __u32           bpffs_path_fd;
> +               __u64           bpffs_pathname;
> +       } token_create;
> +
>  } __attribute__((aligned(8)));
>
>  /* The description below is an attempt at providing documentation to eBP=
F
> --
> 2.34.1
>
>
