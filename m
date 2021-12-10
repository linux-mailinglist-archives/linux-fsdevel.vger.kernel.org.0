Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA03470269
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 15:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhLJOJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 09:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235766AbhLJOJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639145135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IPYd/U/Ts1tZJpb5JWXIO6VaK+NnfSEAcLoJXiiX6k=;
        b=FVZhbPJhHfpurZSWNWaSGKtgnHapmzVFS/pAtqNGkxF8gswnkom/yZHMy1L7jI4BRBPpJF
        AamAOsBnJP//SBVeDZz3cDLN+jGAGAXEVypVwwXreQMgmyyL1I5KC0sayV6qTlpaG1O1xU
        lWrUImrdPO35ZS/+qRXHVQ3NzKZdIsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-AXVHfjlYNN-rOCr5ug7-OA-1; Fri, 10 Dec 2021 09:05:32 -0500
X-MC-Unique: AXVHfjlYNN-rOCr5ug7-OA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA031017965;
        Fri, 10 Dec 2021 14:05:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C13919C59;
        Fri, 10 Dec 2021 14:05:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AC32F2209DD; Fri, 10 Dec 2021 09:05:01 -0500 (EST)
Date:   Fri, 10 Dec 2021 09:05:01 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
Message-ID: <YbNejVRF5NQB0r83@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209063828.18944-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 07:38:28AM +0100, Christoph Hellwig wrote:
> While using the MC-safe copy routines is rather pointless on a virtual device
> like virtiofs,

I was wondering about that. Is it completely pointless.

Typically we are just mapping host page cache into qemu address space.
That shows as virtiofs device pfn in guest and that pfn is mapped into
guest application address space in mmap() call.

Given on host its DRAM, so I would not expect machine check on load side
so there was no need to use machine check safe variant. But what if host
filesystem is on persistent memory and using DAX. In that case load in
guest can trigger a machine check. Not sure if that machine check will
actually travel into the guest and unblock read() operation or not.

But this sounds like a good change from virtiofs point of view, anyway.

Thanks
Vivek


> it also isn't harmful at all.  So just use _copy_mc_to_iter
> unconditionally to simplify the code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 10 ----------
>  fs/fuse/virtio_fs.c |  1 -
>  include/linux/dax.h |  1 -
>  3 files changed, 12 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index ff676a07480c8..fe783234ca669 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -107,8 +107,6 @@ enum dax_device_flags {
>  	DAXDEV_SYNC,
>  	/* do not use uncached operations to write data */
>  	DAXDEV_CACHED,
> -	/* do not use mcsafe operations to read data */
> -	DAXDEV_NOMCSAFE,
>  };
>  
>  /**
> @@ -171,8 +169,6 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  	 * via access_ok() in vfs_red, so use the 'no check' version to bypass
>  	 * the HARDENED_USERCOPY overhead.
>  	 */
> -	if (test_bit(DAXDEV_NOMCSAFE, &dax_dev->flags))
> -		return _copy_to_iter(addr, bytes, i);
>  	return _copy_mc_to_iter(addr, bytes, i);
>  }
>  
> @@ -242,12 +238,6 @@ void set_dax_cached(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(set_dax_cached);
>  
> -void set_dax_nomcsafe(struct dax_device *dax_dev)
> -{
> -	set_bit(DAXDEV_NOMCSAFE, &dax_dev->flags);
> -}
> -EXPORT_SYMBOL_GPL(set_dax_nomcsafe);
> -
>  bool dax_alive(struct dax_device *dax_dev)
>  {
>  	lockdep_assert_held(&dax_srcu);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 754319ce2a29b..d9c20b148ac19 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -838,7 +838,6 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	if (IS_ERR(fs->dax_dev))
>  		return PTR_ERR(fs->dax_dev);
>  	set_dax_cached(fs->dax_dev);
> -	set_dax_nomcsafe(fs->dax_dev);
>  	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
>  					fs->dax_dev);
>  }
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index d22cbf03d37d2..d267331bc37e7 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -90,7 +90,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  #endif
>  
>  void set_dax_cached(struct dax_device *dax_dev);
> -void set_dax_nomcsafe(struct dax_device *dax_dev);
>  
>  struct writeback_control;
>  #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
> -- 
> 2.30.2
> 

