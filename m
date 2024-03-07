Return-Path: <linux-fsdevel+bounces-13889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC2875277
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844FA1F24494
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34812EBCF;
	Thu,  7 Mar 2024 14:55:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1271E897;
	Thu,  7 Mar 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823300; cv=none; b=HDmfqVTntMtROKFRnlj7MmkPykAcI2uC3SFhJ9om6l5BktdsL5Tfua3aoMvdCMgyM5NDX3uimRLhw3sPQr2rYSWU1WXdYUImq9sEkpnhw6YKUf8UV23mwaSYn4ciH02QOx/Wpl1V2gnyEPWUEoJcl89MRWEFVss8oV9FPaZqeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823300; c=relaxed/simple;
	bh=5klGFeusxPf2AcVg0+ohMPA+OeJIQ42jAC1ws8tqDqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShUX1FbjGWhJzK92SJC0ipTZcNov+UhHGB0VVETMN+40OOMHq2MsTgbRJ8csy1RbEXPIqI4dV7v0MfYoyHLVhLK0TCWJ94w/TWFAg1yMkF9GoJRfkCxQIIj4Zp5cNNge86xnciUAiYEExvraYdKGo1y72MLujf8O+2cfVuumGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2ABB768CFE; Thu,  7 Mar 2024 15:54:46 +0100 (CET)
Date: Thu, 7 Mar 2024 15:54:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
Message-ID: <20240307145445.GA28823@lst.de>
References: <ZelGX3vVlGfEZm8H@casper.infradead.org> <1668172.1709764777@warthog.procyon.org.uk> <1831809.1709807788@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1831809.1709807788@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 07, 2024 at 10:36:28AM +0000, David Howells wrote:
> There are some places that should perhaps be using kiocb_invalidate_pages()
> and kiocb_invalidate_post_direct_write() instead - assuming Christoph has no
> objection to the latter function being exported.

These are intended as helpers for direct I/O implementation, so I
very much expected them to eventually get exported.


