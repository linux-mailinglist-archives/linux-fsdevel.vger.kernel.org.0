Return-Path: <linux-fsdevel+bounces-73431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51931D191E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4836C3013E96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB49438FF13;
	Tue, 13 Jan 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lhc1X72N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F46341678
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311417; cv=none; b=fnqtZR5k7gDeEw6exap4WmE0jPps8C0w2URiQutCWsO5pUsj4Blg2SX0aFaDQTRTXPeEz0CFHCzsvzw9UYKRk5g+6XSdUob5HYQRyvQW8ShV55C1fxwIZPtF/xVuWbOoBtg/H/9XH98Uh3tKeRvrsgxzpJPs9VjnhGaCi6xJewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311417; c=relaxed/simple;
	bh=j+6fUJ9H3WRYRxsgaebhUvMLLb0D6b84x0sPNZ52WCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaH2YCaNa7xXjs6HgHjF6RmzUj4d54G1wzDD5DMCXO1+B3/YR4NIkfQszswszljkRAnPSKnrIuQBCd2OKGREjIEQZEOom+ORMxpzAYotg1Vv+ygK6n0KfpkrX5moqBdnQONkoiZuTLzBD0GonxSviIYB7+DrL5u7rBZp1Z/6Eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lhc1X72N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7/bdkp85+sMATkMAo8J3p0JrnkJV/IUDv+e7CflleQ4=; b=Lhc1X72NSXm+G3YzlYjmMAQr7q
	qX4YY6VU0nOEdJnusgylfp1pXWIn1fhv8zKbDt6xM3+yXT0yJ+mbFvnXMHpOGxWSxVyALHWUaCOdO
	LJlqV42MFCU8+Xq/AfVomHa6B87oqqANjfHPbVoTMZaXATVF71OFCjwQI9qzeOVFIcDazewNRBtMC
	wD61/E6HXls2E4WAbCo5NE4lK9ioodiMwI/7jUTRB2+B7bhSmqdPSwUMwpeNHGOhGYnq+1+EyqukJ
	1SkZLmKIcjyZXnMWjfRWe+2NaPTaG2tKN91UuakvXudLyxY9yZ6iS9tRfecTKbIGJUpi/E1CHjZ6c
	aMRtPj9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfeZk-00000004ljd-3W2Y;
	Tue, 13 Jan 2026 13:36:48 +0000
Date: Tue, 13 Jan 2026 13:36:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"yuling-dong@qq.com" <yuling-dong@qq.com>
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Message-ID: <aWZKcGNQtFzHY8yN@casper.infradead.org>
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
 <aWMy-4X75vkHmtDE@casper.infradead.org>
 <20260112070506.2675963-2-Yuezhang.Mo@sony.com>
 <PUZPR04MB631645EC670C756D3C5D26538181A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB631645EC670C756D3C5D26538181A@PUZPR04MB6316.apcprd04.prod.outlook.com>

On Mon, Jan 12, 2026 at 07:48:59AM +0000, Yuezhang.Mo@sony.com wrote:
> Oh no, sorry, there's something wrong with my environment. Resend the email.
> 
> On Sun, Jan 11, 2026 at 05:51:34AM +0000, Matthew Wilcox wrote:
> > On Sun, Jan 11, 2026 at 05:19:55AM +0000, Matthew Wilcox wrote:
> > > On Thu, Jan 08, 2026 at 05:38:57PM +0800, yuling-dong@qq.com wrote:
> > > > -	start = ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > > > -	end = min_t(loff_t, i_size_read(inode),
> > > > -			start + vma->vm_end - vma->vm_start);
> > > > +	new_valid_size = (loff_t)vmf->pgoff << PAGE_SHIFT;
> > > 
> > > Uh, this is off-by-one.  If you access page 2, it'll expand the file
> > > to a size of 8192 bytes, when it needs to expand the file to 12288
> > > bytes.  What testing was done to this patch?
> > 
> > Oh, and we should probably make this function support large folios
> > (I know exfat doesn't yet, but this is on your roadmap, right?)
> > Something like this:
> > 
> > 	struct folio *folio = page_folio(vmf->page)
> > 	loff_t new_valid_size = folio_next_pos(folio);
> > 
> > ... although this doesn't lock the folio, so we could have a race
> > where the folio is truncated and then replaced with a larger folio
> > and we wouldn't've extended the file enough.  So maybe we need to
> > copy the guts of filemap_page_mkwrite() into exfat_page_mkwrite().
> > It's all quite tricky because exfat_extend_valid_size() also needs
> > to lock the folio that it's going to write to.
> > 
> > Hm.  So maybe punt on all this for now and just add the missing "+ 1".
> 
> Hi Matthew,
> 
> Thank you for your feedback!
> 
> There are two ways to extend valid_size: one is by writing 0 through
> exfat_extend_valid_size(), and the other is by writing user data.
> Before writing user data, we just need to extend valid_size to the
> position of user data.
> 
> In your example above, valid_size is extended to 8192 by
> exfat_extend_valid_size(), and when page 2(user data) is written,
> valid_size will be expanded to 12288.

This _is_  the point where we write user data to page 2 though.
There's no other call to the filesystem after page_mkwrite; on return
the page is dirty and in the page tables.  Userspace gets to write to
it without further kernel involvement until writeback comes along and
unmaps it from the page table.

