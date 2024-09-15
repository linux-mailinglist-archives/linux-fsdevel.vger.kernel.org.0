Return-Path: <linux-fsdevel+bounces-29400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D47BD979656
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7996D1F21FD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B81C3F33;
	Sun, 15 Sep 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BER7eFtq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645DE55B
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726396845; cv=none; b=Jigxwx23GxjxHDK7h+kn6gYMLsb5H2WOIxnrRQVAUmghn3lkeK6EQF7Ll4Rn4AtUgXFjibJdUK8pWiombYk9+/wUPN6RkRhrJEkoaeogNAqkf0RMUwVExQQA0Jnb4ePZZh6mvX5+yhDL682N22q2QaDSJiMtnmmZa23zGz/JGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726396845; c=relaxed/simple;
	bh=6Rc7DWsaT1k39pwG6my0vxDSPVV2xaCBg92bt1Vg3nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3vAOMIN+vk/KNehgC2PLoQbTgxkgzuU1a93Eb8PTI3pn2bfCRvbkWaSLNf+4AfgfMzl7OUle/yR+qmXS/q9ybfRPxUa13ujcrzPO53liwsnkhKuMnPRyBx8Ep3JqgQVLpDs2OXvJQujJpGZs4gWDdbUbE7RN1njno/DNcY0yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BER7eFtq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9oWw0L1ve3FphXzm1P4wGPdSmqZQ4QHpKd0CSh+cF+o=; b=BER7eFtqKn/4nRL8rffmzWMRsc
	7OtdjUGN2UxKyOYIE80lPA5dS/Hh0njm3o2wZBK6WjnaI/LHO6xn1XJAQ5ULNJzUVtOh/qRSXZ7eS
	4J5CbStQZZ3lLZEFlLijhWK560U06nKZwGM7qBRyEOTYMwh/LgGep6tGsx3DIsOcv5m2MIJkUK+J3
	+PGR6Z3VQ5bfGkfuA1EuS8Yy+b6n/pXya47otbPv9LlYqnoDKjlw3nbwKK3OIgra5tD4PlZM9RxxL
	tAczbaf79XReaxMA/pipgW3Vz6XOVzm9spTpF+6r3QuqU4lSagCi4fjIrgtojVFdwsVfjhbDcoNLG
	OrD5ynMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spmg4-00000000kfB-2sL1;
	Sun, 15 Sep 2024 10:40:24 +0000
Date: Sun, 15 Sep 2024 11:40:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
Message-ID: <Zua5mDwhm7RlC0MS@casper.infradead.org>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>

On Sat, Sep 14, 2024 at 10:06:13PM +0800, Kefeng Wang wrote:
> +++ b/mm/shmem.c
> @@ -3228,6 +3228,7 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file->f_mapping->host;
> +	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
>  	ssize_t ret;
>  
>  	inode_lock(inode);
> @@ -3240,6 +3241,10 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ret = file_update_time(file);
>  	if (ret)
>  		goto unlock;
> +
> +	if (!shmem_allowable_huge_orders(inode, NULL, index, 0, false))
> +		iocb->ki_flags |= IOCB_NO_LARGE_CHUNK;

Wouldn't it be better to call mapping_set_folio_order_range() so we
don't need this IOCB flag?

