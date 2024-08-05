Return-Path: <linux-fsdevel+bounces-24998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077AA947966
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C31C2017F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714ED15A4AF;
	Mon,  5 Aug 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr0BcwZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C8156899;
	Mon,  5 Aug 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853258; cv=none; b=b0mzO5VR/1aKtmsawMrdnWBOHqd/7rO8wmCtv7X2uQ6cffMAr3BSCtgbtUYbVobL7NdEOQVVZVO0nKm8x4+6DYdNzA7yz+QxDNUo+dOWVoifzSdB+p90PCsn6m3vS0QjmXPqzW2DIx9K0hJhFA5PotAC6H4hmal72iXJ8Vw52tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853258; c=relaxed/simple;
	bh=yKff71coMiTPQXo77q6gFamXJPAuyHeBjScWwioklIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXR5i/rzynm/Z4u5t4qRT6LTj3Ocns5VuDk23hRVRu7TOeT8hRXYjNL0xff/GdW+y98Mlbl6RFLTIOR02ZMRrpM0ODZ128OqkN4cQLUypGKwyfpNtxSK8GFDxduW7rIMZihwyspcmVUsH2woBpYgY0FTkEQv+8Za2Ejj47/kW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr0BcwZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF52C4AF12;
	Mon,  5 Aug 2024 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853258;
	bh=yKff71coMiTPQXo77q6gFamXJPAuyHeBjScWwioklIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lr0BcwZRRVJqq8nnxFKElkds8d0oizUwP/XzFg2C9TgNPcwJ7VgjTQHUV4TWnslKu
	 0ji6soFr7FFtqkREOp6xF7C5XGMe/C6ScpgTdC1HRTYgd2xgy+lp3c/Kw0vusJITcp
	 zvuEx/1+SCeQRNgYrVEq7mhtJ9pz+v8bXKwdbFzE+NFIkV6mdiDzuP8S5bijdyV/Z+
	 OeX6RCJtXHOEc/n3zPWLXyYRzTb2hN8flgQ3LyjLPeoa++yR3oPQ6/Dyo2jg2HPFJj
	 mW+FQYm2X3nXDNZZrGTDqRyBUIFsBU0wcFRfKx2CMCXMi86On6H/WJhk4N5AupjS7+
	 b49Xb5ugpem6A==
Date: Mon, 5 Aug 2024 12:20:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Steve Sistare <steven.sistare@oracle.com>, Jan Kara <jack@suse.cz>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-fsdevel@vger.kernel.org, Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Paul Durrant <pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: Re: [PATCH 01/10] guestmemfs: Introduce filesystem skeleton
Message-ID: <20240805-tukan-emblem-f84119475e49@brauner>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805093245.889357-2-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805093245.889357-2-jgowans@amazon.com>

(I'm just going to point at a few things but it's by no means a
comprehensive review.)

On Mon, Aug 05, 2024 at 11:32:36AM GMT, James Gowans wrote:
> Add an in-memory filesystem: guestmemfs. Memory is donated to guestmemfs
> by carving it out of the normal System RAM range with the memmap= cmdline
> parameter and then giving that same physical range to guestmemfs with the
> guestmemfs= cmdline parameter.
> 
> A new filesystem is added; so far it doesn't do much except persist a
> super block at the start of the donated memory and allows itself to be
> mounted.
> 
> A hook to x86 mm init is added to reserve the memory really early on via
> memblock allocator. There is probably a better arch-independent place to
> do this...
> 
> Signed-off-by: James Gowans <jgowans@amazon.com>
> ---
>  arch/x86/mm/init_64.c      |   2 +
>  fs/Kconfig                 |   1 +
>  fs/Makefile                |   1 +
>  fs/guestmemfs/Kconfig      |  11 ++++
>  fs/guestmemfs/Makefile     |   6 ++
>  fs/guestmemfs/guestmemfs.c | 116 +++++++++++++++++++++++++++++++++++++
>  fs/guestmemfs/guestmemfs.h |   9 +++
>  include/linux/guestmemfs.h |  16 +++++
>  8 files changed, 162 insertions(+)
>  create mode 100644 fs/guestmemfs/Kconfig
>  create mode 100644 fs/guestmemfs/Makefile
>  create mode 100644 fs/guestmemfs/guestmemfs.c
>  create mode 100644 fs/guestmemfs/guestmemfs.h
>  create mode 100644 include/linux/guestmemfs.h
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 8932ba8f5cdd..39fcf017c90c 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/swap.h>
>  #include <linux/smp.h>
> +#include <linux/guestmemfs.h>
>  #include <linux/init.h>
>  #include <linux/initrd.h>
>  #include <linux/kexec.h>
> @@ -1331,6 +1332,7 @@ static void __init preallocate_vmalloc_pages(void)
>  
>  void __init mem_init(void)
>  {
> +	guestmemfs_reserve_mem();
>  	pci_iommu_alloc();
>  
>  	/* clear_bss() already clear the empty_zero_page */
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f..727359901da8 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -321,6 +321,7 @@ source "fs/befs/Kconfig"
>  source "fs/bfs/Kconfig"
>  source "fs/efs/Kconfig"
>  source "fs/jffs2/Kconfig"
> +source "fs/guestmemfs/Kconfig"
>  # UBIFS File system configuration
>  source "fs/ubifs/Kconfig"
>  source "fs/cramfs/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 6ecc9b0a53f2..044524b17d63 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>  obj-$(CONFIG_EROFS_FS)		+= erofs/
>  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> +obj-$(CONFIG_GUESTMEMFS_FS)	+= guestmemfs/
> diff --git a/fs/guestmemfs/Kconfig b/fs/guestmemfs/Kconfig
> new file mode 100644
> index 000000000000..d87fca4822cb
> --- /dev/null
> +++ b/fs/guestmemfs/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config GUESTMEMFS_FS
> +	bool "Persistent Guest memory filesystem (guestmemfs)"
> +	help
> +	  An in-memory filesystem on top of reserved memory specified via
> +	  guestmemfs= cmdline argument.  Used for storing kernel state and
> +	  userspace memory which is preserved across kexec to support
> +	  live update of a hypervisor when running guest virtual machines.
> +	  Select this if you need the ability to persist memory for guest VMs
> +	  across kexec to do live update.
> diff --git a/fs/guestmemfs/Makefile b/fs/guestmemfs/Makefile
> new file mode 100644
> index 000000000000..6dc820a9d4fe
> --- /dev/null
> +++ b/fs/guestmemfs/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for persistent kernel filesystem
> +#
> +
> +obj-y += guestmemfs.o
> diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
> new file mode 100644
> index 000000000000..3aaada1b8df6
> --- /dev/null
> +++ b/fs/guestmemfs/guestmemfs.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "guestmemfs.h"
> +#include <linux/dcache.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/fs_context.h>
> +#include <linux/io.h>
> +#include <linux/memblock.h>
> +#include <linux/statfs.h>
> +
> +static phys_addr_t guestmemfs_base, guestmemfs_size;
> +struct guestmemfs_sb *psb;
> +
> +static int statfs(struct dentry *root, struct kstatfs *buf)
> +{
> +	simple_statfs(root, buf);
> +	buf->f_bsize = PMD_SIZE;
> +	buf->f_blocks = guestmemfs_size / PMD_SIZE;
> +	buf->f_bfree = buf->f_bavail = buf->f_blocks;
> +	return 0;
> +}
> +
> +static const struct super_operations guestmemfs_super_ops = {
> +	.statfs = statfs,

(Please make it a habit to name these things with a consistent prefix.
Doesn't matter if it's wubalubadubdub_statfs() or guestmemfs_statfs() as
far as I'm concerned but just something that is grep-able and local to
your fs.)

> +};
> +
> +static int guestmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct inode *inode;
> +	struct dentry *dentry;
> +
> +	psb = kzalloc(sizeof(*psb), GFP_KERNEL);
> +	/*
> +	 * Keep a reference to the persistent super block in the
> +	 * ephemeral super block.
> +	 */
> +	sb->s_fs_info = psb;
> +	sb->s_op = &guestmemfs_super_ops;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;
> +
> +	inode->i_ino = 1;
> +	inode->i_mode = S_IFDIR;
> +	inode->i_op = &simple_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	simple_inode_init_ts(inode);
> +	/* directory inodes start off with i_nlink == 2 (for "." entry) */
> +	inc_nlink(inode);
> +
> +	dentry = d_make_root(inode);
> +	if (!dentry)
> +		return -ENOMEM;
> +	sb->s_root = dentry;
> +
> +	return 0;
> +}
> +
> +static int guestmemfs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_nodev(fc, guestmemfs_fill_super);

That makes the filesystem multi-instance so

mount -t guestmemfs guestmemfs /mnt
mount -t guestmemfs guestmemfs /opt

would mount two separate instances of guestmemfs. That is intentional,
right as multiple instances draw memory from the same reserved
memblock?

> +}
> +
> +static const struct fs_context_operations guestmemfs_context_ops = {
> +	.get_tree	= guestmemfs_get_tree,
> +};
> +
> +static int guestmemfs_init_fs_context(struct fs_context *const fc)
> +{
> +	fc->ops = &guestmemfs_context_ops;
> +	return 0;
> +}
> +
> +static struct file_system_type guestmemfs_fs_type = {
> +	.owner                  = THIS_MODULE,
> +	.name                   = "guestmemfs",
> +	.init_fs_context        = guestmemfs_init_fs_context,
> +	.kill_sb                = kill_litter_super,
> +	.fs_flags               = FS_USERNS_MOUNT,

This makes the filesystem mountable by unprivileged containers and
therefore unprivileged users. Iiuc, you need a mechanism to prevent a
container from just taking over the whole reserved memory block. Afaict
memblock isn't accounted for in cgroups at all so it'd be good to know
how that would be done. And that should be explained somewhere in the
documentation patch, please.

> +};
> +
> +static int __init guestmemfs_init(void)
> +{
> +	int ret;
> +
> +	ret = register_filesystem(&guestmemfs_fs_type);
> +	return ret;
> +}
> +
> +/**
> + * Format: guestmemfs=<size>:<base>
> + * Just like: memmap=nn[KMG]!ss[KMG]
> + */
> +static int __init parse_guestmemfs_extents(char *p)
> +{
> +	guestmemfs_size = memparse(p, &p);
> +	return 0;
> +}
> +
> +early_param("guestmemfs", parse_guestmemfs_extents);
> +
> +void __init guestmemfs_reserve_mem(void)
> +{
> +	guestmemfs_base = memblock_phys_alloc(guestmemfs_size, 4 << 10);
> +	if (guestmemfs_base) {
> +		memblock_reserved_mark_noinit(guestmemfs_base, guestmemfs_size);
> +		memblock_mark_nomap(guestmemfs_base, guestmemfs_size);
> +	} else {
> +		pr_warn("Failed to alloc %llu bytes for guestmemfs\n", guestmemfs_size);
> +	}
> +}
> +
> +MODULE_ALIAS_FS("guestmemfs");
> +module_init(guestmemfs_init);
> diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
> new file mode 100644
> index 000000000000..37d8cf630e0a
> --- /dev/null
> +++ b/fs/guestmemfs/guestmemfs.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#define pr_fmt(fmt) "guestmemfs: " KBUILD_MODNAME ": " fmt
> +
> +#include <linux/guestmemfs.h>
> +
> +struct guestmemfs_sb {
> +    /* Will be populated soon... */
> +};
> diff --git a/include/linux/guestmemfs.h b/include/linux/guestmemfs.h
> new file mode 100644
> index 000000000000..60e769c8e533
> --- /dev/null
> +++ b/include/linux/guestmemfs.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +#ifndef _LINUX_GUESTMEMFS_H
> +#define _LINUX_GUESTMEMFS_H
> +
> +/*
> + * Carves out chunks of memory from memblocks for guestmemfs.
> + * Must be called in early boot before memblocks are freed.
> + */
> +# ifdef CONFIG_GUESTMEMFS_FS
> +void guestmemfs_reserve_mem(void);
> +#else
> +void guestmemfs_reserve_mem(void) { }
> +#endif
> +
> +#endif
> -- 
> 2.34.1
> 

