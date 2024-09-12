Return-Path: <linux-fsdevel+bounces-29171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016179769B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347541C2362F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD9E1A4F1A;
	Thu, 12 Sep 2024 12:54:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771781E49F;
	Thu, 12 Sep 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145684; cv=none; b=Jo+aGY7Tb1QzGXmiU9NworR08IvtlqTVQ/86T/Q6tB5JmvbgaeJC1cv/WS6HgQPc6Qi3CuvWbwCC/cENJ1yIiSTbzCqbQD/PKTPhblLbrGcyi3BdfKHNt7wlCQvvafWAK6/UYJ4DRzeTY6jmCBvCw32fUBiQ08VqjNcobZ9Oi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145684; c=relaxed/simple;
	bh=8APp/Yy2G604WqM1PE3PGOMTxoqh/mu66mcme6NivDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OigZ2M9j/URkHtw842Jh5CrNeUXyIgixREj8v4ic0c+QnY2UqTWHwLKlW99PKHKl91FQHe+UAJDb4sDhVoYoW21Sr9rKvNba9IU1/2zOC5qYj0uxpQjtTAuYiAj1vWXqc9dG1yhBD3PGf29vTZtF8NkaTxGNrxUD8DZ9QUg51VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2EFE227AB5; Thu, 12 Sep 2024 14:54:38 +0200 (CEST)
Date: Thu, 12 Sep 2024 14:54:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v5 2/5] fcntl: rename rw_hint_* to rw_lifetime_hint_*
Message-ID: <20240912125438.GB28068@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f@epcas5p3.samsung.com> <20240910150200.6589-3-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 10, 2024 at 08:31:57PM +0530, Kanchan Joshi wrote:
> F_GET/SET_RW_HINT fcntl handlers query/set write life hints.
> Rename the handlers/helpers to be explicit that write life hints are
> being handled.
> 
> This is in preparation to introduce a new interface that supports more
> than one type of write hint.

Wouldn't it make more sense to stick with the name as exposed in the
uapi?  The same minda applies to the previous patch - in fact IFF we
decide to do the rename I'd probably expect both parts to go together.


