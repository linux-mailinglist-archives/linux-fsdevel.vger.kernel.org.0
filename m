Return-Path: <linux-fsdevel+bounces-33962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A99C0F99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C85D285252
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3DE217F5B;
	Thu,  7 Nov 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rbWCU6p1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAF188CC6;
	Thu,  7 Nov 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010804; cv=none; b=uvfs0rF13BsyigxCHUqfIurjXLBw1PmbuqmEuQJeqNy5i1f9vGnEw3Lbut1NZ2Hagf/Cpa2yQeLLlKxgXK/kO2kejjsJ31vNc3FPGAB9JJv7pCxGRt979ERD62BzQU4gDLkEgCvWexJqbC6C3/lUrKJ2tPjQcG0QhMlbnK13ebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010804; c=relaxed/simple;
	bh=DZULhkNtIKVgrZSI1ZQHnxEFQHoKswm8s5buWEDQRmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDYUAFPCQ+LIo1j5ZP0YajdRK5XiRxzNi2d38hyntJ+NkBm/OkyHej1yYROcx0PVlOPTGoLEFhcFFxduJ7jsrxv8NiIKtcKuTBYKaA4C1VtTIj3jiYdkGjNyH8wkJs0FfzKYxkeb+T7u8BSx3x1DOfLWfFtZhPcsb2amQ6HtXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rbWCU6p1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WBdml7YjmERUT8SVBwJP9R+7xZP2+k1OGM6A0zqovvs=; b=rbWCU6p19KhlwSTEPtF5J0EJBt
	LSf714Sv1wrXB29l5QtvRIF10xdPqfq15PfALw27p3i31Hc3o8MrDU+Mh8TVlAqthI+pNzUIbzkZG
	ncEoWd5qQ5MgfcM89DZlpRn8JvEZxf42YTDyi3aC2OOAHSw2AaqFCym8ELxz//aKjzOzyqIr67ikL
	o7uUiltBB5NDbQaoz3ryf9+N/t1W/X7F4xKL1MaCFfMWHrJaZicsgv1s70p5nfpQ1JfpKl/rY/Bar
	cpBq8eRUhPhKGbAMcsZy4H8rfc9Qg8RY7xepQpgXBUSbQ/Qh1sUb6FBugvS1T7SCIsu4IAaSrv4QA
	iZ5fYy0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t98z2-00000007Kj7-2nAz;
	Thu, 07 Nov 2024 20:20:00 +0000
Date: Thu, 7 Nov 2024 20:20:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, kvm@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>
Subject: Re: [ISSUE] split_folio() and dirty IOMAP folios
Message-ID: <Zy0g8DdnuZxQly3b@casper.infradead.org>
References: <4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com>
 <ZyzmUW7rKrkIbQ0X@casper.infradead.org>
 <ada851da-70c2-424e-b396-6153cecf7179@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada851da-70c2-424e-b396-6153cecf7179@redhat.com>

On Thu, Nov 07, 2024 at 05:34:40PM +0100, David Hildenbrand wrote:
> On 07.11.24 17:09, Matthew Wilcox wrote:
> > On Thu, Nov 07, 2024 at 04:07:08PM +0100, David Hildenbrand wrote:
> > > I'm debugging an interesting problem: split_folio() will fail on dirty
> > > folios on XFS, and I am not sure who will trigger the writeback in a timely
> > > manner so code relying on the split to work at some point (in sane setups
> > > where page pinning is not applicable) can make progress.
> > 
> > You could call something like filemap_write_and_wait_range()?
> 
> Thanks, have to look into some details of that.
> 
> Looks like the folio_clear_dirty_for_io() is buried in
> folio_prepare_writeback(), so that part is taken care of.
> 
> Guess I have to fo from folio to "mapping,lstart,lend" such that
> __filemap_fdatawrite_range() would look up the folio again. Sounds doable.
> 
> (I assume I have to drop the folio lock+reference before calling that)

I was thinking you'd do it higher in the callchain than
gmap_make_secure().  Presumably userspace says "I want to make this
256MB range secure" and we can start by writing back that entire
256MB chunk of address space.

That doesn't prevent anybody from dirtying it in-between, of course,
so you can still get -EBUSY and have to loop round again.


