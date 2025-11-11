Return-Path: <linux-fsdevel+bounces-67863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF456C4C7EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2FC44E6FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276062ECEA5;
	Tue, 11 Nov 2025 08:57:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13642EA756;
	Tue, 11 Nov 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851428; cv=none; b=abvG4DnqkMWVHCWEM3I62nwcqUD98KB1Sg78fy2olQXNhsaHgJZt/EEvoAOB8mGRd7KjS+A6ecydGaRWXbh/6dco0RxfYcbjQ9qHY/WhrteqnRNL70eyceKT5FNv3Wcrl1vbMRrqfOIjEcO12rmt671BzFasfl0zNIwGSj48acM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851428; c=relaxed/simple;
	bh=ll5q7qBfeXaD5xqmOUO/RhZY6bK7xWm8m1Vf+JOtrKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7wIC8enO0FizD9dFBcJNZfGj0qjyOxUSTZBi0/yBGMEPyso3hiiFkIMfBhrVcLxKW5hxx2/E9iSPh5gYRXDg2Ud6YHHe880m+dSnCZ1TKjLg9IJCrakxceHRTjabJz7NELnHvGmEe6p1dkPA3/i/UiB95ZBbMAn2n3+ql8GClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 077C4227A87; Tue, 11 Nov 2025 09:57:00 +0100 (CET)
Date: Tue, 11 Nov 2025 09:56:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Florian Weimer <fweimer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251111085659.GA11723@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com> <20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de> <aRESlvWf9VquNzx3@dread.disaster.area> <lhuseem1mpe.fsf@oldenburg.str.redhat.com> <aRJK5LqJnrT5KAyH@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRJK5LqJnrT5KAyH@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 07:28:20AM +1100, Dave Chinner wrote:
> IOWs, I have no problems with COW filesystems not doing
> preallocation, but if they are going to return success they still
> need to perform all the non-allocation parts of fallocate()
> operations correctly.
> 
> Again, I don't see a need for a new API here to provide
> non-destructive "truncate up only" semantics as we already have
> those semantics built into the ALLOCATE_RANGE operation...

The problem it loses the ability of an intelligent application using
the low-level Linux API to probe what is there.  That might not be a
major issue, but it is an issue at least.

