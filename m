Return-Path: <linux-fsdevel+bounces-51549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9BAD82A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F721709D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47A24DCF9;
	Fri, 13 Jun 2025 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/AEmnkB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1F248888;
	Fri, 13 Jun 2025 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793145; cv=none; b=XwZyQNSJ4YWnglmbDdcgVp0n1p/TVmdnszBMXj2u5DXGF4XKy77r545XHZrF4VfNhcWHgIZKJ64LcIkKCBGG8dZMmdqFnUnL322fBoSNFXO6Hw0KSvRRYRLXorkiuEhLCH+k+b8FGVcytuXDgZPGLji2iSPL5f1ZbL5hNSoB8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793145; c=relaxed/simple;
	bh=Tcw7B7UNIKjva3SAyRZeoBE9LdNxudfnPXiSiHUlCwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt1z9Y3F4/yZm4KjzzTYrgxcIdUqwZ9KC3IMoPZ1sJc/pjtybfgJ9JQd8giXf+Vwze1zXvDOhkZ6OM/4mLdfxkLJ9/Y63ADrkuiyqMBr1DVFa3ly7/5JC64BPFcCw5V3RqDVgCpY1uyLmgWG+DyLRWJYNiDWb/hlXZsthml54OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/AEmnkB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tcw7B7UNIKjva3SAyRZeoBE9LdNxudfnPXiSiHUlCwc=; b=c/AEmnkBFWI/zwanAl0nCJ5wi7
	66jRwdv8HxlSJr9C1zjPCCBP8tRrQ+TNFm2zp5UoaApI4H/YrROWWHokuLXRKdVzC3pV3V4TvvKyR
	PQo8WAMQ70CF0dtWIQn38I+gne2kDJvo67JfDlgpu7QwME5hCIoz+QGuhJ09cQeZHf6xi4JsmF662
	IlLVqLytl4pfes/HpWL1BM/RlLs39tlnBjAwNTXIwpa7lNq3+mnUig7ZVOx0Fg0xlujnlL7XqR2z6
	5AWRjPDtiBCfM9kNu/q5ThadjorwzL02R/JLKZJVLnGaxIM+4KVllDxTccPxmUnamqh1PLKHsiCP6
	K48Bp1ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPx83-0000000FOm5-2Ale;
	Fri, 13 Jun 2025 05:39:03 +0000
Date: Thu, 12 Jun 2025 22:39:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aEu5d3XnI9oNtjwd@infradead.org>
References: <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <5D9EA89B-A65F-40A1-B78F-547A42734FC2@redhat.com>
 <aEr4rAbQiT1yGMsI@kernel.org>
 <04acd698-a065-4e87-b321-65881c2f036d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04acd698-a065-4e87-b321-65881c2f036d@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 12, 2025 at 11:58:27AM -0400, Chuck Lever wrote:
> NFS/RDMA does this already. Let's not re-invent the wheel.

The other thing that fixes the problem (but also creates various others)
are the block/scsi/nvme layouts, which gurantee that all the data
transfers to the data device us block protocols that gets this right.
Well, unless you run them over TCP and still get the whole receive
side copy issue in the drivers, but at least the copied payload
is always aligned.


