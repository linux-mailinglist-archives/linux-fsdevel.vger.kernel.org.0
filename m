Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5F6B096
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfGPUqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 16:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbfGPUqg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:46:36 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE272145D;
        Tue, 16 Jul 2019 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563309995;
        bh=hf1kHilRo2b86FKLdptr/FM84ElXk/6EL+6g3vp0Hjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRTxJiHNC+o/fh1xF0OFHblVJbQAxWfGn2Wd23Cj+bdMMwzaUlxNJ+PDUZaHsDfMG
         xOU2DsQcoVXmqjc96P5VB1FRo8b5cMJdrxjFh8smu4X7GUdGtANYCuaoAR2/XsCP76
         6AWgXNkNkpVr9qBRwoON4W+Sol6kLtmV71Q1QUrY=
Date:   Tue, 16 Jul 2019 13:46:34 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] f2fs: include charset encoding information in the
 superblock
Message-ID: <20190716204634.GB99092@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190711204556.120381-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711204556.120381-1-drosen@google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Daniel,

Could you please rebase you patch set?
e.g., f2fs_msg() was replaced with f2fs_err|info|...

On 07/11, Daniel Rosenberg wrote:
> Add charset encoding to f2fs to support casefolding. It is modeled after
> the same feature introduced in commit c83ad55eaa91 ("ext4: include charset
> encoding information in the superblock")
> 
> Currently this is not compatible with encryption, similar to the current
> ext4 imlpementation. This will change in the future.
> 
> >From the ext4 patch:
> """
> The s_encoding field stores a magic number indicating the encoding
> format and version used globally by file and directory names in the
> filesystem.  The s_encoding_flags defines policies for using the charset
> encoding, like how to handle invalid sequences.  The magic number is
> mapped to the exact charset table, but the mapping is specific to ext4.
> Since we don't have any commitment to support old encodings, the only
> encoding I am supporting right now is utf8-12.1.0.
> 
> The current implementation prevents the user from enabling encoding and
> per-directory encryption on the same filesystem at the same time.  The
> incompatibility between these features lies in how we do efficient
> directory searches when we cannot be sure the encryption of the user
> provided fname will match the actual hash stored in the disk without
> decrypting every directory entry, because of normalization cases.  My
> quickest solution is to simply block the concurrent use of these
> features for now, and enable it later, once we have a better solution.
> """
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/f2fs/f2fs.h          |  6 +++
>  fs/f2fs/super.c         | 81 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/f2fs_fs.h |  9 ++++-
>  3 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 06b89a9862ab2..0e101f699eccd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -150,6 +150,7 @@ struct f2fs_mount_info {
>  #define F2FS_FEATURE_LOST_FOUND		0x0200
>  #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
>  #define F2FS_FEATURE_SB_CHKSUM		0x0800
> +#define F2FS_FEATURE_CASEFOLD		0x1000
>  
>  #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>  	((raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -1162,6 +1163,10 @@ struct f2fs_sb_info {
>  	int valid_super_block;			/* valid super block no */
>  	unsigned long s_flag;				/* flags for sbi */
>  	struct mutex writepages;		/* mutex for writepages() */
> +#ifdef CONFIG_UNICODE
> +	struct unicode_map *s_encoding;
> +	__u16 s_encoding_flags;
> +#endif
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
> @@ -3565,6 +3570,7 @@ F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
>  F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
>  F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
>  F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
> +F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6b959bbb336a3..a346f5a01370b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -23,6 +23,7 @@
>  #include <linux/f2fs_fs.h>
>  #include <linux/sysfs.h>
>  #include <linux/quota.h>
> +#include <linux/unicode.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -211,6 +212,36 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>  	va_end(args);
>  }
>  
> +#ifdef CONFIG_UNICODE
> +static const struct f2fs_sb_encodings {
> +	__u16 magic;
> +	char *name;
> +	char *version;
> +} f2fs_sb_encoding_map[] = {
> +	{F2FS_ENC_UTF8_12_1, "utf8", "12.1.0"},
> +};
> +
> +static int f2fs_sb_read_encoding(const struct f2fs_super_block *sb,
> +				 const struct f2fs_sb_encodings **encoding,
> +				 __u16 *flags)
> +{
> +	__u16 magic = le16_to_cpu(sb->s_encoding);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(f2fs_sb_encoding_map); i++)
> +		if (magic == f2fs_sb_encoding_map[i].magic)
> +			break;
> +
> +	if (i >= ARRAY_SIZE(f2fs_sb_encoding_map))
> +		return -EINVAL;
> +
> +	*encoding = &f2fs_sb_encoding_map[i];
> +	*flags = le16_to_cpu(sb->s_encoding_flags);
> +
> +	return 0;
> +}
> +#endif
> +
>  static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
>  {
>  	block_t limit = (sbi->user_block_count << 1) / 1000;
> @@ -812,6 +843,13 @@ static int parse_options(struct super_block *sb, char *options)
>  		return -EINVAL;
>  	}
>  #endif
> +#ifndef CONFIG_UNICODE
> +	if (f2fs_sb_has_casefold(sbi)) {
> +		f2fs_msg(sb, KERN_ERR,
> +			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
> +		return -EINVAL;
> +	}
> +#endif
>  
>  	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
>  		f2fs_msg(sb, KERN_ERR,
> @@ -1110,6 +1148,9 @@ static void f2fs_put_super(struct super_block *sb)
>  	destroy_percpu_info(sbi);
>  	for (i = 0; i < NR_PAGE_TYPE; i++)
>  		kvfree(sbi->write_io[i]);
> +#ifdef CONFIG_UNICODE
> +	utf8_unload(sbi->s_encoding);
> +#endif
>  	kvfree(sbi);
>  }
>  
> @@ -3157,6 +3198,42 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_maxbytes = sbi->max_file_blocks <<
>  				le32_to_cpu(raw_super->log_blocksize);
>  	sb->s_max_links = F2FS_LINK_MAX;
> +#ifdef CONFIG_UNICODE
> +	if (f2fs_sb_has_casefold(sbi) && !sbi->s_encoding) {
> +		const struct f2fs_sb_encodings *encoding_info;
> +		struct unicode_map *encoding;
> +		__u16 encoding_flags;
> +
> +		if (f2fs_sb_has_encrypt(sbi)) {
> +			f2fs_msg(sb, KERN_ERR,
> +				 "Can't mount with encoding and encryption");
> +			goto free_options;
> +		}
> +
> +		if (f2fs_sb_read_encoding(raw_super, &encoding_info,
> +					  &encoding_flags)) {
> +			f2fs_msg(sb, KERN_ERR,
> +				 "Encoding requested by superblock is unknown");
> +			goto free_options;
> +		}
> +
> +		encoding = utf8_load(encoding_info->version);
> +		if (IS_ERR(encoding)) {
> +			f2fs_msg(sb, KERN_ERR,
> +				 "can't mount with superblock charset: %s-%s "
> +				 "not supported by the kernel. flags: 0x%x.",
> +				 encoding_info->name, encoding_info->version,
> +				 encoding_flags);
> +			goto free_options;
> +		}
> +		f2fs_msg(sb, KERN_INFO, "Using encoding defined by superblock: "
> +			 "%s-%s with flags 0x%hx", encoding_info->name,
> +			 encoding_info->version?:"\b", encoding_flags);
> +
> +		sbi->s_encoding = encoding;
> +		sbi->s_encoding_flags = encoding_flags;
> +	}
> +#endif
>  
>  #ifdef CONFIG_QUOTA
>  	sb->dq_op = &f2fs_quota_operations;
> @@ -3511,6 +3588,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  free_bio_info:
>  	for (i = 0; i < NR_PAGE_TYPE; i++)
>  		kvfree(sbi->write_io[i]);
> +
> +#ifdef CONFIG_UNICODE
> +	utf8_unload(sbi->s_encoding);
> +#endif
>  free_options:
>  #ifdef CONFIG_QUOTA
>  	for (i = 0; i < MAXQUOTAS; i++)
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 65559900d4d76..b7c9c7f721339 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -36,6 +36,11 @@
>  
>  #define F2FS_MAX_QUOTAS		3
>  
> +#define F2FS_ENC_UTF8_12_1	1
> +#define F2FS_ENC_STRICT_MODE_FL	(1 << 0)
> +#define f2fs_has_strict_mode(sbi) \
> +	(sbi->s_encoding_flags & F2FS_ENC_STRICT_MODE_FL)
> +
>  #define F2FS_IO_SIZE(sbi)	(1 << F2FS_OPTION(sbi).write_io_size_bits) /* Blocks */
>  #define F2FS_IO_SIZE_KB(sbi)	(1 << (F2FS_OPTION(sbi).write_io_size_bits + 2)) /* KB */
>  #define F2FS_IO_SIZE_BYTES(sbi)	(1 << (F2FS_OPTION(sbi).write_io_size_bits + 12)) /* B */
> @@ -109,7 +114,9 @@ struct f2fs_super_block {
>  	struct f2fs_device devs[MAX_DEVICES];	/* device list */
>  	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
>  	__u8 hot_ext_count;		/* # of hot file extension */
> -	__u8 reserved[310];		/* valid reserved region */
> +	__le16  s_encoding;		/* Filename charset encoding */
> +	__le16  s_encoding_flags;	/* Filename charset encoding flags */
> +	__u8 reserved[306];		/* valid reserved region */
>  	__le32 crc;			/* checksum of superblock */
>  } __packed;
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
