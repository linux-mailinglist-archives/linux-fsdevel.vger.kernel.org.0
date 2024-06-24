Return-Path: <linux-fsdevel+bounces-22277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34C915A2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 00:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74E5B22A08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 22:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2C1A257B;
	Mon, 24 Jun 2024 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIgX487J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF151A254A;
	Mon, 24 Jun 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269905; cv=none; b=FDEa5iKgXpamGEvgrIv0TXZA0zklAL/AL7bFAyABp2EjKE/qTKPVJX3aX7zBZM8dxxAdKYAr+oz+0s0KyfBk9vWTuiZyZV7j55kce4KrPdGkG5Kf5HMcrgIREG/d8YUB4KZXUFziAWK0xmWTAlni4NfkoWXjyEEnvNZaq6kKA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269905; c=relaxed/simple;
	bh=iA7soJkpGVIKt7XVvk8Avygo72QDsaSjKA52TLDa3y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URc6vSgslW+dcyjRN9juuWhGRfDdGunBGkF8nEfadyVxE/U6pOZGpka81dIKh2Il1nxJMr6skOUGVe+Za1XK0zwNP99x+/SYBsas/FR08ZAQVYs+ImJr/E2/U/ZiZ8dHPcI0uzjEUdGaZmWeTEmKH7s/pe8TcF2DWYSzofVAZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIgX487J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53667C2BBFC;
	Mon, 24 Jun 2024 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719269904;
	bh=iA7soJkpGVIKt7XVvk8Avygo72QDsaSjKA52TLDa3y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIgX487JN8lhIWwtdU5liMps5jnB/iuFfCdxzShBm0+k16Zc6TUnzq5B+IfX9ao9h
	 bvCAPx5R4d2FID4jv+PXsrL3rU+CdxSXD0FEz55Yytha/MVXjP4qDCMIOV76mfGvUK
	 RzGVX3+vG7RP3qfmNcGzcY77s6ybP1HFlnIdfemDqWPpp9e6OAcDCjkcf7enJbDEf8
	 z/T3Hgac1qVPR5zIsLevzeNCOVA2NJzbYir9lUyWmKJLRPzp9Z+AUFtGO0zgS3MJx/
	 CQS1ogR3PouW+eiO0maCC1Dwix1Dx4KUlCAD21OPYpzKHeecDTqvnNx0TENlrK+VwA
	 cR4rL1FSGnaMw==
Date: Mon, 24 Jun 2024 16:58:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
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
Message-ID: <Znn6C-C73Tps3WJk@kbusch-mbp.dhcp.thefacebook.com>
References: <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
 <20240601055931.GB5772@lst.de>
 <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
 <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
 <20240605082028.GC18688@lst.de>
 <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com>
 <66795280.630a0220.f3ccd.b80cSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66795280.630a0220.f3ccd.b80cSMTPIN_ADDED_BROKEN@mx.google.com>

On Mon, Jun 24, 2024 at 04:14:07PM +0530, Nitesh Shetty wrote:
> c. List/ctx based approach:
> A new member is added to bio, bio_copy_ctx, which will a union with
> bi_integrity. Idea is once a copy bio reaches blk_mq_submit_bio, it will
> add the bio to this list.

Is there a reason to tie this to CONFIG_BLK_DEV_INTEGRITY? Why not use
the bio_io_vec? There's no user data here, so that's unused, right?

> 1. Send the destination BIO, once this reaches blk_mq_submit_bio, this
> will add the destination BIO to the list inside bi_copy_ctx and return
> without forming any request.
> 2. Send source BIO, once this reaches blk_mq_submit_bio, this will
> retrieve the destination BIO from bi_copy_ctx and form a request with
> destination BIO and source BIO. After this request will be sent to
> driver.

Like Damien, I also don't see the point of the 2-bio requirement. Treat
it like discard, and drivers can allocate "special".

