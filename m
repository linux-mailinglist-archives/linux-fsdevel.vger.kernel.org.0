Return-Path: <linux-fsdevel+bounces-20696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4AE8D6E3B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 07:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5E1C218F5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A912B7F;
	Sat,  1 Jun 2024 05:59:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25E111A1;
	Sat,  1 Jun 2024 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717221579; cv=none; b=rwl74DGLnA1gSo//MaOryVQ6AbpFiJgtS3NMLDjYPcZfYt+j7HNEaEfUn1nFchWYVpdA1TNDMQs5TOWfaY03y3NU+7W9iNnfkyyDJBK/G5hi/RtB52rseub7DI+PmhcWbyHpFRah1Wgvgd9IR43taEke8n46/Xy80wDDensiK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717221579; c=relaxed/simple;
	bh=icMOdDMIgwIXGGzLIxIeSihpdWV/icJnEheY/OC4ask=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrdRsNfYo6vFW0UXEoaM4k1LKYF4IlzJFUCDTrQ1DIspcOq4/Hm9aFeRiXvDliBwS1DQOCAA1hROe9qJ8EesqoOnZK+Z2rOkpxUQuseUCKrl3BmVqBWB97ztJV9Is6tjJlaM4qgCbzsq54XBoVMUpU3QmoukJhNibjZHnOjwop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06C1168D17; Sat,  1 Jun 2024 07:59:32 +0200 (CEST)
Date: Sat, 1 Jun 2024 07:59:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20240601055931.GB5772@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com> <20240520102033.9361-3-nj.shetty@samsung.com> <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org> <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org> <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org> <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com> <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 30, 2024 at 10:11:15AM -0700, Bart Van Assche wrote:
> This new approach has the following two disadvantages:
> * Without plug, REQ_OP_COPY_SRC and REQ_OP_COPY_DST are not combined. These two
>   operation types are the only operation types for which not using a plug causes
>   an I/O failure.

So?  We can clearly document that and even fail submission with a helpful
message trivially to enforce that.

> * A loop is required to combine the REQ_OP_COPY_SRC and REQ_OP_COPY_DST operations.

I don't see why that is a problem.  Especiallly once we allow multiple
sources which is really useful for GC workloads we'll need to do that
anyway.

> Please switch to the approach Hannes suggested, namely bio chaining. Chaining
> REQ_OP_COPY_SRC and REQ_OP_COPY_DST bios before these are submitted eliminates the
> two disadvantages mentioned above.

No.

