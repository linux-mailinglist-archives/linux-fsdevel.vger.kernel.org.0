Return-Path: <linux-fsdevel+bounces-55212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CDFB08759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D1A565215
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 07:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375725E44B;
	Thu, 17 Jul 2025 07:51:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7123507F
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738692; cv=none; b=E/p/Y/+i5N2UF1AUlT35C4yfX477tSLtcS/edOkmSGTpSVJGEAtzYkuI7J/qAtZE0jMF5EmlspmGRQShAjEto6l+/V49Pi4CpprzH6FD1izgLR5NuI7RxoYa/cF3egGZGHpSbCRK+sp3wOcs4aD/9mRhBVS3doSeszYV2AfGmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738692; c=relaxed/simple;
	bh=c5cOHKT0LCfOuG2vq1Oj9WpDusRH+V6D544GmkEOb2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh+lhdcB0IjYBG4ZkkRKWj8oD0YkQOHfIL4HpQng19btdkexSK8iIIGDLMWG6+dAu1lXFEEQSLhoqr+fTjIbBghQdiCJ2mO9ajGC4fC3uRvDcrIiQfDcF+tbn5ivxPxmrhnnw77CITIU95smXvORW2VJ8CXuria9XBDpc0v31/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D660D227A87; Thu, 17 Jul 2025 09:51:23 +0200 (CEST)
Date: Thu, 17 Jul 2025 09:51:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250717075123.GA1356@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org> <aHZ9H_3FPnPzPZrg@casper.infradead.org> <20250716130200.GA5553@lst.de> <20250717-studien-tomaten-d9d1d7b5e6e8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-studien-tomaten-d9d1d7b5e6e8@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 17, 2025 at 09:48:49AM +0200, Christian Brauner wrote:
> On Wed, Jul 16, 2025 at 03:02:00PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 15, 2025 at 05:09:03PM +0100, Matthew Wilcox wrote:
> > > will be harder, we have to get to 604 bytes.  Although for my system if
> > > we could get xfs_inode down from 1024 bytes to 992, that'd save me much
> > > more memory ;-)
> > 
> > There's some relatively low hanging fruit there.
> > 
> > One would be to make the VFS inode i_ino a u64 finally so that XFS
> > and other modern files systems an stop having their own duplicate of
> 
> That's already on my TODO since we discussed this with Jeff last year.

Cool!

Btw, I remember anothing I've been wanting to look at, which is
killing the u/g/p quota pointers.  If we used a rhashtable with
proper sizing for them, doing a hash lookup instead of the caching
should be efficient enough to be noise compared to the actual quota
operations.  That would free three pointers per inode, or in case
of XFS six without the optimization in this thread.
---end quoted text---

