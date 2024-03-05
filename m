Return-Path: <linux-fsdevel+bounces-13653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C58B8726F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 19:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9791C2356F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A424215;
	Tue,  5 Mar 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXMB/EMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA6241E3;
	Tue,  5 Mar 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664791; cv=none; b=jPiKLzFOJJ2PJ8yRlwYfixNwxTtn/POxbAWRpwnF1EsNMbjMj9DfcJSIbRaodIGkeucKi5AQa4HCxH9ICAIy2M0Kd2rO/YuzSS7FZTdxpaZtZ7MKACDEG5aY0aWxvHJf2w58IdyjtAk+CLg2mL5gPlEqoCadiqQnfHwrmN9QbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664791; c=relaxed/simple;
	bh=RlxotYmw5rWlPllP+/fOtrGSdBEVKU7H7JyM3ifCs5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxutSvbm118kJqEuEoPhulha2exl5bwC+Gj2OmMaJz3OP29FnIoCMjOkRQlVJm3bZ5MUFjISuAQD7gmr3uZ9f8Tu7R84vK0ZVruwCfxWTLIOS5pPn35z8JTTHkAycgKEG70pqcxaOgdyn0c4wfs/pI0c7oG6cMX5r51JkYZCuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZXMB/EMq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lSJrdvz86yrqh9l2Sx5QNPyc/+eHatak3sGtDFJpvhU=; b=ZXMB/EMqHF69Zw+0R25mw2xsv3
	14Q1Zh9G9VfOXmAXq9lj2qQJQIEc+YuVsBRVwOJit0trAg3TizjxnoBiGWN7x8tOeYeKDknBJs3kF
	1zF6186bHVPfXJMKYiOKozwfArFTUJZwQkIzhzznAn2CpLPbwFiIAdhG7OjzsyFn7xFvBhHtXcJ7T
	7riYI8E286dVpnD36IS6N76dIlKZ1UEAYoAZ73hJDromBqBNI/V5I2wtjMghLwuj7QCZ3fCVodWzA
	kTSzm9D7tEkJjKiRsMclElIWVUxSMJZj7F22NhQMpptCBrm4mDxbl2DHbsJryG2vT4VgoKXiU66co
	SYBaV+Vg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhZuW-000000052HO-2ZW8;
	Tue, 05 Mar 2024 18:53:08 +0000
Date: Tue, 5 Mar 2024 18:53:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: reiserfs-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] reiserfs: Convert to writepages
Message-ID: <ZedqFFiVyntHkxLZ@casper.infradead.org>
References: <20240305185208.1200166-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305185208.1200166-1-willy@infradead.org>


Apologies, copy-and-paste error on the email address.

On Tue, Mar 05, 2024 at 06:52:05PM +0000, Matthew Wilcox (Oracle) wrote:
> Use buffer_migrate_folio to handle folio migration instead of writing
> out dirty pages and reading them back in again.  Use writepages to write
> out folios more efficiently.  We now only do that wait_on_write_block
> check once per call to writepages instead of once per page.  It would be
> possible to do one transaction per writeback run, but that's a bit of a
> big change to do to this old filesystem, so leave it as one transaction
> per folio (and leave reiserfs supporting only one page per folio).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/reiserfs/inode.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 1d825459ee6e..c1daedc50f4c 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -2503,8 +2503,8 @@ static int map_block_for_writepage(struct inode *inode,
>   * start/recovery path as __block_write_full_folio, along with special
>   * code to handle reiserfs tails.
>   */
> -static int reiserfs_write_full_folio(struct folio *folio,
> -				    struct writeback_control *wbc)
> +static int reiserfs_write_folio(struct folio *folio,
> +		struct writeback_control *wbc, void *data)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	unsigned long end_index = inode->i_size >> PAGE_SHIFT;
> @@ -2721,12 +2721,11 @@ static int reiserfs_read_folio(struct file *f, struct folio *folio)
>  	return block_read_full_folio(folio, reiserfs_get_block);
>  }
>  
> -static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
> +static int reiserfs_writepages(struct address_space *mapping,
> +		struct writeback_control *wbc)
>  {
> -	struct folio *folio = page_folio(page);
> -	struct inode *inode = folio->mapping->host;
> -	reiserfs_wait_on_write_block(inode->i_sb);
> -	return reiserfs_write_full_folio(folio, wbc);
> +	reiserfs_wait_on_write_block(mapping->host->i_sb);
> +	return write_cache_pages(mapping, wbc, reiserfs_write_folio, NULL);
>  }
>  
>  static void reiserfs_truncate_failed_write(struct inode *inode)
> @@ -3405,7 +3404,7 @@ int reiserfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  }
>  
>  const struct address_space_operations reiserfs_address_space_operations = {
> -	.writepage = reiserfs_writepage,
> +	.writepages = reiserfs_writepages,
>  	.read_folio = reiserfs_read_folio,
>  	.readahead = reiserfs_readahead,
>  	.release_folio = reiserfs_release_folio,
> @@ -3415,4 +3414,5 @@ const struct address_space_operations reiserfs_address_space_operations = {
>  	.bmap = reiserfs_aop_bmap,
>  	.direct_IO = reiserfs_direct_IO,
>  	.dirty_folio = reiserfs_dirty_folio,
> +	.migrate_folio = buffer_migrate_folio,
>  };
> -- 
> 2.43.0
> 

