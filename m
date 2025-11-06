Return-Path: <linux-fsdevel+bounces-67324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAE5C3BDA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A13A3532
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A0342CB5;
	Thu,  6 Nov 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ia2TRo7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A533F8BE;
	Thu,  6 Nov 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440157; cv=none; b=W53TO3WAhtNoPCYBOLT5Sszn7ngYmRHpKCpfX2Kwaj+UT/tn28eOanHaWILksol8aoWdm9ag3OheiTXghkyvZiVEuxydSlZ1LhiC/wdXi8JlyKUxK80hAixFSEyTP0JJ0WFIdAIr/QDXQOwjwWg5ukJyPpZK/nnAI8gbihQ4al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440157; c=relaxed/simple;
	bh=XCL0KhhrHG5plCqfuuBw0XxZzn9yfR42S6yeDmlCXqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErqAllMMH5uc+mkyxzv28THTse9w2qfiVK3Ic37wMsN4lYYVuQkl7uav6RyMBRBOWWPPpu2/h5rM0J39yVQwSteP8HA7z0QmNIoyo3FA2toij8Yht1KCUiK96vK57rWHkSBbEUfGZQZJZx0bR1KAXOEGFwAUTYD3w//YYIRwQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ia2TRo7B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sJ9c+b+VfFvQuoP2g/4jPNJjSn7A1S3rq8wxhwzlLak=; b=ia2TRo7B6xlRXy2oLByeygzrdf
	MZZ1WYSLYaf5VRrlQ4b/jipQL8wOKwkJvoXMFCKT07vBziOIe1pwNlMn0SWBRQHiGYc0qwnKT4Eax
	ZVM5ILcm1EsGvcJLw39QiJbZwGimtuq3ucPJOlMDk9rbKtnyuoXPpFyzqZ87X/tb6etOWPw9sv6ol
	uFVHMmcGBRuy9OUIDvriMXsHeW9Jqi15ZVGv635bxbVBLnlMxeZZp7Mw2pLf9LxJhyvVW3C8y+i1N
	InUbt0xRjXuiyK+EpKYytkFr46BToh8nhXKjYlRuXfOGFrRMQwiznbx6yPd5xULO1q6Gby7VZfYIg
	bIZwEptA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH1C2-00000004A5h-2uxe;
	Thu, 06 Nov 2025 14:42:30 +0000
Date: Thu, 6 Nov 2025 14:42:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Florian Weimer <fweimer@redhat.com>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <aQyz1j7nqXPKTYPT@casper.infradead.org>
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
 <lhuikfngtlv.fsf@oldenburg.str.redhat.com>
 <20251106135212.GA10477@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106135212.GA10477@lst.de>

On Thu, Nov 06, 2025 at 02:52:12PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 02:48:12PM +0100, Florian Weimer wrote:
> > * Hans Holmberg:
> > 
> > > We don't support preallocations for CoW inodes and we currently fail
> > > with -EOPNOTSUPP, but this causes an issue for users of glibc's
> > > posix_fallocate[1]. If fallocate fails, posix_fallocate falls back on
> > > writing actual data into the range to try to allocate blocks that way.
> > > That does not actually gurantee anything for CoW inodes however as we
> > > write out of place.
> > 
> > Why doesn't fallocate trigger the copy instead?  Isn't this what the
> > user is requesting?
> 
> What copy?

I believe Florian is thinking of CoW in the sense of "share while read
only, then you have a mutable block allocation", rather than the
WAFL (or SMR) sense of "we always put writes in a new location".

