Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188073F28BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhHTI5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 04:57:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52974 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhHTI5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:57:17 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2D301FDE9;
        Fri, 20 Aug 2021 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629449798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DiuxsGRlZyf5U39p+AGHvsaZvfBZfheC+GT5DYQNN6k=;
        b=AYaaIsaIkOUbT/cUJ6qbEYzn8v2C9zEYL47JIuuaq+HUfRszVLNU55mc/1hLq6WuCqZEdS
        cmXAQlEgIAogdC7gNMNE7DXQmgbI8i8+Qwmerz+pWe93uJgrlSfLeJayNMlgKzAHfKMXTT
        mn7YU1/r3c3VRLeVebtG7p9UPSziVfo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 63DF71333E;
        Fri, 20 Aug 2021 08:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3hQdFUZuH2GNUQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 20 Aug 2021 08:56:38 +0000
Subject: Re: [PATCH v10 07/14] btrfs: add definitions + documentation for
 encoded I/O ioctls
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
References: <cover.1629234193.git.osandov@fb.com>
 <9bd601f8c5494342d8c7d8aaa86aa815c2118173.1629234193.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1e9a95f4-01a3-c356-a348-2992d63c867f@suse.com>
Date:   Fri, 20 Aug 2021 11:56:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9bd601f8c5494342d8c7d8aaa86aa815c2118173.1629234193.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18.08.21 г. 0:06, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In order to allow sending and receiving compressed data without
> decompressing it, we need an interface to write pre-compressed data
> directly to the filesystem and the matching interface to read compressed
> data without decompressing it. This adds the definitions for ioctls to
> do that and detailed explanations of how to use them.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  include/uapi/linux/btrfs.h | 132 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index d7d3cfead056..95da52955894 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -861,6 +861,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
>  		__u8 align[7];
>  };
>  
> +/*
> + * Data and metadata for an encoded read or write.
> + *
> + * Encoded I/O bypasses any encoding automatically done by the filesystem (e.g.,
> + * compression). This can be used to read the compressed contents of a file or
> + * write pre-compressed data directly to a file.
> + *
> + * BTRFS_IOC_ENCODED_READ and BTRFS_IOC_ENCODED_WRITE are essentially
> + * preadv/pwritev with additional metadata about how the data is encoded and the
> + * size of the unencoded data.
> + *
> + * BTRFS_IOC_ENCODED_READ fills the given iovecs with the encoded data, fills
> + * the metadata fields, and returns the size of the encoded data. It reads one
> + * extent per call. It can also read data which is not encoded.
> + *
> + * BTRFS_IOC_ENCODED_WRITE uses the metadata fields, writes the encoded data
> + * from the iovecs, and returns the size of the encoded data. Note that the
> + * encoded data is not validated when it is written; if it is not valid (e.g.,
> + * it cannot be decompressed), then a subsequent read may return an error.
> + *
> + * Since the filesystem page cache contains decoded data, encoded I/O bypasses
> + * the page cache. Encoded I/O requires CAP_SYS_ADMIN.
> + */
> +struct btrfs_ioctl_encoded_io_args {
> +	/* Input parameters for both reads and writes. */
> +
> +	/*
> +	 * iovecs containing encoded data.
> +	 *
> +	 * For reads, if the size of the encoded data is larger than the sum of
> +	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
> +	 * ENOBUFS.
> +	 *
> +	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
> +	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
> +	 * increase in the future). This must also be less than or equal to
> +	 * unencoded_len.
> +	 */
> +	const struct iovec __user *iov;
> +	/* Number of iovecs. */
> +	unsigned long iovcnt;
> +	/*
> +	 * Offset in file.
> +	 *
> +	 * For writes, must be aligned to the sector size of the filesystem.
> +	 */
> +	__s64 offset;
> +	/* Currently must be zero. */
> +	__u64 flags;
> +
> +	/*
> +	 * For reads, the following members are filled in with the metadata for
> +	 * the encoded data.
> +	 * For writes, the following members must be set to the metadata for the
> +	 * encoded data.
> +	 */
> +
> +	/*
> +	 * Length of the data in the file.
> +	 *
> +	 * Must be less than or equal to unencoded_len - unencoded_offset. For
> +	 * writes, must be aligned to the sector size of the filesystem unless
> +	 * the data ends at or beyond the current end of the file.
> +	 */
> +	__u64 len;
> +	/*
> +	 * Length of the unencoded (i.e., decrypted and decompressed) data.
> +	 *
> +	 * For writes, must be no more than 128 KiB (this limit may increase in
> +	 * the future). If the unencoded data is actually longer than
> +	 * unencoded_len, then it is truncated; if it is shorter, then it is
> +	 * extended with zeroes.
> +	 */
> +	__u64 unencoded_len;
> +	/*
> +	 * Offset from the first byte of the unencoded data to the first byte of
> +	 * logical data in the file.
> +	 *
> +	 * Must be less than unencoded_len.
> +	 */
> +	__u64 unencoded_offset;
> +	/*
> +	 * BTRFS_ENCODED_IO_COMPRESSION_* type.
> +	 *
> +	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
> +	 */
> +	__u32 compression;
> +	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
> +	__u32 encryption;
> +	/*
> +	 * Reserved for future expansion.
> +	 *
> +	 * For reads, always returned as zero. Users should check for non-zero
> +	 * bytes. If there are any, then the kernel has a newer version of this
> +	 * structure with additional information that the user definition is
> +	 * missing.
> +	 *
> +	 * For writes, must be zeroed.
> +	 */
> +	__u8 reserved[32];
> +};
> +
> +/* Data is not compressed. */
> +#define BTRFS_ENCODED_IO_COMPRESSION_NONE 0
> +/* Data is compressed as a single zlib stream. */
> +#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB 1
> +/*
> + * Data is compressed as a single zstd frame with the windowLog compression
> + * parameter set to no more than 17.
> + */
> +#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
> +/*
> + * Data is compressed page by page (using the page size indicated by the name of
> + * the constant) with LZO1X and wrapped in the format documented in
> + * fs/btrfs/lzo.c. For writes, the compression page size must match the
> + * filesystem page size.
> + */
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K 5
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K 6
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K 7
> +#define BTRFS_ENCODED_IO_COMPRESSION_TYPES 8
> +
> +/* Data is not encrypted. */
> +#define BTRFS_ENCODED_IO_ENCRYPTION_NONE 0
> +#define BTRFS_ENCODED_IO_ENCRYPTION_TYPES 1

How about an enums for encryption/compression.


> +
>  /* Error codes as returned by the kernel */
>  enum btrfs_err_code {
>  	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
> @@ -989,5 +1117,9 @@ enum btrfs_err_code {
>  				struct btrfs_ioctl_ino_lookup_user_args)
>  #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
>  				struct btrfs_ioctl_vol_args_v2)
> +#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, \
> +				    struct btrfs_ioctl_encoded_io_args)
> +#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
> +				     struct btrfs_ioctl_encoded_io_args)
>  
>  #endif /* _UAPI_LINUX_BTRFS_H */
> 
