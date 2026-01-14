Return-Path: <linux-fsdevel+bounces-73615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC30D1CB2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 456F0307B3E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C836E473;
	Wed, 14 Jan 2026 06:41:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB212E62A2;
	Wed, 14 Jan 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768372901; cv=none; b=PEewy3p8ZOmtXWK0/M6On5lv/HktG6rlzP9AP7usGLMjj4ungpM/Z1v1NZqxyDMppT1V2daBpPogh7JVYPlssze+SCs3cpk9hHjvgNrzu0zG1RGAXm3r9GbZcu/1F4HFazkC7I7ozVgMs7z10bMCdgJ8qJ9fqilSXs3a4Dpu4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768372901; c=relaxed/simple;
	bh=Wk2Qes8mC74BQQVtKDTbnWWnLCvdYM7n1bvz88FbkT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHXsCsacDOKjgMejpJjHm0es9z2uYiVz/Nlc9XxN71Gn+PKy7oM2zXapCKimDAnAXzoOJ686PwuKdHTaQxVN4jHJ6ZH14IOHE+DNmh//+wg7ST2jLVkx+QZOpASau4ohHUBw202A4uksxLtESxMZDRfZAvnsHOG7VzCFvQzH3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BC1C227AA8; Wed, 14 Jan 2026 07:41:31 +0100 (CET)
Date: Wed, 14 Jan 2026 07:41:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take
 iocb without file
Message-ID: <20260114064130.GB10876@lst.de>
References: <cover.1768229271.patch-series@thinky> <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q> <20260112222215.GJ15551@frogsfrogsfrogs> <20260113081535.GC30809@lst.de> <aWZ2RL3oBQGUmLvF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWZ2RL3oBQGUmLvF@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 04:43:48PM +0000, Matthew Wilcox wrote:
> > It's not passed down, but I think it could easily.
> 
> willy@deadly:~/kernel/linux$ git grep ki_filp |grep file_inode | wc
>     109     575    7766
> willy@deadly:~/kernel/linux$ git grep ki_filp |wc
>     367    1920   23371
> 
> I think there's a pretty strong argument for adding ki_inode to
> struct kiocb.  What do you think?

That assumes the reduced pointer dereference is worth bloating the
structure.  Feel free to give it a try.

Note that we'd still require the file to be set, otherwise we're
going to have calling conventions from hell.

