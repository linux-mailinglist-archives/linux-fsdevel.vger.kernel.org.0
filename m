Return-Path: <linux-fsdevel+bounces-52762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F9AE6505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B7179725
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A82951CB;
	Tue, 24 Jun 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1pklRl97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D928ECE0;
	Tue, 24 Jun 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768248; cv=none; b=HWx79nbcPExXOAOyUZsJx3nD8KTCfs+Lt0LGvZL5FwXivi8or469kbdZB01UFHrFAag1OVGPliVcx8QOFc84/z7Lgu1bu82+EQsGqsJ3RZ1VIMUg4hBbi5JwDHQ0fxdUsDEWuWCVZN5wBH8h1ZadchUgbkRDcJVlX5zbnHfScSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768248; c=relaxed/simple;
	bh=IjM0NHnKN6LTObmdbH1FkCW2t9jx7C0HhZBkuwk5XRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKwzRqfp7DyxA6bLjfmJCgQnrIjCZZAzLKyl1emR6sEgRIrW0kTJSDc1220MtUKRYMQJU/NqjJB5o0lIKrgp1HMY4LWwJIPnG7V2AqM2lw++tlDwVOkYd9PXw5ac6nU2WXTmwUuf1wTWgOE4fBf9QadXd1P6ztQf67Li81bOSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1pklRl97; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vq4U1GOUj6esgARKwMxGsslJLJjUh2JF63zzR7Tc7nk=; b=1pklRl97p2cRC7rYdqv7tQnpcE
	YA/ab2RiKKXc0aTwilyWC7id/Her/+ygLJJbPQBYTnhjdL/LQqPiBLRNQoHFtkzROea+z1zElfpaL
	KNk0NRtdyLNA91fqe7mlmXk64IO2dB0HpULiHAbOFOhoaw0n8frbsAw86wJc0uC0c5hCnQRyjuDaI
	DG6Ai19r7pCZwg8tP1MVK1qkhhCt6BnQFWLkAoauYSPVtH9ooNu6U/yUxtvJNiiUJ/HRJXDkcv+Ev
	DLBecU5+EuaWAO1MMRP87DKySEBZSj5VlVzS2OfAMT+ptlMVUw1nhYlbaImln+qYb2bZlR0bbIrAX
	aURuxOXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU2nU-00000005aMw-0wc7;
	Tue, 24 Jun 2025 12:30:44 +0000
Date: Tue, 24 Jun 2025 05:30:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <aFqadK7JiATTzBP2@infradead.org>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 24, 2025 at 06:57:08AM +0930, Qu Wenruo wrote:
> > When the VFS/libfs does an upcall into the file system to notify it
> > that a device is gone that's pretty much a device loss.  I'm not married
> > to the exact name, but drop seems like a pretty bad choice.
> 
> What about a more common used term, mark_dead()?

That's even less generic than devloss.


