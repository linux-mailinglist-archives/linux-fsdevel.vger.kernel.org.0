Return-Path: <linux-fsdevel+bounces-24611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAF941437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBAD1F212DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E101A08DA;
	Tue, 30 Jul 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAcW5wT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277B522F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349403; cv=none; b=dYH3HqpCoqEx4PR/gXCa1IAv2BaKR+TxObndLe6rMzILF+YjapW+C3qXg24CXDICbCGw4v3OOe035OQAChoNzV/rKGq6WWDk6SnAgWj3Uo2ut9AqUEAi8zwYN5WyVFW+GzFN8Ht7iT2SZxDjP9jw2fRxPtPqmVGNtEzN6wXhhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349403; c=relaxed/simple;
	bh=QGfio2IKSW5gKG9NqApubJUcAr3HLzOJStodwrsNlSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImC5FW4uR3c6QhC3sXmrV9VzezIPZecCcJXgUx++ltG7CjmPH6qdMKUrrxP2FcvBhBHx8/E5m3Gij0+/tsXF3McqT5Xboq4PUTtUfIAIjjRjI6r4Vn+lzMEAky+DtracKg/ZutdVgJO1lHZJODf0tid138qQpDKom5Lq+V4rYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAcW5wT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EA2C4AF0E;
	Tue, 30 Jul 2024 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722349403;
	bh=QGfio2IKSW5gKG9NqApubJUcAr3HLzOJStodwrsNlSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAcW5wT7pfDs2iNeGew9J0qfKyhrZjoxiLbPgMTXQ+TM9aWPmETL0PaGhTgLVGL9k
	 SXohy2SlHO5eaflkrcO1VAkSlBEIEKgYJJtHp2RzJUONb/snVfmbX/L/g7ZI4jZfim
	 DMKTxaDk0XEjPaH+eIZh3xE74irxnT+kGcUuem+Usnm0a3k4zhuVF0vlzj7IS7vj8X
	 6sFUREx02SyrCEgfwS7IwHcCUruD7WhrXa/kvHbHrmc/FGnq4wNu+22zRcgRnY9zyH
	 upx7psOHe+wC8sUID549kAK5oNgWRQlzTXqqiBYQjtew74jUPAtg6vJUX1y9h7A21I
	 5hRrvSVqs6UmA==
Date: Tue, 30 Jul 2024 16:23:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] Convert write_begin / write_end to take a folio
Message-ID: <20240730-gasteltern-umstritten-36bac982fe4c@brauner>
References: <20240717154716.237943-1-willy@infradead.org>
 <20240723-einfuhr-benachbarten-f1abb87dd181@brauner>
 <Zp-uLk9wCP5tIc6c@casper.infradead.org>
 <20240723-gelebt-teilen-58ffd6ae35ec@brauner>
 <ZqA0oachCIQ1Uj6E@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqA0oachCIQ1Uj6E@casper.infradead.org>

On Tue, Jul 23, 2024 at 11:54:25PM GMT, Matthew Wilcox wrote:
> On Tue, Jul 23, 2024 at 03:41:37PM +0200, Christian Brauner wrote:
> > On Tue, Jul 23, 2024 at 02:20:46PM GMT, Matthew Wilcox wrote:
> > > On Tue, Jul 23, 2024 at 09:49:10AM +0200, Christian Brauner wrote:
> > > > On Wed, Jul 17, 2024 at 04:46:50PM GMT, Matthew Wilcox wrote:
> > > > > You can find the full branch at
> > > > > http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end
> > > > > aka
> > > > > git://git.infradead.org/users/willy/pagecache.git write-end
> > > > > 
> > > > > On top of the ufs, minix, sysv and qnx6 directory handling patches, this
> > > > > patch series converts us to using folios for write_begin and write_end.
> > > > > That's the last mention of 'struct page' in several filesystems.
> > > > > 
> > > > > I'd like to get some version of these patches into the 6.12 merge
> > > > > window.
> > > > 
> > > > Is it stable enough that I can already pull it from you?
> > > > I'd like this to be based on v6.11-rc1.
> > > 
> > > It's stable in that it works, but it's still based on linux-next.  I think
> > > it probably depends on a few fs git pulls that are still outstanding.
> > > More awkwardly for merging is that it depends on the four directory
> > > handling patch series, each of which you've put on a separate topic
> > > branch.  So I'm not sure how you want to handle that.
> > 
> > I've put them there before this series here surfaced. But anyway,
> > there's plenty of options. I can merge all separate topic branches
> > together in a main branch or I can just pull it all in together. That
> > depends how complex it turns out to be.
> 
> I've rebased to current-ish Linus, updated to commit f45c4246ab18 at
> the above URL.  It all seems to work well enough, so I'm not relying on
> any later commits.  I can rebase it onto -rc1 when it is tagged, or
> you can pull it now if you'd rather.  It's missing the R-b/A-b tags
> from Josef & Ryusuke Konishi.

I've rebased to v6.11-rc1 and added the missing Acks. I also added your
SoB to "qnx6: Convert directory handling to use kmap_local" which was
missing. Let me know if anything looks wrong. It's in the vfs.folio
branch.

