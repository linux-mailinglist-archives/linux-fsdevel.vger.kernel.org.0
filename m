Return-Path: <linux-fsdevel+bounces-27520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D8961DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE25BB22EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1FA14A4F9;
	Wed, 28 Aug 2024 05:11:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4614A0B9;
	Wed, 28 Aug 2024 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821875; cv=none; b=RR6CasNQAarqX8gfNe8Si01UneWRXxIjF4M9fT52R6T8CjR4ztmzY/7Yv0UemjU01o/oquC3r29sh7U/ObSh5kIS1PQnZd/0/GUKqdoZDZWAeblxyqQBsJ5uuiA16lC9evCx1yfCU2QwkTTFgtn3GXNL+YESmxrbJC08oaO/jOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821875; c=relaxed/simple;
	bh=sJ0srPLWSnV+D0eiPjNumzDGOoan5ZedVkPrbB4Vg/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpvdXz1ef5vCJ6jvPwoaYkpeo5vq++W2+1qRmaE7wlDsrfhJKEXe3xX3KLDrZIosvCf8JupYcMbMtCL8TERf7ejgBZqz+nf+R6HP/nq5mopPaRhaISPCUjU5et6URcdZ7XohsoLQFW4Mk+ydGZ515efDKZRz/AZ9ma7pLa2gCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7279368B05; Wed, 28 Aug 2024 07:11:10 +0200 (CEST)
Date: Wed, 28 Aug 2024 07:11:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: ebiggers@google.com, Christian Brauner <brauner@kernel.org>, hch@lst.de,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: Re: [PATCH -next] nilfs2: support STATX_DIOALIGN for statx file
Message-ID: <20240828051110.GA31869@lst.de>
References: <20240827015152.222983-1-lihongbo22@huawei.com> <CAKFNMomMtJbEbZNRAzari3koP1eRHOrUDQ=rAxDbL6yfHHG=gg@mail.gmail.com> <86e1541f-0d8b-4479-b8d1-bb5a9f5849d4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e1541f-0d8b-4479-b8d1-bb5a9f5849d4@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 28, 2024 at 09:12:50AM +0800, Hongbo Li wrote:
>> I checked the STATX_DIOALIGN specification while looking at the
>> implementation of other file systems, and I thought that if DIO
>> support is incomplete, the dio_xx_align member should be set to 0.
>>
>> Due to the nature of NILFS2 as a log-structured file system, DIO
>> writes fall back to buffered io.  (DIO reads are supported)
>>
> That's really a question. How to handle the asymmetric situation of 
> O_DIRECT read and write?
>
> The STATX_DIOALIGN specification does not define this case.

Yes, it needs separate reporting for the read alignment.  I actually
wrote patches for that a few days ago, but never got around to testing
them.  I'll send out what I have.


