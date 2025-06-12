Return-Path: <linux-fsdevel+bounces-51420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED76AD694D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB2C3A775B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226A21771B;
	Thu, 12 Jun 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KxhQbr7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F391EB1AC;
	Thu, 12 Jun 2025 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713986; cv=none; b=oKLC/g19BBs6gjTNP/B6Lb8RNR6SGVCyOFFSTUSp3AoPqZnFipCUsA7RvcG+C76g4SqkzKgGi+ZjlrNfjeEdqsODFjgBRp7DDx6s+GrCiGZV6yryhIgN57YYeU+m3APUPhz/POu8ehh/tuO/FOTQTFw7kSRT25k3rpn7T6tLEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713986; c=relaxed/simple;
	bh=kt686VHtJ6hEnxfjptKCJFMQqSlvSYmuJY4ciSFwXR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNd0ma/9Dwi3ylAYCBVbwFh11Wb5zeKhWSAqaaKccl6OFVj5XwLJxs9railLNVFnPmftj+aRw3YSki1tDgXyn+fmmwBPO8YwTdgXgy85ypvyDf6LXvgou8BjIiUzOP7oC+4+Rm+eirQg7bfy64lXUEs9vbeC5lMQbr8Uum6MxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KxhQbr7j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ynCU26HeRltCjmpdIassn5oQo0zCrDNqMapd9thqJ+s=; b=KxhQbr7jt+DF5Jv+Uld1TvU8js
	pkz/EoNQ2LFusq7BA/ah+B1aFAq6KZFXR01dcySp4xGzz0lp+nLT/JdooarhESqUryeR4uAg3jF6c
	LWB6uI75lF2xompOnRSGGFXyIjXSzUTTPIhaZhbJ5CRqxl69ZmFiSIbxe+KY9Zmq/xG21DslngElZ
	eZzg6X9/Dn42Rg7em9mdgGrO3fjqZ8fYOBYAh3/xuyWrCDTVn3nFHxzT5BEVTMRIyK5wKwp322N/o
	PoABB+fHTELo8DXBh+oM2GuF0z2qIfsae0DavYL4ZrpZhNcQWpmEtpspeUjCa8GFHqKBGrnljFE/m
	tg5P4liA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPcXI-0000000CTUW-3t0H;
	Thu, 12 Jun 2025 07:39:44 +0000
Date: Thu, 12 Jun 2025 00:39:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
Message-ID: <aEqEQLumUp8Y7JR5@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <54acf3548634f5a46fa261fc2ab3fdbf86938c1c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54acf3548634f5a46fa261fc2ab3fdbf86938c1c.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 08:55:20AM -0400, Jeff Layton wrote:
> To be clear, my concern with *_DONTCACHE is this bit in
> generic_write_sync():

> I understand why it was done, but it means that we're kicking off
> writeback for small ranges after every write. I think we'd be better
> served by allowing for a little batching, and just kick off writeback
> (maybe even for the whole inode) after a short delay. IOW, I agree with
> Dave Chinner that we need some sort of writebehind window.

Agreed.  Not offloading to the worker threads also hurts the I/O
pattern.  I guess Jens did that to not overwhelm the single threaded
worker thread, but that might be solved with the pending series for
multiple writeback workers.

Another thing is that using the page cache for reads is probably
rather pointless.  I've been wondering if we should just change
the direct I/O read code to read from the page cache if there are
cached pages and otherwise go direct to the device.  That would make
a setup using buffered writes (without or without the dontcache
flag) and direct I/O reads safe.


