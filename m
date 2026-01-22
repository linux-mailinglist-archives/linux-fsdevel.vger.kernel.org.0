Return-Path: <linux-fsdevel+bounces-74996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJgqLAzjcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:42:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 209BD6357D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62D8962A56C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB453D7D65;
	Thu, 22 Jan 2026 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2moXo0MM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB117A300;
	Thu, 22 Jan 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070872; cv=none; b=KEgPEC3HxY+38CAYF8Dt8c5GyOJ/aEXiIxyYCwLUFZtEzuS0suJNeCZsr6x/ug+KbjCwjIkBYxuCYrwXcoNRlDjocs+UVWADDa1aJqYI9IVQz8lmowyeDgGwl3qcgvSS89zy9vpBMXxr+nVrwBzxi9BG5es3xVApS2JrwKSBa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070872; c=relaxed/simple;
	bh=Ec9HSKoS+AjRIYzZwTjw9D3Foun14L6Ec3gSgfCISms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILp3WmUMB1LkPxNTCRpVAnysqbniKEiaJx+pYxU3neExNWaUnRYgiKB/u62Bq1lCrvvs5flydppbgzSLAG7ALACHX23GATFq1NW8i7i1OaO4VWB3TmcQRnkIQGljUhNcP+64IeMbYHahV0rTPEOTSWIsQ4jGpNNUNzqLMm277oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2moXo0MM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wyKG6mSVnYVdf6WsGgp/YJqBxiUMWc/coML45itFX9Y=; b=2moXo0MM7AqnOr1r91L6tzTt0Q
	8Y4djegXXpfVa/iRYwy5+HfmImkZq/F+jqFu0eN101xM1Pg4Yrcu22qbT5qeBmFHTF99Bh2iU2yqP
	NDIWpRfPtHUvqb5CZQ+RrNe7mFT79LRaVE7alJFRxUFZva1lmQtuTOHuNG5guqb6Z3G+9W1HzS61b
	vl/P6QVlwyhzxjm3wXWTGtIw+fewNWfjVG8hDKxyaCGgvJuLMKdjcaSy8KvcI0wt54yOVytH12+GO
	H/T+2MD+uAlklTccD9cnGVXmeGOjcl+CCavvGFgDqXe2LExL4CnOnZPvlEGe0Q+98/UPz13rAA08k
	2sNAS85g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viq96-00000006epL-3gs3;
	Thu, 22 Jan 2026 08:34:28 +0000
Date: Thu, 22 Jan 2026 00:34:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] f2fs: improve readahead for POSIX_FADV_WILLNEED
Message-ID: <aXHhFN-feFYFcKYu@infradead.org>
References: <20251121014202.1969909-1-jaegeuk@kernel.org>
 <aSALfvLUObUGSx-e@infradead.org>
 <aSCpzRW8mUhNnjHB@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSCpzRW8mUhNnjHB@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	TAGGED_FROM(0.00)[bounces-74996-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 209BD6357D
X-Rspamd-Action: no action

On Fri, Nov 21, 2025 at 06:05:01PM +0000, Jaegeuk Kim wrote:
> On 11/20, Christoph Hellwig wrote:
> > On Fri, Nov 21, 2025 at 01:42:01AM +0000, Jaegeuk Kim wrote:
> > > This patch boosts readahead for POSIX_FADV_WILLNEED.
> > 
> > How?  That's not a good changelog.
> > 
> > Also open coding the read-ahead logic is not a good idea.  The only
> > f2fs-specific bits are the compression check, and the extent precaching,
> > but you surely should be able to share a read-ahead helper with common
> > code instead of duplicating the logic.
> 
> Ok, let me try to write up and post a generic version of the changes.

Did this go anywhere?


