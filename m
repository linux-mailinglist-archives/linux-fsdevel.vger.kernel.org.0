Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979193335F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 07:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCJGjV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 01:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCJGjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:39:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1EC06174A;
        Tue,  9 Mar 2021 22:39:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s21so440696pfm.1;
        Tue, 09 Mar 2021 22:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSNOMI9oKfCyeZf1IReYIhbAleL143kM1K6H+TStvKA=;
        b=bS0EnS12cjBxn+d37qEsq/bv5AV7F2FblUGPmoJXC9rxgmVZamu58/BllswX0K490u
         XekCwAjuyVDdm5YmyUYJl7qJDts4xdxwZVdlMzrE5NGdZPgUEWvO+qrIwjWUeBIP13xk
         tasZyxn3lvj5SjA16njfmRUegfN2WuyxSLS4bi2nsdKgqPR05652zvlAjU5WmKQiPNek
         fn1g7qizAaHaynpPUZZr0x20D0Q2Tdr28yiL7wkLWdobLslcqSiZicpmsPHe6X8Oo8sr
         bzHahroS/12bEOh0WbcMWLYSHUrx2hZVJYh5jEAQEQ3V3oeXJ39cvIwTDAv3Ho8ZZeuR
         eHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gSNOMI9oKfCyeZf1IReYIhbAleL143kM1K6H+TStvKA=;
        b=Dcr8SJifJMVtfVXlR2zuB+nkSQ4Nx8yVSN/AqgEVppMxJ5gAwAgNXhE+RICHIrtpb6
         m/CVaT99XbgsbfIe2XzD2FgsefCmPBtKWeqaNH7Y5uibuMMrBkODuxioxPfPE8xpgyjL
         YpoTbx00IM40QcXVkMkqckTI/uc01Ln75LKvKQGmIBSHFvlDWLlPlP5KcCN40hNMXcQz
         +gPe+XzsOYJcTboQcqGA/QbVAlaPBgreKGxznR8hw6TEQcpiXB1H6mW0G43tBnZLJNsb
         W92pKFRcNi4FRu8I80lnPvvaelngmGK69KEkRv730YtLM1J9gKiekeslGovqFZSkBDhy
         /Ghw==
X-Gm-Message-State: AOAM530Ed+c5JvZrpq1HfGsPGLQuPD13hDk+WHT5STqEyuQ1qk6/KI2s
        A7djbBe1Rsujd4xY2RyCQ/Y=
X-Google-Smtp-Source: ABdhPJzDatmAVmdLX8shF2XynOLpFurMwrwCNSBEhWWtyzFrNbIB7bjf9CIa97oVlNSPdJfjvpsY5w==
X-Received: by 2002:a63:ff57:: with SMTP id s23mr1586621pgk.90.1615358348725;
        Tue, 09 Mar 2021 22:39:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
        by smtp.gmail.com with ESMTPSA id c12sm4755639pjq.48.2021.03.09.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 22:39:07 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Mar 2021 22:39:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] fs: rename alloc_anon_inode to alloc_anon_inode_sb
Message-ID: <YEhpiRCOUll6Ri6J@google.com>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:40PM +0100, Christoph Hellwig wrote:
> Rename alloc_inode to free the name for a new variant that does not
> need boilerplate to create a super_block first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/platforms/pseries/cmm.c | 2 +-
>  drivers/dma-buf/dma-buf.c            | 2 +-
>  drivers/gpu/drm/drm_drv.c            | 2 +-
>  drivers/misc/cxl/api.c               | 2 +-
>  drivers/misc/vmw_balloon.c           | 2 +-
>  drivers/scsi/cxlflash/ocxl_hw.c      | 2 +-
>  drivers/virtio/virtio_balloon.c      | 2 +-
>  fs/aio.c                             | 2 +-
>  fs/anon_inodes.c                     | 4 ++--
>  fs/libfs.c                           | 2 +-
>  include/linux/fs.h                   | 2 +-
>  kernel/resource.c                    | 2 +-
>  mm/z3fold.c                          | 2 +-
>  mm/zsmalloc.c                        | 2 +-
>  14 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 45a3a3022a85c9..6d36b858b14df1 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -580,7 +580,7 @@ static int cmm_balloon_compaction_init(void)
>  		return rc;
>  	}
>  
> -	b_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
> +	b_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
>  	if (IS_ERR(b_dev_info.inode)) {
>  		rc = PTR_ERR(b_dev_info.inode);
>  		b_dev_info.inode = NULL;
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f264b70c383eb4..dedcc9483352dc 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -445,7 +445,7 @@ static inline int is_dma_buf_file(struct file *file)
>  static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
>  {
>  	struct file *file;
> -	struct inode *inode = alloc_anon_inode(dma_buf_mnt->mnt_sb);
> +	struct inode *inode = alloc_anon_inode_sb(dma_buf_mnt->mnt_sb);
>  
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 20d22e41d7ce74..87e7214a8e3565 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -519,7 +519,7 @@ static struct inode *drm_fs_inode_new(void)
>  		return ERR_PTR(r);
>  	}
>  
> -	inode = alloc_anon_inode(drm_fs_mnt->mnt_sb);
> +	inode = alloc_anon_inode_sb(drm_fs_mnt->mnt_sb);
>  	if (IS_ERR(inode))
>  		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
>  
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index b493de962153ba..2efbf6c98028ef 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -73,7 +73,7 @@ static struct file *cxl_getfile(const char *name,
>  		goto err_module;
>  	}
>  
> -	inode = alloc_anon_inode(cxl_vfs_mount->mnt_sb);
> +	inode = alloc_anon_inode_sb(cxl_vfs_mount->mnt_sb);
>  	if (IS_ERR(inode)) {
>  		file = ERR_CAST(inode);
>  		goto err_fs;
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index b837e7eba5f7dc..5d057a05ddbee8 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1900,7 +1900,7 @@ static __init int vmballoon_compaction_init(struct vmballoon *b)
>  		return PTR_ERR(vmballoon_mnt);
>  
>  	b->b_dev_info.migratepage = vmballoon_migratepage;
> -	b->b_dev_info.inode = alloc_anon_inode(vmballoon_mnt->mnt_sb);
> +	b->b_dev_info.inode = alloc_anon_inode_sb(vmballoon_mnt->mnt_sb);
>  
>  	if (IS_ERR(b->b_dev_info.inode))
>  		return PTR_ERR(b->b_dev_info.inode);
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> index 244fc27215dc79..40184ed926b557 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -88,7 +88,7 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
>  		goto err2;
>  	}
>  
> -	inode = alloc_anon_inode(ocxlflash_vfs_mount->mnt_sb);
> +	inode = alloc_anon_inode_sb(ocxlflash_vfs_mount->mnt_sb);
>  	if (IS_ERR(inode)) {
>  		rc = PTR_ERR(inode);
>  		dev_err(dev, "%s: alloc_anon_inode failed rc=%d\n",
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8985fc2cea8615..cae76ee5bdd688 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -916,7 +916,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	}
>  
>  	vb->vb_dev_info.migratepage = virtballoon_migratepage;
> -	vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
> +	vb->vb_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
>  	if (IS_ERR(vb->vb_dev_info.inode)) {
>  		err = PTR_ERR(vb->vb_dev_info.inode);
>  		goto out_kern_unmount;
> diff --git a/fs/aio.c b/fs/aio.c
> index 1f32da13d39ee6..d1c2aa7fd6de7c 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -234,7 +234,7 @@ static const struct address_space_operations aio_ctx_aops;
>  static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
>  {
>  	struct file *file;
> -	struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
> +	struct inode *inode = alloc_anon_inode_sb(aio_mnt->mnt_sb);
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index a280156138ed89..4745fc37014332 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -63,7 +63,7 @@ static struct inode *anon_inode_make_secure_inode(
>  	const struct qstr qname = QSTR_INIT(name, strlen(name));
>  	int error;
>  
> -	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
>  	if (IS_ERR(inode))
>  		return inode;
>  	inode->i_flags &= ~S_PRIVATE;
> @@ -231,7 +231,7 @@ static int __init anon_inode_init(void)
>  	if (IS_ERR(anon_inode_mnt))
>  		panic("anon_inode_init() kernel mount failed (%ld)\n", PTR_ERR(anon_inode_mnt));
>  
> -	anon_inode_inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	anon_inode_inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
>  	if (IS_ERR(anon_inode_inode))
>  		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e2de5401abca5a..600bebc1cd847f 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1216,7 +1216,7 @@ static int anon_set_page_dirty(struct page *page)
>  	return 0;
>  };
>  
> -struct inode *alloc_anon_inode(struct super_block *s)
> +struct inode *alloc_anon_inode_sb(struct super_block *s)
>  {
>  	static const struct address_space_operations anon_aops = {
>  		.set_page_dirty = anon_set_page_dirty,

EXPORT_SYMBOL(alloc_anon_inode_sb) ?
