Return-Path: <linux-fsdevel+bounces-73179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5FFD10388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 02:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC7D302F6A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 01:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8859B47A6B;
	Mon, 12 Jan 2026 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+8mjHWC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254BCA5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768179769; cv=none; b=sS88b14nJUxW9PkOyQ6fwlFDSUP+J0rNPEKt2L9jraFlnner8iAGdxNJtYO9Xxfpi9GZkCq1X0QX3e4kAItLOC8bit8XlzZUdc+yiNLzmliuKidPDGPh1eW4srBFn3UAslaqptnFatrWeEZGL3FoVl2cynekW5MoHRwDmJsK/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768179769; c=relaxed/simple;
	bh=a3jueOmJgOzgdKLB9j/N2iyZkyJk2mut/X4NQcziptM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UbYGYOQ6rDdpMN9hC92B609SPXOl2JiKNY5yPBvcVttWcP5+0zKLQpZhm1liheErSXD+RMPKJealQoEcPjzp+UCmcxFlCY+o8q4Ikp6t8pvAZMHBPfNYYdqqE8Gmhwlo2TJDjymYeR4eCwcppav9NdIIZO4CBXyKwK/txLT0kkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+8mjHWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E1C4CEF7;
	Mon, 12 Jan 2026 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768179768;
	bh=a3jueOmJgOzgdKLB9j/N2iyZkyJk2mut/X4NQcziptM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=u+8mjHWCon1SEzSLZW2hoFcGQ1WDLGzPyX/usaQyM4lhUBv8xa43Ow4FgBGuT2T0m
	 jC/f7pA2l7gTwUATodJb4qtCz43wSQquMZD/SeSfHsBM4EKEaFfFiHyGx+LsHEUx1D
	 9X3t4cvY7/IWefAVR6yebA5Y2UbK/xlZvAHkJrHwK1RsxYvyjHKtp75AhDnelmt4Di
	 TesPlyRPY0ZTfrg23DOl38nvZ1hBhByKZopAVpXpuozPAujOuXjBXdL6Tkq3GO2PGM
	 /MtgmNgfnjMn38lzffD9qp8Bk04eenDALqgzte5KbkjgMANQ66NfmMrMM1873ZA9D/
	 Fk7xK0V7o8BrQ==
Message-ID: <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
Date: Mon, 12 Jan 2026 09:02:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
To: Nanzhe Zhao <nzzhao@126.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260111100941.119765-2-nzzhao@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/2026 6:09 PM, Nanzhe Zhao wrote:
> f2fs_read_data_large_folio() can build a single read BIO across multiple
> folios during readahead. If a folio ends up having none of its subpages
> added to the BIO (e.g. all subpages are zeroed / treated as holes), it
> will never be seen by f2fs_finish_read_bio(), so folio_end_read() is
> never called. This leaves the folio locked and not marked uptodate.
> 
> Track whether the current folio has been added to a BIO via a local
> 'folio_in_bio' bool flag, and when iterating readahead folios, explicitly
> mark the folio uptodate (on success) and unlock it when nothing was added.
> 
> Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
> ---
>   fs/f2fs/data.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f32eb51ccee4..ddabcb1b9882 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2436,6 +2436,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	unsigned nrpages;
>   	struct f2fs_folio_state *ffs;
>   	int ret = 0;
> +	bool folio_in_bio;
> 
>   	if (!IS_IMMUTABLE(inode))
>   		return -EOPNOTSUPP;
> @@ -2451,6 +2452,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	if (!folio)
>   		goto out;
> 
> +	folio_in_bio = false;
>   	index = folio->index;
>   	offset = 0;
>   	ffs = NULL;
> @@ -2536,6 +2538,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   					offset << PAGE_SHIFT))
>   			goto submit_and_realloc;
> 
> +		folio_in_bio = true;
>   		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>   		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
>   				F2FS_BLKSIZE);
> @@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	}
>   	trace_f2fs_read_folio(folio, DATA);
>   	if (rac) {
> +		if (!folio_in_bio) {
> +			if (!ret)

ret should never be true here?

Thanks,

> +				folio_mark_uptodate(folio);
> +			folio_unlock(folio);
> +		}
>   		folio = readahead_folio(rac);
>   		goto next_folio;
>   	}
> --
> 2.34.1
> 


