Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F002929BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgJSOsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgJSOsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:48:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18600C0613CE
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2020 07:48:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l24so10542176edj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2020 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=nFAqhOeRwk6xsRKTG725iKeHbR5L52DeHV/knpJzMzQ=;
        b=YSykJST50i2yVfRgYP5pUXb3oIzFiF1PaoS0tXTZk1lZnxv9WYo1Dfxjt9XnsgHSvW
         5ueVErIWDBe1Sj/kLVOoWqdciXzwJ9yTWlJ4sZTcjiCSLDGuMw7X0up64oAzPX4oieKU
         utcTG3FwUraSuyrdopaUJsd3KEDY+6VptLQg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=nFAqhOeRwk6xsRKTG725iKeHbR5L52DeHV/knpJzMzQ=;
        b=Z6fiidXMaamMIHbUrdCGw2dt/2gYI+2twIdX/CM3W/EHp64jXRUWOHxR+Aj/Pi+3ZM
         cicTSZW7gjBj/Tr6ZzHFWa9KgU8PtGfn3jiGj3ZKPn/q8GXXlaKsz2n48zKrkzcjb6mr
         jWIjGPBkXxwPhMcnBCB3x8yUNoXCw+t/WeDzfCa2zNA3T2OJ8VYvbYZXhZ2g8EX/rUZD
         thrsO6yYd3FYOMBmgZ1K5JrRk/PCtiQA+OAALxTm2VwwmRMGsidRXus6OZgGckX/403o
         zH/ocyLw4CIsUeaUXZxonvN4rq9XYgXtfCF/9ygP45hhg+vi0aoKM0hYcx93Pg92b8NI
         OwOw==
X-Gm-Message-State: AOAM530oibYym8JYKbmNVQWjkQ0qDL8+EVcjB+VEGYfahhD8ED3Flpk9
        dT9HcB8HRbc6C4ip7vIAR71/2w==
X-Google-Smtp-Source: ABdhPJwlwwIdQuoiNSTialbjFlLypOcUr0TrK8J+0234ihF0tWvIQzUAsGBJmt9dfOA+OmLrv7B0RQ==
X-Received: by 2002:a05:6402:195:: with SMTP id r21mr176679edv.164.1603118929655;
        Mon, 19 Oct 2020 07:48:49 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id c19sm11145847edt.48.2020.10.19.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:48:48 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:48:46 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.10
Message-ID: <20201019144846.GB327006@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.10

- Support directly accessing host page cache from virtiofs.  This can
  improve I/O performance for various workloads, as well as reducing the
  memory requirement by eliminating double caching.  Thanks to Vivek Goyal
  for doing most of the work on this.

- Allow automatic submounting inside virtiofs.  This allows unique st_dev/
  st_ino values to be assigned inside the guest to files residing on
  different filesystems on the host.  Thanks to Max Reitz for the patches.

- Fix an old use after free bug found by Pradeep P V K.

*Merge notes*

This tree acquired two merge conflicts against mainline:

 1) a trivial one in fs/fuse/file.c: keep HEAD and s/ff->fc/ff->fm->fc/

 2) a semantic conflict in fs/fuse/virtio_fs.c against commit a4574f63edc6
 ("mm/memremap_pages: convert to 'struct range'") and commit b7b3c01b1915
 ("mm/memremap_pages: support multiple ranges per invocation"):
   - s/pgmap->res/pgmap->range/
   - s/struct resource/struct range/
   - remove .name assignment
   - add "pgmap->nr_range = 1"

Appended my resolution at the end of this mail.

Thanks,
Miklos

---
André Almeida (1):
      fuse: update project homepage

Max Reitz (6):
      fuse: add submount support to <uapi/linux/fuse.h>
      fuse: store fuse_conn in fuse_req
      fuse: drop fuse_conn parameter where possible
      fuse: split fuse_mount off of fuse_conn
      fuse: Allow fuse_fill_super_common() for submounts
      fuse: implement crossmounts

Miklos Szeredi (2):
      fuse: fix page dereference after free
      fuse: connection remove fix

Sebastien Boeuf (3):
      virtio: Add get_shm_region method
      virtio: Implement get_shm_region for PCI transport
      virtio: Implement get_shm_region for MMIO transport

Stefan Hajnoczi (3):
      virtiofs: set up virtio_fs dax_device
      virtiofs: implement FUSE_INIT map_alignment field
      virtiofs: add DAX mmap support

Vivek Goyal (13):
      dax: Modify bdev_dax_pgoff() to handle NULL bdev
      dax: Create a range version of dax_layout_busy_page()
      virtiofs: provide a helper function for virtqueue initialization
      virtiofs: get rid of no_mount_options
      virtiofs: add a mount option to enable dax
      virtiofs: keep a list of free dax memory ranges
      virtiofs: introduce setupmapping/removemapping commands
      virtiofs: implement dax read/write operations
      virtiofs: define dax address space operations
      virtiofs: serialize truncate/punch_hole and dax fault path
      virtiofs: maintain a list of busy elements
      virtiofs: add logic to free up a memory range
      virtiofs: calculate number of scatter-gather elements accurately

---
 Documentation/filesystems/fuse.rst |    2 +-
 MAINTAINERS                        |    2 +-
 drivers/dax/super.c                |    3 +-
 drivers/virtio/virtio_mmio.c       |   31 +
 drivers/virtio/virtio_pci_modern.c |   95 +++
 fs/dax.c                           |   29 +-
 fs/fuse/Kconfig                    |   16 +-
 fs/fuse/Makefile                   |    6 +-
 fs/fuse/control.c                  |   20 +-
 fs/fuse/cuse.c                     |   21 +-
 fs/fuse/dax.c                      | 1365 ++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c                      |  189 ++---
 fs/fuse/dir.c                      |  220 ++++--
 fs/fuse/file.c                     |  256 ++++---
 fs/fuse/fuse_i.h                   |  185 ++++-
 fs/fuse/inode.c                    |  391 ++++++++---
 fs/fuse/readdir.c                  |   10 +-
 fs/fuse/virtio_fs.c                |  378 ++++++++--
 fs/fuse/xattr.c                    |   34 +-
 include/linux/dax.h                |    6 +
 include/linux/virtio_config.h      |   17 +
 include/uapi/linux/fuse.h          |   50 +-
 include/uapi/linux/virtio_fs.h     |    3 +
 include/uapi/linux/virtio_mmio.h   |   11 +
 include/uapi/linux/virtio_pci.h    |   11 +-
 25 files changed, 2854 insertions(+), 497 deletions(-)
 create mode 100644 fs/fuse/dax.c
---
diff --cc fs/fuse/file.c
index 43c165e796da,53d4dd1ab992..c03034e8c152
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@@ -3120,17 -3156,10 +3146,17 @@@ fuse_direct_IO(struct kiocb *iocb, stru
  	 * By default, we want to optimize all I/Os with async request
  	 * submission to the client filesystem if supported.
  	 */
- 	io->async = ff->fc->async_dio;
 -	io->async = async_dio;
++	io->async = ff->fm->fc->async_dio;
  	io->iocb = iocb;
  	io->blocking = is_sync_kiocb(iocb);
  
 +	/* optimization for short read */
 +	if (io->async && !io->write && offset + count > i_size) {
- 		iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
++		iov_iter_truncate(iter, fuse_round_up(ff->fm->fc, i_size - offset));
 +		shortened = count - iov_iter_count(iter);
 +		count -= shortened;
 +	}
 +
  	/*
  	 * We cannot asynchronously extend the size of a file.
  	 * In such case the aio will behave exactly like sync io.
diff --cc fs/fuse/virtio_fs.c
index 104f35de5270,f9c1aa1d289c..21a9e534417c
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@@ -676,6 -733,130 +733,130 @@@ static void virtio_fs_cleanup_vqs(struc
  	vdev->config->del_vqs(vdev);
  }
  
+ /* Map a window offset to a page frame number.  The window offset will have
+  * been produced by .iomap_begin(), which maps a file offset to a window
+  * offset.
+  */
+ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+ 				    long nr_pages, void **kaddr, pfn_t *pfn)
+ {
+ 	struct virtio_fs *fs = dax_get_private(dax_dev);
+ 	phys_addr_t offset = PFN_PHYS(pgoff);
+ 	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
+ 
+ 	if (kaddr)
+ 		*kaddr = fs->window_kaddr + offset;
+ 	if (pfn)
+ 		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
+ 					PFN_DEV | PFN_MAP);
+ 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
+ }
+ 
+ static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
+ 				       pgoff_t pgoff, void *addr,
+ 				       size_t bytes, struct iov_iter *i)
+ {
+ 	return copy_from_iter(addr, bytes, i);
+ }
+ 
+ static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
+ 				       pgoff_t pgoff, void *addr,
+ 				       size_t bytes, struct iov_iter *i)
+ {
+ 	return copy_to_iter(addr, bytes, i);
+ }
+ 
+ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
+ 				     pgoff_t pgoff, size_t nr_pages)
+ {
+ 	long rc;
+ 	void *kaddr;
+ 
+ 	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
+ 	if (rc < 0)
+ 		return rc;
+ 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
+ 	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
+ 	return 0;
+ }
+ 
+ static const struct dax_operations virtio_fs_dax_ops = {
+ 	.direct_access = virtio_fs_direct_access,
+ 	.copy_from_iter = virtio_fs_copy_from_iter,
+ 	.copy_to_iter = virtio_fs_copy_to_iter,
+ 	.zero_page_range = virtio_fs_zero_page_range,
+ };
+ 
+ static void virtio_fs_cleanup_dax(void *data)
+ {
+ 	struct dax_device *dax_dev = data;
+ 
+ 	kill_dax(dax_dev);
+ 	put_dax(dax_dev);
+ }
+ 
+ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
+ {
+ 	struct virtio_shm_region cache_reg;
+ 	struct dev_pagemap *pgmap;
+ 	bool have_cache;
+ 
+ 	if (!IS_ENABLED(CONFIG_FUSE_DAX))
+ 		return 0;
+ 
+ 	/* Get cache region */
+ 	have_cache = virtio_get_shm_region(vdev, &cache_reg,
+ 					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
+ 	if (!have_cache) {
+ 		dev_notice(&vdev->dev, "%s: No cache capability\n", __func__);
+ 		return 0;
+ 	}
+ 
+ 	if (!devm_request_mem_region(&vdev->dev, cache_reg.addr, cache_reg.len,
+ 				     dev_name(&vdev->dev))) {
+ 		dev_warn(&vdev->dev, "could not reserve region addr=0x%llx len=0x%llx\n",
+ 			 cache_reg.addr, cache_reg.len);
+ 		return -EBUSY;
+ 	}
+ 
+ 	dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n", cache_reg.len,
+ 		   cache_reg.addr);
+ 
+ 	pgmap = devm_kzalloc(&vdev->dev, sizeof(*pgmap), GFP_KERNEL);
+ 	if (!pgmap)
+ 		return -ENOMEM;
+ 
+ 	pgmap->type = MEMORY_DEVICE_FS_DAX;
+ 
+ 	/* Ideally we would directly use the PCI BAR resource but
+ 	 * devm_memremap_pages() wants its own copy in pgmap.  So
+ 	 * initialize a struct resource from scratch (only the start
+ 	 * and end fields will be used).
+ 	 */
 -	pgmap->res = (struct resource){
 -		.name = "virtio-fs dax window",
++	pgmap->range = (struct range) {
+ 		.start = (phys_addr_t) cache_reg.addr,
+ 		.end = (phys_addr_t) cache_reg.addr + cache_reg.len - 1,
+ 	};
++	pgmap->nr_range = 1;
+ 
+ 	fs->window_kaddr = devm_memremap_pages(&vdev->dev, pgmap);
+ 	if (IS_ERR(fs->window_kaddr))
+ 		return PTR_ERR(fs->window_kaddr);
+ 
+ 	fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
+ 	fs->window_len = (phys_addr_t) cache_reg.len;
+ 
+ 	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
+ 		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
+ 
+ 	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops, 0);
+ 	if (IS_ERR(fs->dax_dev))
+ 		return PTR_ERR(fs->dax_dev);
+ 
+ 	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
+ 					fs->dax_dev);
+ }
+ 
  static int virtio_fs_probe(struct virtio_device *vdev)
  {
  	struct virtio_fs *fs;
