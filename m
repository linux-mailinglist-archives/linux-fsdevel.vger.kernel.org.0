Return-Path: <linux-fsdevel+bounces-29955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7439F984217
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6481F241B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1415666D;
	Tue, 24 Sep 2024 09:28:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9E146D59;
	Tue, 24 Sep 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170120; cv=none; b=NJhWn6dDMc7nNfYB6g+ISuM6sJDHcDjhIU8dDMI0/zjwHOuj9tAfc5/Os2qbOM3VwB6j6J08p4KRRktSrln+AXneYraoxUTfuIbowNPgKbVecIkTf560HCynqJizrS48rFnHMjtPW6t8nG+YyU7cz5EdqeNK6bxvCwPCAbF5/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170120; c=relaxed/simple;
	bh=fjVVmIrEi0o8jKXEV+bEzfwsrbypruhXbD3Jk5awKw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEjT5TLPSiyfRqfzaDpfQe6OtdpZmw17E9kCooEpCAh2zal1NS+bKI+YgmFjupYiDbc6Dssr0Lz+vwHLwoDBmlVLX430m4GkYqNQKrV8TBdmMOVNGwb7RzyD5mWSO/T10j2tYnqBUmiPPXdmucJubBdLVVtHe38IQfjltn8Z94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE8A1227A8E; Tue, 24 Sep 2024 11:28:32 +0200 (CEST)
Date: Tue, 24 Sep 2024 11:28:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240924092832.GA26208@lst.de>
References: <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com> <20240917062007.GA4170@lst.de> <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com> <20240918064258.GA32627@lst.de> <197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com> <20240918120159.GA20658@lst.de> <edcbf69e-9ae9-06df-60c0-47393371fcd8@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edcbf69e-9ae9-06df-60c0-47393371fcd8@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 24, 2024 at 02:54:51PM +0530, Kanchan Joshi wrote:
> FS managed/created hints is a different topic altogether,
> and honestly 
> that is not the scope of this series. That needs to be thought at per-FS 
> level due to different data/meta layouts.

No, it is not.  If you design an API where hints bypass the file
system you fundamentally do the wrong thing when there is a file
system.  No one is asking to actually implement file system
support in this series, but we need to consider the fundamental
problem in the API design.

And yes, the actual implementation will be highly dependent on the
file system.

> This scope of this series is to enable application-managed hints passing 
> through the file system. FS only needs to pass what it receives.

Which fundamentally can't work for even a semi-intelligent file system.


