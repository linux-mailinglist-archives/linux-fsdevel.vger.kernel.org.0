Return-Path: <linux-fsdevel+bounces-40521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CBCA24502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 23:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C8B1886697
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58F1F3FFA;
	Fri, 31 Jan 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cqC6Lzbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22631487E9;
	Fri, 31 Jan 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738360917; cv=none; b=kRSVRg2sPd4j0Wf/2wFDSy1+NGA4Z84fXiANfJHWL8veVbPYgTKj0jRLu+5XjOOugGSxHD4nPKpAVvswOYHJuksEhq0+rcqMODTpSDkV2zLjJR2G3+nSmQ94ZfHDjUYdKqjhiVYEPq3wluUGyJbKn9pAVcpGgiQGdrZHhRGuX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738360917; c=relaxed/simple;
	bh=zEpNeN4bQXMDPRiwVYQP12A4ynlqLCsRv9yIAZkiocg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKh9qhMwGSbaTJCArZN+1nwODMWdef2A0OpnNvbb1vvktivODk8HhAfTWr6QjUPKxd6Bcr1oGbszqEtQDl/q1X1NqXoH3sxh+QmSxqBz5eWGFKKKjbSZRaEpjT6sRXC8iF8rkF4rbvFClzayv4g97e0zCssnfeB48QJBDS1TSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cqC6Lzbi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R5v3Vp8tsw1LE/lxKen0G1myY0wqF26imHFfjT4SmXY=; b=cqC6LzbiijGTbh/tgJBpGzZD6w
	RgljOVnsa/poOlHqwhg+1K5UbvltHwAVrRsp/XzoAgwPctDvlqRtcIU3Vt13pryrPmMqBOwB5VRTK
	8niKO0DUEbLSO/gmesV4IPh4O/MiwfMe02g82j6NnIEVOYpOcVXEYAoFSw9t/NbVakrMof+NdjO2t
	4Ze1IxToitidCy8cCcW+qQcq8H01itmjNMqpULSP1V00XQqKqV4coLdnKOs9hbO6Zy2d2KhT+Lqz0
	vtzFPCHrdozxjxEUbUVsbRMxZr3lHac0gKWehVCRGYcpwel2qgK/MNwUV3YnpkHB9mkOEjhTLB+ky
	CmjRPJSg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdz58-0000000FCc3-1I5f;
	Fri, 31 Jan 2025 22:01:46 +0000
Date: Fri, 31 Jan 2025 22:01:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <Z51ISh2YAlwoLo5h@casper.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <Z2MrCey3RIBJz9_E@casper.infradead.org>
 <Z2OEmALBGB8ARLlc@bombadil.infradead.org>
 <Z2OYRkpRcUFIOFog@casper.infradead.org>
 <Z50AR0RKSKmsumFN@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z50AR0RKSKmsumFN@bombadil.infradead.org>

On Fri, Jan 31, 2025 at 08:54:31AM -0800, Luis Chamberlain wrote:
> On Thu, Dec 19, 2024 at 03:51:34AM +0000, Matthew Wilcox wrote:
> > On Wed, Dec 18, 2024 at 06:27:36PM -0800, Luis Chamberlain wrote:
> > > On Wed, Dec 18, 2024 at 08:05:29PM +0000, Matthew Wilcox wrote:
> > > > On Tue, Dec 17, 2024 at 06:26:21PM -0800, Luis Chamberlain wrote:
> > > > > This splits up a minor enhancement from the bs > ps device support
> > > > > series into its own series for better review / focus / testing.
> > > > > This series just addresses the reducing the array size used and cleaning
> > > > > up the async read to be easier to read and maintain.
> > > > 
> > > > How about this approach instead -- get rid of the batch entirely?
> > > 
> > > Less is more! I wish it worked, but we end up with a null pointer on
> > > ext4/032 (and indeed this is the test that helped me find most bugs in
> > > what I was working on):
> > 
> > Yeah, I did no testing; just wanted to give people a different approach
> > to consider.
> > 
> > > [  106.034851] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > [  106.046300] RIP: 0010:end_buffer_async_read_io+0x11/0x90
> > > [  106.047819] Code: f2 ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 8b 47 10 48 89 fb 48 8b 40 18 <48> 8b 00 f6 40 0d 40 74 0d 0f b7 00 66 25 00 f0 66 3d 00 80 74 09
> > 
> > That decodes as:
> > 
> >    5:	53                   	push   %rbx
> >    6:	48 8b 47 10          	mov    0x10(%rdi),%rax
> >    a:	48 89 fb             	mov    %rdi,%rbx
> >    d:	48 8b 40 18          	mov    0x18(%rax),%rax
> >   11:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
> >   14:	f6 40 0d 40          	testb  $0x40,0xd(%rax)
> > 
> > 6: bh->b_folio
> > d: b_folio->mapping
> > 11: mapping->host
> > 
> > So folio->mapping is NULL.
> > 
> > Ah, I see the problem.  end_buffer_async_read() uses the buffer_async_read
> > test to decide if all buffers on the page are uptodate or not.  So both
> > having no batch (ie this patch) and having a batch which is smaller than
> > the number of buffers in the folio can lead to folio_end_read() being
> > called prematurely (ie we'll unlock the folio before finishing reading
> > every buffer in the folio).
> 
> But:
> 
> a) all batched buffers are locked in the old code, we only unlock
>    the currently evaluated buffer, the buffers from our pivot are locked
>    and should also have the async flag set. That fact that buffers ahead
>    should have the async flag set should prevent from calling
>    folio_end_read() prematurely as I read the code, no?

I'm sure you know what you mean by "the old code", but I don't.

If you mean "the code in 6.13", here's what it does:

        tmp = bh;
        do {
                if (!buffer_uptodate(tmp))
                        folio_uptodate = 0;
                if (buffer_async_read(tmp)) {
                        BUG_ON(!buffer_locked(tmp));
                        goto still_busy;
                }
                tmp = tmp->b_this_page;
        } while (tmp != bh);
        folio_end_read(folio, folio_uptodate);

so it's going to cycle around every buffer on the page, and if it finds
none which are marked async_read, it'll call folio_end_read().
That's fine in 6.13 because in stage 2, all buffers which are part of
this folio are marked as async_read.

In your patch, you mark every buffer _in the batch_ as async_read
and then submit the entire batch.  So if they all complete before you
mark the next bh as being uptodate, it'll think the read is complete
and call folio_end_read().


