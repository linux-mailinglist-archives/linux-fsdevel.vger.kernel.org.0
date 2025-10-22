Return-Path: <linux-fsdevel+bounces-65055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A98AABFA358
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 562D934C7A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DC2EF655;
	Wed, 22 Oct 2025 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RX7a1AXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D922ECD3A;
	Wed, 22 Oct 2025 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114292; cv=none; b=dutoeRbKC+wYGaTgAcp5AHyutyIJVTgeHE/c7EbCTlEODxqkNGmmbbA/0QVrmBClctCwAtzLP88jAyNqC4/rOttF9sIRgX/jKg0Wf14yMSP4Tf2vihu0YLDKGx4wMX6pcOaNaMkkgMyfzQm85jZNqw1pbceYhrOYQibHl1vbu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114292; c=relaxed/simple;
	bh=vHas3sy8prCVLo71319oRvMTTc/fK2RlrePiiW26olw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDo03chbPnaT7nqcNVtzKSjgx6BeNmo8SsgWU8qTXQT3ggupo3nUjBHsGvDQF6EuXZNETrxVscpMNE4LGfEXQ1Oxsr4cZDXgbu0Jew8QcGjasLBytHU6EpRuaPuw59cIjADLfGnri338vhnQQI8nchvAZlhW1Bl5cOfSsUianLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RX7a1AXW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1XhDE1BELRWX5YDOcVl25kQ97WNQSKEMx7NE0+Z0zfs=; b=RX7a1AXWTILfx/vttsD6ASD5QM
	nm39/Tj4XmpGD53ez9zf4QpAZwF67Zia4CQzhS9732EWS8EPh2m8ojSGgnoJs+ttrmJRmrRTMPhRi
	jt9Me0ujkGJNrMfLgoTCR5PgmzW3b8SlrnGxZ4pz/+jVDasdZsUWCAqzQ0ae3gmPoSxHkqQ/q19xI
	RYkBGdEhA6XkBkYrGAoXPT+y9kz1RXrhJ3UCNIW1WFCR3np8xaonuIeoPL7+Mp6mH+7Pnppq8Qvxt
	gfbhjptNvEJ0BDuMiJWCcyQYvs5SNAKh9t7u6juA0NeJcsmSSGnr1ZY9pemg6FZaqGbLYAb1E/y07
	Yqg5E91w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSHA-00000001eTW-3aoM;
	Wed, 22 Oct 2025 06:24:48 +0000
Date: Tue, 21 Oct 2025 23:24:48 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	WenRuo Qu <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"jack@suse.com" <jack@suse.com>
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPh4sJ8eFJeMCAHx@infradead.org>
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
 <aPc6uLKJkavZ_SkM@infradead.org>
 <4f4c468a-ac87-4f54-bc5a-d35058e42dd2@suse.com>
 <25742d91-f82e-482e-8978-6ab2288569da@wdc.com>
 <f13c9393-1733-4f52-a879-94cdc7a724f2@gmx.com>
 <aPhl7wvyZ8b7cnLw@infradead.org>
 <3677cfe8-00cd-466d-b9e3-680c6d6d8c73@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3677cfe8-00cd-466d-b9e3-680c6d6d8c73@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 04:47:56PM +1030, Qu Wenruo wrote:
> So far it looks like the bounce pages solution is wasting a lot of code for
> almost nothing, it's not any better than falling back.

That was my expectation, but I wasn't entirely sure from your wording
if that's what you measured.

> Since we always fallback to buffered IO for checksums, the content should
> not change and we can do the submission and checksum calculation in
> parallel.

Yes.

> Already got a prototype, results around 10% improvement inside my VM.
> Will fix the bugs related to compression and send an RFC for it.

Nice.  I've also started looking at my PI backlog for the XFS version.


