Return-Path: <linux-fsdevel+bounces-54546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B155B00C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 21:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC3C4A2131
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB32FD875;
	Thu, 10 Jul 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKXXsY6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDD2367CB;
	Thu, 10 Jul 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177098; cv=none; b=umRFDpgAd8TLCdG502xknZs6p45TUW4lkZ5ZaLPWMYtLQCTIlVZZPfv+8AYNJyWC0dPuEPvXvs2iM6VfVOf2oCGCQCySaKN+ySL5ilj6Z4FFYC0/4Wf/qhbPBdy49LE4htA/1+ehurk51REXUFSY4W7Bk/vlMnyNxcGpR7Z/dOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177098; c=relaxed/simple;
	bh=z6Vb0hDPgvh+Zg/g3GJWRWckfO4hy+X/KmQVekry7Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh7tLPqS5RlZ+3WQdQBjggt29rbMtxCpkUtyJHAWzgogdrCEvw8qRbFIAXM2g5pCSLl0WhhMcLX+/N4B6tMkjiJDT+ggWlbMvK6168A7RkSFwnga7R9f6jx8EVmtSLz9AQloQxV35wKALOUbTiBHKYBl5u7d3fZE4oaQBSsYdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKXXsY6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FEDC4CEE3;
	Thu, 10 Jul 2025 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752177095;
	bh=z6Vb0hDPgvh+Zg/g3GJWRWckfO4hy+X/KmQVekry7Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKXXsY6xEsTP5LTdTXEndWnZXO//ZS4oKNP3v80/LspWjeO5VekHTsvEKVCMNT55I
	 7FE1RKuJ1jJqZC/cvrzlqn/2RVRgM0ag1LoAdlefTEKXtSiJTbtWMrupEG042Lyhxg
	 BlzxOf/ZD8JhYrD4XI16oH3GzpS2kI+5jWiZSORM7/kM45Vkb+FXAZEs2KIZKkXQZ8
	 ifQwAmGCJjdUvFvfczT72D2/0KFmr8xuy+5Ey5/5l0+xgu78pfOPIEnbmYKemYnhuj
	 eRYn8v7ABRs98YPs/4V3p3prACHHX4zngKGSeXdw4A2laBWCa4WHk0bK902xW07DQK
	 nCc3+jFjqc0lw==
Date: Thu, 10 Jul 2025 13:51:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aHAZxExjUt6pkiNh@kbusch-mbp>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <5819d6c5bb194613a14d2dcf05605e701683ba49.camel@kernel.org>
 <aG_SpLuUv4EH7fAb@kbusch-mbp>
 <aG_mbURjwxk3vZlX@kernel.org>
 <aG_qYnxiK1Rq5nZR@kbusch-mbp>
 <aG_28zNe3T-wt7L8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG_28zNe3T-wt7L8@kernel.org>

On Thu, Jul 10, 2025 at 01:22:59PM -0400, Mike Snitzer wrote:
> On Thu, Jul 10, 2025 at 10:29:22AM -0600, Keith Busch wrote:
> > The trim calculation assumes the current bi_size is already a block size
> > multiple, but it may not be with your propsal. So the trim bytes needs
> > to take into account the existing bi_size to know how much to trim off
> > to arrive at a proper total bi_size instead of assuming we can append a
> > block sized multiple carved out the current iov.
> 
> The trim "calculation" doesn't assume anything, it just lops off
> whatever is past the end of the last logical_block_size aligned
> boundary of the requested pages (which is meant to be bi_size).  The
> fact that the trim ever gets anything implies bi_size is *not* always
> logical_block_size aligned. No?

No. The iov must be a block size, but if it spans more pages than the
bio can hold (because of bi_max_vecs), the total size of the pages
gotten is only part of iov. That's the case that 'trim' is trying to
handle, as we only got part of the iov, so it's aligned down to make
sure the next iteration can consider perfectly block size aligned
iovecs. At every step of iovec iteration, the bio's bi_size is a block
size multiple.

Let's say we tried to allow smaller vecs. Assume block size of 512
bytes, and you send a direct IO with 4 vecs of 128 bytes each. That
would normally get rejected very early, but if you did send that to the
bio layer, the entirety of the first iov would get trimmed off and you
should get an EFAULT return.

