Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10552120168
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 10:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLPJqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 04:46:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46039 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfLPJqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:46:21 -0500
Received: from [79.140.120.2] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1igmxF-0003LX-EQ; Mon, 16 Dec 2019 09:46:17 +0000
Date:   Mon, 16 Dec 2019 10:46:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>,
        linux-api@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Henning Schild <henning.schild@siemens.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        keescook@chromium.org
Subject: Re: [PATCH v8 0/1] ns: introduce binfmt_misc namespace
Message-ID: <20191216094615.xlhxoze3umjn2tzy@wittgenstein>
References: <20191216091220.465626-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216091220.465626-1-laurent@vivier.eu>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:12:19AM +0100, Laurent Vivier wrote:
> v8: s/file->f_path.dentry/file_dentry(file)/
> 
> v7: Use the new mount API
> 
>     Replace
> 
>       static struct dentry *bm_mount(struct file_system_type *fs_type,
>                             int flags, const char *dev_name, void *data)
>       {
>                struct user_namespace *ns = current_user_ns();
> 
>                return mount_ns(fs_type, flags, data, ns, ns,
>                                bm_fill_super);
>       }
> 
>     by
> 
>       static void bm_free(struct fs_context *fc)
>       {
>              if (fc->s_fs_info)
>                      put_user_ns(fc->s_fs_info);
>       }
> 
>       static int bm_get_tree(struct fs_context *fc)
>       {
>               return get_tree_keyed(fc, bm_fill_super, get_user_ns(fc->user_ns));
>       }
> 
>       static const struct fs_context_operations bm_context_ops = {
>               .free           = bm_free,
>               .get_tree       = bm_get_tree,
>       };
> 
>       static int bm_init_fs_context(struct fs_context *fc)
>       {
>               fc->ops = &bm_context_ops;
>               return 0;
>       }
> 
> v6: Return &init_binfmt_ns instead of NULL in binfmt_ns()
>     This should never happen, but to stay safe return a
>     value we can use.
>     change subject from "RFC" to "PATCH"
> 
> v5: Use READ_ONCE()/WRITE_ONCE()
>     move mount pointer struct init to bm_fill_super() and add smp_wmb()
>     remove useless NULL value init
>     add WARN_ON_ONCE()
> 
> v4: first user namespace is initialized with &init_binfmt_ns,
>     all new user namespaces are initialized with a NULL and use
>     the one of the first parent that is not NULL. The pointer
>     is initialized to a valid value the first time the binfmt_misc
>     fs is mounted in the current user namespace.
>     This allows to not change the way it was working before:
>     new ns inherits values from its parent, and if parent value is modified
>     (or parent creates its own binfmt entry by mounting the fs) child
>     inherits it (unless it has itself mounted the fs).
> 
> v3: create a structure to store binfmt_misc data,
>     add a pointer to this structure in the user_namespace structure,
>     in init_user_ns structure this pointer points to an init_binfmt_ns
>     structure. And all new user namespaces point to this init structure.
>     A new binfmt namespace structure is allocated if the binfmt_misc
>     filesystem is mounted in a user namespace that is not the initial
>     one but its binfmt namespace pointer points to the initial one.
>     add override_creds()/revert_creds() around open_exec() in
>     bm_register_write()
> 
> v2: no new namespace, binfmt_misc data are now part of
>     the mount namespace
>     I put this in mount namespace instead of user namespace
>     because the mount namespace is already needed and
>     I don't want to force to have the user namespace for that.
>     As this is a filesystem, it seems logic to have it here.
> 
> This allows to define a new interpreter for each new container.
> 
> But the main goal is to be able to chroot to a directory
> using a binfmt_misc interpreter without being root.
> 
> I have a modified version of unshare at:
> 
>   https://github.com/vivier/util-linux.git branch unshare-chroot
> 
> with some new options to unshare binfmt_misc namespace and to chroot
> to a directory.
> 
> If you have a directory /chroot/powerpc/jessie containing debian for powerpc
> binaries and a qemu-ppc interpreter, you can do for instance:
> 
>  $ uname -a
>  Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
>  $ ./unshare --map-root-user --fork --pid \
>    --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/qemu-ppc:OC" \
>    --root=/chroot/powerpc/jessie /bin/bash -l
>  # uname -a
>  Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 ppc GNU/Linux
>  # id
> uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
>  # ls -l
> total 5940
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 bin
> drwxr-xr-x.   2 nobody nogroup    4096 Jun 17 20:26 boot
> drwxr-xr-x.   4 nobody nogroup    4096 Aug 12 00:08 dev
> drwxr-xr-x.  42 nobody nogroup    4096 Sep 28 07:25 etc
> drwxr-xr-x.   3 nobody nogroup    4096 Sep 28 07:25 home
> drwxr-xr-x.   9 nobody nogroup    4096 Aug 12 00:58 lib
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 media
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 mnt
> drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 13:09 opt
> dr-xr-xr-x. 143 nobody nogroup       0 Sep 30 23:02 proc
> -rwxr-xr-x.   1 nobody nogroup 6009712 Sep 28 07:22 qemu-ppc
> drwx------.   3 nobody nogroup    4096 Aug 12 12:54 root
> drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 00:08 run
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 sbin
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 srv
> drwxr-xr-x.   2 nobody nogroup    4096 Apr  6  2015 sys
> drwxrwxrwt.   2 nobody nogroup    4096 Sep 28 10:31 tmp
> drwxr-xr-x.  10 nobody nogroup    4096 Aug 12 00:08 usr
> drwxr-xr-x.  11 nobody nogroup    4096 Aug 12 00:08 var
> 
> If you want to use the qemu binary provided by your distro, you can use
> 
>     --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/bin/qemu-ppc-static:OCF"
> 
> With the 'F' flag, qemu-ppc-static will be then loaded from the main root
> filesystem before switching to the chroot.
> 
> Another example is to use the 'P' flag in one chroot and not in another one (useful in a test
> environment to test different configurations of the same interpreter):
> 
> ./unshare --fork --pid --mount-proc --map-root-user --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff://usr/bin/qemu-ppc-noargv0:OCF" --root=/chroot/powerpc/jessie /bin/bash -l
> root@localhost:/# sh -c 'echo $0'
> /bin/sh
> 
> ./unshare --fork --pid --mount-proc --map-root-user --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff://usr/bin/qemu-ppc-argv0:OCFP" --root=/chroot/powerpc/jessie /bin/bash -l
> root@localhost:/# sh -c 'echo $0'
> sh

Hey Laurent,

We have quite some time before the v5.6 merge window opens. So I would
really like for this new feature to come with proper testing!

I know you've been waiting on this patch quite some time but adding
tests will not endanger v5.6 inclusion - lest we find significant bugs. ;)

Christian
