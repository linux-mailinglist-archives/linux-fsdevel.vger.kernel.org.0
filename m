Return-Path: <linux-fsdevel+bounces-9494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73900841BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 07:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6659A1C234CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ED3381DA;
	Tue, 30 Jan 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="shp+Ntp/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3B381B6;
	Tue, 30 Jan 2024 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595202; cv=none; b=nPoyTGiPTtpIoAJX6AHnefrgi4g3SVVUenW/e7JiztfbSEp0TnZc3fgrpntxAajqz0yGVveBbWZ1RoXrI6EurD/8JLnc0js9ss4vobL3x+akuWI6fqie4Et6MPcUdUsZdVm0qA4swcK/zzpjAmUmibqw4GnkuunMXK6vXxowxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595202; c=relaxed/simple;
	bh=zjQ6yf6RzTZyhb7cdTmUi8VVWbtiL5FkYNucL8jcKLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq1kLizbARI1Evg8SliAT70zOldtQG/XvFveHI8PcPDbfwUEw1wr2gw2IawtySpLGFn7vQyr67gTyp2ZaTjZzvlTknK17Tw9C8pGHJGbKnVyW7exW5M1cGEFctuscqklZ8b0jFpOpkIMFty049wlVd9eTSnRbfTurNwdSeD5+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=shp+Ntp/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RvFiTSeyZH3jejdjN8UpxpNfKxiu5OCZhfTaYIa/XzE=; b=shp+Ntp/EsobLtw4KNsj9JLvna
	HuiGD1GN49Se+uyaY8rYbOFOF+iYeQ5zAsskgDaJi9/Vk4jROrugxvWl2ccFrwHGnqTW5OdrC+z7P
	dHyI8XHw4mS+FC8sxzb7y52/TrEQzBXX4dSxxDB4qlBLOEX0lPipajWT37WrTQEvjZJIeFmHeXWeX
	av1rTiIyI7TKUumi9cLIelUfjALmQWXwSxc/DhamTvhJA7pn+w9Na3GVinljDCZ7bKdCrJE4BsuYF
	b8RvP9rcuFJX4i0IRCetOsduYrpWFyJjtzlN7NBhdC5U6BL9DiybdNJQo7+bzhbx8pLKskLF22Gzh
	rZOqOuKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUhN1-0000000924z-0TAU;
	Tue, 30 Jan 2024 06:13:19 +0000
Date: Tue, 30 Jan 2024 06:13:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Convert to buffered_write_operations
Message-ID: <ZbiTfwyTXKC2XbNM@casper.infradead.org>
References: <20240130055414.2143959-1-willy@infradead.org>
 <20240130055414.2143959-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130055414.2143959-4-willy@infradead.org>

On Tue, Jan 30, 2024 at 05:54:13AM +0000, Matthew Wilcox (Oracle) wrote:
> +++ b/fs/ext4/file.c
> @@ -287,16 +287,24 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  {
>  	ssize_t ret;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> +	const struct buffered_write_operations *ops;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		return -EOPNOTSUPP;
>  
> +	if (ext4_inode_journal_mode(inode))

I forgot to commit --amend.  This line should have been:

+       if (ext4_should_journal_data(inode))

> +		ops = &ext4_journalled_bw_ops;
> +	else if (test_opt(inode->i_sb, DELALLOC))
> +		ops = &ext4_da_bw_ops;
> +	else
> +		ops = &ext4_bw_ops;
> +
>  	inode_lock(inode);
>  	ret = ext4_write_checks(iocb, from);
>  	if (ret <= 0)
>  		goto out;
>  
> -	ret = generic_perform_write(iocb, from);
> +	ret = filemap_perform_write(iocb, from, ops);
>  
>  out:
>  	inode_unlock(inode);

