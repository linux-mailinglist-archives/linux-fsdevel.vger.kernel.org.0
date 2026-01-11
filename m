Return-Path: <linux-fsdevel+bounces-73144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4326D0E16A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 06:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3063D3011A6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1E1C84DC;
	Sun, 11 Jan 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NqiTAehF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA632AD20
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768110709; cv=none; b=oQmSDyVZn7mWeTbYGg/8qnrtY3hIt8FJMzl2tDWty6weM9tZohJQg7ZU1N1Rnd/7DkI6iHqLLZ+383bvLoaJWiruBZYQ+ZJFkRyyd4mAYDgeDjAVo+bL/uAt3703/+1dBGFu4dbMXtIY52Pw3W+cI6AOlKUBulVA+0kAzAUc6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768110709; c=relaxed/simple;
	bh=yuAv/N1oxPUxTdNWCEWzvfLAhK2tSCeoWyZrxSax5lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh7YHMuPLboRHXdgioMGnXrNvpGM/DHKArg35euhfLYGaZ4THdSP9f72+pjwOdsJ4vIkigJji6Vop5G8PPA10NrUuLkVS7lMVPoGBADzVqVqj9jcwwoDqdsOx2NzHroG9Bw4E6kX4Y50lxEAjEjPvg9MsH1JrNmAQ6Ouijlx4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NqiTAehF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JMHaP7DPtC6RnB3OYS/BJzRtc48vy15hGg+Crcn6RwU=; b=NqiTAehFupSJbZWwwpaWV/lw4+
	qcHXlYFXTA2deu2fKzmylgW/b/D3lsIalIBCKJtXUQcV12dtvAgmItfHwrjn1XW+VhGj6l5kMkjjB
	XtW/ckB25QWgw0Uop6O1VheZU9ogdbrDL0WBjjgmTgWges4SfM8dH23SLkXvhw3CQ62bYR12MZSbd
	D+AP0aobi3XCISqc5r2jT1Y12A/65l7RkZ528YNVFo2qICqtgna5SMKg4CDYmZlLWmjkcMpWH75oq
	MBHzKOfcQ+idiAqFVaPMglG/w8amh+HbbBgjTMZpwOK8WWvDfh52zfdtWDTPh8GikgH4J9xosf8em
	iR8K0BuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veoMQ-00000001W7s-3yCx;
	Sun, 11 Jan 2026 05:51:34 +0000
Date: Sun, 11 Jan 2026 05:51:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: yuling-dong@qq.com
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Message-ID: <aWM6ZkR9aDTwyFst@casper.infradead.org>
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
 <aWMy-4X75vkHmtDE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWMy-4X75vkHmtDE@casper.infradead.org>

On Sun, Jan 11, 2026 at 05:19:55AM +0000, Matthew Wilcox wrote:
> On Thu, Jan 08, 2026 at 05:38:57PM +0800, yuling-dong@qq.com wrote:
> > -	start = ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > -	end = min_t(loff_t, i_size_read(inode),
> > -			start + vma->vm_end - vma->vm_start);
> > +	new_valid_size = (loff_t)vmf->pgoff << PAGE_SHIFT;
> 
> Uh, this is off-by-one.  If you access page 2, it'll expand the file
> to a size of 8192 bytes, when it needs to expand the file to 12288
> bytes.  What testing was done to this patch?

Oh, and we should probably make this function support large folios
(I know exfat doesn't yet, but this is on your roadmap, right?)
Something like this:

	struct folio *folio = page_folio(vmf->page)
	loff_t new_valid_size = folio_next_pos(folio);

... although this doesn't lock the folio, so we could have a race
where the folio is truncated and then replaced with a larger folio
and we wouldn't've extended the file enough.  So maybe we need to
copy the guts of filemap_page_mkwrite() into exfat_page_mkwrite().
It's all quite tricky because exfat_extend_valid_size() also needs
to lock the folio that it's going to write to.

Hm.  So maybe punt on all this for now and just add the missing "+ 1".

