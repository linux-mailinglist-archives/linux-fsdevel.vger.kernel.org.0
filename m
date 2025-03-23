Return-Path: <linux-fsdevel+bounces-44818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FAA6CDFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 07:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603B23B42F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57174201246;
	Sun, 23 Mar 2025 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3zRY+YvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD961FC105;
	Sun, 23 Mar 2025 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742710896; cv=none; b=TsvjqMcovtvWEu4OQHTNsX3TegtQKpTtsGxk39YYVGiaISzxO5qGsKtBlZ6NhpUgPOVu200rcH7/Nu6rUZfjpryDqoLmRSKTOcZ4TbtWQNYzcUoqiJAC20DsbQXmsggw6qC2f7Snj7xGPnF1+HLDHm7ZhiXhe+mA0nnunJk8NVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742710896; c=relaxed/simple;
	bh=1USActi8BiCcrXYOuZOmFNDAtk1TmeyWlhovpQvjTHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq/5PWthQANfIe/7tHncve2ipWhgfJpOB3T09bN0L+3XcM/pOBWQV9/K8jASLyqb+3gRPv9SHFHDoEtZBqZ64TIC27pvM59KHUD59T9SB85a5TRItNPyDGa7aGdj95cLW6KTo3DLLrDtDbSXi+39vGtWPO+BpDj6CaAxw1lXxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3zRY+YvN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L1ic8gyVxVIspX+A5ncCA9aQdUq2VzF6Q97RWcvY5wU=; b=3zRY+YvNGQUSC9kOV3Jx4UErEG
	BG2L8v7UKQkhm6NoDW6WlXMruVLMyVUMjWnIMhIgd8GZ1QZX0ouyX0SfxR5/QXAgpqPWlo8gqaeVz
	PeoEtDOV58uSXA47JCHXsGbQMIqFrxtHUe6yKOcls61I8vP7y6CdL3EHZRPUrb1vc5P9CxDHhF+xj
	Q6DGKhTJKQ1cxKDSIX7q+KJbjoqTUM7bOJysVABJzoLMlcNNIyzGuowJOv4RI7PHcUZ0TGoYhuuqb
	bN5ClG2A7KLuDc+ZdIpUqH1CmOv17eDsPFOQz3gZ3IfJUMpeQ8in9Gf1gdvg3AwGZostRzNyA+o20
	vQQgnhbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1twEi8-00000000kzq-0yMV;
	Sun, 23 Mar 2025 06:21:28 +0000
Date: Sat, 22 Mar 2025 23:21:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] iov_iter: Add composite, scatterlist and skbuff
 iterator types
Message-ID: <Z9-oaC3lVIMQ4rUF@infradead.org>
References: <20250321161407.3333724-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321161407.3333724-1-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is going entirely in the wrong direction.  We don't need more iter
types but less.  The reason why we have to many is because the underlying
representation of the ranges is a mess which goes deeper than just the
iterator, because it also means we have to convert between the
underlying representations all the time.

E.g. the socket code should have (and either has for a while or at least
there were patches) been using bio_vecs instead of reinventing them as sk
fragment.  The crypto code should not be using scatterlists, which are a
horrible data structure because they mix up the physical memory
description and the dma mapping information which isn't even used for
most uses, etc.

So instead of more iters let's convert everyone to a common
scatter/gather memory definition, which simplifies the iters.  For now
that is the bio_vec, which really should be converted from storing a
struct page to a phys_addr_t (and maybe renamed if that helps adoption).
That allows to trivially kill the kvec for example.

As for the head/tail - that seems to be a odd NFS/sunrpc fetish.  I've
actually started a little project to just convert the sunrpc code to
use bio_vecs, which massively simplifies the code, and allows directly
passing it to the iters in the socket API.  It doesn't quite work yet
but shows how all these custom (and in this case rather ad-hoc) memory
fragment representation cause a huge mess.

I don't think the iterlist can work in practice, but it would be nice
to have for a few use cases.  If it worked it should hopefully allow
to kill off the odd xarray iterator.


