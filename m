Return-Path: <linux-fsdevel+bounces-43803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95106A5DE78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B707ABD91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB024BBE7;
	Wed, 12 Mar 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HfhH08SS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F5241678;
	Wed, 12 Mar 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787691; cv=none; b=aRb558i7/Bn3OeHy6doGwz9bQHnvy7DlTXQyJn7YBaNP0Scn3zAHVeJ8Xiufwx9t3EclXxx3lxJOCntXLyNVhcWPYcYZycU8ssD+tPk0T00Q2OyhnGfWCIFuANvXsiOZvT54d6Ixnr/Pdw8ZAuPbfUMQjdJmpuTez3uWh1fRAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787691; c=relaxed/simple;
	bh=s7HppErOuRAEfWoZvC9h8SjPc+omLVLEhgLC3zn/b5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUsmCd+IsB66Mb5k2gO5DquCGsvigUmRnyYF0iRh3o8tWA1ff6bsECZ4haLVu24Pd/ztiPJK7Foh/BkSzRALaarowNWzDCHljQDwo9OnXnCR2tlDmVNYyqVgM4s/NN9qJNGAvF3N1MTX/pfdCJCmWjwAWlGecQ4CJTGGiSzRfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HfhH08SS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lfneeWODElFymFhQnucV3WL3Lau0GPYLjMhVhcnqKW8=; b=HfhH08SSMP3zY3OeXVKlQ3ZbtD
	ASMEE5hDn5masctrOVgF4cgC5EpNYAB77QksrAgCFHdpJzMsbHkTTMUM6FwdzJmiss4zMryqtPdQB
	xojhyVY1j+DMG870wbf+qKWdUh0W57WSV9F3/c4VkIcapXkB0QvTkNqnHFyKfhIolGZDS2MEq0Z9J
	t2NbIASiMHHmR/lIQzzMN0rW4BA+67yGNabsnUopfPZLcHt9jEFr2PZSlMe/gz39DoHjsSW1mS+mo
	Tlj1lWHOH3I2o8qgH0N35ZlkI+5ynaSPoAI7Na9ex7Ju3EHr5fbxZCjQtyaUFP2M7AOE59OpOG5Rn
	+tjZnE9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMXp-00000008d2W-415a;
	Wed, 12 Mar 2025 13:54:49 +0000
Date: Wed, 12 Mar 2025 06:54:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 07/10] xfs: Commit CoW-based atomic writes atomically
Message-ID: <Z9GSKbuollfpAZeX@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-8-john.g.garry@oracle.com>
 <Z9E6LmV1PHOoEME7@infradead.org>
 <63587581-17a5-431e-9fe3-a1a24ea4fa21@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63587581-17a5-431e-9fe3-a1a24ea4fa21@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 09:04:07AM +0000, John Garry wrote:
> > As already mentioned in a previous reply:  "all" might be to much.
> > The code can only support a (relatively low) number of extents
> > in a single transaction safely.
> 
> Then we would need to limit the awu max to whatever can be guaranteed
> (to fit).

Yes.  And please add a testcase that creates a badly fragmented file
and verifies that we can handle the worst case for this limit.

(although being able to reproduce the worst case btree splits might
be hard, but at least the worst case fragmentation should be doable)

> > Assuming we could actually to the multi extent per transaction
> > commit safely, what would be the reason to not always do it?
> > 
> 
> Yes, I suppose that it could always be used. I would suggest that as a later
> improvement, if you agree.

I remember running into some problems with my earlier version, but I'd
have to dig into it.  Maybe it will resurface with the above testing,
or it was due to my optimizations for the extent lookups.


