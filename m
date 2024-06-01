Return-Path: <linux-fsdevel+bounces-20695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0978D6E35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 07:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC77285BBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C1612B7F;
	Sat,  1 Jun 2024 05:57:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532ED111A8;
	Sat,  1 Jun 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717221462; cv=none; b=hxC/xVeowvM64R0ebTOGLFr1P2K/QA9da4PjE6/KvMUl99KTV0L8rZr9lhUbtFMOyp0CKPkPUSpG3mi0jeQNcNBlute/Tz+0hjUDIn0jhBbBSU1WvCPlFLNqiFP76ttm/aUEuiU+wq84DLssHmO8wbYrLZnjuh2IFY6oyV10TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717221462; c=relaxed/simple;
	bh=RtLg5SIXalA/xjJDVWd3IwNH9f+yh9qpLP07b0GBOJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB3+O62+oh/VROsPofPBYHqviurMIQPLfcrNVOkn2WHprLRg7sR2cYAh+CAglm6qkd+/548KaCy3aftmdJi3vi6I/6lhSdTkckhk5MkB12Bm9ZjthSARsErLp2WOyN25VKZ5NEoCNvQx9AMA9VJxnMBufPwCpk9lTFqvwOfu7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B4E3468D17; Sat,  1 Jun 2024 07:57:35 +0200 (CEST)
Date: Sat, 1 Jun 2024 07:57:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240601055735.GA5772@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com> <20240520102033.9361-3-nj.shetty@samsung.com> <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org> <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 29, 2024 at 04:48:18PM +0900, Damien Le Moal wrote:
> > Yes, in this case copy won't work, as both src and dst bio reach driver
> > as part of separate requests.
> > We will add this as part of documentation.
> 
> So that means that 2 major SAS HBAs which set this flag (megaraid and mpt3sas)
> will not get support for copy offload ? Not ideal, by far.

We really need to ignore the normerges flag for this.
As should we for the precedence in the discard merging.

And the drivers need to stop setting this flag as they have no business
to, but that's a separate discussion (and the flag can still be set
manually).


