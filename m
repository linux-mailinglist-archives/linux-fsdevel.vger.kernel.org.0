Return-Path: <linux-fsdevel+bounces-22059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6549118E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 05:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ED81C21469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 03:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F54126F02;
	Fri, 21 Jun 2024 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBghmtXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393CB3207
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939159; cv=none; b=DQxrZIOlaptRrhcUnv4qIPUWznelJrpYc7czsYOPO8PgkPis7v7mG0UgUT81rHF8nixYgAp/gYrMCggZtkeTlx2h2R0d0YsIr/scEcfJcIQ9SoI8Q8muqY32M6zuB+uGuaQhdCTmPAcOosjz7gMZuHr6R/ifG4P1YvNCWBFZ4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939159; c=relaxed/simple;
	bh=rvS+UtZ42ZMLPuBWN0yVsSNsDPF7YFURYQ+a0NuReuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7AhKXzl0gmsbrTcUzNFrXTlWk+c9Y39eFtDSHAFJAc9rs0C/t1Q5FsmlPW0/7zLVN0gBducLp7IUm/oYOL8kyNpt86qcZRtZLn1FAv0d+t4/ceYP2UuGuEd2EIM+uHHrFs+WPMxqmNiG8u+plaENGXwI8T+UpciZHbJ9rU15nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBghmtXw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lihongbo22@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718939155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvCxzWxncVfk5O6/kk8NKM+jU5ea2ZVXHj/RiPVE4NE=;
	b=LBghmtXwBIxJFQ/48tClweORYPXuLN4AIMeT06IVb0leOWJirp1Wd6x7kOiEq9dSHOPmUQ
	zZGGINs9IUBzsVxJE37+NppJ7/xHZ+wOoUyhMowpbsLM0MjbSOn0JQFJoG0Cg5kwPDY6sf
	5vKkgIwkJMOrwz6RCQcJCe5iqTXw/5A=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: hch@lst.de
Date: Thu, 20 Jun 2024 23:05:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t?
Message-ID: <en467ekfgtlokrntl7zqla4umhdeudujtq7xm2jgzziu6iqzhw@hzvvcyjtil2o>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
 <d7a104b4-fea8-4c61-b184-ddc89bf007c4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a104b4-fea8-4c61-b184-ddc89bf007c4@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 21, 2024 at 10:37:29AM +0800, Hongbo Li wrote:
> 
> 
> On 2024/6/20 22:56, Jens Axboe wrote:
> > On 6/20/24 8:49 AM, Matthew Wilcox wrote:
> > > On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
> > > I'm more sympathetic to "lets relax the alignment requirements", since
> > > most IO devices actually can do IO to arbitrary boundaries (or at least
> > > reasonable boundaries, eg cacheline alignment or 4-byte alignment).
> > > The 512 byte alignment doesn't seem particularly rooted in any hardware
> > > restrictions.
> > 
> > We already did, based on real world use cases to avoid copies just
> > because the memory wasn't aligned on a sector size boundary. It's
> > perfectly valid now to do:
> > 
> > struct queue_limits lim {
> > 	.dma_alignment = 3,
> > };
> > 
> > disk = blk_mq_alloc_disk(&tag_set, &lim, NULL);
> > 
> > and have O_DIRECT with a 32-bit memory alignment work just fine, where
> Does this mean that file system can relax its alignment restrictions on
> offset or memory (not 512 or 4096)? Is it necessary to add alignment
> restrictions in the super block of file system? Because there are different
> alignment restrictions for different storage hardware driver.

A multidevice filesystem can't get rid of those checks becaause if
different devices have inconsistent restrictions that'll be quite the
source of confusion later.

And since devices can be hot-added, it does effectively need to be in
the superblock.

