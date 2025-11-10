Return-Path: <linux-fsdevel+bounces-67656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C7C45C0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78ADD188F4FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE732303A1A;
	Mon, 10 Nov 2025 09:52:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6B301707;
	Mon, 10 Nov 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768356; cv=none; b=XeoweLypwmynM029Jq9zqEFNRd/NTxRa1LR9J4yEAs/sqkxS4ghoU4xrOZQfQMIDSdD0DPYbfXbDZHfKlINVSklvLJcFIzYtVwdL5py3slDggcl9UFd557zvApC82axjP6fgIe+gJQ8L5d0Mv6gdb7/UUh0oexzIbhlKucjClx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768356; c=relaxed/simple;
	bh=MPWOn1EHVfNtQ9OEeCM4Aca03T/vWKRPOdqIwl/ZYEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmEXiZQtqP/eq0PmmGmKeVIui5ZRx05hUf31EgHtty30IbMEKbrKPT9so7/45x0EvOp8LcBszfwRhH8wNZjllBw2a1VsIALg97vZ2nJDeTX8Gg7pvawzX/aMJDS4MyecqLu9+eRSH7Rgd86li6X6VuFdTjo6xxxMIb9Qj22Q5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12EED227A87; Mon, 10 Nov 2025 10:52:29 +0100 (CET)
Date: Mon, 10 Nov 2025 10:52:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251110095228.GA24387@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com> <20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de> <20251110093140.GA22674@lst.de> <lhubjlaz08f.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhubjlaz08f.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 10:49:04AM +0100, Florian Weimer wrote:
> >> Maybe add two flags, one for the ftruncate replacement, and one that
> >> instructs the file system that the range will be used with mmap soon?
> >> I expect this could be useful information to the file system.  We
> >> wouldn't use it in posix_fallocate, but applications calling fallocate
> >> directly might.
> >
> > What do you think "to be used with mmap" flag could be useful for
> > in the file system?  For file systems mmap I/O isn't very different
> > from other use cases.
> 
> I'm not a file system developer. 8-)
> 
> The original concern was about a large file download tool that didn't
> download in sequence.  It wrote to a memory mapping directly, in
> somewhat random order.  And was observed to cause truly bad
> fragmentation in practice.  Maybe this something for posix_fadvise.

In general smart allocators (both the classic XFS allocator, and the
zoned one we're talking about here) take the file offset into account
when allocating blocks.  Additionally the VM writeback code usually
avoids writing back out of order unless writeback is forced by an
f(data)sync or memory pressuere.  So it should not be needed here,
although I won't hold my hand into the fire that fallocate won't help
with simpler allocators or really degenerate I/O patterns, but
there is nothing mmap-specific about that.

> 
> Thanks,
> Florian
---end quoted text---

