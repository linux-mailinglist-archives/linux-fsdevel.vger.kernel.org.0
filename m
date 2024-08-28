Return-Path: <linux-fsdevel+bounces-27611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A015A962D60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E487B259F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B11A3BB1;
	Wed, 28 Aug 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muD8Htpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172334CC4;
	Wed, 28 Aug 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861619; cv=none; b=hyxcOull2/z6oS67Nqi3O1PilUGAaF1AVxJaJB4Bb5MVSC4AybGYlU9FQZaWfiPAlkp0GTrK+BzpiWgeFnzb0dlPh8s4Q00c/HalZ8fK+YGg3FZswtGo7yqdIdynYCRXIfGfKvdhbxR/wgm985cU5WGJz/ePLlb4CxAYrSwKGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861619; c=relaxed/simple;
	bh=zdCdsY+jeYjKDjT+Cc27R2H1cgv6tyZ8edPuagZsmF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIBUGYAw/0XGLeKkJ2fhcovApIrR+XfNt8Kg3DmtPL9LnvKyE23951Tcb8Q2fl8lSCbSMBHmcpNWdoQoHa9LX0sDyIPlpzIfxsQm0y9ENsthXVrVyMMBD5ElkHdlKqwFRv07cbU5z9SkNCOru5dDLb1JUZoJmrXLzIQRCQscWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muD8Htpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD2CC4E697;
	Wed, 28 Aug 2024 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861618;
	bh=zdCdsY+jeYjKDjT+Cc27R2H1cgv6tyZ8edPuagZsmF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muD8HtpoC2P4gW2JExN+1d/z4b1TFD8Wnxb7u+W9/L82rxIq54X0L868QNCho7cNP
	 Skd3kkcLiL8olxgUzKMMjGbhfS/RoeJ1s7hWSrbCw4QIMHwxUVn3VqAFr0Hhqd/6EZ
	 4YID9FDfcO/95hnVwsvxWkXRu7nXzaf3Ssqu/pmu+oNaHYbi5Qzof2o0M+JDPlQY8P
	 o/jCzet1yGt6+TxMuEG0G3b00isV6APRJG4H6LLCRfhsTMZ+B0qMDx0Jn10bMlldto
	 5ApdvwNjiIS40T+fsDZRXa48GDYNb78lCf/w9wihsEOPnzHEhpaR6LNSpl9+Gus3ho
	 bfJJbX9sCZ+XQ==
Date: Wed, 28 Aug 2024 09:13:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: handle a post-direct I/O invalidate race in
 iomap_write_delalloc_release
Message-ID: <20240828161338.GH1977952@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-2-hch@lst.de>
 <20240827161416.GV865349@frogsfrogsfrogs>
 <20240828044848.GA31463@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828044848.GA31463@lst.de>

On Wed, Aug 28, 2024 at 06:48:48AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 09:14:16AM -0700, Darrick J. Wong wrote:
> > Is there any chance that we could get stuck in a loop here?  I
> > think it's the case that if SEEK_HOLE returns data_end == start_byte,
> > then the next time through the loop, the SEEK_DATA will return something
> > that is > start_byte.
> 
> Yes.
> 
> > Unless someone is very rapidly writing and
> > punching the page cache?
> > 
> > Hmm but then if *xfs* is punching delalloc then we're we holding the
> > iolock so who else could be doing that?
> 
> Yes.  It's only the async direct I/O completions that punch without
> the lock.

Heh, I forgot that I'd asked three questions.  Anyway I'm satisfied with
the answers I got, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Though we might have to revisit this for filesystems that don't take
i_rwsem exclusively when writing -- is that a problem?  I guess if you
had two threads both writing and punching the pagecache they could get
into trouble, but that might be a case of "if it hurts don't do that".

--D


