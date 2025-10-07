Return-Path: <linux-fsdevel+bounces-63528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE7BC0251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 06:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A1818991F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 04:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA8218ACC;
	Tue,  7 Oct 2025 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bdkq4Ihy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC6EACE;
	Tue,  7 Oct 2025 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759810788; cv=none; b=H4Le6ITJezKoy4e7KsY94wehw8vznXZxNaYopoh2BcqInKQzGFX+FW6RJFlx+//DtGY52kAzkfBvsSQxS8QnPVrFTW4HE8JYSzDHbrv0OP3vf35fUYGaypIh5hjHREVfaLwTBnj5/MGXjEk25bNWp5Y1iqe6l5O/XZw20A1405k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759810788; c=relaxed/simple;
	bh=HE3t377Q3IJxZqEyiSSkqsH0urjCP1pnPETMv0lwR+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGwjTrl1ihsi9TH4P+x1dqknvzcku1ikBFho+qetluDhEB3ZUE+QZy4cbqmkBTffub5rppCT/KGsfyUYmaZesgIlWmMq+mJ/ZuHp44odzD/ldO2Xs+UfU+Fhjz2ZYmScpZ2NKj8IX3TZ0vwI7DB5lxQJd0mvKGZbW9T8cFqiQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bdkq4Ihy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kv1h6jsJnfMTDAj0F7MQezv7IuzNrX04iRYje3vHnPQ=; b=Bdkq4IhyvCvI7TUA6dKJ8VmmP5
	HsBNO/OPwH6pQDAlq0zE7ty15KWm8MlZbPH6Ngw3IdhhhiphhpbvrScxNLcUpQOXjPJi7g593cfy3
	kZutunoQM33x0t+dm+wMN4MyUtxm1Z2Ufq+0sTeNel4+YYE6YRQhPZCoC2UfPXdQEYH1Hgdt6Y6rU
	mUHAOn8TzXqpgbgf74haI3rq9l7Le3TQOd7waPHM4bE5hquhaU7KSeSzV2MQw2xs7Injv+Nepepta
	uRo8x+B7/IuOhFnEqXHwdT64UOVksHryVuYFYniHH3E0pt1AaEqsp+YeJeeP+JQPCBr3+0TYZJIiG
	z+BObKfA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5zAt-00000007qjM-0Yg6;
	Tue, 07 Oct 2025 04:19:43 +0000
Date: Tue, 7 Oct 2025 05:19:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios
 that are fs block aligned
Message-ID: <aOSU3h7tTLz-qDeE@casper.infradead.org>
References: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
 <aOSOaYLpBOZwMMF9@casper.infradead.org>
 <aOSRe1wDI5JD_wvc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOSRe1wDI5JD_wvc@infradead.org>

On Mon, Oct 06, 2025 at 09:05:15PM -0700, Christoph Hellwig wrote:
> On Tue, Oct 07, 2025 at 04:52:09AM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 07, 2025 at 01:40:22PM +1030, Qu Wenruo wrote:
> > > During my development of btrfs bs > ps support, I hit some read bios
> > > that are submitted from iomap to btrfs, but are not aligned to fs block
> > > size.
> > > 
> > > In my case the fs block size is 8K, the page size is 4K. The ASSERT()
> > > looks like this:
> > 
> > Why isn't bdev_logical_block_size() set correctly by btrfs?
> 
> bdev_logical_block_size is never set by the file system.  It is the LBA
> size of the underlying block device.  But if the file system block size
> is larger AND the file system needs to do file system block size
> granularity operations that is not the correct boundary.  See also the
> iov_iter_alignment for always COW / zoned file system in
> xfs_file_dio_write.

But the case he's complaining about is bs>PS, so the LBA size really is
larger than PAGE_SIZE.

