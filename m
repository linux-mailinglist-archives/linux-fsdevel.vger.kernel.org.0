Return-Path: <linux-fsdevel+bounces-64208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A5BDCD42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942633E0332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6102FE57F;
	Wed, 15 Oct 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0Woxrr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5423126BE;
	Wed, 15 Oct 2025 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512157; cv=none; b=mtKBuLYRSGnfEIqQjCCaTaQ45mgK61FDn1psJbLBrkVnhBU52YdhhQnSwDYsvofpw6UjmOwpyoLTzT9BrBdOLbv4HqZuLL7KykCpBD9OKtemLJCz3Gm6jYXSoAzFrbVZokIVLb5MeJpzSmzao4BTHBHxtIOPIc1bDstJvVLmhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512157; c=relaxed/simple;
	bh=UMOggXsmSPLysxqQ4itPauqV7qt745eUMB/nuFIg2w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8R61S9fnN4+/jpjmNbJo1wa4umjsGFzcVzNIFMIrKhrNHuT1RiUqdYYVuFEmfhj7sDRQVGz+F+ZWUvOLTYVEWyKBMLGDgfqteNPnDUdu2EIstL0nrXT1q+iyl/JhZ9LpNh15tcR89jtE6SptauwC5i1PEe/b+QdFeoEHNJDwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0Woxrr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABADC4CEF9;
	Wed, 15 Oct 2025 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512157;
	bh=UMOggXsmSPLysxqQ4itPauqV7qt745eUMB/nuFIg2w0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o0Woxrr6d4Kjc2IeLhUM//liDCgTmMC8m7u94P0oWpYw5ZABbIAFXouGwSoLw2PWw
	 4KQjKaw5riSZy7EgXgKqDGkEvvolojqRU+OxJ/VAVp+05l+0lzxnQEL9BUJH+IKaM0
	 mnQK9uJXXhnDjcU+tAPck6AavFFL1rNQkArdnlK0VdrUU2q9AWB9XVtnD5UtB1A3yC
	 485ll3gliB5FsLmL/mS1AAUenJWU1qP3BrCK5JebxppZgfn9yiGBJgbTp8Q7pKXz5z
	 HCmsFNOhxhpw71ayascaMj6JwAV+RM4DnpFUls9VqcHz/CnxQwbUoAw5t/UhcXjLtQ
	 sX5HHK1m7lo1A==
Message-ID: <a1671515-4aec-46a0-aff0-75ea8540394c@kernel.org>
Date: Wed, 15 Oct 2025 16:09:13 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 hans.holmberg@wdc.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251015062728.60104-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/15 15:27, Christoph Hellwig wrote:
> The relatively low minimal writeback size of 4MiB leads means that

Removes "leads" in the above.

> written back inodes on rotational media are switched a lot.  Besides
> introducing additional seeks, this also can lead to extreme file
> fragmentation on zoned devices when a lot of files are cached relative
> to the available writeback bandwidth.
> 
> Add a superblock field that allows the file system to override the
> default size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..23f1f10646b7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1583,6 +1583,7 @@ struct super_block {
>  
>  	spinlock_t		s_inode_wblist_lock;
>  	struct list_head	s_inodes_wb;	/* writeback inodes */
> +	unsigned int		s_min_writeback_pages;

Given that writeback_chunk_size() returns a long type, maybe this should be a long ?

>  } __randomize_layout;
>  
>  static inline struct user_namespace *i_user_ns(const struct inode *inode)



-- 
Damien Le Moal
Western Digital Research

