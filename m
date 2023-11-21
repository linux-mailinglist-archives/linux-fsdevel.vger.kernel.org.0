Return-Path: <linux-fsdevel+bounces-3290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D67F25A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 07:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B742C282B8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 06:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E51EA7B;
	Tue, 21 Nov 2023 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TNv1ay4i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F99ECA;
	Mon, 20 Nov 2023 22:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pu892CmklwtJGI+KPlhGZXprVPRFixMF2XsAMJ9jaQc=; b=TNv1ay4i6k4bYr6tnn5DCNpw+Q
	ozy8KZHfNl+IcuqxeLhubINYVHE+3b5nKzC2/R65RcNbQ9LjXJurLwuThPUhJryaZwmVrd1bbOpGQ
	Vi9QLk94ACENOPurhhZKqC/yftcc8PaA5tKnmLhJ3ZdQoVci1TB+wFERcg5tM57DNRb+4OJm4QB/s
	qLN8kU/rdoyaZdP0zqvDhmHCgmcydyEX+ZwJbVQ2xqBGF+UfBxRGEFX4Nt7JnJg6xdyJA/D2lpndn
	2IVooUyKd+a8fNX0Vst0djFMbLMa3wwlnAs5W9PRlTYUixhIrtGTs1bsqcVT5xHUDcYWjlCK3Ykt5
	KMdoM4jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Jvz-00FkR4-2a;
	Tue, 21 Nov 2023 06:08:31 +0000
Date: Mon, 20 Nov 2023 22:08:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZVxJXxKipvxcPlSo@infradead.org>
References: <ZVw1xxNYQuHimSmx@infradead.org>
 <874jhfy7i8.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jhfy7i8.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 21, 2023 at 11:26:15AM +0530, Ritesh Harjani wrote:
> > instantly spot anything that relies on them - you are just a lot more
> > likely to hit an -ENOSPC from ->map_blocks now.
> 
> Which is also true with existing code no? If the block reservation is
> not done at the write fault, writeback is likely to fail due to ENOSPC?

Yes. Not saying you should change this, I just want to make sure the
iomap code handles this fine.  I think it does, but I'd rather be sure.

> Sure, make sense. Thanks!
> I can try and check if the the wrapper helps.

Let's wait until we have a few more conversions.

> > Did yo run into issues in using the iomap based aops for the other uses
> > of ext2_aops, or are just trying to address the users one at a time?
> 
> There are problems for e.g. for dir type in ext2. It uses the pagecache
> for dir. It uses buffer_heads and attaches them to folio->private.
>     ...it uses block_write_begin/block_write_end() calls.
>     Look for ext4_make_empty() -> ext4_prepare_chunk ->
>     block_write_begin(). 
> Now during sync/writeback of the dirty pages (ext4_handle_dirsync()), we
> might take a iomap writeback path (if using ext2_file_aops for dir)
> which sees folio->private assuming it is "struct iomap_folio_state".
> And bad things will happen... 

Oh, indeed, bufferheads again.

> Now we don't have an equivalent APIs in iomap for
> block_write_begin()/end() which the users can call for. Hence, Jan
> suggested to lets first convert ext2 regular file path to iomap as an RFC.

Yes, no problem.  But maybe worth documenting in the commit log.


