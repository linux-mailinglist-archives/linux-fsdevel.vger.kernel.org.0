Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E95625A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 23:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiF3VxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 17:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiF3VxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:53:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CADBC2;
        Thu, 30 Jun 2022 14:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1272B82D5A;
        Thu, 30 Jun 2022 21:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787E6C341C7;
        Thu, 30 Jun 2022 21:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656625988;
        bh=uoe9vKPdWWNIKhbghTYdMNYXLmY0zPocgOT1n2zEgEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8O/ZM3ORAmX4a8KW0HSuPCUBX3MaSZiwJO06hBorRoSSkBTBb747mhpgi8hwwXsl
         5cWUSMuU2jOTo/xKaMVX3Yfz4XDL6y2viPQnIyJYt8sKTTFw+a0rxY6qaVNUZAee2y
         6Jw4Zjt9rgBT68Jq08vyz1uxolFARxijQoCeg1CfoLXixgH+G7nYRLPeZ0UjwhEf+D
         aSwEA0l1mwn0tABz0CFMwAnCn//Ext4+GlPSgmn4OZPct83H3WZxo1B/jQU6kb7VUT
         NeeKfAzWfKz7+ULEN9gw0Kl3DDrm5bVOfdNUItqujNqoyLGe1pqRTX5qm7WuFcuW91
         1bnVr2fmwYvSQ==
Date:   Thu, 30 Jun 2022 14:53:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v2 1/9] mm: Add msharefs filesystem
Message-ID: <Yr4bREHJQV0oISSo@magnolia>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <de5566e71e038d95342d00364c6760c7078cb091.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5566e71e038d95342d00364c6760c7078cb091.1656531090.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:52PM -0600, Khalid Aziz wrote:
> Add a ram-based filesystem that contains page table sharing
> information and files that enables processes to share page tables.
> This patch adds the basic filesystem that can be mounted.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  Documentation/filesystems/msharefs.rst |  19 +++++
>  include/uapi/linux/magic.h             |   1 +
>  mm/Makefile                            |   2 +-
>  mm/mshare.c                            | 103 +++++++++++++++++++++++++
>  4 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/filesystems/msharefs.rst
>  create mode 100644 mm/mshare.c
> 
> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
> new file mode 100644
> index 000000000000..fd161f67045d
> --- /dev/null
> +++ b/Documentation/filesystems/msharefs.rst
> @@ -0,0 +1,19 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================================
> +msharefs - a filesystem to support shared page tables
> +=====================================================
> +
> +msharefs is a ram-based filesystem that allows multiple processes to
> +share page table entries for shared pages.
> +
> +msharefs is typically mounted like this::
> +
> +	mount -t msharefs none /sys/fs/mshare
> +
> +When a process calls mshare syscall with a name for the shared address
> +range,

You mean creat()?

> a file with the same name is created under msharefs with that
> +name. This file can be opened by another process, if permissions
> +allow, to query the addresses shared under this range. These files are
> +removed by mshare_unlink syscall and can not be deleted directly.

Oh?

> +Hence these files are created as immutable files.
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index f724129c0425..2a57a6ec6f3e 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -105,5 +105,6 @@
>  #define Z3FOLD_MAGIC		0x33
>  #define PPC_CMM_MAGIC		0xc7571590
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> +#define MSHARE_MAGIC		0x4d534852	/* "MSHR" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/mm/Makefile b/mm/Makefile
> index 6f9ffa968a1a..51a2ab9080d9 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -37,7 +37,7 @@ CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
>  CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
>  
>  mmu-y			:= nommu.o
> -mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
> +mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o mshare.o \
>  			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
>  			   msync.o page_vma_mapped.o pagewalk.o \
>  			   pgtable-generic.o rmap.o vmalloc.o
> diff --git a/mm/mshare.c b/mm/mshare.c
> new file mode 100644
> index 000000000000..c8fab3869bab
> --- /dev/null
> +++ b/mm/mshare.c

Filesystems are usually supposed to live under fs/; is there some reason
to put it in mm/?

I guess shmfs is in mm so maybe this isn't much of an objection.

Also, should this fs be selectable via a Kconfig option?

--D

> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Enable copperating processes to share page table between
> + * them to reduce the extra memory consumed by multiple copies
> + * of page tables.
> + *
> + * This code adds an in-memory filesystem - msharefs.
> + * msharefs is used to manage page table sharing
> + *
> + *
> + * Copyright (C) 2022 Oracle Corp. All rights reserved.
> + * Author:	Khalid Aziz <khalid.aziz@oracle.com>
> + *
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/syscalls.h>
> +#include <linux/uaccess.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/fileattr.h>
> +#include <uapi/linux/magic.h>
> +#include <uapi/linux/limits.h>
> +
> +static struct super_block *msharefs_sb;
> +
> +static const struct file_operations msharefs_file_operations = {
> +	.open	= simple_open,
> +	.llseek	= no_llseek,
> +};
> +
> +static int
> +msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
> +{
> +	unsigned long hash = init_name_hash(dentry);
> +	const unsigned char *s = qstr->name;
> +	unsigned int len = qstr->len;
> +
> +	while (len--)
> +		hash = partial_name_hash(*s++, hash);
> +	qstr->hash = end_name_hash(hash);
> +	return 0;
> +}
> +
> +static const struct dentry_operations msharefs_d_ops = {
> +	.d_hash = msharefs_d_hash,
> +};
> +
> +static int
> +msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	static const struct tree_descr empty_descr = {""};
> +	int err;
> +
> +	sb->s_d_op = &msharefs_d_ops;
> +	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
> +	if (err)
> +		return err;
> +
> +	msharefs_sb = sb;
> +	return 0;
> +}
> +
> +static int
> +msharefs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_single(fc, msharefs_fill_super);
> +}
> +
> +static const struct fs_context_operations msharefs_context_ops = {
> +	.get_tree	= msharefs_get_tree,
> +};
> +
> +static int
> +mshare_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &msharefs_context_ops;
> +	return 0;
> +}
> +
> +static struct file_system_type mshare_fs = {
> +	.name			= "msharefs",
> +	.init_fs_context	= mshare_init_fs_context,
> +	.kill_sb		= kill_litter_super,
> +};
> +
> +static int
> +mshare_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = sysfs_create_mount_point(fs_kobj, "mshare");
> +	if (ret)
> +		return ret;
> +
> +	ret = register_filesystem(&mshare_fs);
> +	if (ret)
> +		sysfs_remove_mount_point(fs_kobj, "mshare");
> +
> +	return ret;
> +}
> +
> +fs_initcall(mshare_init);
> -- 
> 2.32.0
> 
