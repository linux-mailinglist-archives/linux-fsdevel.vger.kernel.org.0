Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8289579FC4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjINGsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 02:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:48:09 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50DCCD;
        Wed, 13 Sep 2023 23:48:05 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7a7d7a3d975so327868241.3;
        Wed, 13 Sep 2023 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694674084; x=1695278884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVkSBOidF5jZ/kRD34qwreK7L3VDPKeJsOCPs4UXZMQ=;
        b=M733xMII+mp7ll1MehLetOj5/Rby7bQvuFtvW0lSQNUQhO5Bum8DlPuopTxhZcbkkC
         eR0J9+V6ftgjvkE93OGwitdfAg+aus74mZUZOutDuLsf2m8moZbxu/vx23FauDW/XPe4
         s3F1BQlVqjFniCbqMuRnZk+LqzUmfXdZFZhr/4hhla0UpXaddaNu/rKdEmRK7858rkF7
         1nFgBNfFlyQAhAQw1U8lL+tfAZBaEH4yB7gz6/SqyHMXZUi7kmJM27coYE+ZoS3cdh/9
         bHHjDpokkodu2RzGbF3iXQWcA3pYxYTtdYRQJoi8GTy1S5dG8IFn5mk72Ltm1mf53ga9
         xgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694674084; x=1695278884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVkSBOidF5jZ/kRD34qwreK7L3VDPKeJsOCPs4UXZMQ=;
        b=gUMWSc7Y8CCP0bIExBrC+vKgA6Oh+JWYzXMueJN9wzdIjYi/WibszaRcTP/w1Jg/4+
         Rn1dwqembb5GA43GPRtTvlwIyKnmhE9aKBuq06fNvKPGGQ0QzQNFTICt5az1NNiIDOaU
         NErck3CNB0JhDJBUhDnSiaCiZjFQcyZ2XDQdHvWRgymutmjkpewPoI4UGyyztOiDv72O
         xfF8Af6xN/IXPb7ZvMo755JltB0Fg/8AMQ3rQ3tj3HRT3ZVP+gnCUjSGl6GoriVS9nwG
         +UjICompO9nZu/IuwHa2LKwCBvkr9e/QHo0WaB0tNydRVWtuV/IMSrHW3sauxQCY3Z32
         5x9A==
X-Gm-Message-State: AOJu0Yyv6ZZw0WaXjBlkPZe/fVjAAWewOZPfjSSY8mUNf/yYIKupzQ+X
        vrkSKE63jk0KtzYFTj6dfRWFSIBDWZqcezOojo82HZTQpY0=
X-Google-Smtp-Source: AGHT+IF9RDNj478YjOhQJscUtD8ZDfkcIOK5cUpGnYnn7NjXnzBZMXppz8hxntOHacJe+WK6pEX4ktUuZhsUpG3JwO0=
X-Received: by 2002:a1f:ea43:0:b0:48d:2bcf:f959 with SMTP id
 i64-20020a1fea43000000b0048d2bcff959mr5256766vkh.3.1694674084110; Wed, 13 Sep
 2023 23:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com>
In-Reply-To: <20230913152238.905247-1-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Sep 2023 09:47:52 +0300
Message-ID: <CAOQ4uxiuc0VNVaF98SE0axE3Mw6wMJJ1t36cmbcM5vwYLqtWSw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] quering mount attributes
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
> Implement the mount querying syscalls agreed on at LSF/MM 2023.  This is =
an
> RFC with just x86_64 syscalls.
>
> Excepting notification this should allow full replacement for
> parsing /proc/self/mountinfo.

Since you mentioned notifications, I will add that the plan discussed
in LFSMM was, once we have an API to query mount stats and children,
implement fanotify events for:
mount [mntuid] was un/mounted at [parent mntuid],[dirfid+name]

As with other fanotify events, the self mntuid and dirfid+name
information can be omitted and without it, multiple un/mount events
from the same parent mntuid will be merged, allowing userspace
to listmnt() periodically only mntuid whose child mounts have changed,
with little risk of event queue overflow.

The possible monitoring scopes would be the entire mount namespace
of the monitoring program or watching a single mount for change in
its children mounts. The latter is similar to inotify directory children wa=
tch,
where the watches needs to be set recursively, with all the weight on
userspace to avoid races.

That still leaves the problem of monitoring the creation of new mount
namespaces, but that is out of scope for this discussion, which is
about a replacement for /proc/self/mountinfo monitoring.

Thanks,
Amir.

>
> It is not a replacement for /proc/$OTHER_PID/mountinfo, since mount
> namespace and root are taken from the current task.  I guess namespace an=
d
> root could be switched before invoking these syscalls but that sounds a b=
it
> complicated.  Not sure if this is a problem.
>
> Test utility attached at the end.
> ---
>
> Miklos Szeredi (3):
>   add unique mount ID
>   add statmnt(2) syscall
>   add listmnt(2) syscall
>
>  arch/x86/entry/syscalls/syscall_64.tbl |   2 +
>  fs/internal.h                          |   5 +
>  fs/mount.h                             |   3 +-
>  fs/namespace.c                         | 365 +++++++++++++++++++++++++
>  fs/proc_namespace.c                    |  19 +-
>  fs/stat.c                              |   9 +-
>  fs/statfs.c                            |   1 +
>  include/linux/syscalls.h               |   5 +
>  include/uapi/asm-generic/unistd.h      |   8 +-
>  include/uapi/linux/mount.h             |  36 +++
>  include/uapi/linux/stat.h              |   1 +
>  11 files changed, 443 insertions(+), 11 deletions(-)
>
> --
> 2.41.0
>
> =3D=3D=3D statmnt.c =3D=3D=3D
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <string.h>
> #include <errno.h>
> #include <sys/mount.h>
> #include <sys/stat.h>
> #include <err.h>
>
> struct stmt_str {
>         __u32 off;
>         __u32 len;
> };
>
> struct statmnt {
>         __u64 mask;             /* What results were written [uncond] */
>         __u32 sb_dev_major;     /* Device ID */
>         __u32 sb_dev_minor;
>         __u64 sb_magic;         /* ..._SUPER_MAGIC */
>         __u32 sb_flags;         /* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIM=
E} */
>         __u32 __spare1;
>         __u64 mnt_id;           /* Unique ID of mount */
>         __u64 mnt_parent_id;    /* Unique ID of parent (for root =3D=3D m=
nt_id) */
>         __u32 mnt_id_old;       /* Reused IDs used in proc/.../mountinfo =
*/
>         __u32 mnt_parent_id_old;
>         __u64 mnt_attr;         /* MOUNT_ATTR_... */
>         __u64 mnt_propagation;  /* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} *=
/
>         __u64 mnt_peer_group;   /* ID of shared peer group */
>         __u64 mnt_master;       /* Mount receives propagation from this I=
D */
>         __u64 propagate_from;   /* Propagation from in current namespace =
*/
>         __u64 __spare[20];
>         struct stmt_str mnt_root;       /* Root of mount relative to root=
 of fs */
>         struct stmt_str mountpoint;     /* Mountpoint relative to root of=
 process */
>         struct stmt_str fs_type;        /* Filesystem type[.subtype] */
>         struct stmt_str sb_opts;        /* Super block string options (nu=
l delimted) */
> };
>
> #define STMT_SB_BASIC           0x00000001U     /* Want/got sb_... */
> #define STMT_MNT_BASIC          0x00000002U     /* Want/got mnt_... */
> #define STMT_PROPAGATE_FROM     0x00000004U     /* Want/got propagate_fro=
m */
> #define STMT_MNT_ROOT           0x00000008U     /* Want/got mnt_root  */
> #define STMT_MOUNTPOINT         0x00000010U     /* Want/got mountpoint */
> #define STMT_FS_TYPE            0x00000020U     /* Want/got fs_type */
> #define STMT_SB_OPTS            0x00000040U     /* Want/got sb_opts */
>
> #define __NR_statmnt   454
> #define __NR_listmnt   455
>
> #define STATX_MNT_ID_UNIQUE     0x00004000U     /* Want/got extended stx_=
mount_id */
>
> int main(int argc, char *argv[])
> {
>         char buf[65536];
>         struct statmnt *st =3D (void *) buf;
>         char *end;
>         const char *arg =3D argv[1];
>         long res;
>         int list =3D 0;
>         unsigned long mnt_id;
>         unsigned int mask =3D STMT_SB_BASIC | STMT_MNT_BASIC | STMT_PROPA=
GATE_FROM | STMT_MNT_ROOT | STMT_MOUNTPOINT | STMT_FS_TYPE | STMT_SB_OPTS;
>
>         if (arg && strcmp(arg, "-l") =3D=3D 0) {
>                 list =3D 1;
>                 arg =3D argv[2];
>         }
>         if (argc !=3D list + 2)
>                 errx(1, "usage: %s [-l] (mnt_id|path)", argv[0]);
>
>         mnt_id =3D strtol(arg, &end, 0);
>         if (!mnt_id || *end !=3D '\0') {
>                 struct statx sx;
>
>                 res =3D statx(AT_FDCWD, arg, 0, STATX_MNT_ID_UNIQUE, &sx)=
;
>                 if (res =3D=3D -1)
>                         err(1, "%s", arg);
>
>                 if (!(sx.stx_mask & (STATX_MNT_ID | STATX_MNT_ID_UNIQUE))=
)
>                         errx(1, "Sorry, no mount ID");
>
>                 mnt_id =3D sx.stx_mnt_id;
>         }
>
>
>         if (list) {
>                 size_t size =3D 8192;
>                 uint64_t list[size];
>                 long i, num;
>
>                 res =3D syscall(__NR_listmnt, mnt_id, list, size, 0);
>                 if (res =3D=3D -1)
>                         err(1, "listmnt(%lu)", mnt_id);
>
>                 num =3D res;
>                 for (i =3D 0; i < num; i++) {
>                         printf("0x%lx / ", list[i]);
>
>                         res =3D syscall(__NR_statmnt, list[i], STMT_MNT_B=
ASIC | STMT_MOUNTPOINT, &buf, sizeof(buf), 0);
>                         if (res =3D=3D -1) {
>                                 printf("???\t[%s]\n", strerror(errno));
>                         } else {
>                                 printf("%u\t%s\n", st->mnt_id_old,
>                                        (st->mask & STMT_MOUNTPOINT) ? buf=
 + st->mountpoint.off : "???");
>                         }
>                 }
>
>                 return 0;
>         }
>
>         res =3D syscall(__NR_statmnt, mnt_id, mask, &buf, sizeof(buf), 0)=
;
>         if (res =3D=3D -1)
>                 err(1, "statmnt(%lu)", mnt_id);
>
>         printf("mask: 0x%llx\n", st->mask);
>         if (st->mask & STMT_SB_BASIC) {
>                 printf("sb_dev_major: %u\n", st->sb_dev_major);
>                 printf("sb_dev_minor: %u\n", st->sb_dev_minor);
>                 printf("sb_magic: 0x%llx\n", st->sb_magic);
>                 printf("sb_flags: 0x%08x\n", st->sb_flags);
>         }
>         if (st->mask & STMT_MNT_BASIC) {
>                 printf("mnt_id: 0x%llx\n", st->mnt_id);
>                 printf("mnt_parent_id: 0x%llx\n", st->mnt_parent_id);
>                 printf("mnt_id_old: %u\n", st->mnt_id_old);
>                 printf("mnt_parent_id_old: %u\n", st->mnt_parent_id_old);
>                 printf("mnt_attr: 0x%08llx\n", st->mnt_attr);
>                 printf("mnt_propagation: %s%s%s%s\n",
>                        st->mnt_propagation & MS_SHARED ? "shared," : "",
>                        st->mnt_propagation & MS_SLAVE ? "slave," : "",
>                        st->mnt_propagation & MS_UNBINDABLE ? "unbindable,=
" : "",
>                        st->mnt_propagation & MS_PRIVATE ? "private" : "")=
;
>                 printf("mnt_peer_group: %llu\n", st->mnt_peer_group);
>                 printf("mnt_master: %llu\n", st->mnt_master);
>         }
>         if (st->mask & STMT_PROPAGATE_FROM) {
>                 printf("propagate_from: %llu\n", st->propagate_from);
>         }
>         if (st->mask & STMT_MNT_ROOT) {
>                 printf("mnt_root: %i/%u <%s>\n", st->mnt_root.off,
>                        st->mnt_root.len, buf + st->mnt_root.off);
>         }
>         if (st->mask & STMT_MOUNTPOINT) {
>                 printf("mountpoint: %i/%u <%s>\n", st->mountpoint.off,
>                        st->mountpoint.len, buf + st->mountpoint.off);
>         }
>         if (st->mask & STMT_FS_TYPE) {
>                 printf("fs_type: %i/%u <%s>\n", st->fs_type.off,
>                        st->fs_type.len, buf + st->fs_type.off);
>         }
>
>         if (st->mask & STMT_SB_OPTS) {
>                 char *p =3D buf + st->sb_opts.off;
>                 char *end =3D p + st->sb_opts.len;
>
>                 printf("sb_opts: %i/%u ", st->sb_opts.off, st->sb_opts.le=
n);
>                 for (; p < end; p +=3D strlen(p) + 1)
>                         printf("<%s>, ", p);
>                 printf("\n");
>         }
>
>         return 0;
> }
>
