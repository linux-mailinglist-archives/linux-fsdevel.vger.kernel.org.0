Return-Path: <linux-fsdevel+bounces-73874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E3D22674
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B038C3028598
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 05:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E442D0C99;
	Thu, 15 Jan 2026 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D3lKk+Ex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8C23D297
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768453275; cv=none; b=VeZCrRCWwQkOqRhY7HUEed2S6/J/FxVAigmKnLzTw1xHKf05TNsYA5ZU3I208Z7YcItfLd+BruA5tKig910/4k7Zfnl3b0tuVLfCMlfgikvbZBe8HFDgsyEQekltN+YmnxSBAsBioNy3KOeDgf9gtXRHDuq9jhZ+MTHWqt87uiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768453275; c=relaxed/simple;
	bh=tIdSD+lnVu+eR2RFrEOzybitZ4d0Zz10/7L7tXoGQWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiOl9/iBjNBPQQeLOH+lv9tigteERhCJkPbzzEJ8FhcMLM30CcFHltIT5wUF/+Aedd45cNwadLDxlL3MwiQTAglAVejdNuVLufUmvx38tEKefu9QYaebiI8Rbc6Bi7IN3PT/oS8ORJrepeN2YDG1ZEUaVkLWzr0wohoqFuF8UWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D3lKk+Ex; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PZwCBH8NPnmzql4J+EZxc5iJXLT16KkU7dbvR3mnvGA=; b=D3lKk+Ex9gfppMjU0VAjUhiGUE
	bBy595GDnzXQ5KinmyBu0Kq/zr6TczEKtfhdJFaEa2iZVfKfdbWw14Inv4AzPRfQWTcFsazdlS0I4
	+mc/iDlNTbpH9C1KzgfmG1JJf+tuce1hOs75Vc19lunFtYjIBQLRVGSZeUm9W+dGQO2RZ+ZMTdC4n
	9s9NQAc8caw7IAkoLK0S3il1TMHymrv6AnYuSL/ycx9fYlfgmpZrimeKQ0FdnJZlW1B9JlWxkP33b
	UKo8pe16QpyRwI0ySlICWEAvImAf41P6NCy9RnLQkFMfzO8uvYTHYFDLYF42piRSMleMbtKseps5Q
	F//XzEgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgFTq-00000007E9D-33sy;
	Thu, 15 Jan 2026 05:01:10 +0000
Date: Thu, 15 Jan 2026 05:01:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix readahead folio refcounting race
Message-ID: <aWh0lmKBL-4A1zuX@casper.infradead.org>
References: <20260114180255.3043081-1-joannelkoong@gmail.com>
 <aWfk7T4sCjAhOVZ9@casper.infradead.org>
 <CAJnrk1awyskKaoSTznzwLg3bS64asPqH4c50iLKqANRe-eMK5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1awyskKaoSTznzwLg3bS64asPqH4c50iLKqANRe-eMK5Q@mail.gmail.com>

On Wed, Jan 14, 2026 at 11:52:54AM -0800, Joanne Koong wrote:
> On Wed, Jan 14, 2026 at 10:48 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jan 14, 2026 at 10:02:55AM -0800, Joanne Koong wrote:
> > > readahead_folio() returns the next folio from the readahead control
> > > (rac) but it also drops the refcount on the folio that had been held by
> > > the rac. As such, there is only one refcount remaining on the folio
> > > (which is held by the page cache) after this returns.
> > >
> > > This is problematic because this opens a race where if the folio does
> > > not have an iomap_folio_state struct attached to it and the folio gets
> > > read in by the filesystem's IO helper, folio_end_read() may have already
> > > been called on the folio (which will unlock the folio) which allows the
> > > page cache to evict the folio (dropping the refcount and leading to the
> > > folio being freed) by the time iomap_read_end() runs.
> > >
> > > Switch to __readahead_folio(), which returns the folio with a reference
> > > held for the caller, and add explicit folio_put() calls when done with
> > > the folio.
> >
> > No.  The direction we're going in is that there's no refcount held at
> > this point.  I just want to get this ANCK out before Christian applies
> > the patch; I'll send a followup with a better fix imminently.
> 
> Sounds good, thanks for taking a look. I'll keep an eye out for your patch.

I can't quite figure out what's going on.  If things are happening as
you describe, then with your patch we'll end up calling folio_end_read()
twice, which is not allowed anyway (and we have debugging assertions
to catch!)  It feels like something needs to be clearing ctx->cur_folio
if it knows it's going to call / already has called folio_end_read().

But then I can't see anywhere in Linus' current tree that's calling
iomap_finish_folio_read() outside of fs/iomap/bio.c.  Should I be looking
at a different tree to see the problem you're experiencing?

