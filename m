Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E943638C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhJUN5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 09:57:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50988 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhJUN5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:57:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1BA41FDB2;
        Thu, 21 Oct 2021 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634824519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8zMP61btDAmOLyCB9fT6Mz0RmA1RP5RFwMMZ47ssA8=;
        b=ICUzuxL+2iTnqFgX1pISg3Yf2padq4ihm0I4yeBcN1Id44rIQx+GNX0kEeDEYwdvegcbdF
        ed9Qlz1zlTWE/cXZC6BaapHigQGj/1/D+oZu3cp0ZN4qkHmaafHDt9d98RPaULLC6Mj1bP
        POVv8ou5T/kofl1+hUmMwtdgepWJLI8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AA09133A6;
        Thu, 21 Oct 2021 13:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zK4wI0dxcWEJLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Oct 2021 13:55:19 +0000
Subject: Re: [PATCH v11 06/10] btrfs-progs: receive: encoded_write fallback to
 explicit decode and write
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <06689de6a56f046d5e41525fa12c7af92db478e5.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8ac98c8e-901e-0fc1-2281-27d282486a49@suse.com>
Date:   Thu, 21 Oct 2021 16:55:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <06689de6a56f046d5e41525fa12c7af92db478e5.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <boris@bur.io>
> 

<snip>

> @@ -79,6 +83,12 @@ struct btrfs_receive
>  	struct subvol_uuid_search sus;
>  
>  	int honor_end_cmd;
> +
> +	int force_decompress;

Make it bool

> +
> +	/* Reuse stream objects for encoded_write decompression fallback */
> +	ZSTD_DStream *zstd_dstream;
> +	z_stream *zlib_stream;
>  };
>  
>  static int finish_subvol(struct btrfs_receive *rctx)
> @@ -989,9 +999,222 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
>  	return 0;
>  }
>  

<snip>

> +
> +static int decompress_lzo(const char *encoded_data, u64 encoded_len,
> +			  char *unencoded_data, u64 unencoded_len,
> +			  unsigned int page_size)
> +{
> +	uint32_t total_len;
> +	size_t in_pos, out_pos;
> +
> +	if (encoded_len < 4) {
> +		error("lzo header is truncated");
> +		return -EIO;
> +	}
> +	memcpy(&total_len, encoded_data, 4);
> +	total_len = le32toh(total_len);
> +	if (total_len > encoded_len) {
> +		error("lzo header is invalid");
> +		return -EIO;
> +	}
> +
> +	in_pos = 4;
> +	out_pos = 0;
> +	while (in_pos < total_len && out_pos < unencoded_len) {
> +		size_t page_remaining;
> +		uint32_t src_len;
> +		lzo_uint dst_len;
> +		int ret;
> +
> +		page_remaining = -in_pos % page_size;

Why the -in_pos?

> +		if (page_remaining < 4) {
> +			if (total_len - in_pos <= page_remaining)
> +				break;
> +			in_pos += page_remaining;
> +		}
> +
> +		if (total_len - in_pos < 4) {
> +			error("lzo segment header is truncated");
> +			return -EIO;
> +		}
> +
> +		memcpy(&src_len, encoded_data + in_pos, 4);
> +		src_len = le32toh(src_len);
> +		in_pos += 4;
> +		if (src_len > total_len - in_pos) {
> +			error("lzo segment header is invalid");
> +			return -EIO;
> +		}
> +
> +		dst_len = page_size;
> +		ret = lzo1x_decompress_safe((void *)(encoded_data + in_pos),
> +					    src_len,
> +					    (void *)(unencoded_data + out_pos),
> +					    &dst_len, NULL);
> +		if (ret != LZO_E_OK) {
> +			error("lzo1x_decompress_safe failed: %d", ret);
> +			return -EIO;
> +		}
> +
> +		in_pos += src_len;
> +		out_pos += dst_len;
> +	}
> +	return 0;
> +}
> +
> +static int decompress_and_write(struct btrfs_receive *rctx,
> +				const char *encoded_data, u64 offset,
> +				u64 encoded_len, u64 unencoded_file_len,
> +				u64 unencoded_len, u64 unencoded_offset,
> +				u32 compression)
> +{
> +	int ret = 0;
> +	size_t pos;
> +	ssize_t w;
> +	char *unencoded_data;
> +	int page_shift;
> +
> +	unencoded_data = calloc(unencoded_len, 1);
> +	if (!unencoded_data) {
> +		error("allocating space for unencoded data failed: %m");
> +		return -errno;
> +	}
> +
> +	switch (compression) {
> +	case BTRFS_ENCODED_IO_COMPRESSION_ZLIB:
> +		ret = decompress_zlib(rctx, encoded_data, encoded_len,
> +				      unencoded_data, unencoded_len);
> +		if (ret)
> +			goto out;
> +		break;
> +	case BTRFS_ENCODED_IO_COMPRESSION_ZSTD:
> +		ret = decompress_zstd(rctx, encoded_data, encoded_len,
> +				      unencoded_data, unencoded_len);
> +		if (ret)
> +			goto out;
> +		break;
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_4K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_8K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_16K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_32K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_64K:
> +		page_shift = compression - BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + 12;

Doesn't this calculation assume page size is 4k, what about arches with
larger page size (ppc/aarch64), shouldn't that '12' be adjusted?

> +		ret = decompress_lzo(encoded_data, encoded_len, unencoded_data,
> +				     unencoded_len, 1U << page_shift);
> +		if (ret)
> +			goto out;
> +		break;
> +	default:
> +		error("unknown compression: %d", compression);
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	pos = unencoded_offset;
> +	while (pos < unencoded_file_len) {
> +		w = pwrite(rctx->write_fd, unencoded_data + pos,
> +			   unencoded_file_len - pos, offset);
> +		if (w < 0) {
> +			ret = -errno;
> +			error("writing unencoded data failed: %m");
> +			goto out;
> +		}
> +		pos += w;
> +		offset += w;
> +	}
> +out:
> +	free(unencoded_data);
> +	return ret;
> +}
> +
>  static int process_encoded_write(const char *path, const void *data, u64 offset,
> -	u64 len, u64 unencoded_file_len, u64 unencoded_len,
> -	u64 unencoded_offset, u32 compression, u32 encryption, void *user)
> +				 u64 len, u64 unencoded_file_len,
> +				 u64 unencoded_len, u64 unencoded_offset,
> +				 u32 compression, u32 encryption, void *user)

That's irrelevant change for this patch,  it should be squashed in the
previous patch which introduces process_encoded_write.

>  {
>  	int ret;
>  	struct btrfs_receive *rctx = user;
> @@ -1007,6 +1230,7 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
>  		.compression = compression,
>  		.encryption = encryption,
>  	};
> +	bool encoded_write = !rctx->force_decompress;

No point in the local variable simply use !rctx->force_decompress in the
condition below.

>  
>  	if (encryption) {
>  		error("encoded_write: encryption not supported");
> @@ -1023,13 +1247,21 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
> -	if (ret < 0) {
> -		ret = -errno;
> -		error("encoded_write: writing to %s failed: %m", path);
> -		return ret;
> +	if (encoded_write) {
> +		ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
> +		if (ret >= 0)
> +			return 0;
> +		/* Fall back for these errors, fail hard for anything else. */
> +		if (errno != ENOSPC && errno != ENOTTY && errno != EINVAL) {
> +			ret = -errno;
> +			error("encoded_write: writing to %s failed: %m", path);
> +			return ret;
> +		}
>  	}
> -	return 0;
> +
> +	return decompress_and_write(rctx, data, offset, len, unencoded_file_len,
> +				    unencoded_len, unencoded_offset,
> +				    compression);
>  }
>  
>  static struct btrfs_send_ops send_ops = {

<snip>

