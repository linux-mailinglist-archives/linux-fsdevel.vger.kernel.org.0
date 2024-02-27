Return-Path: <linux-fsdevel+bounces-12954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831518692D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8331F2D7DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988113DB9B;
	Tue, 27 Feb 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5R5q6N5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DED913B2B8;
	Tue, 27 Feb 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041156; cv=none; b=WPw+KVQP2JPBi1lVErDw4ncAvWfA3jjJLFpSpvrQP/JgJ4AHI0dz1Cre6s5HWG9oxifxfVYI7dxyS0quZtck+8g9bf30yWnSSH5K2O8gkQkdIGJ/9WWEbfJ5BgBREvaYcVsYSqBFt+cNSb0M7hyclS6Obf+W1n7LL57U5FNJWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041156; c=relaxed/simple;
	bh=3G2IKCcYmdE7HxKy3Q0/nm/Ij6/cDDwW4C+TD4+vILk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2yYn+U7QoOlla7NSShqXlr6hha1f94IE/CQGpZcaocFDhN1zcangYT+GktAZ8LjhULtYDcVTzX1iWrkD3jH/x/oa06aKYJ3vu4HtyIAicCZnxM2ll/xn8GLY28RkLhJ3rohkyzVHyvklRxulwV71qpPIEZRzKSzYKd0GCrVzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5R5q6N5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A450C433C7;
	Tue, 27 Feb 2024 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041155;
	bh=3G2IKCcYmdE7HxKy3Q0/nm/Ij6/cDDwW4C+TD4+vILk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5R5q6N5zuG7piLstwEVJyUR9gnTMpDloVlEu6O4G69l6s4NxIcyDu3gKl4ibN6Wg
	 NVjwC7fuR0NZmDAD9sqoO3OX0CY+GiDXzWPGw4/yS50XA793/4Dnw+8fc64D/KMol4
	 4E7p7cIvJcPfWMAQEKro1cwhk3SUhiz89HyHtaanudfBLZlL+df/J3p1laip0OKi5G
	 bZAbsTSEBujGdeT6/lVElPvxNMXDsx9jgvbctg+4PY+nIY2tHbBUHGwqduiONEjApd
	 XtMaCyGBUtmy6p9k3yRralTQVe6VL6Zj7RUAVLl1AhaOOHlLqQ+Pvt6To9NpgmveFV
	 YvSMFs8m789Ww==
From: Christian Brauner <brauner@kernel.org>
To: John Groves <John@groves.net>
Cc: Christian Brauner <brauner@kernel.org>,
	John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com
Subject: Re: [RFC PATCH 08/20] famfs: Add famfs_internal.h
Date: Tue, 27 Feb 2024 14:38:58 +0100
Message-ID: <20240227-kiesgrube-couch-77ee2f6917c7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538; i=brauner@kernel.org; h=from:subject:message-id; bh=3G2IKCcYmdE7HxKy3Q0/nm/Ij6/cDDwW4C+TD4+vILk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTeffoz6FTZHdtipfmL8/7MdlK7nq+/wfbljfIYhyeGD 56HdqwX6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIZ21GhgczV0x5kLG81Jyl d9K32Npe7WOzhNuPnPL7G8dx/e21/38Y/pmK97xQcpnR2/aqS750iW4a3/8Gg46NRRkcP+4c+hd zjhkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, Feb 23, 2024 at 11:41:52AM -0600, John Groves wrote:
> Add the famfs_internal.h include file. This contains internal data
> structures such as the per-file metadata structure (famfs_file_meta)
> and extent formats.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/famfs/famfs_internal.h | 53 +++++++++++++++++++++++++++++++++++++++

Already mentioned in another reply here but adding a bunch of types such
as famfs_file_operations that aren't even defines is pretty odd. So you
should reorder this.

>  1 file changed, 53 insertions(+)
>  create mode 100644 fs/famfs/famfs_internal.h
> 
> diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
> new file mode 100644
> index 000000000000..af3990d43305
> --- /dev/null
> +++ b/fs/famfs/famfs_internal.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2024 Micron Technology, Inc.
> + *
> + * This file system, originally based on ramfs the dax support from xfs,
> + * is intended to allow multiple host systems to mount a common file system
> + * view of dax files that map to shared memory.
> + */
> +#ifndef FAMFS_INTERNAL_H
> +#define FAMFS_INTERNAL_H
> +
> +#include <linux/atomic.h>
> +#include <linux/famfs_ioctl.h>
> +
> +#define FAMFS_MAGIC 0x87b282ff

That needs to go into include/uapi/linux/magic.h.

> +
> +#define FAMFS_BLKDEV_MODE (FMODE_READ|FMODE_WRITE)
> +
> +extern const struct file_operations      famfs_file_operations;
> +
> +/*
> + * Each famfs dax file has this hanging from its inode->i_private.
> + */
> +struct famfs_file_meta {
> +	int                   error;
> +	enum famfs_file_type  file_type;
> +	size_t                file_size;
> +	enum extent_type      tfs_extent_type;
> +	size_t                tfs_extent_ct;
> +	struct famfs_extent   tfs_extents[];  /* flexible array */
> +};
> +
> +struct famfs_mount_opts {
> +	umode_t mode;
> +};
> +
> +extern const struct iomap_ops             famfs_iomap_ops;
> +extern const struct vm_operations_struct  famfs_file_vm_ops;
> +
> +#define ROOTDEV_STRLEN 80
> +
> +struct famfs_fs_info {
> +	struct famfs_mount_opts  mount_opts;
> +	struct file             *dax_filp;
> +	struct dax_device       *dax_devp;
> +	struct bdev_handle      *bdev_handle;
> +	struct list_head         fsi_list;
> +	char                    *rootdev;
> +};
> +
> +#endif /* FAMFS_INTERNAL_H */
> -- 
> 2.43.0
> 

