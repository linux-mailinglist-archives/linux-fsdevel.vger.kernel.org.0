Return-Path: <linux-fsdevel+bounces-67326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D202BC3BE14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70DB250354F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A713451CD;
	Thu,  6 Nov 2025 14:46:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE61D271;
	Thu,  6 Nov 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440377; cv=none; b=MvfcrH+KImPZMt0ff3EQCpF0LmMOw7t+0UkjUw8UW53Sw7N/lZYwPnqY9rZqzSvEJkmvSHGUVDu4827HW07bLhZqdBaEovn7dS41HkbIIo3tC6azZLVF4+6U+jmpTTGn5gkdsq80jTOG7NDBO7Nyv17PCFKlY6KWKq56YrAgqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440377; c=relaxed/simple;
	bh=FaWCe0HBuSNVm+1a2uvCPEoKIlnvRBc0xcItbF2Xdqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhoWPgwsw74TbIlggLNhSvJZ02PDRj7kJE9RCtTdJjHqPFLMaCX9AfK1rknLgBqH/+GtFXQFzmMBSSJqAPOWvJi9JfmbqIUH06LN4PyUnCMKgQxlHec8a/MZbKPoWCxNEtCj9DYFvu9q/mYnsGxVgYfq+LFDezGpXjykV9ZjIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECB46227AAE; Thu,  6 Nov 2025 15:46:10 +0100 (CET)
Date: Thu, 6 Nov 2025 15:46:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251106144610.GA14909@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQyz1j7nqXPKTYPT@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 02:42:30PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 06, 2025 at 02:52:12PM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 06, 2025 at 02:48:12PM +0100, Florian Weimer wrote:
> > > * Hans Holmberg:
> > > 
> > > > We don't support preallocations for CoW inodes and we currently fail
> > > > with -EOPNOTSUPP, but this causes an issue for users of glibc's
> > > > posix_fallocate[1]. If fallocate fails, posix_fallocate falls back on
> > > > writing actual data into the range to try to allocate blocks that way.
> > > > That does not actually gurantee anything for CoW inodes however as we
> > > > write out of place.
> > > 
> > > Why doesn't fallocate trigger the copy instead?  Isn't this what the
> > > user is requesting?
> > 
> > What copy?
> 
> I believe Florian is thinking of CoW in the sense of "share while read
> only, then you have a mutable block allocation", rather than the
> WAFL (or SMR) sense of "we always put writes in a new location".

Note that the glibc posix_fallocate(3( fallback will never copy anyway.
It does a racy check and somewhat broken check if there is already
data, and if it thinks there isn't it writes zeroes.  Which is the
wrong thing for just about every use case imaginable.  And the only
thing to stop it from doing that is to implement fallocate(2) and
return success.

