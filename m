Return-Path: <linux-fsdevel+bounces-50500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E3EACC961
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50821882CDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C84239E8A;
	Tue,  3 Jun 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0p9YHVFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA622FE0E;
	Tue,  3 Jun 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961693; cv=none; b=WV7B+R2CZvzFdwj6JiBGJdtaOalvlMKiK2OnSPiTN3k4F19mVwkmIwZ2oLX4UORIth7rWhB6K7SrM0+JORyWMY1YVeVZsYRWsBwNfGSK02mQMRCWyhEi0FqydBaZ5ddHgt0l5ZRRfoYJQl+R9XhTPuNdkEHQogSiRo9p+hZwGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961693; c=relaxed/simple;
	bh=Z48KV/8zzAeG4WKw93AGeFBmEJpttPZVeMs+mzertJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr3caqzXGi9FLioCNcLFkzTlGjrnpsxWjCXjeyNXSMfDg8Tcxc7jixEpflCl6XWfD0cvvwmqO21gdS0iokeMDDmT+bO2/Nf+dH1kMIC0wSEoDDXFU4LLB9lF9J1+o9j80yBR2st8jgE4y1T+LANg/fHtf2HbqL3c14SXkZLCHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0p9YHVFK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hyja1MvFgPRIftVPaJdamEkY5qTH4VWPtD3hwYSk6nQ=; b=0p9YHVFK+RD3Yg2jjlRl3Pc+1M
	uW3PTKREKka5EtoxBYYwgdYViR1xF93wlEnjo74fR7ZoiB9OvSd7Ps0dGnfBQdcRj40OIHgljGxBk
	88zpulGX7rQJg9Z/W669vmukrAAWZhiQ7rrIEFCG6ErUSvzyUH+l4YZ94VUnUNmo1stWXJcJUpYHj
	yoxMdxXxwzN6R1PuoozC8w4fQcNNq1PffSTv/pRacemrwse8bY/Y97BhxjEFDh8cmOJ+YHW0NuGVC
	2W9ubEhCN7vmZm10KliPLLlxtEhCXm7YA/sMfvDD8OymcqdK9TSawhYh1lJK9PjFFwrC13A2u1l6+
	NOeKc2BQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSpW-0000000BBPW-1cgI;
	Tue, 03 Jun 2025 14:41:30 +0000
Date: Tue, 3 Jun 2025 07:41:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD8Jmmd4Aiy1HElV@infradead.org>
References: <aD03HeZWLJihqikU@infradead.org>
 <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org>
 <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
 <aD5ratf3NF_DUnL-@casper.infradead.org>
 <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
 <aD58p4OpY0QhKl3i@infradead.org>
 <e2b4db3d-a282-4c96-b333-8d4698e5a705@kernel.org>
 <CALOAHbA_ttJmOejYJ+rrRdzKav_BPtwxuKwCSAf2dwLZJ1UyZQ@mail.gmail.com>
 <26d6d164-5acd-4f85-a7ac-d01f44fb5a87@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d6d164-5acd-4f85-a7ac-d01f44fb5a87@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

[taking this private to discuss the mpt drivers]

> Hmmm... DID_SOFT_ERROR... Normally, this is an immediate retry as this normally
> is used to indicate that a command is a collateral abort due to an NCQ error,
> and per ATA spec, that command should be retried. However, the *BAD* thing
> about Broadcom HBAs using this is that it increments the command retry counter,
> so if a command ends up being retried more than 5 times due to other commands
> failing, the command runs out of retries and is failed like this. The command
> retry counter should *not* be incremented for NCQ collateral aborts. I tried to
> fix this, but it is impossible as we actually do not know if this is a
> collateral abort or something else. The HBA events used to handle completion do
> not allow differentiation. Waiting on Broadcom to do something about this (the
> mpi3mr HBA driver has the same nasty issue).

Maybe we should just change the mpt3 sas/mr drivers to use
DID_SOFT_ERROR less?  In fact there's not really a whole lot of
DID_SOFT_ERROR users otherwise, and there's probably better status
codes whatever they are doing can be translated to that do not increment
the retry counter.


