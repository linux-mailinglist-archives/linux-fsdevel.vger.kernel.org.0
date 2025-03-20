Return-Path: <linux-fsdevel+bounces-44509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F9A69F7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AF3170EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBCA1E7C23;
	Thu, 20 Mar 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FevDVPUt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72917482;
	Thu, 20 Mar 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449696; cv=none; b=SENvlyNtyHns6+BodpfkHSkM09KpvEx/vu091ojYwthDCwfmR33Ynw/kctJ7RwIIgVS1EGtH3puBujdJbO8KAQFJxg9KqOLlq9he7dR5/OlRq2r2EG/d+D2lEdKj/JwIMqtqFmg0EXgYFniNMfkRb+Z7sXFuuYKH3iLXGHntEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449696; c=relaxed/simple;
	bh=ZCqa1kK4yN7nk/NG8bkHiIXdA+DyndLxxAyigDwUJbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6VYi2F4WA2WyjIVoszfA1LfXxKZqgz0uVQPzj6ZWfemypcNTtTWJX+fNTu7TM9GpC1jeNnab2hxGkoMbbUSYu2Cm29OaR3eBes1xXMBILwwSILEPXPyQ6xv2UhYg46kWMrJEgZK40DEA2vVQCC3UKnm3Onql+7ge9Xc4eG3ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FevDVPUt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=whmPEYHG6N1H8UlgtSGjiPfpFSDvL0exFGvh42fP/5g=; b=FevDVPUt3SbAei9b89H4qsOjgq
	+CAmjV0Pw3nprvaf5FRhHJQyRNhvIKAW0Tnev6dtJD/er8x3hRC+t3i1JQjNFvoSsmMuWwLkrtVbm
	xmsstUnYCIZDSbY0iZnkyqH/AsRno2o6Fx9dK7qoEqBQdRoSWT+I47eRXq+e5FQq/r0p4QVFUx7w5
	lwIN8FNswBc7XiRuqRF7odDNVxi7CcRwdcGcc+/JgutaEl0tK8pXZeQDeFCRoru93RQgd3R4K4fUr
	EzS0heeUB9AD9+Aux7VDk2D3jKfmQF+oex2GEjb/s+zUixuQMJGKpwSer5GfM6kCTPeTQWHBxBI9z
	K5iFxIAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8lH-0000000BFMr-3Blz;
	Thu, 20 Mar 2025 05:48:11 +0000
Date: Wed, 19 Mar 2025 22:48:11 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z9usG3LELEWPYSUG@infradead.org>
References: <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
 <Z6GivxxFWFZhN7jD@infradead.org>
 <edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
 <CGME20250318080742epcas5p31b31b3024d6f7d9d150c8a7c2db4dffd@epcas5p3.samsung.com>
 <Z9kpyh_8RH5irL96@infradead.org>
 <435cf6be-98e7-4b8b-ae42-e074091de991@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435cf6be-98e7-4b8b-ae42-e074091de991@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 19, 2025 at 11:36:28PM +0530, Kanchan Joshi wrote:
> I tried to describe that in the cover letter of the PoC:
> https://lore.kernel.org/linux-btrfs/20250129140207.22718-1-joshi.k@samsung.com/

I don't think it does as people have pointed that out multiple times.
Once you do checksums on the device they are not end to end, either in
the T10 DIF definition or that of file system checksums.  You leave a
huge glaring gap in the protection envelope.  So calling this "offload"
is extremely dishonest and misleading.


