Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1534DDF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 02:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfFUAAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 20:00:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46836 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFUAAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:00:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KNwsMv091382;
        Thu, 20 Jun 2019 23:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/mzUBTcckOnL9stejWbwXJK36urYgJBOTaRSFF7K42M=;
 b=CdBi975wOuTCMHvXWYp0cRldSAz+8VTysq45Mc+e6V34QjPI8GD4MLrGFx327ZMdBUDN
 3CvHXgrLFUYJ/W3z6D6wrP4k06pXWGKEZhtHP4cKFAjyYoKTP/S2MtMHQKoWGqmrtdkR
 gyS0NfmypVe0ft+X/Ed5m+gI+McaohKOKrDbZp8SNndy7GMxcDzFE2bAykzmQz6OrseW
 GsVGvYFYYl3c6kD5S3hzndeS28Jbc1afcZ1d4Fm1kA4URjtElHO8sP4r0uugLC+XTGVt
 /KXR8cMooEVGcXLT81M8rf8/as2+zMvjUwNQ2E0hqapYPaKhVkR38W0JGzuPwpsTwslV Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t7809kp8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 23:59:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KNwcvN104991;
        Thu, 20 Jun 2019 23:59:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t77ypnrtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 23:59:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5KNxesR012117;
        Thu, 20 Jun 2019 23:59:40 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 16:59:39 -0700
Date:   Thu, 20 Jun 2019 16:59:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 14/16] ext4: add basic fs-verity support
Message-ID: <20190620235938.GE5375@magnolia>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-15-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-15-ebiggers@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200171
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 01:50:41PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add most of fs-verity support to ext4.  fs-verity is a filesystem
> feature that enables transparent integrity protection and authentication
> of read-only files.  It uses a dm-verity like mechanism at the file
> level: a Merkle tree is used to verify any block in the file in
> log(filesize) time.  It is implemented mainly by helper functions in
> fs/verity/.  See Documentation/filesystems/fsverity.rst for the full
> documentation.
> 
> This commit adds all of ext4 fs-verity support except for the actual
> data verification, including:
> 
> - Adding a filesystem feature flag and an inode flag for fs-verity.
> 
> - Implementing the fsverity_operations to support enabling verity on an
>   inode and reading/writing the verity metadata.
> 
> - Updating ->write_begin(), ->write_end(), and ->writepages() to support
>   writing verity metadata pages.
> 
> - Calling the fs-verity hooks for ->open(), ->setattr(), and ->ioctl().
> 
> ext4 stores the verity metadata (Merkle tree and fsverity_descriptor)
> past the end of the file, starting at the first 64K boundary beyond
> i_size.  This approach works because (a) verity files are readonly, and
> (b) pages fully beyond i_size aren't visible to userspace but can be
> read/written internally by ext4 with only some relatively small changes
> to ext4.  This approach avoids having to depend on the EA_INODE feature
> and on rearchitecturing ext4's xattr support to support paging
> multi-gigabyte xattrs into memory, and to support encrypting xattrs.
> Note that the verity metadata *must* be encrypted when the file is,
> since it contains hashes of the plaintext data.
> 
> This patch incorporates work by Theodore Ts'o and Chandan Rajendra.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ext4/Makefile |   1 +
>  fs/ext4/ext4.h   |  21 ++-
>  fs/ext4/file.c   |   4 +
>  fs/ext4/inode.c  |  46 ++++--
>  fs/ext4/ioctl.c  |  12 ++
>  fs/ext4/super.c  |   9 ++
>  fs/ext4/sysfs.c  |   6 +
>  fs/ext4/verity.c | 354 +++++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 438 insertions(+), 15 deletions(-)
>  create mode 100644 fs/ext4/verity.c
> 
> diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> index 8fdfcd3c3e0437..b17ddc229ac5f5 100644
> --- a/fs/ext4/Makefile
> +++ b/fs/ext4/Makefile
> @@ -13,3 +13,4 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
>  
>  ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
>  ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
> +ext4-$(CONFIG_FS_VERITY)		+= verity.o
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1cb67859e0518b..5a1deea3fb3e37 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -41,6 +41,7 @@
>  #endif
>  
>  #include <linux/fscrypt.h>
> +#include <linux/fsverity.h>
>  
>  #include <linux/compiler.h>
>  
> @@ -395,6 +396,7 @@ struct flex_groups {
>  #define EXT4_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
>  #define EXT4_HUGE_FILE_FL               0x00040000 /* Set to each huge file */
>  #define EXT4_EXTENTS_FL			0x00080000 /* Inode uses extents */
> +#define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */

Hmm, a new inode flag, superblock rocompat feature flag, and
(presumably) the Merkle tree has some sort of well defined format which
starts at the next 64k boundary past EOF.

Would you mind updating the relevant parts of the ondisk format
documentation in Documentation/filesystems/ext4/, please?

I saw that the Merkle tree and verity descriptor formats themselves are
documented in the first patch, so you could simply link the ext4
documentation to it.

>  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
>  #define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
>  #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */

<snip>

> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> new file mode 100644
> index 00000000000000..0ff98eb4ecdbb7
> --- /dev/null
> +++ b/fs/ext4/verity.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * fs/ext4/verity.c: fs-verity support for ext4
> + *
> + * Copyright 2019 Google LLC
> + */
> +
> +/*
> + * Implementation of fsverity_operations for ext4.
> + *
> + * ext4 stores the verity metadata (Merkle tree and fsverity_descriptor) past
> + * the end of the file, starting at the first 64K boundary beyond i_size.  This
> + * approach works because (a) verity files are readonly, and (b) pages fully
> + * beyond i_size aren't visible to userspace but can be read/written internally
> + * by ext4 with only some relatively small changes to ext4.  This approach
> + * avoids having to depend on the EA_INODE feature and on rearchitecturing
> + * ext4's xattr support to support paging multi-gigabyte xattrs into memory, and
> + * to support encrypting xattrs.  Note that the verity metadata *must* be
> + * encrypted when the file is, since it contains hashes of the plaintext data.

Ahh, I had wondered about "why not just shove it in an ea_inode?"...

> + *
> + * Using a 64K boundary rather than a 4K one keeps things ready for
> + * architectures with 64K pages, and it doesn't necessarily waste space on-disk
> + * since there can be a hole between i_size and the start of the Merkle tree.
> + */
> +
> +#include <linux/quotaops.h>
> +
> +#include "ext4.h"
> +#include "ext4_extents.h"
> +#include "ext4_jbd2.h"
> +
> +static inline loff_t ext4_verity_metadata_pos(const struct inode *inode)
> +{
> +	return round_up(inode->i_size, 65536);
> +}
> +
> +/*
> + * Read some verity metadata from the inode.  __vfs_read() can't be used because
> + * we need to read beyond i_size.
> + */
> +static int pagecache_read(struct inode *inode, void *buf, size_t count,
> +			  loff_t pos)
> +{
> +	while (count) {
> +		size_t n = min_t(size_t, count,
> +				 PAGE_SIZE - offset_in_page(pos));
> +		struct page *page;
> +		void *addr;
> +
> +		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
> +					 NULL);
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
> +
> +		addr = kmap_atomic(page);
> +		memcpy(buf, addr + offset_in_page(pos), n);
> +		kunmap_atomic(addr);
> +
> +		put_page(page);
> +
> +		buf += n;
> +		pos += n;
> +		count -= n;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Write some verity metadata to the inode for FS_IOC_ENABLE_VERITY.
> + * kernel_write() can't be used because the file descriptor is readonly.
> + */
> +static int pagecache_write(struct inode *inode, const void *buf, size_t count,
> +			   loff_t pos)
> +{
> +	while (count) {
> +		size_t n = min_t(size_t, count,
> +				 PAGE_SIZE - offset_in_page(pos));
> +		struct page *page;
> +		void *fsdata;
> +		void *addr;
> +		int res;
> +
> +		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
> +					    &page, &fsdata);
> +		if (res)
> +			return res;
> +
> +		addr = kmap_atomic(page);
> +		memcpy(addr + offset_in_page(pos), buf, n);
> +		kunmap_atomic(addr);
> +
> +		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
> +					  page, fsdata);
> +		if (res < 0)
> +			return res;
> +		if (res != n)
> +			return -EIO;
> +
> +		buf += n;
> +		pos += n;
> +		count -= n;
> +	}
> +	return 0;
> +}

This same code is duplicated in the f2fs patch.  Is there a reason why
they don't share this common code?  Even if you have to hide it under
fs/verity/ ?

--D

> +
> +static int ext4_begin_enable_verity(struct file *filp)
> +{
> +	struct inode *inode = file_inode(filp);
> +	const int credits = 2; /* superblock and inode for ext4_orphan_add() */
> +	handle_t *handle;
> +	int err;
> +
> +	err = ext4_convert_inline_data(inode);
> +	if (err)
> +		return err;
> +
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> +		ext4_warning_inode(inode,
> +				   "verity is only allowed on extent-based files");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = ext4_inode_attach_jinode(inode);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * ext4 uses the last allocated block to find the verity descriptor, so
> +	 * we must remove any other blocks which might confuse things.
> +	 */
> +	err = ext4_truncate(inode);
> +	if (err)
> +		return err;
> +
> +	err = dquot_initialize(inode);
> +	if (err)
> +		return err;
> +
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, credits);
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
> +	err = ext4_orphan_add(handle, inode);
> +	if (err == 0)
> +		ext4_set_inode_state(inode, EXT4_STATE_VERITY_IN_PROGRESS);
> +
> +	ext4_journal_stop(handle);
> +	return err;
> +}
> +
> +/*
> + * ext4 stores the verity descriptor beginning on the next filesystem block
> + * boundary after the Merkle tree.  Then, the descriptor size is stored in the
> + * last 4 bytes of the last allocated filesystem block --- which is either the
> + * block in which the descriptor ends, or the next block after that if there
> + * weren't at least 4 bytes remaining.
> + *
> + * We can't simply store the descriptor in an xattr because it *must* be
> + * encrypted when ext4 encryption is used, but ext4 encryption doesn't encrypt
> + * xattrs.  Also, if the descriptor includes a large signature blob it may be
> + * too large to store in an xattr without the EA_INODE feature.
> + */
> +static int ext4_write_verity_descriptor(struct inode *inode, const void *desc,
> +					size_t desc_size, u64 merkle_tree_size)
> +{
> +	const u64 desc_pos = round_up(ext4_verity_metadata_pos(inode) +
> +				      merkle_tree_size, i_blocksize(inode));
> +	const u64 desc_end = desc_pos + desc_size;
> +	const __le32 desc_size_disk = cpu_to_le32(desc_size);
> +	const u64 desc_size_pos = round_up(desc_end + sizeof(desc_size_disk),
> +					   i_blocksize(inode)) -
> +				  sizeof(desc_size_disk);
> +	int err;
> +
> +	err = pagecache_write(inode, desc, desc_size, desc_pos);
> +	if (err)
> +		return err;
> +
> +	return pagecache_write(inode, &desc_size_disk, sizeof(desc_size_disk),
> +			       desc_size_pos);
> +}
> +
> +static int ext4_end_enable_verity(struct file *filp, const void *desc,
> +				  size_t desc_size, u64 merkle_tree_size)
> +{
> +	struct inode *inode = file_inode(filp);
> +	const int credits = 2; /* superblock and inode for ext4_orphan_add() */
> +	handle_t *handle;
> +	int err1 = 0;
> +	int err;
> +
> +	if (desc != NULL) {
> +		/* Succeeded; write the verity descriptor. */
> +		err1 = ext4_write_verity_descriptor(inode, desc, desc_size,
> +						    merkle_tree_size);
> +
> +		/* Write all pages before clearing VERITY_IN_PROGRESS. */
> +		if (!err1)
> +			err1 = filemap_write_and_wait(inode->i_mapping);
> +	} else {
> +		/* Failed; truncate anything we wrote past i_size. */
> +		ext4_truncate(inode);
> +	}
> +
> +	/*
> +	 * We must always clean up by clearing EXT4_STATE_VERITY_IN_PROGRESS and
> +	 * deleting the inode from the orphan list, even if something failed.
> +	 * If everything succeeded, we'll also set the verity bit in the same
> +	 * transaction.
> +	 */
> +
> +	ext4_clear_inode_state(inode, EXT4_STATE_VERITY_IN_PROGRESS);
> +
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, credits);
> +	if (IS_ERR(handle)) {
> +		ext4_orphan_del(NULL, inode);
> +		return PTR_ERR(handle);
> +	}
> +
> +	err = ext4_orphan_del(handle, inode);
> +	if (err)
> +		goto out_stop;
> +
> +	if (desc != NULL && !err1) {
> +		struct ext4_iloc iloc;
> +
> +		err = ext4_reserve_inode_write(handle, inode, &iloc);
> +		if (err)
> +			goto out_stop;
> +		ext4_set_inode_flag(inode, EXT4_INODE_VERITY);
> +		ext4_set_inode_flags(inode);
> +		err = ext4_mark_iloc_dirty(handle, inode, &iloc);
> +	}
> +out_stop:
> +	ext4_journal_stop(handle);
> +	return err ?: err1;
> +}
> +
> +static int ext4_get_verity_descriptor_location(struct inode *inode,
> +					       size_t *desc_size_ret,
> +					       u64 *desc_pos_ret)
> +{
> +	struct ext4_ext_path *path;
> +	struct ext4_extent *last_extent;
> +	u32 end_lblk;
> +	u64 desc_size_pos;
> +	__le32 desc_size_disk;
> +	u32 desc_size;
> +	u64 desc_pos;
> +	int err;
> +
> +	/*
> +	 * Descriptor size is in last 4 bytes of last allocated block.
> +	 * See ext4_write_verity_descriptor().
> +	 */
> +
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> +		EXT4_ERROR_INODE(inode, "verity file doesn't use extents");
> +		return -EFSCORRUPTED;
> +	}
> +
> +	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL, 0);
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
> +
> +	last_extent = path[path->p_depth].p_ext;
> +	if (!last_extent) {
> +		EXT4_ERROR_INODE(inode, "verity file has no extents");
> +		ext4_ext_drop_refs(path);
> +		kfree(path);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	end_lblk = le32_to_cpu(last_extent->ee_block) +
> +		   ext4_ext_get_actual_len(last_extent);
> +	desc_size_pos = (u64)end_lblk << inode->i_blkbits;
> +	ext4_ext_drop_refs(path);
> +	kfree(path);
> +
> +	if (desc_size_pos < sizeof(desc_size_disk))
> +		goto bad;
> +	desc_size_pos -= sizeof(desc_size_disk);
> +
> +	err = pagecache_read(inode, &desc_size_disk, sizeof(desc_size_disk),
> +			     desc_size_pos);
> +	if (err)
> +		return err;
> +	desc_size = le32_to_cpu(desc_size_disk);
> +
> +	/*
> +	 * The descriptor is stored just before the desc_size_disk, but starting
> +	 * on a filesystem block boundary.
> +	 */
> +
> +	if (desc_size > INT_MAX || desc_size > desc_size_pos)
> +		goto bad;
> +
> +	desc_pos = round_down(desc_size_pos - desc_size, i_blocksize(inode));
> +	if (desc_pos < ext4_verity_metadata_pos(inode))
> +		goto bad;
> +
> +	*desc_size_ret = desc_size;
> +	*desc_pos_ret = desc_pos;
> +	return 0;
> +
> +bad:
> +	EXT4_ERROR_INODE(inode, "verity file corrupted; can't find descriptor");
> +	return -EFSCORRUPTED;
> +}
> +
> +static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
> +				      size_t buf_size)
> +{
> +	size_t desc_size = 0;
> +	u64 desc_pos = 0;
> +	int err;
> +
> +	err = ext4_get_verity_descriptor_location(inode, &desc_size, &desc_pos);
> +	if (err)
> +		return err;
> +
> +	if (buf_size) {
> +		if (desc_size > buf_size)
> +			return -ERANGE;
> +		err = pagecache_read(inode, buf, desc_size, desc_pos);
> +		if (err)
> +			return err;
> +	}
> +	return desc_size;
> +}
> +
> +static struct page *ext4_read_merkle_tree_page(struct inode *inode,
> +					       pgoff_t index)
> +{
> +	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
> +
> +	return read_mapping_page(inode->i_mapping, index, NULL);
> +}
> +
> +static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
> +					u64 index, int log_blocksize)
> +{
> +	loff_t pos = ext4_verity_metadata_pos(inode) + (index << log_blocksize);
> +
> +	return pagecache_write(inode, buf, 1 << log_blocksize, pos);
> +}
> +
> +const struct fsverity_operations ext4_verityops = {
> +	.begin_enable_verity	= ext4_begin_enable_verity,
> +	.end_enable_verity	= ext4_end_enable_verity,
> +	.get_verity_descriptor	= ext4_get_verity_descriptor,
> +	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
> +	.write_merkle_tree_block = ext4_write_merkle_tree_block,
> +};
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
