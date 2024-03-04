Return-Path: <linux-fsdevel+bounces-13564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7ED871135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D97A1C2244C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31907D3E8;
	Mon,  4 Mar 2024 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0RTTDEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376327C0B8;
	Mon,  4 Mar 2024 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595569; cv=none; b=Gt9rL5QxGB8F8GMVLCHVFDPlA2fELGZViQH7MUEbok2yhIkE3mj6LcAazW7CIAPVUX4JSHoAZjKqfRCbBzPHaiAFD4CtBYsAEnZKB76xsx7kL0ra+bpHmWkrc8K5aGCE+xXYLL8Jqkluxx9EvSEiwunzzUsp63dXFSxj0W+jEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595569; c=relaxed/simple;
	bh=AGfHjrEdVXmKbi3OhCMHmeeCkz52cPwQAGWc0u6ypCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHOZJI5o1MryDKN/69zACpUAvlMmmIbc/k007BhIxAT8cIK3PC6CErxT9Z2i9ocgDNyFX9jGgdIM3FrJ+avhxXu6MpANVYgIQ60DIGLW3ELPFaMcp69c7JWp/l4YRTKSSdTgQi6BJVt8sMYbIH9lOxf2jMF5iVAEPGIFMjkcymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0RTTDEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D352EC433C7;
	Mon,  4 Mar 2024 23:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595569;
	bh=AGfHjrEdVXmKbi3OhCMHmeeCkz52cPwQAGWc0u6ypCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0RTTDEr6Mjid65RUentJf2uDwOxYZpXt37AadSybwjibdbja56+PVXr87jhGun4O
	 TXL15DcfrD+jhswBovJJ81G4O0xoNC50fwV/a5nVH6e2aUz0b7ks5m7niMt75R+LT5
	 hJNtrKlGRBWbAqiujOemmMMkW69W5WXk1AKAwLoih1HJBKf0/Ib65UZz8L3yO+M3fu
	 9uSvJTa6R3kGmYoIGxo9Fqg8co6JtjzdeIkGc34YosdOV3+HDQFE26boSSBBBmY1lJ
	 IFv+GLihk+iBU6dkLOii10UUv1P+T7XT6utpkM3zsRJNwVX2P5mT/9P25AyiOna9PY
	 iYG1cJ3eK8pEA==
Date: Mon, 4 Mar 2024 15:39:27 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240304233927.GC17145@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-12-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:33PM +0100, Andrey Albershteyn wrote:
> +#ifdef CONFIG_FS_VERITY
> +struct iomap_fsverity_bio {
> +	struct work_struct	work;
> +	struct bio		bio;
> +};

Maybe leave a comment above that mentions that bio must be the last field.

> @@ -471,6 +529,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
>   * iomap_readahead - Attempt to read pages from a file.
>   * @rac: Describes the pages to be read.
>   * @ops: The operations vector for the filesystem.
> + * @wq: Workqueue for post-I/O processing (only need for fsverity)

This should not be here.

> +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
> +
>  static int __init iomap_init(void)
>  {
> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> -			   offsetof(struct iomap_ioend, io_inline_bio),
> -			   BIOSET_NEED_BVECS);
> +	int error;
> +
> +	error = bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
> +			    offsetof(struct iomap_ioend, io_inline_bio),
> +			    BIOSET_NEED_BVECS);
> +#ifdef CONFIG_FS_VERITY
> +	if (error)
> +		return error;
> +
> +	error = bioset_init(&iomap_fsverity_bioset, IOMAP_POOL_SIZE,
> +			    offsetof(struct iomap_fsverity_bio, bio),
> +			    BIOSET_NEED_BVECS);
> +	if (error)
> +		bioset_exit(&iomap_ioend_bioset);
> +#endif
> +	return error;
>  }
>  fs_initcall(iomap_init);

This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
for these bios, regardless of whether they end up being used or not.  When
PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.

How about allocating the pool when it's known it's actually going to be used,
similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
there could be a flag in struct fsverity_operations that says whether filesystem
wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
for any file for the first time since boot, it could call into fs/iomap/ to
initialize the iomap fsverity bioset if needed.

BTW, errors from builtin initcalls such as iomap_init() get ignored.  So the
error handling logic above does not really work as may have been intended.

- Eric

