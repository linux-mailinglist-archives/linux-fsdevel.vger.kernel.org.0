Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD22528454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiEPMkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbiEPMkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 08:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3947E387A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652704836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lz8qwUcipaME+DgyD88J/N41w/1RlERkl1tUxRrxCw8=;
        b=VhVZz8s1e6DI76g6Ao9VcXlzmHFjRKOfokwgOQ3EhffwG9XzUoq9dQTIVE8JrzT/oCvXdk
        ksMpKAAzJY4wJWGuYT+Fy5N23su8sMmBXa8kS23Ydym+eFlyJoujtLDXfosvThZHOWO3/r
        zwSJo0Tf+2U3/ruX47J90DDAnqELnXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-7lMfe7KgOmGpHCwIcdMUcg-1; Mon, 16 May 2022 08:40:33 -0400
X-MC-Unique: 7lMfe7KgOmGpHCwIcdMUcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B53C880CDA6;
        Mon, 16 May 2022 12:40:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7099E7C2A;
        Mon, 16 May 2022 12:40:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 28BC02208FA; Mon, 16 May 2022 08:40:09 -0400 (EDT)
Date:   Mon, 16 May 2022 08:40:09 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v10 4/7] dax: introduce DAX_RECOVERY_WRITE dax access mode
Message-ID: <YoJGKRyzwT66726N@redhat.com>
References: <20220422224508.440670-5-jane.chu@oracle.com>
 <165247892149.4131000.9240706498758561525.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165247892149.4131000.9240706498758561525.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 02:55:59PM -0700, Dan Williams wrote:
> From: Jane Chu <jane.chu@oracle.com>
> 
> Up till now, dax_direct_access() is used implicitly for normal
> access, but for the purpose of recovery write, dax range with
> poison is requested.  To make the interface clear, introduce
> 	enum dax_access_mode {
> 		DAX_ACCESS,
> 		DAX_RECOVERY_WRITE,
> 	}
> where DAX_ACCESS is used for normal dax access, and
> DAX_RECOVERY_WRITE is used for dax recovery write.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v9:
> - fix a 0-day robot reported missed conversion of virtio_fs to the new
>   calling convention.
> 
>  drivers/dax/super.c             |    5 +++--
>  drivers/md/dm-linear.c          |    5 +++--
>  drivers/md/dm-log-writes.c      |    5 +++--
>  drivers/md/dm-stripe.c          |    5 +++--
>  drivers/md/dm-target.c          |    4 +++-
>  drivers/md/dm-writecache.c      |    7 ++++---
>  drivers/md/dm.c                 |    5 +++--
>  drivers/nvdimm/pmem.c           |    8 +++++---
>  drivers/nvdimm/pmem.h           |    5 ++++-
>  drivers/s390/block/dcssblk.c    |    9 ++++++---
>  fs/dax.c                        |    9 +++++----
>  fs/fuse/dax.c                   |    4 ++--
>  fs/fuse/virtio_fs.c             |    6 ++++--

Looks fine to me from virtio_fs.c perspective. Simple change.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

>  include/linux/dax.h             |    9 +++++++--
>  include/linux/device-mapper.h   |    4 +++-
>  tools/testing/nvdimm/pmem-dax.c |    3 ++-
>  16 files changed, 60 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0211e6f7b47a..5405eb553430 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -117,6 +117,7 @@ enum dax_device_flags {
>   * @dax_dev: a dax_device instance representing the logical memory range
>   * @pgoff: offset in pages from the start of the device to translate
>   * @nr_pages: number of consecutive pages caller can handle relative to @pfn
> + * @mode: indicator on normal access or recovery write
>   * @kaddr: output parameter that returns a virtual address mapping of pfn
>   * @pfn: output parameter that returns an absolute pfn translation of @pgoff
>   *
> @@ -124,7 +125,7 @@ enum dax_device_flags {
>   * pages accessible at the device relative @pgoff.
>   */
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> -		void **kaddr, pfn_t *pfn)
> +		enum dax_access_mode mode, void **kaddr, pfn_t *pfn)
>  {
>  	long avail;
>  
> @@ -138,7 +139,7 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
>  		return -EINVAL;
>  
>  	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages,
> -			kaddr, pfn);
> +			mode, kaddr, pfn);
>  	if (!avail)
>  		return -ERANGE;
>  	return min(avail, nr_pages);
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 76b486e4d2be..13e263299c9c 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -172,11 +172,12 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
>  }
>  
>  static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
>  
> -	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
> +	return dax_direct_access(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);
>  }
>  
>  static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index c9d036d6bb2e..06bdbed65eb1 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -889,11 +889,12 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
>  }
>  
>  static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -					 long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
>  
> -	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
> +	return dax_direct_access(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);
>  }
>  
>  static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index c81d331d1afe..77d72900e997 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -315,11 +315,12 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
>  }
>  
>  static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>  
> -	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
> +	return dax_direct_access(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);
>  }
>  
>  static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
> index 64dd0b34fcf4..8cd5184e62f0 100644
> --- a/drivers/md/dm-target.c
> +++ b/drivers/md/dm-target.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/kmod.h>
>  #include <linux/bio.h>
> +#include <linux/dax.h>
>  
>  #define DM_MSG_PREFIX "target"
>  
> @@ -142,7 +143,8 @@ static void io_err_release_clone_rq(struct request *clone,
>  }
>  
>  static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	return -EIO;
>  }
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 5630b470ba42..d74c5a7a0ab4 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -286,7 +286,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>  
>  	id = dax_read_lock();
>  
> -	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
> +	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, DAX_ACCESS,
> +			&wc->memory_map, &pfn);
>  	if (da < 0) {
>  		wc->memory_map = NULL;
>  		r = da;
> @@ -308,8 +309,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>  		i = 0;
>  		do {
>  			long daa;
> -			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i, p - i,
> -						NULL, &pfn);
> +			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i,
> +					p - i, DAX_ACCESS, NULL, &pfn);
>  			if (daa <= 0) {
>  				r = daa ? daa : -EINVAL;
>  				goto err3;
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 82957bd460e8..9c452641c3d5 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1093,7 +1093,8 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
>  }
>  
>  static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> -				 long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	struct mapped_device *md = dax_get_private(dax_dev);
>  	sector_t sector = pgoff * PAGE_SECTORS;
> @@ -1111,7 +1112,7 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>  	if (len < 1)
>  		goto out;
>  	nr_pages = min(len, nr_pages);
> -	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
> +	ret = ti->type->direct_access(ti, pgoff, nr_pages, mode, kaddr, pfn);
>  
>   out:
>  	dm_put_live_table(md, srcu_idx);
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4aa17132a557..47f34c50f944 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -239,7 +239,8 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>  
>  /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
>  __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
>  
> @@ -278,11 +279,12 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  }
>  
>  static long pmem_dax_direct_access(struct dax_device *dax_dev,
> -		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
> +		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
> +		void **kaddr, pfn_t *pfn)
>  {
>  	struct pmem_device *pmem = dax_get_private(dax_dev);
>  
> -	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
> +	return __pmem_direct_access(pmem, pgoff, nr_pages, mode, kaddr, pfn);
>  }
>  
>  static const struct dax_operations pmem_dax_ops = {
> diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
> index 1f51a2361429..392b0b38acb9 100644
> --- a/drivers/nvdimm/pmem.h
> +++ b/drivers/nvdimm/pmem.h
> @@ -8,6 +8,8 @@
>  #include <linux/pfn_t.h>
>  #include <linux/fs.h>
>  
> +enum dax_access_mode;
> +
>  /* this definition is in it's own header for tools/testing/nvdimm to consume */
>  struct pmem_device {
>  	/* One contiguous memory region per device */
> @@ -28,7 +30,8 @@ struct pmem_device {
>  };
>  
>  long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn);
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn);
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  static inline bool test_and_clear_pmem_poison(struct page *page)
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index d614843caf6c..8d0d0eaa3059 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -32,7 +32,8 @@ static int dcssblk_open(struct block_device *bdev, fmode_t mode);
>  static void dcssblk_release(struct gendisk *disk, fmode_t mode);
>  static void dcssblk_submit_bio(struct bio *bio);
>  static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn);
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn);
>  
>  static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
>  
> @@ -50,7 +51,8 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
>  	long rc;
>  	void *kaddr;
>  
> -	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
> +	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS,
> +			&kaddr, NULL);
>  	if (rc < 0)
>  		return rc;
>  	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
> @@ -927,7 +929,8 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
>  
>  static long
>  dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
>  
> diff --git a/fs/dax.c b/fs/dax.c
> index 67a08a32fccb..ef3103107104 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -721,7 +721,8 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
>  	int id;
>  
>  	id = dax_read_lock();
> -	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
> +	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, DAX_ACCESS,
> +				&kaddr, NULL);
>  	if (rc < 0) {
>  		dax_read_unlock(id);
>  		return rc;
> @@ -1013,7 +1014,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>  
>  	id = dax_read_lock();
>  	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> -				   NULL, pfnp);
> +				   DAX_ACCESS, NULL, pfnp);
>  	if (length < 0) {
>  		rc = length;
>  		goto out;
> @@ -1122,7 +1123,7 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
>  	void *kaddr;
>  	long ret;
>  
> -	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> +	ret = dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);
>  	if (ret > 0) {
>  		memset(kaddr + offset, 0, size);
>  		dax_flush(dax_dev, kaddr + offset, size);
> @@ -1247,7 +1248,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		}
>  
>  		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
> -				&kaddr, NULL);
> +				DAX_ACCESS, &kaddr, NULL);
>  		if (map_len < 0) {
>  			ret = map_len;
>  			break;
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index d7d3a7f06862..10eb50cbf398 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1241,8 +1241,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
>  	INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
>  
>  	id = dax_read_lock();
> -	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
> -				     NULL);
> +	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size),
> +			DAX_ACCESS, NULL, NULL);
>  	dax_read_unlock(id);
>  	if (nr_pages < 0) {
>  		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 86b7dbb6a0d4..8db53fa67359 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -752,7 +752,8 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
>   * offset.
>   */
>  static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> -				    long nr_pages, void **kaddr, pfn_t *pfn)
> +				    long nr_pages, enum dax_access_mode mode,
> +				    void **kaddr, pfn_t *pfn)
>  {
>  	struct virtio_fs *fs = dax_get_private(dax_dev);
>  	phys_addr_t offset = PFN_PHYS(pgoff);
> @@ -772,7 +773,8 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
>  	long rc;
>  	void *kaddr;
>  
> -	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
> +	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS, &kaddr,
> +			       NULL);
>  	if (rc < 0)
>  		return rc;
>  	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 9fc5f99a0ae2..3f1339bce3c0 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -14,6 +14,11 @@ struct iomap_ops;
>  struct iomap_iter;
>  struct iomap;
>  
> +enum dax_access_mode {
> +	DAX_ACCESS,
> +	DAX_RECOVERY_WRITE,
> +};
> +
>  struct dax_operations {
>  	/*
>  	 * direct_access: translate a device-relative
> @@ -21,7 +26,7 @@ struct dax_operations {
>  	 * number of pages available for DAX at that pfn.
>  	 */
>  	long (*direct_access)(struct dax_device *, pgoff_t, long,
> -			void **, pfn_t *);
> +			enum dax_access_mode, void **, pfn_t *);
>  	/*
>  	 * Validate whether this device is usable as an fsdax backing
>  	 * device.
> @@ -178,7 +183,7 @@ static inline void dax_read_unlock(int id)
>  bool dax_alive(struct dax_device *dax_dev);
>  void *dax_get_private(struct dax_device *dax_dev);
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> -		void **kaddr, pfn_t *pfn);
> +		enum dax_access_mode mode, void **kaddr, pfn_t *pfn);
>  size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  		size_t bytes, struct iov_iter *i);
>  size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index c2a3758c4aaa..acdedda0d12b 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -20,6 +20,7 @@ struct dm_table;
>  struct dm_report_zones_args;
>  struct mapped_device;
>  struct bio_vec;
> +enum dax_access_mode;
>  
>  /*
>   * Type of table, mapped_device's mempool and request_queue
> @@ -146,7 +147,8 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
>   * >= 0 : the number of bytes accessible at the address
>   */
>  typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn);
> +		long nr_pages, enum dax_access_mode node, void **kaddr,
> +		pfn_t *pfn);
>  typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
>  		size_t nr_pages);
>  
> diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
> index af19c85558e7..dcc328eba811 100644
> --- a/tools/testing/nvdimm/pmem-dax.c
> +++ b/tools/testing/nvdimm/pmem-dax.c
> @@ -8,7 +8,8 @@
>  #include <nd.h>
>  
>  long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, enum dax_access_mode mode, void **kaddr,
> +		pfn_t *pfn)
>  {
>  	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
>  
> 

