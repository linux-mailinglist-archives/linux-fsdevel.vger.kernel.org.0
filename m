Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C996765F4EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 21:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjAEUDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 15:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjAEUDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DEE1B1DF
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672948945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6LOc/JQXrSyzu2n5DJUAw83XmPIif5T/VhQUyjRKVg=;
        b=ZROQMJ+f8Ys91FzueFF0XSjxMSUY9Smh6ljseGDyDuV1IGaYYX/6GE8nyS3xC+HSaBl0nO
        /z68AJFjSDONvAm7TDs/DeVaJdbd9C75ilLgksYAJIkWYYB9Ze8JffQFe75DPmiy5/yU8s
        nTun924SP6iPbcIEatZlZYy4itN4iV8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-UOjVIlt-Oh-1vjHWf6mlkA-1; Thu, 05 Jan 2023 15:02:24 -0500
X-MC-Unique: UOjVIlt-Oh-1vjHWf6mlkA-1
Received: by mail-io1-f72.google.com with SMTP id u24-20020a6be918000000b006ed1e9ad302so11519074iof.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 12:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6LOc/JQXrSyzu2n5DJUAw83XmPIif5T/VhQUyjRKVg=;
        b=TIbA5GHup2JcVVU75JNyW/hTFGbz6CfqvAkq/89oKMh7xqJiUnTrlddwgjALh4MBvt
         xcNMiJIJvBUew+K93+wOjHZem5wXtrUucC73bxUcxYr+/fQk3lE0N0cDK8Yzm5r6rowA
         nSrOpuvB3ys0rd+ouPdu7C9878LLvg5+NpHXa/QmK3CoaXG0bpdgSO4anEaGHdSHVb4S
         ouTX+li7flkZcYx0Wu2RPA07NS3ClUi3BqYttG/iBTlquj0SxqSPuSaIlQcUtGb4Lm5P
         +ha2o/wrioL8XUlaYak3DxYOLIK17Iwr74XbUXY4pv1uBIPkAaod5DSYTPL00fVT5a9Q
         gWUQ==
X-Gm-Message-State: AFqh2krsWhpf4H08qjzt5umGVAzAIaqeq65JCcICgGs4czVAmZa0gF7y
        oMiB/Sq3eStzHzHH1n8StGibV/FgiSPFKblS2HSFMeohejU1yk7c/8EUd51gkZY9cNOJ/rG+nZV
        6X87z3T4yo9ykwpPz4usTpPYT2w==
X-Received: by 2002:a05:6e02:972:b0:30c:436d:a6ab with SMTP id q18-20020a056e02097200b0030c436da6abmr11326904ilt.12.1672948942885;
        Thu, 05 Jan 2023 12:02:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvut9FoOkw3vqmxmcnnTCZ90ZTu3/xKg3ddFnHy+zoGYcvCL4ikGz6H52LE7rFGpfgv7eiUGw==
X-Received: by 2002:a05:6e02:972:b0:30c:436d:a6ab with SMTP id q18-20020a056e02097200b0030c436da6abmr11326880ilt.12.1672948942452;
        Thu, 05 Jan 2023 12:02:22 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a248600b006faa2c0100bsm26453287qkn.110.2023.01.05.12.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 12:02:21 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:02:20 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Subject: Re: [PATCH 3/6] composefs: Add descriptor parsing code
Message-ID: <Y7cszNNvHHUef2qO@x1>
References: <cover.1669631086.git.alexl@redhat.com>
 <1c4c49fac5bb6406a8cb55ca71f8060703aa63f6.1669631086.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4c49fac5bb6406a8cb55ca71f8060703aa63f6.1669631086.git.alexl@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:16:59PM +0100, Alexander Larsson wrote:
> This adds the code to load and decode the filesystem descriptor file
> format.
> 
> Signed-off-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  fs/composefs/cfs-internals.h |  65 +++
>  fs/composefs/cfs-reader.c    | 958 +++++++++++++++++++++++++++++++++++
>  2 files changed, 1023 insertions(+)
>  create mode 100644 fs/composefs/cfs-internals.h
>  create mode 100644 fs/composefs/cfs-reader.c
> 
> diff --git a/fs/composefs/cfs-internals.h b/fs/composefs/cfs-internals.h
> new file mode 100644
> index 000000000000..f4cb50eec9b8
> --- /dev/null
> +++ b/fs/composefs/cfs-internals.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _CFS_INTERNALS_H
> +#define _CFS_INTERNALS_H
> +
> +#include "cfs.h"
> +
> +#define EFSCORRUPTED EUCLEAN /* Filesystem is corrupted */
> +
> +#define CFS_N_PRELOAD_DIR_CHUNKS 4

From looking through the code it appears that this is actually the
maximum number of chunks. Should this be renamed from PRELOAD to MAX?

> diff --git a/fs/composefs/cfs-reader.c b/fs/composefs/cfs-reader.c
> new file mode 100644
> index 000000000000..ad77ef0bd4d4
> --- /dev/null
> +++ b/fs/composefs/cfs-reader.c
> @@ -0,0 +1,958 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * composefs
> + *
> + * Copyright (C) 2021 Giuseppe Scrivano
> + * Copyright (C) 2022 Alexander Larsson
> + *
> + * This file is released under the GPL.
> + */
> +
> +#include "cfs-internals.h"
> +
> +#include <linux/file.h>
> +#include <linux/fsverity.h>
> +#include <linux/pagemap.h>
> +#include <linux/unaligned/packed_struct.h>
> +
> +struct cfs_buf {
> +	struct page *page;
> +	void *base;
> +};
> +
> +#define CFS_VDATA_BUF_INIT                                                     \
> +	{                                                                      \
> +		NULL, NULL                                                     \
> +	}

Does this really save much in the 4 places it's used below like this:

struct cfs_buf vdata_buf = CFS_VDATA_BUF_INIT;

This seems just as simple:

struct cfs_buf vdata_buf = { NULL, NULL };

> +
> +static void cfs_buf_put(struct cfs_buf *buf)
> +{
> +	if (buf->page) {
> +		if (buf->base)
> +			kunmap(buf->page);
> +		put_page(buf->page);
> +		buf->base = NULL;
> +		buf->page = NULL;
> +	}
> +}
> +
> +static void *cfs_get_buf(struct cfs_context_s *ctx, u64 offset, u32 size,
> +			 struct cfs_buf *buf)
> +{
> +	u64 index = offset >> PAGE_SHIFT;
> +	u32 page_offset = offset & (PAGE_SIZE - 1);
> +	struct page *page = buf->page;
> +	struct inode *inode = ctx->descriptor->f_inode;
> +	struct address_space *const mapping = inode->i_mapping;

Put in reverse Christmas tree order where possible. I won't call out the
other places below.

> +
> +	if (offset > ctx->descriptor_len)
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	if ((offset + size < offset) || (offset + size > ctx->descriptor_len))
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	if (size > PAGE_SIZE)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (PAGE_SIZE - page_offset < size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!page || page->index != index) {
> +		cfs_buf_put(buf);
> +
> +		page = read_cache_page(mapping, index, NULL, NULL);
> +		if (IS_ERR(page))
> +			return page;
> +
> +		buf->page = page;
> +		buf->base = kmap(page);
> +	}
> +
> +	return buf->base + page_offset;
> +}
> +
> +static void *cfs_read_data(struct cfs_context_s *ctx, u64 offset, u64 size,
> +			   u8 *dest)
> +{
> +	size_t copied;
> +	loff_t pos = offset;
> +
> +	if (offset > ctx->descriptor_len)
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	if ((offset + size < offset) || (offset + size > ctx->descriptor_len))
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	copied = 0;
> +	while (copied < size) {
> +		ssize_t bytes;
> +
> +		bytes = kernel_read(ctx->descriptor, dest + copied,
> +				    size - copied, &pos);
> +		if (bytes < 0)
> +			return ERR_PTR(bytes);
> +		if (bytes == 0)
> +			return ERR_PTR(-EINVAL);
> +
> +		copied += bytes;
> +	}
> +
> +	if (copied != size)
> +		return ERR_PTR(-EFSCORRUPTED);
> +	return dest;
> +}
> +
> +int cfs_init_ctx(const char *descriptor_path, const u8 *required_digest,
> +		 struct cfs_context_s *ctx_out)
> +{
> +	struct cfs_header_s *header;
> +	struct file *descriptor;
> +	loff_t i_size;
> +	u8 verity_digest[FS_VERITY_MAX_DIGEST_SIZE];
> +	enum hash_algo verity_algo;
> +	struct cfs_context_s ctx;
> +	int res;
> +
> +	descriptor = filp_open(descriptor_path, O_RDONLY, 0);
> +	if (IS_ERR(descriptor))
> +		return PTR_ERR(descriptor);
> +
> +	if (required_digest) {
> +		res = fsverity_get_digest(d_inode(descriptor->f_path.dentry),
> +					  verity_digest, &verity_algo);
> +		if (res < 0) {
> +			pr_err("ERROR: composefs descriptor has no fs-verity digest\n");
> +			goto fail;
> +		}
> +		if (verity_algo != HASH_ALGO_SHA256 ||
> +		    memcmp(required_digest, verity_digest,
> +			   SHA256_DIGEST_SIZE) != 0) {

Move this up a line with memcmp() since line lengths can now be 100
characters. I'm not going to call out the other places in this patch.

> +			pr_err("ERROR: composefs descriptor has wrong fs-verity digest\n");
> +			res = -EINVAL;
> +			goto fail;
> +		}
> +	}
> +
> +	i_size = i_size_read(file_inode(descriptor));
> +	if (i_size <=
> +	    (sizeof(struct cfs_header_s) + sizeof(struct cfs_inode_s))) {
> +		res = -EINVAL;
> +		goto fail;
> +	}
> +
> +	/* Need this temporary ctx for cfs_read_data() */
> +	ctx.descriptor = descriptor;
> +	ctx.descriptor_len = i_size;
> +
> +	header = cfs_read_data(&ctx, 0, sizeof(struct cfs_header_s),
> +			       (u8 *)&ctx.header);
> +	if (IS_ERR(header)) {
> +		res = PTR_ERR(header);
> +		goto fail;
> +	}
> +	header->magic = cfs_u32_from_file(header->magic);
> +	header->data_offset = cfs_u64_from_file(header->data_offset);
> +	header->root_inode = cfs_u64_from_file(header->root_inode);

Should the cpu to little endian conversion occur in cfs_read_data()?

> +
> +	if (header->magic != CFS_MAGIC ||
> +	    header->data_offset > ctx.descriptor_len ||
> +	    sizeof(struct cfs_header_s) + header->root_inode >
> +		    ctx.descriptor_len) {
> +		res = -EINVAL;

Should this be -EFSCORRUPTED?

> +		goto fail;
> +	}
> +
> +	*ctx_out = ctx;
> +	return 0;
> +
> +fail:
> +	fput(descriptor);
> +	return res;
> +}
> +
> +void cfs_ctx_put(struct cfs_context_s *ctx)
> +{
> +	if (ctx->descriptor) {
> +		fput(ctx->descriptor);
> +		ctx->descriptor = NULL;
> +	}
> +}
> +
> +static void *cfs_get_inode_data(struct cfs_context_s *ctx, u64 offset, u64 size,
> +				u8 *dest)
> +{
> +	return cfs_read_data(ctx, offset + sizeof(struct cfs_header_s), size,
> +			     dest);
> +}
> +
> +static void *cfs_get_inode_data_max(struct cfs_context_s *ctx, u64 offset,
> +				    u64 max_size, u64 *read_size, u8 *dest)
> +{
> +	u64 remaining = ctx->descriptor_len - sizeof(struct cfs_header_s);
> +	u64 size;
> +
> +	if (offset > remaining)
> +		return ERR_PTR(-EINVAL);
> +	remaining -= offset;
> +
> +	/* Read at most remaining bytes, and no more than max_size */
> +	size = min(remaining, max_size);
> +	*read_size = size;
> +
> +	return cfs_get_inode_data(ctx, offset, size, dest);
> +}
> +
> +static void *cfs_get_inode_payload_w_len(struct cfs_context_s *ctx,
> +					 u32 payload_length, u64 index,
> +					 u8 *dest, u64 offset, size_t len)
> +{
> +	/* Payload is stored before the inode, check it fits */
> +	if (payload_length > index)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (offset > payload_length)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (offset + len > payload_length)
> +		return ERR_PTR(-EINVAL);
> +
> +	return cfs_get_inode_data(ctx, index - payload_length + offset, len,
> +				  dest);
> +}
> +
> +static void *cfs_get_inode_payload(struct cfs_context_s *ctx,
> +				   struct cfs_inode_s *ino, u64 index, u8 *dest)
> +{
> +	return cfs_get_inode_payload_w_len(ctx, ino->payload_length, index,
> +					   dest, 0, ino->payload_length);
> +}
> +
> +static void *cfs_get_vdata_buf(struct cfs_context_s *ctx, u64 offset, u32 len,
> +			       struct cfs_buf *buf)
> +{
> +	if (offset > ctx->descriptor_len - ctx->header.data_offset)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (len > ctx->descriptor_len - ctx->header.data_offset - offset)
> +		return ERR_PTR(-EINVAL);

It appears that these same checks are already done in cfs_get_buf().

> +
> +	return cfs_get_buf(ctx, ctx->header.data_offset + offset, len, buf);
> +}
> +
> +static u32 cfs_read_u32(u8 **data)
> +{
> +	u32 v = cfs_u32_from_file(__get_unaligned_cpu32(*data));
> +	*data += sizeof(u32);
> +	return v;
> +}
> +
> +static u64 cfs_read_u64(u8 **data)
> +{
> +	u64 v = cfs_u64_from_file(__get_unaligned_cpu64(*data));
> +	*data += sizeof(u64);
> +	return v;
> +}
> +
> +struct cfs_inode_s *cfs_get_ino_index(struct cfs_context_s *ctx, u64 index,
> +				      struct cfs_inode_s *ino)
> +{
> +	u64 offset = index;
> +	/* Buffer that fits the maximal encoded size: */
> +	u8 buffer[sizeof(struct cfs_inode_s)];
> +	u64 read_size;
> +	u64 inode_size;
> +	u8 *data;
> +
> +	data = cfs_get_inode_data_max(ctx, offset, sizeof(buffer), &read_size,
> +				      buffer);
> +	if (IS_ERR(data))
> +		return ERR_CAST(data);
> +
> +	/* Need to fit at least flags to decode */
> +	if (read_size < sizeof(u32))
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	memset(ino, 0, sizeof(struct cfs_inode_s));

sizeof(*ino)

> +	ino->flags = cfs_read_u32(&data);
> +
> +	inode_size = cfs_inode_encoded_size(ino->flags);

Should CFS_INODE_FLAGS_DIGEST_FROM_PAYLOAD also be accounted for in
cfs_inode_encoded_size()?

Also, cfs_inode_encoded_size() is only used here so can be brought into
this file.

> +	/* Shouldn't happen, but lets check */
> +	if (inode_size > sizeof(buffer))
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, PAYLOAD))
> +		ino->payload_length = cfs_read_u32(&data);
> +	else
> +		ino->payload_length = 0;
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, MODE))
> +		ino->st_mode = cfs_read_u32(&data);
> +	else
> +		ino->st_mode = CFS_INODE_DEFAULT_MODE;
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, NLINK)) {
> +		ino->st_nlink = cfs_read_u32(&data);
> +	} else {
> +		if ((ino->st_mode & S_IFMT) == S_IFDIR)
> +			ino->st_nlink = CFS_INODE_DEFAULT_NLINK_DIR;
> +		else
> +			ino->st_nlink = CFS_INODE_DEFAULT_NLINK;
> +	}
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, UIDGID)) {
> +		ino->st_uid = cfs_read_u32(&data);
> +		ino->st_gid = cfs_read_u32(&data);
> +	} else {
> +		ino->st_uid = CFS_INODE_DEFAULT_UIDGID;
> +		ino->st_gid = CFS_INODE_DEFAULT_UIDGID;
> +	}
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, RDEV))
> +		ino->st_rdev = cfs_read_u32(&data);
> +	else
> +		ino->st_rdev = CFS_INODE_DEFAULT_RDEV;
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, TIMES)) {
> +		ino->st_mtim.tv_sec = cfs_read_u64(&data);
> +		ino->st_ctim.tv_sec = cfs_read_u64(&data);
> +	} else {
> +		ino->st_mtim.tv_sec = CFS_INODE_DEFAULT_TIMES;
> +		ino->st_ctim.tv_sec = CFS_INODE_DEFAULT_TIMES;
> +	}
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, TIMES_NSEC)) {
> +		ino->st_mtim.tv_nsec = cfs_read_u32(&data);
> +		ino->st_ctim.tv_nsec = cfs_read_u32(&data);
> +	} else {
> +		ino->st_mtim.tv_nsec = 0;
> +		ino->st_ctim.tv_nsec = 0;
> +	}
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, LOW_SIZE))
> +		ino->st_size = cfs_read_u32(&data);
> +	else
> +		ino->st_size = 0;
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, HIGH_SIZE))
> +		ino->st_size += (u64)cfs_read_u32(&data) << 32;
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, XATTRS)) {
> +		ino->xattrs.off = cfs_read_u64(&data);
> +		ino->xattrs.len = cfs_read_u32(&data);
> +	} else {
> +		ino->xattrs.off = 0;
> +		ino->xattrs.len = 0;
> +	}
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, DIGEST)) {
> +		memcpy(ino->digest, data, SHA256_DIGEST_SIZE);
> +		data += 32;
> +	}
> +
> +	return ino;
> +}
> +
> +struct cfs_inode_s *cfs_get_root_ino(struct cfs_context_s *ctx,
> +				     struct cfs_inode_s *ino_buf, u64 *index)

Second line is misaligned.

> +{
> +	u64 root_ino = ctx->header.root_inode;
> +
> +	*index = root_ino;
> +	return cfs_get_ino_index(ctx, root_ino, ino_buf);
> +}
> +
> +static int cfs_get_digest(struct cfs_context_s *ctx, struct cfs_inode_s *ino,
> +			  const char *payload,
> +			  u8 digest_out[SHA256_DIGEST_SIZE])
> +{
> +	int r;
> +
> +	if (CFS_INODE_FLAG_CHECK(ino->flags, DIGEST)) {
> +		memcpy(digest_out, ino->digest, SHA256_DIGEST_SIZE);
> +		return 1;
> +	}
> +
> +	if (payload && CFS_INODE_FLAG_CHECK(ino->flags, DIGEST_FROM_PAYLOAD)) {
> +		r = cfs_digest_from_payload(payload, ino->payload_length,
> +					    digest_out);
> +		if (r < 0)
> +			return r;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool cfs_validate_filename(const char *name, size_t name_len)
> +{
> +	if (name_len == 0)
> +		return false;
> +
> +	if (name_len == 1 && name[0] == '.')
> +		return false;
> +
> +	if (name_len == 2 && name[0] == '.' && name[1] == '.')

Can strcmp() be used here?

> +		return false;
> +
> +	if (memchr(name, '/', name_len))
> +		return false;
> +
> +	return true;
> +}
> +
> +static struct cfs_dir_s *cfs_dir_read_chunk_header(struct cfs_context_s *ctx,
> +						   size_t payload_length,
> +						   u64 index, u8 *chunk_buf,
> +						   size_t chunk_buf_size,
> +						   size_t max_n_chunks)
> +{
> +	size_t n_chunks, i;
> +	struct cfs_dir_s *dir;
> +
> +	/* Payload and buffer should be large enough to fit the n_chunks */
> +	if (payload_length < sizeof(struct cfs_dir_s) ||
> +	    chunk_buf_size < sizeof(struct cfs_dir_s))
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	/* Make sure we fit max_n_chunks in buffer before reading it */
> +	if (chunk_buf_size < cfs_dir_size(max_n_chunks))
> +		return ERR_PTR(-EINVAL);
> +
> +	dir = cfs_get_inode_payload_w_len(ctx, payload_length, index, chunk_buf,
> +					  0,
> +					  min(chunk_buf_size, payload_length));
> +	if (IS_ERR(dir))
> +		return ERR_CAST(dir);
> +
> +	n_chunks = cfs_u32_from_file(dir->n_chunks);
> +	dir->n_chunks = n_chunks;
> +
> +	/* Don't support n_chunks == 0, the canonical version of that is payload_length == 0 */
> +	if (n_chunks == 0)
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	if (payload_length != cfs_dir_size(n_chunks))
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	max_n_chunks = min(n_chunks, max_n_chunks);
> +
> +	/* Verify data (up to max_n_chunks) */
> +	for (i = 0; i < max_n_chunks; i++) {
> +		struct cfs_dir_chunk_s *chunk = &dir->chunks[i];
> +
> +		chunk->n_dentries = cfs_u16_from_file(chunk->n_dentries);
> +		chunk->chunk_size = cfs_u16_from_file(chunk->chunk_size);
> +		chunk->chunk_offset = cfs_u64_from_file(chunk->chunk_offset);
> +
> +		if (chunk->chunk_size <
> +		    sizeof(struct cfs_dentry_s) * chunk->n_dentries)
> +			return ERR_PTR(-EFSCORRUPTED);
> +
> +		if (chunk->chunk_size > CFS_MAX_DIR_CHUNK_SIZE)
> +			return ERR_PTR(-EFSCORRUPTED);
> +
> +		if (chunk->n_dentries == 0)
> +			return ERR_PTR(-EFSCORRUPTED);
> +
> +		if (chunk->chunk_size == 0)
> +			return ERR_PTR(-EFSCORRUPTED);
> +
> +		if (chunk->chunk_offset >
> +		    ctx->descriptor_len - ctx->header.data_offset)
> +			return ERR_PTR(-EFSCORRUPTED);
> +	}
> +
> +	return dir;
> +}
> +
> +static char *cfs_dup_payload_path(struct cfs_context_s *ctx,
> +				  struct cfs_inode_s *ino, u64 index)
> +{
> +	const char *v;
> +	u8 *path;
> +
> +	if ((ino->st_mode & S_IFMT) != S_IFREG &&
> +	    (ino->st_mode & S_IFMT) != S_IFLNK) {
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (ino->payload_length == 0 || ino->payload_length > PATH_MAX)
> +		return ERR_PTR(-EFSCORRUPTED);
> +
> +	path = kmalloc(ino->payload_length + 1, GFP_KERNEL);
> +	if (!path)
> +		return ERR_PTR(-ENOMEM);
> +
> +	v = cfs_get_inode_payload(ctx, ino, index, path);
> +	if (IS_ERR(v)) {
> +		kfree(path);
> +		return ERR_CAST(v);
> +	}
> +
> +	/* zero terminate */
> +	path[ino->payload_length] = 0;
> +
> +	return (char *)path;
> +}
> +
> +int cfs_init_inode_data(struct cfs_context_s *ctx, struct cfs_inode_s *ino,
> +			u64 index, struct cfs_inode_data_s *inode_data)
> +{
> +	u8 buf[cfs_dir_size(CFS_N_PRELOAD_DIR_CHUNKS)];
> +	struct cfs_dir_s *dir;
> +	int ret = 0;
> +	size_t i;
> +	char *path_payload = NULL;
> +
> +	inode_data->payload_length = ino->payload_length;
> +
> +	if ((ino->st_mode & S_IFMT) != S_IFDIR || ino->payload_length == 0) {
> +		inode_data->n_dir_chunks = 0;
> +	} else {
> +		u32 n_chunks;
> +
> +		dir = cfs_dir_read_chunk_header(ctx, ino->payload_length, index,
> +						buf, sizeof(buf),
> +						CFS_N_PRELOAD_DIR_CHUNKS);
> +		if (IS_ERR(dir))
> +			return PTR_ERR(dir);
> +
> +		n_chunks = dir->n_chunks;
> +		inode_data->n_dir_chunks = n_chunks;
> +
> +		for (i = 0; i < n_chunks && i < CFS_N_PRELOAD_DIR_CHUNKS; i++)
> +			inode_data->preloaded_dir_chunks[i] = dir->chunks[i];
> +	}
> +
> +	if ((ino->st_mode & S_IFMT) == S_IFLNK ||
> +	    ((ino->st_mode & S_IFMT) == S_IFREG && ino->payload_length > 0)) {
> +		path_payload = cfs_dup_payload_path(ctx, ino, index);
> +		if (IS_ERR(path_payload)) {
> +			ret = PTR_ERR(path_payload);
> +			goto fail;
> +		}
> +	}
> +	inode_data->path_payload = path_payload;
> +
> +	ret = cfs_get_digest(ctx, ino, path_payload, inode_data->digest);
> +	if (ret < 0)
> +		goto fail;
> +
> +	inode_data->has_digest = ret != 0;

Can you do 'has_digest = inode_data->digest != NULL;' to get rid of the
need for return 1 in cfs_get_digest().

> +
> +	inode_data->xattrs_offset = ino->xattrs.off;
> +	inode_data->xattrs_len = ino->xattrs.len;
> +
> +	if (inode_data->xattrs_len != 0) {
> +		/* Validate xattr size */
> +		if (inode_data->xattrs_len <
> +			    sizeof(struct cfs_xattr_header_s) ||
> +		    inode_data->xattrs_len > CFS_MAX_XATTRS_SIZE) {
> +			ret = -EFSCORRUPTED;
> +			goto fail;
> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	cfs_inode_data_put(inode_data);
> +	return ret;
> +}
> +
> +void cfs_inode_data_put(struct cfs_inode_data_s *inode_data)
> +{
> +	inode_data->n_dir_chunks = 0;
> +	kfree(inode_data->path_payload);
> +	inode_data->path_payload = NULL;
> +}
> +
> +ssize_t cfs_list_xattrs(struct cfs_context_s *ctx,
> +			struct cfs_inode_data_s *inode_data, char *names,
> +			size_t size)
> +{
> +	u8 *data, *data_end;
> +	size_t n_xattrs = 0, i;
> +	ssize_t copied = 0;
> +	const struct cfs_xattr_header_s *xattrs;
> +	struct cfs_buf vdata_buf = CFS_VDATA_BUF_INIT;
> +
> +	if (inode_data->xattrs_len == 0)
> +		return 0;
> +
> +	/* xattrs_len basic size req was verified in cfs_init_inode_data */
> +
> +	xattrs = cfs_get_vdata_buf(ctx, inode_data->xattrs_offset,
> +				   inode_data->xattrs_len, &vdata_buf);
> +	if (IS_ERR(xattrs))
> +		return PTR_ERR(xattrs);
> +
> +	n_xattrs = cfs_u16_from_file(xattrs->n_attr);
> +
> +	/* Verify that array fits */
> +	if (inode_data->xattrs_len < cfs_xattr_header_size(n_xattrs)) {
> +		copied = -EFSCORRUPTED;
> +		goto exit;
> +	}
> +
> +	data = ((u8 *)xattrs) + cfs_xattr_header_size(n_xattrs);
> +	data_end = ((u8 *)xattrs) + inode_data->xattrs_len;
> +
> +	for (i = 0; i < n_xattrs; i++) {
> +		const struct cfs_xattr_element_s *e = &xattrs->attr[i];
> +		u16 this_key_len = cfs_u16_from_file(e->key_length);
> +		u16 this_value_len = cfs_u16_from_file(e->value_length);
> +		const char *this_key, *this_value;
> +
> +		if (this_key_len > XATTR_NAME_MAX ||
> +		    /* key and data needs to fit in data */
> +		    data_end - data < this_key_len + this_value_len) {
> +			copied = -EFSCORRUPTED;
> +			goto exit;
> +		}
> +
> +		this_key = data;
> +		this_value = data + this_key_len;
> +		data += this_key_len + this_value_len;
> +
> +		if (size) {
> +			if (size - copied < this_key_len + 1) {
> +				copied = -E2BIG;
> +				goto exit;
> +			}
> +
> +			memcpy(names + copied, this_key, this_key_len);
> +			names[copied + this_key_len] = '\0';
> +		}
> +
> +		copied += this_key_len + 1;
> +	}
> +
> +exit:
> +	cfs_buf_put(&vdata_buf);
> +
> +	return copied;
> +}
> +
> +int cfs_get_xattr(struct cfs_context_s *ctx,
> +		  struct cfs_inode_data_s *inode_data, const char *name,
> +		  void *value, size_t size)
> +{
> +	size_t name_len = strlen(name);
> +	size_t n_xattrs = 0, i;
> +	struct cfs_xattr_header_s *xattrs;
> +	u8 *data, *data_end;
> +	struct cfs_buf vdata_buf = CFS_VDATA_BUF_INIT;
> +	int res;
> +
> +	if (inode_data->xattrs_len == 0)
> +		return -ENODATA;
> +
> +	/* xattrs_len basic size req was verified in cfs_init_inode_data */
> +
> +	xattrs = cfs_get_vdata_buf(ctx, inode_data->xattrs_offset,
> +				   inode_data->xattrs_len, &vdata_buf);
> +	if (IS_ERR(xattrs))
> +		return PTR_ERR(xattrs);
> +
> +	n_xattrs = cfs_u16_from_file(xattrs->n_attr);
> +
> +	/* Verify that array fits */
> +	if (inode_data->xattrs_len < cfs_xattr_header_size(n_xattrs)) {
> +		res = -EFSCORRUPTED;
> +		goto exit;
> +	}
> +
> +	data = ((u8 *)xattrs) + cfs_xattr_header_size(n_xattrs);
> +	data_end = ((u8 *)xattrs) + inode_data->xattrs_len;
> +
> +	for (i = 0; i < n_xattrs; i++) {
> +		const struct cfs_xattr_element_s *e = &xattrs->attr[i];
> +		u16 this_key_len = cfs_u16_from_file(e->key_length);
> +		u16 this_value_len = cfs_u16_from_file(e->value_length);
> +		const char *this_key, *this_value;
> +
> +		if (this_key_len > XATTR_NAME_MAX ||
> +		    /* key and data needs to fit in data */
> +		    data_end - data < this_key_len + this_value_len) {
> +			res = -EFSCORRUPTED;
> +			goto exit;
> +		}
> +
> +		this_key = data;
> +		this_value = data + this_key_len;
> +		data += this_key_len + this_value_len;
> +
> +		if (this_key_len != name_len ||
> +		    memcmp(this_key, name, name_len) != 0)
> +			continue;
> +
> +		if (size > 0) {
> +			if (size < this_value_len) {
> +				res = -E2BIG;
> +				goto exit;
> +			}
> +			memcpy(value, this_value, this_value_len);
> +		}
> +
> +		res = this_value_len;
> +		goto exit;
> +	}
> +
> +	res = -ENODATA;
> +
> +exit:
> +	return res;
> +}
> +
> +static struct cfs_dir_s *
> +cfs_dir_read_chunk_header_alloc(struct cfs_context_s *ctx, u64 index,
> +				struct cfs_inode_data_s *inode_data)
> +{
> +	size_t chunk_buf_size = cfs_dir_size(inode_data->n_dir_chunks);
> +	u8 *chunk_buf;
> +	struct cfs_dir_s *dir;
> +
> +	chunk_buf = kmalloc(chunk_buf_size, GFP_KERNEL);
> +	if (!chunk_buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dir = cfs_dir_read_chunk_header(ctx, inode_data->payload_length, index,
> +					chunk_buf, chunk_buf_size,
> +					inode_data->n_dir_chunks);
> +	if (IS_ERR(dir)) {
> +		kfree(chunk_buf);
> +		return ERR_CAST(dir);
> +	}
> +
> +	return dir;
> +}
> +
> +static struct cfs_dir_chunk_s *
> +cfs_dir_get_chunk_info(struct cfs_context_s *ctx, u64 index,
> +		       struct cfs_inode_data_s *inode_data, void **chunks_buf)
> +{
> +	struct cfs_dir_s *full_dir;
> +
> +	if (inode_data->n_dir_chunks <= CFS_N_PRELOAD_DIR_CHUNKS) {
> +		*chunks_buf = NULL;
> +		return inode_data->preloaded_dir_chunks;
> +	}
> +
> +	full_dir = cfs_dir_read_chunk_header_alloc(ctx, index, inode_data);
> +	if (IS_ERR(full_dir))
> +		return ERR_CAST(full_dir);
> +
> +	*chunks_buf = full_dir;
> +	return full_dir->chunks;
> +}
> +
> +static inline int memcmp2(const void *a, const size_t a_size, const void *b,
> +			  size_t b_size)
> +{
> +	size_t common_size = min(a_size, b_size);
> +	int res;
> +
> +	res = memcmp(a, b, common_size);
> +	if (res != 0 || a_size == b_size)
> +		return res;
> +
> +	return a_size < b_size ? -1 : 1;

This function appears to be used only in one place below. It doesn't
seem like it matters for the common_size. Can this just be dropped and
use memcmp()?

Brian

