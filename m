Return-Path: <linux-fsdevel+bounces-40592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A83A25BB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229B9165BB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8682063CB;
	Mon,  3 Feb 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgvYe2rP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901520A5CD;
	Mon,  3 Feb 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591202; cv=none; b=J98OSpwszwLbiiEjiaM9jMZQk+8mqaIzje+6k1XRRfPnxc70ibhmTERkg/oZcSX1i+C4BG96EEdBhp7EXyyKSaJavK0E99K5Ail3VGeNVOupi3OEhVjvOuCpAq2nvCYoaNGAPiaFFS1mrRtcU47dWECY0Qquq58Tz2P9u/KjA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591202; c=relaxed/simple;
	bh=DodJHTwvmvoQJhOboL7veVJCLIW/qyqGwOMGQqc+N4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUkzvB++HMBjTA22YUQT4xY39OTQR+Nn9DVC6349XIloiar2kf8+XApgCtVOcq+b+6Y6C8WjFM2gvCKCFO8C5IZG/o3D9Vwsb5BANDlC64XEB1aDatNUMc/2/FrfL4ZSogbNx1+SaqXxOduh+L+StS8bzJotdZPUG+uE/xyI7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgvYe2rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BBBC4CED2;
	Mon,  3 Feb 2025 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738591202;
	bh=DodJHTwvmvoQJhOboL7veVJCLIW/qyqGwOMGQqc+N4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgvYe2rPWcMjSyAu3Eokhg0NfcNuRWANm4Gyz/4hOOBktMJSf8tin3RUlguKJqOk4
	 bEgKeU/PSciJwSbVdm+qO/peNzrP+IoB9+9Opsuh9POZy7jilaHSxoGkCMYHtaUNan
	 E1eQtyzugdwz57zepOXLKhHZvZNCnWGn/8+e9Od8224p/I9D5sTNS9ve7HWAlZ3nAN
	 bYEqYGuuOk+Y44bUThSnihWPSNVGLIOQksmEe65mV/BNjt7Zo3tQ5Vts3dzpogMa+5
	 2juoCX6Yg03qW7uTt9yZ2o6FWyEdnAipDTyI7/rlKj1/6SBiMVgl4aYefXniuy7c1Q
	 yNcWcJlhI7Eig==
Date: Mon, 3 Feb 2025 06:00:00 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <Z6DL4MrsHbtX_MIs@bombadil.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <Z2MrCey3RIBJz9_E@casper.infradead.org>
 <Z2OEmALBGB8ARLlc@bombadil.infradead.org>
 <Z2OYRkpRcUFIOFog@casper.infradead.org>
 <Z50AR0RKSKmsumFN@bombadil.infradead.org>
 <Z51ISh2YAlwoLo5h@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z51ISh2YAlwoLo5h@casper.infradead.org>

On Fri, Jan 31, 2025 at 10:01:46PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 31, 2025 at 08:54:31AM -0800, Luis Chamberlain wrote:
> > On Thu, Dec 19, 2024 at 03:51:34AM +0000, Matthew Wilcox wrote:
> > > On Wed, Dec 18, 2024 at 06:27:36PM -0800, Luis Chamberlain wrote:
> > > > On Wed, Dec 18, 2024 at 08:05:29PM +0000, Matthew Wilcox wrote:
> > > > > On Tue, Dec 17, 2024 at 06:26:21PM -0800, Luis Chamberlain wrote:
> > > > > > This splits up a minor enhancement from the bs > ps device support
> > > > > > series into its own series for better review / focus / testing.
> > > > > > This series just addresses the reducing the array size used and cleaning
> > > > > > up the async read to be easier to read and maintain.
> > > > > 
> > > > > How about this approach instead -- get rid of the batch entirely?
> > > > 
> > > > Less is more! I wish it worked, but we end up with a null pointer on
> > > > ext4/032 (and indeed this is the test that helped me find most bugs in
> > > > what I was working on):
> > > 
> > > Yeah, I did no testing; just wanted to give people a different approach
> > > to consider.
> > > 
> > > > [  106.034851] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > > [  106.046300] RIP: 0010:end_buffer_async_read_io+0x11/0x90
> > > > [  106.047819] Code: f2 ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 8b 47 10 48 89 fb 48 8b 40 18 <48> 8b 00 f6 40 0d 40 74 0d 0f b7 00 66 25 00 f0 66 3d 00 80 74 09
> > > 
> > > That decodes as:
> > > 
> > >    5:	53                   	push   %rbx
> > >    6:	48 8b 47 10          	mov    0x10(%rdi),%rax
> > >    a:	48 89 fb             	mov    %rdi,%rbx
> > >    d:	48 8b 40 18          	mov    0x18(%rax),%rax
> > >   11:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
> > >   14:	f6 40 0d 40          	testb  $0x40,0xd(%rax)
> > > 
> > > 6: bh->b_folio
> > > d: b_folio->mapping
> > > 11: mapping->host
> > > 
> > > So folio->mapping is NULL.
> > > 
> > > Ah, I see the problem.  end_buffer_async_read() uses the buffer_async_read
> > > test to decide if all buffers on the page are uptodate or not.  So both
> > > having no batch (ie this patch) and having a batch which is smaller than
> > > the number of buffers in the folio can lead to folio_end_read() being
> > > called prematurely (ie we'll unlock the folio before finishing reading
> > > every buffer in the folio).
> > 
> > But:
> > 
> > a) all batched buffers are locked in the old code, we only unlock
> >    the currently evaluated buffer, the buffers from our pivot are locked
> >    and should also have the async flag set. That fact that buffers ahead
> >    should have the async flag set should prevent from calling
> >    folio_end_read() prematurely as I read the code, no?
> 
> I'm sure you know what you mean by "the old code", but I don't.
> 
> If you mean "the code in 6.13", here's what it does:

Yes that is what I meant, sorry.

> 
>         tmp = bh;
>         do {
>                 if (!buffer_uptodate(tmp))
>                         folio_uptodate = 0;
>                 if (buffer_async_read(tmp)) {
>                         BUG_ON(!buffer_locked(tmp));
>                         goto still_busy;
>                 }
>                 tmp = tmp->b_this_page;
>         } while (tmp != bh);
>         folio_end_read(folio, folio_uptodate);
> 
> so it's going to cycle around every buffer on the page, and if it finds
> none which are marked async_read, it'll call folio_end_read().
> That's fine in 6.13 because in stage 2, all buffers which are part of
> this folio are marked as async_read.

Indeed, also, its not just every buffer on the page, since we can call
end_buffer_async_read() on every buffer in the page we can end up
calling end_buffer_async_read() on every buffer in the worst case, and
on each loop above we start from the pivot buffer up to the end of the
page.

> In your patch, you mark every buffer _in the batch_ as async_read
> and then submit the entire batch.  So if they all complete before you
> mark the next bh as being uptodate, it'll think the read is complete
> and call folio_end_read().

Ah yes, thanks, this clarifies to me what you meant!

  Luis

