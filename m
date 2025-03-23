Return-Path: <linux-fsdevel+bounces-44832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A5A6CFC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 15:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61941889613
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0874E09;
	Sun, 23 Mar 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kxK36Rxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2BF6ADD;
	Sun, 23 Mar 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742740426; cv=none; b=TFZV0Bi/Ns21gh08qP4dY5Mx+E6VXPXS3IvxxvyGi8ICPvuxzUI3IaqSq31dSmnKVwpheoGsdc1ooV6XbqBpcs+ugJh/LseYVPDb/wJLUJGuvXsS0J3swvY+TWEueGqzXmdrVI8rivoWaBNsX4IBypyhkewSc8xuSexVABEzbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742740426; c=relaxed/simple;
	bh=rKINkbhYV6hTVFAbzvACFUklqCfglI92COp/9PBq9eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ9ipFwiPTGF97SodkaePMSa+uUN23nI1EKfkXGHIPzC1Ld0BBPY5qQDyU1NN7UuDHV74x/l3+RPViecFUXDA0CpjRhepateZqiT35WbIXNz98YgSdoakVodeGUCQWMG80Wkn1MFv1KgHXX5Wa9gefbsSt7g7YWDDCYaKP6Isn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kxK36Rxm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zGBTpFLK0UixlShYpg/OWoA6cRXQfCGU0ZBvGLWIcIo=; b=kxK36Rxm0wzobQNar9Cv3m5UPz
	0G/kYXg/jvR3ydP9fmiTHxM6kftq9uKF0ATEvxJsc3aqu7xSnU6QoxbHf7xQPRLKi0l0VOubdkOTf
	kUVa5+BCmN2Ds/f8rEIVDWzzx4j0sLLTvJCTEw/9FL2I7cuOqcBIDXSwnjrCF6GFarhbgjGt4s3Er
	fhcmPHrHOxcOt7FZwZG7dmkfz48YvC5h09KgiCN3Hyp+AkQiVkmsoadosGyN2xk86iXNO50ZGv+z8
	FyLVqGcW1EYM6XeYYjZffoat3bKdcY/qzVi+3gKvGnOPuXVgP4+T7ghDqYcXD9ktlnth3PqWwLKoe
	aGaAoHIg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1twMOR-00000006gTC-1B8U;
	Sun, 23 Mar 2025 14:33:39 +0000
Date: Sun, 23 Mar 2025 14:33:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] iov_iter: Add composite, scatterlist and skbuff
 iterator types
Message-ID: <Z-AbwwTtfpKr_pgY@casper.infradead.org>
References: <20250321161407.3333724-1-dhowells@redhat.com>
 <Z9-oaC3lVIMQ4rUF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9-oaC3lVIMQ4rUF@infradead.org>

On Sat, Mar 22, 2025 at 11:21:28PM -0700, Christoph Hellwig wrote:
> This is going entirely in the wrong direction.  We don't need more iter
> types but less.  The reason why we have to many is because the underlying
> representation of the ranges is a mess which goes deeper than just the
> iterator, because it also means we have to convert between the
> underlying representations all the time.
> 
> E.g. the socket code should have (and either has for a while or at least
> there were patches) been using bio_vecs instead of reinventing them as sk
> fragment.  The crypto code should not be using scatterlists, which are a

I did this work six years ago -- see 8842d285bafa

Unfortunately, networking is full of inconsiderate arseholes who backed
it out without even talking to me in 21d2e6737c97


