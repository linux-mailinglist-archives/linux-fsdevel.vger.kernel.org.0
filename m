Return-Path: <linux-fsdevel+bounces-41422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57520A2F503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C449C3A6D26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD224FBE3;
	Mon, 10 Feb 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TV/IkCyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF524F5A0;
	Mon, 10 Feb 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208019; cv=none; b=GyqcjQvh/4dFmRtv71f/syifgpL4Ym2LNSp0t7MTMhORhEEft8dLkouffMOAhwOCc6cntDyA1i9hpE5cVSP+0PUTYikrFvnq2Nsf9dRslT8TSLAQI0FuDr2PZcSYqb76JU5uSbDmAsdBs7UX+i658lPiLbjDno33sxAk5pQD68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208019; c=relaxed/simple;
	bh=hM+KtGee0DBGmElFHqh4Dk8/Tgf96P6/TXuR6T7QK1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMwf4NuFdJHhj2YxxKOWK9CeKSZewkvmV8f/riU2KZ7d9Ugk+rWlkgDToDuieN+sarKqxMDtieBbgAez7prcDGKZuP77yQrbJGq1CoRngf/lCBUS1XY7YWtUIBDFzTVXXxT4FhgG3RKGMSv1+spUmm9/oL+5pvSmfz0wUxtiHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TV/IkCyS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pklYGgzM6xnfX5CyE/d340+EA7VudroV6w5u0YV+5jk=; b=TV/IkCyS8FG7w8lnDCKRHnBTg5
	sZpJxCbY/q96exXJhUmIHL4RS1tiwKMIypxRT/uioC3OGrL+XYcyb76DkCDSRiBMrlGhZjZfEtFni
	d/fywoBGGYZneRBF7HOIVkp5DAmWikdoc3LQUW8xT5Jimm6ZRrmcTj6X2Cc8mYi2vmsQmggW5AfA4
	f2iqX6SH47GRcMc2TO+xXeeIjVq4H86cHHvPVtAHYQODuezfzHbfT0Oo2GxwQ7EGEZifhFyN0Z4EI
	wfJ7MzmtYiQriocPX3FDSUULfeMKH3Juh4WH+qqRm2A/2lVTaY08t65WKzFUn0UVFhJP0rmTWAWQU
	ZFDK2R8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thXS9-0000000GL8w-3XD9;
	Mon, 10 Feb 2025 17:20:13 +0000
Date: Mon, 10 Feb 2025 17:20:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z6o1TcS7mQ2POrc9@casper.infradead.org>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
 <Z4q_cd5qNRjqSG8i@google.com>
 <Z6JAcsAOCCWp-y66@google.com>
 <Z6owv7koMsTWH1uM@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6owv7koMsTWH1uM@google.com>

On Mon, Feb 10, 2025 at 05:00:47PM +0000, Jaegeuk Kim wrote:
> On 02/04, Jaegeuk Kim wrote:
> > On 01/17, Jaegeuk Kim wrote:
> > > On 01/17, Matthew Wilcox wrote:
> > > > On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > > > > I don't understand how this is different from MADV_COLD.  Please
> > > > > > explain.
> > > > > 
> > > > > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > > > > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > > > > at the time when it's called. The idea is to keep the hints only, and try to
> > > > > reclaim all later when admin expects system memory pressure soon.
> > > > 
> > > > So you're saying you want POSIX_FADV_COLD?
> > > 
> > > Yeah, the intention looks similar like marking it cold and paging out later.
> > 
> > Kindly ping, for the feedback on the direction. If there's demand for something
> > generalized api, I'm happy to explore.
> 
> If there's no objection, let me push the change in f2fs and keep an eye on
> who more will need this in general.

I don't know why you're asking for direction.  I gave my direction: use
fadvise().

Putting this directly in f2fs is a horrible idea.  NAK.

