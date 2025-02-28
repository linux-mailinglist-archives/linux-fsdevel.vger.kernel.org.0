Return-Path: <linux-fsdevel+bounces-42829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BF9A49223
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 08:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EB516C195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39631CAA9E;
	Fri, 28 Feb 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH+wtRL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D3276D12
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727535; cv=none; b=XehD03aNoXk9Y7wKLZ1C8LyTHAt22l1S907TXOULKDTFfWAAhNVaK1Xbb9WJW9+cLVchNLMj+0pDw4MaFwmYQBAX1LEjD3SQZZfROc/WlYhdXr+j/M9R0oSWDOenjm4zAboqzPxylQ6lQtvbuNvpW3E9gn5oF7Bj6Ja/dy6CYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727535; c=relaxed/simple;
	bh=DaNz3vrr0AWCklzsrYQFRMH1Wufb+iyNrR9fYKDr2+A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LxwA/iRKPj7i7rHtIHkmYqkuSaKdrW1HJvF9EwSSnOSgIBKT5yrfCO1nmzIIEAq/bsb1sS3bhp2L0BgoOtKSBLmC26GBbFSwzn+Z44rvjmx/S9FaBDcwWIYNNj4olwLvqG6CQsolrdUYDajPEl5EzS/XRqt4/ObPUQF5RB7mHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH+wtRL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC57BC4CED6;
	Fri, 28 Feb 2025 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740727534;
	bh=DaNz3vrr0AWCklzsrYQFRMH1Wufb+iyNrR9fYKDr2+A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DH+wtRL0CYx9RZkzaz6UBbWRN89a+0zzp27pGJjl6Z+Es4L5VCxrXOzbCsVJf+3Q+
	 LrDYsaCmdczNtmhO4/UcSq5iP9rSB6adVaFnsRCVniXLxDP0nS6/lTgyjm4YkGKqVB
	 QJwbrT8r6s647xvvabLZ1gH0ZQfSgepNsk5ZhBUIpuJ0Q1GDwfnYnDmY6t6qzzIneu
	 wfGfG+P66dmezcnTA44H7b4/TDgBgf1XWBG3430+2HSaxCE5sPTJhaZnLsJJOOhZqj
	 1Bg9bVRQZHLYcA0QyuZZtshbFIqE5IZwBDitUnhpw7TV8yH5j1d0D2IcfPUImxjVwd
	 1em2Noyw1llYA==
Message-ID: <4dd3fbe6-9a39-4911-9ab1-72f20c83c02c@kernel.org>
Date: Fri, 28 Feb 2025 15:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 20/27] f2fs: Hoist the page_folio() call to the start of
 f2fs_merge_page_bio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-21-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250218055203.591403-21-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/18 13:51, Matthew Wilcox (Oracle) wrote:
> Remove one call to compound_head() and a reference to page->mapping
> by calling page_folio() early on.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/f2fs/data.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d297e9ae6391..fe7fa08b20c7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -888,6 +888,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   	struct bio *bio = *fio->bio;
>   	struct page *page = fio->encrypted_page ?
>   			fio->encrypted_page : fio->page;
> +	struct folio *folio = page_folio(fio->page);
>   
>   	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>   			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))

Minor thing, missed to change below line:

	trace_f2fs_submit_folio_bio(page_folio(page), fio);

can be cleaned up to:

	trace_f2fs_submit_folio_bio(folio, fio);

Thanks,

> @@ -901,8 +902,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   alloc_new:
>   	if (!bio) {
>   		bio = __bio_alloc(fio, BIO_MAX_VECS);
> -		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
> -				page_folio(fio->page)->index, fio, GFP_NOIO);
> +		f2fs_set_bio_crypt_ctx(bio, folio->mapping->host,
> +				folio->index, fio, GFP_NOIO);
>   
>   		add_bio_entry(fio->sbi, bio, page, fio->temp);
>   	} else {
> @@ -911,8 +912,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   	}
>   
>   	if (fio->io_wbc)
> -		wbc_account_cgroup_owner(fio->io_wbc, page_folio(fio->page),
> -					 PAGE_SIZE);
> +		wbc_account_cgroup_owner(fio->io_wbc, folio, folio_size(folio));
>   
>   	inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
>   


