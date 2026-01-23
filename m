Return-Path: <linux-fsdevel+bounces-75242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI/GL/Myc2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:36:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E78972966
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F155E301DC1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A450322B77;
	Fri, 23 Jan 2026 08:35:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F62DE1FA;
	Fri, 23 Jan 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157359; cv=none; b=KypCMqpaD3SjGk9ThvndYxUfdOTH/FujGYXtgxZiMhXb6AmHnWQ4eyNb8MkdBDVXsONMAOxIHFAj7I1u0dpIeAo2rZiQ1Ig0kex5WH2yRIusoLEapma/oWLe2HgCBSbNSyx3AR6eovgh7RQSW7Mp9cDlHyHO4wKLyDU7pJgDJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157359; c=relaxed/simple;
	bh=4xe7FzvjqGCo86DTA9TePIu6gBkFRDzmOQywZnr4y7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqliJ7gF/PMTc6xWpSpaosO1d8mcUq3NT47Wq3Gzf7n8M+E61ifZnWFxYqOfQd3q4RlE16WzCN7l7ANGWxOkxejTnkRl/c7uJzkotMruKjPvT+D19sMniYeDblQU7KXTD5nWhBLCLg3Z4STuHGVNNkUNkXZsUahsPVS7p7p5bJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F08D227AAF; Fri, 23 Jan 2026 09:35:54 +0100 (CET)
Date: Fri, 23 Jan 2026 09:35:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/14] block: refactor get_contig_folio_len
Message-ID: <20260123083554.GA30708@lst.de>
References: <20260119074425.4005867-1-hch@lst.de> <20260119074425.4005867-2-hch@lst.de> <824538a6-ce9d-41e7-9485-10ff9e4d5334@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824538a6-ce9d-41e7-9485-10ff9e4d5334@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75242-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E78972966
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 07:32:04PM +1100, Damien Le Moal wrote:
> > -	unsigned int j;
> > +	struct folio *folio = page_folio(pages[0]);
> > +	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
> > +	unsigned int max_pages, i;
> > +	size_t folio_offset, len;
> > +
> > +	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;
> 
> folio_page_idx(folio, pages[0]) is always going to be 0 here, no ?

No, page could be at an offset into the folio.


