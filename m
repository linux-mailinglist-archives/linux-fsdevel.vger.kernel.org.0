Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335924B67C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiBOJiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 04:38:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiBOJiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:38:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A5C3C34
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 01:38:02 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JybW908V2z1FD9M;
        Tue, 15 Feb 2022 17:33:41 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 17:38:01 +0800
Subject: Re: [PATCH 10/10] fs: Move many prototypes to pagemap.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-11-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b67fadfa-78f2-fc6e-c9a2-f6f713b3028d@huawei.com>
Date:   Tue, 15 Feb 2022 17:38:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-11-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/2/15 4:00, Matthew Wilcox (Oracle) wrote:
> These functions are page cache functionality and don't need to be
> declared in fs.h.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  drivers/block/xen-blkback/xenbus.c           |   1 +
>  drivers/usb/gadget/function/f_mass_storage.c |   1 +
>  fs/coda/file.c                               |   1 +
>  fs/iomap/fiemap.c                            |   1 +
>  fs/nfsd/filecache.c                          |   1 +
>  fs/nfsd/vfs.c                                |   1 +
>  fs/vboxsf/utils.c                            |   1 +
>  include/linux/fs.h                           | 116 -------------------
>  include/linux/pagemap.h                      | 114 ++++++++++++++++++
>  9 files changed, 121 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index 62125fd4af4a..f09040435e2e 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/kthread.h>
> +#include <linux/pagemap.h>
>  #include <xen/events.h>
>  #include <xen/grant_table.h>
>  #include "common.h"
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 46dd11dcb3a8..7371c6e65b10 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -179,6 +179,7 @@
>  #include <linux/kthread.h>
>  #include <linux/sched/signal.h>
>  #include <linux/limits.h>
> +#include <linux/pagemap.h>
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 29dd87be2fb8..3f3c81e6b1ab 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -14,6 +14,7 @@
>  #include <linux/time.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/pagemap.h>
>  #include <linux/stat.h>
>  #include <linux/cred.h>
>  #include <linux/errno.h>
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 66cf267c68ae..610ca6f1ec9b 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -7,6 +7,7 @@
>  #include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/fiemap.h>
> +#include <linux/pagemap.h>
>  
>  static int iomap_to_fiemap(struct fiemap_extent_info *fi,
>  		const struct iomap *iomap, u32 flags)
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..47f804e0ec93 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -7,6 +7,7 @@
>  #include <linux/hash.h>
>  #include <linux/slab.h>
>  #include <linux/file.h>
> +#include <linux/pagemap.h>
>  #include <linux/sched.h>
>  #include <linux/list_lru.h>
>  #include <linux/fsnotify_backend.h>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 91600e71be19..fe0d7abbc1b1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -26,6 +26,7 @@
>  #include <linux/xattr.h>
>  #include <linux/jhash.h>
>  #include <linux/ima.h>
> +#include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/exportfs.h>
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index aec2ebf7d25a..e1db0f3f7e5e 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -9,6 +9,7 @@
>  #include <linux/namei.h>
>  #include <linux/nls.h>
>  #include <linux/sizes.h>
> +#include <linux/pagemap.h>
>  #include <linux/vfs.h>
>  #include "vfsmod.h"
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 85c584c5c623..0961c979e949 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2746,50 +2746,6 @@ extern void init_special_inode(struct inode *, umode_t, dev_t);
>  extern void make_bad_inode(struct inode *);
>  extern bool is_bad_inode(struct inode *);
>  
> -unsigned long invalidate_mapping_pages(struct address_space *mapping,
> -					pgoff_t start, pgoff_t end);
> -
> -static inline void invalidate_remote_inode(struct inode *inode)
> -{
> -	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> -	    S_ISLNK(inode->i_mode))
> -		invalidate_mapping_pages(inode->i_mapping, 0, -1);
> -}
> -extern int invalidate_inode_pages2(struct address_space *mapping);
> -extern int invalidate_inode_pages2_range(struct address_space *mapping,
> -					 pgoff_t start, pgoff_t end);
> -extern int write_inode_now(struct inode *, int);
> -extern int filemap_fdatawrite(struct address_space *);
> -extern int filemap_flush(struct address_space *);
> -extern int filemap_fdatawait_keep_errors(struct address_space *mapping);
> -extern int filemap_fdatawait_range(struct address_space *, loff_t lstart,
> -				   loff_t lend);
> -extern int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
> -		loff_t start_byte, loff_t end_byte);
> -
> -static inline int filemap_fdatawait(struct address_space *mapping)
> -{
> -	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
> -}
> -
> -extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
> -				  loff_t lend);
> -extern int filemap_write_and_wait_range(struct address_space *mapping,
> -				        loff_t lstart, loff_t lend);
> -extern int __filemap_fdatawrite_range(struct address_space *mapping,
> -				loff_t start, loff_t end, int sync_mode);
> -extern int filemap_fdatawrite_range(struct address_space *mapping,
> -				loff_t start, loff_t end);
> -extern int filemap_check_errors(struct address_space *mapping);
> -extern void __filemap_set_wb_err(struct address_space *mapping, int err);
> -int filemap_fdatawrite_wbc(struct address_space *mapping,
> -			   struct writeback_control *wbc);
> -
> -static inline int filemap_write_and_wait(struct address_space *mapping)
> -{
> -	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
> -}
> -
>  extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
>  						loff_t lend);
>  extern int __must_check file_check_and_advance_wb_err(struct file *file);
> @@ -2801,67 +2757,6 @@ static inline int file_write_and_wait(struct file *file)
>  	return file_write_and_wait_range(file, 0, LLONG_MAX);
>  }
>  
> -/**
> - * filemap_set_wb_err - set a writeback error on an address_space
> - * @mapping: mapping in which to set writeback error
> - * @err: error to be set in mapping
> - *
> - * When writeback fails in some way, we must record that error so that
> - * userspace can be informed when fsync and the like are called.  We endeavor
> - * to report errors on any file that was open at the time of the error.  Some
> - * internal callers also need to know when writeback errors have occurred.
> - *
> - * When a writeback error occurs, most filesystems will want to call
> - * filemap_set_wb_err to record the error in the mapping so that it will be
> - * automatically reported whenever fsync is called on the file.
> - */
> -static inline void filemap_set_wb_err(struct address_space *mapping, int err)
> -{
> -	/* Fastpath for common case of no error */
> -	if (unlikely(err))
> -		__filemap_set_wb_err(mapping, err);
> -}
> -
> -/**
> - * filemap_check_wb_err - has an error occurred since the mark was sampled?
> - * @mapping: mapping to check for writeback errors
> - * @since: previously-sampled errseq_t
> - *
> - * Grab the errseq_t value from the mapping, and see if it has changed "since"
> - * the given value was sampled.
> - *
> - * If it has then report the latest error set, otherwise return 0.
> - */
> -static inline int filemap_check_wb_err(struct address_space *mapping,
> -					errseq_t since)
> -{
> -	return errseq_check(&mapping->wb_err, since);
> -}
> -
> -/**
> - * filemap_sample_wb_err - sample the current errseq_t to test for later errors
> - * @mapping: mapping to be sampled
> - *
> - * Writeback errors are always reported relative to a particular sample point
> - * in the past. This function provides those sample points.
> - */
> -static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
> -{
> -	return errseq_sample(&mapping->wb_err);
> -}
> -
> -/**
> - * file_sample_sb_err - sample the current errseq_t to test for later errors
> - * @file: file pointer to be sampled
> - *
> - * Grab the most current superblock-level errseq_t value for the given
> - * struct file.
> - */
> -static inline errseq_t file_sample_sb_err(struct file *file)
> -{
> -	return errseq_sample(&file->f_path.dentry->d_sb->s_wb_err);
> -}
> -
>  extern int vfs_fsync_range(struct file *file, loff_t start, loff_t end,
>  			   int datasync);
>  extern int vfs_fsync(struct file *file, int datasync);
> @@ -3604,15 +3499,4 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>  			   int advice);
>  
> -/*
> - * Flush file data before changing attributes.  Caller must hold any locks
> - * required to prevent further writes to this file until we're done setting
> - * flags.
> - */
> -static inline int inode_drain_writes(struct inode *inode)
> -{
> -	inode_dio_wait(inode);
> -	return filemap_write_and_wait(inode->i_mapping);
> -}
> -
>  #endif /* _LINUX_FS_H */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index cdb3f118603a..f968b36ad771 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -18,6 +18,120 @@
>  
>  struct folio_batch;
>  
> +unsigned long invalidate_mapping_pages(struct address_space *mapping,
> +					pgoff_t start, pgoff_t end);
> +
> +static inline void invalidate_remote_inode(struct inode *inode)
> +{
> +	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> +	    S_ISLNK(inode->i_mode))
> +		invalidate_mapping_pages(inode->i_mapping, 0, -1);
> +}
> +int invalidate_inode_pages2(struct address_space *mapping);
> +int invalidate_inode_pages2_range(struct address_space *mapping,
> +		pgoff_t start, pgoff_t end);
> +int write_inode_now(struct inode *, int sync);
> +int filemap_fdatawrite(struct address_space *);
> +int filemap_flush(struct address_space *);
> +int filemap_fdatawait_keep_errors(struct address_space *mapping);
> +int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
> +int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
> +		loff_t start_byte, loff_t end_byte);
> +
> +static inline int filemap_fdatawait(struct address_space *mapping)
> +{
> +	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
> +}
> +
> +bool filemap_range_has_page(struct address_space *, loff_t lstart, loff_t lend);
> +int filemap_write_and_wait_range(struct address_space *mapping,
> +		loff_t lstart, loff_t lend);
> +int __filemap_fdatawrite_range(struct address_space *mapping,
> +		loff_t start, loff_t end, int sync_mode);
> +int filemap_fdatawrite_range(struct address_space *mapping,
> +		loff_t start, loff_t end);
> +int filemap_check_errors(struct address_space *mapping);
> +void __filemap_set_wb_err(struct address_space *mapping, int err);
> +int filemap_fdatawrite_wbc(struct address_space *mapping,
> +			   struct writeback_control *wbc);
> +
> +static inline int filemap_write_and_wait(struct address_space *mapping)
> +{
> +	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
> +}
> +
> +/**
> + * filemap_set_wb_err - set a writeback error on an address_space
> + * @mapping: mapping in which to set writeback error
> + * @err: error to be set in mapping
> + *
> + * When writeback fails in some way, we must record that error so that
> + * userspace can be informed when fsync and the like are called.  We endeavor
> + * to report errors on any file that was open at the time of the error.  Some
> + * internal callers also need to know when writeback errors have occurred.
> + *
> + * When a writeback error occurs, most filesystems will want to call
> + * filemap_set_wb_err to record the error in the mapping so that it will be
> + * automatically reported whenever fsync is called on the file.
> + */
> +static inline void filemap_set_wb_err(struct address_space *mapping, int err)
> +{
> +	/* Fastpath for common case of no error */
> +	if (unlikely(err))
> +		__filemap_set_wb_err(mapping, err);
> +}
> +
> +/**
> + * filemap_check_wb_err - has an error occurred since the mark was sampled?
> + * @mapping: mapping to check for writeback errors
> + * @since: previously-sampled errseq_t
> + *
> + * Grab the errseq_t value from the mapping, and see if it has changed "since"
> + * the given value was sampled.
> + *
> + * If it has then report the latest error set, otherwise return 0.
> + */
> +static inline int filemap_check_wb_err(struct address_space *mapping,
> +					errseq_t since)
> +{
> +	return errseq_check(&mapping->wb_err, since);
> +}
> +
> +/**
> + * filemap_sample_wb_err - sample the current errseq_t to test for later errors
> + * @mapping: mapping to be sampled
> + *
> + * Writeback errors are always reported relative to a particular sample point
> + * in the past. This function provides those sample points.
> + */
> +static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
> +{
> +	return errseq_sample(&mapping->wb_err);
> +}
> +
> +/**
> + * file_sample_sb_err - sample the current errseq_t to test for later errors
> + * @file: file pointer to be sampled
> + *
> + * Grab the most current superblock-level errseq_t value for the given
> + * struct file.
> + */
> +static inline errseq_t file_sample_sb_err(struct file *file)
> +{
> +	return errseq_sample(&file->f_path.dentry->d_sb->s_wb_err);
> +}
> +
> +/*
> + * Flush file data before changing attributes.  Caller must hold any locks
> + * required to prevent further writes to this file until we're done setting
> + * flags.
> + */
> +static inline int inode_drain_writes(struct inode *inode)
> +{
> +	inode_dio_wait(inode);
> +	return filemap_write_and_wait(inode->i_mapping);
> +}
> +
>  static inline bool mapping_empty(struct address_space *mapping)
>  {
>  	return xa_empty(&mapping->i_pages);
> 

