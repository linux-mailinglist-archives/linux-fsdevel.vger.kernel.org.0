Return-Path: <linux-fsdevel+bounces-4434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AA7FF66F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E404B209F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9855763
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iSUjxsLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F067C197;
	Thu, 30 Nov 2023 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=92VXvFUlFRJzLvUpsx/6oVUi1MNnsUSU071rX2CwwRM=; b=iSUjxsLr5KjK+1lFq02//yGooQ
	AJtK8D9RIfzXEbgA097WkSZMuge9IiiKpHaAe1S9eSxu8J62ZR82s+0XybDp7nB2ItKkeeKPF1m2B
	cQs0T0zlPdVWuQW0fTXWVN0G4ufSvyKANxymWR2KU/FlqZt8455J1WfHYCTQF0qyvMqSUGD6aSw1d
	F+JLSW1u5BaU5gD8gKdQWM7hqx0eOebkzfwJ9ytzznvAk5xYDNYxw6B6ykCXyFotq2uYvy0kcs4/b
	TrkKjWDuHUViO+YGEj3wWPfPyelhEmgpdvZTTfQcr+O4t4VumpR9ld08GJOEus9aC9sOGbjvF4hU9
	zIXU7qEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r8jVp-00Ecwr-8G; Thu, 30 Nov 2023 16:03:37 +0000
Date: Thu, 30 Nov 2023 16:03:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZWiyWfEuWmPc+VuO@casper.infradead.org>
References: <20231130140859.hdgvf24ystz2ghdv@quack3>
 <878r6fi6jy.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r6fi6jy.fsf@doe.com>

On Thu, Nov 30, 2023 at 09:20:41PM +0530, Ritesh Harjani wrote:
> OR, one other approach to this can be... 
> 
> IIUC, for a new block mapping for the same folio, the folio can be made to
> get invalidated once in between right? So should this be handled in folio
> cache somehow to know if for a given folio the underlying mapping might
> have changed for which iomap should again query  ->map_blocks() ? 
> ... can that also help against unnecessary re-validations against cached
> block mappings?

That's pretty much exactly what buffer heads do -- we'd see the mapped
bit was now clear.  Maybe we could have a bit in the iomap_folio_state
that is set once a map has been returned for this folio.  On the one
hand, this is exactly against the direction of iomap; to divorce the
filesystem state from the page cache state.  On the other hand, maybe
that wasn't a great idea and deserves to be reexamined.

