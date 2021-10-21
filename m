Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FACC4368F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhJURZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhJURZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:25:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28EC061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 10:22:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v8so1215113pfu.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MhWFkmNsOz2GMbhHvZUNdPT4szxTuauUc0ijZpacxzc=;
        b=fCsYEA4piiULbPmLXWp5cJrVtnZQodydlKfpxWfDIzfEtfT4N9in0Ks8XTAtXXBhWI
         BANGToNP1t8i0AEMtPOg7vOgbSQRBpY2IB2FYgWHIIustTpOd0BURTD7mxgAMl6ehqHD
         oWdgDzvAcsJUBKy0RsSn3QMuEjgx29o2WHgfzIhByej+zBq2o1gWGC5z84AvVIDkd5S0
         BCNYmG2kP9Nji2/DzS64IhSRrzFuQkXBe+9B+rdek2ZKx+xRBQ+Nt/ki7mDK48OP1Pox
         drLgzNWthZyKU8LALIvOWEInr0F6JthKgPCESdGPyxfa1fU7Wh8ep60HcjkkmTUkks3w
         UeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MhWFkmNsOz2GMbhHvZUNdPT4szxTuauUc0ijZpacxzc=;
        b=6mfD6/BKfCjGitO1O8twjFtiy4C6GKHdcbdq2McaceQzSr0FRVDZ8mva5XttpC6Q+1
         zgBuxk9lFO2CFKmfLlUvnvgbd8fNUgH9It9EQVZAZ0MZL/cK6jhs1x1XrII7rRMVvGHf
         /Os/uzRn9JLHVhhqNUEKagX2dxLwdKzjklI1owAm1gC/cEv236eo8ranxRveSWcJae6R
         wX3ga9HN90Y+PaVSzIOAuHMYPf2zCS7Bno0BKLOVmMnFdiRU0uNlDOd9s6FxkN+zmeYq
         uK15ySf45ToC1EffbkzH1XPZ8poJk+oy+poC6euYIwD13jjSdR9NYgMEtt9s/vTRm10d
         By1g==
X-Gm-Message-State: AOAM533WQ1n/ybLnfTv4n9MIEzO8cCrhKZEwPa/79P3ueDhu+TOt+PKe
        ruan9BPnAFE1q2IsVUBRd63FYQ==
X-Google-Smtp-Source: ABdhPJzrOWiqDDdaXawJ6nDrTp7jGLnYL0wDUClbjIN+Nj4NLniGPLqV0UqbfBCfMHAVw3+TcMRo9A==
X-Received: by 2002:a05:6a00:9a2:b0:44c:b979:afe3 with SMTP id u34-20020a056a0009a200b0044cb979afe3mr6836039pfg.61.1634836972009;
        Thu, 21 Oct 2021 10:22:52 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::381])
        by smtp.gmail.com with ESMTPSA id e20sm7443916pfv.27.2021.10.21.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:22:51 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:22:50 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 06/10] btrfs-progs: receive: encoded_write fallback
 to explicit decode and write
Message-ID: <YXGh6g4RGvlvj/29@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <06689de6a56f046d5e41525fa12c7af92db478e5.1630515568.git.osandov@fb.com>
 <8ac98c8e-901e-0fc1-2281-27d282486a49@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ac98c8e-901e-0fc1-2281-27d282486a49@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:55:19PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Boris Burkov <boris@bur.io>
> > 
> > +static int decompress_lzo(const char *encoded_data, u64 encoded_len,
> > +			  char *unencoded_data, u64 unencoded_len,
> > +			  unsigned int page_size)
> > +{
> > +	uint32_t total_len;
> > +	size_t in_pos, out_pos;
> > +
> > +	if (encoded_len < 4) {
> > +		error("lzo header is truncated");
> > +		return -EIO;
> > +	}
> > +	memcpy(&total_len, encoded_data, 4);
> > +	total_len = le32toh(total_len);
> > +	if (total_len > encoded_len) {
> > +		error("lzo header is invalid");
> > +		return -EIO;
> > +	}
> > +
> > +	in_pos = 4;
> > +	out_pos = 0;
> > +	while (in_pos < total_len && out_pos < unencoded_len) {
> > +		size_t page_remaining;
> > +		uint32_t src_len;
> > +		lzo_uint dst_len;
> > +		int ret;
> > +
> > +		page_remaining = -in_pos % page_size;
> 
> Why the -in_pos?

in_pos is our position in the encoded data. This calculates how many
bytes are remaining in the page that in_pos current points to.

> > +		if (page_remaining < 4) {
> > +			if (total_len - in_pos <= page_remaining)
> > +				break;
> > +			in_pos += page_remaining;
> > +		}
> > +
> > +		if (total_len - in_pos < 4) {
> > +			error("lzo segment header is truncated");
> > +			return -EIO;
> > +		}
> > +
> > +		memcpy(&src_len, encoded_data + in_pos, 4);
> > +		src_len = le32toh(src_len);
> > +		in_pos += 4;
> > +		if (src_len > total_len - in_pos) {
> > +			error("lzo segment header is invalid");
> > +			return -EIO;
> > +		}
> > +
> > +		dst_len = page_size;
> > +		ret = lzo1x_decompress_safe((void *)(encoded_data + in_pos),
> > +					    src_len,
> > +					    (void *)(unencoded_data + out_pos),
> > +					    &dst_len, NULL);
> > +		if (ret != LZO_E_OK) {
> > +			error("lzo1x_decompress_safe failed: %d", ret);
> > +			return -EIO;
> > +		}
> > +
> > +		in_pos += src_len;
> > +		out_pos += dst_len;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int decompress_and_write(struct btrfs_receive *rctx,
> > +				const char *encoded_data, u64 offset,
> > +				u64 encoded_len, u64 unencoded_file_len,
> > +				u64 unencoded_len, u64 unencoded_offset,
> > +				u32 compression)
> > +{
> > +	int ret = 0;
> > +	size_t pos;
> > +	ssize_t w;
> > +	char *unencoded_data;
> > +	int page_shift;
> > +
> > +	unencoded_data = calloc(unencoded_len, 1);
> > +	if (!unencoded_data) {
> > +		error("allocating space for unencoded data failed: %m");
> > +		return -errno;
> > +	}
> > +
> > +	switch (compression) {
> > +	case BTRFS_ENCODED_IO_COMPRESSION_ZLIB:
> > +		ret = decompress_zlib(rctx, encoded_data, encoded_len,
> > +				      unencoded_data, unencoded_len);
> > +		if (ret)
> > +			goto out;
> > +		break;
> > +	case BTRFS_ENCODED_IO_COMPRESSION_ZSTD:
> > +		ret = decompress_zstd(rctx, encoded_data, encoded_len,
> > +				      unencoded_data, unencoded_len);
> > +		if (ret)
> > +			goto out;
> > +		break;
> > +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_4K:
> > +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_8K:
> > +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_16K:
> > +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_32K:
> > +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_64K:
> > +		page_shift = compression - BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + 12;
> 
> Doesn't this calculation assume page size is 4k, what about arches with
> larger page size (ppc/aarch64), shouldn't that '12' be adjusted?

This is unrelated to the machine page size. It is translating the
BTRFS_ENCODED_IO_COMPRESSION_LZO_* value to the page size used for
compressing the data:

compression | - LZO_4K | + 12 | 1 <<
=====================================
LZO_4K = 3  | 0        | 12   | 4096
LZO_8K = 4  | 1        | 13   | 8192
LZO_16K = 5 | 2        | 14   | 16384
LZO_32K = 6 | 3        | 15   | 32768
LZO_64K = 7 | 4        | 16   | 65536

I'll fix the other comments, thanks.
