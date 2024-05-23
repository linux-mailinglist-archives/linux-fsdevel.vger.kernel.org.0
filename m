Return-Path: <linux-fsdevel+bounces-20050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C368CD2FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A816F1F21F41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9D14A4FF;
	Thu, 23 May 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KDndgTDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C41494AC;
	Thu, 23 May 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469185; cv=none; b=qtPj7v5qbkk4CPVOdkzuj/BCzx+LXeBPnpLsP7AWQSCud6oFsWc55hejiLu/WD/OcvKjOj6oNb4cuwQATzfOrB7zoxnf9DGCqVh5hZUPFtnWngq9EmWIW+E6tD3l9KC0J9MI9UVzhdjUcivYvkZ1tFf3h8W745oSG4ztX1o3T4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469185; c=relaxed/simple;
	bh=r/jKk9ccksY/9WiNmL6OIFw97z+/dtosx4ERQ9Umakw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMEtkAcvkmur1yR+49uKYOtMJwgklfgQirFdi3nLh883dW32XvYK/ocqIyfNuaMBCytNpOQjYedSss/arPJX0m0BWQm/8fbXslgZgckkGqY+DG3JVAUI2Y6fYvO/ot5Ou10XjfxKNRLhHObAiSmsdj2gT4qlDSiUZ7n5M0NNJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KDndgTDg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iDDVfg/vJO5TvVPe2vKaGxm0sb/5qDyjmp6tSkeBIJY=; b=KDndgTDg2qikMCFERZR+gFarmK
	9G/Uj8HEob9i/zOZ/rQiZOw+8Sls3K+AIZqyY7HhAGmtHePMnCx78hTbnK8Iq3OyAhYH6ARHTBLt6
	wR5IXYGJvkh7bcWGCIe+KXZkcWisgmyslwcHVE6IG0EfdIuSFBrcGyEARAZxPg+5aJ7sUx8l6482D
	+hcu1V7NJ8kMFKU0wlgbCUfHNH8Vbmem8ep65CqepoNeUcl5YEB0V75Vmino4e9KfjPwgnywW6XIl
	AeO4ytyHtrUjUCebIU6hlTDJIN9baFTVLKwInT2vNigDOIlHjHF5Xadzj3VzqYMmEOWg/Rq49enPS
	Ugz/Y4yQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA82m-00000006IH1-1BCC;
	Thu, 23 May 2024 12:59:40 +0000
Date: Thu, 23 May 2024 05:59:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <Zk89vBVAeny6v13q@infradead.org>
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 15, 2024 at 01:54:39PM -0600, John Garry wrote:
> On 27/02/2024 23:12, Theodore Ts'o wrote:
> > Last year, I talked about an interest to provide database such as
> > MySQL with the ability to issue writes that would not be torn as they
> > write 16k database pages[1].
> > 
> > [1] https://urldefense.com/v3/__https://lwn.net/Articles/932900/__;!!ACWV5N9M2RV99hQ!Ij_ZeSZrJ4uPL94Im73udLMjqpkcZwHmuNnznogL68ehu6TDTXqbMsC4xLUqh18hq2Ib77p1D8_4mV5Q$
> > 
> 
> After discussing this topic earlier this week, I would like to know if there
> are still objections or concerns with the untorn-writes userspace API
> proposed in https://lore.kernel.org/linux-block/20240326133813.3224593-1-john.g.garry@oracle.com/
> 
> I feel that the series for supporting direct-IO only, above, is stuck
> because of this topic of buffered IO.

Just my 2 cents, but I think supporting untorn I/O for buffered I/O
is an amazingly bad idea that opens up a whole can of worms in terms
of potential failure paths while not actually having a convincing use
case.

For buffered I/O something like the atomic msync proposal makes a lot
more sense, because it actually provides a useful API for non-trivial
transactions.

