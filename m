Return-Path: <linux-fsdevel+bounces-35263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5759D3360
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 07:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50B3283FC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 06:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1C215820C;
	Wed, 20 Nov 2024 06:03:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B51156649;
	Wed, 20 Nov 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732082628; cv=none; b=dqr2HVZi5SY5OYxl+TqJDDo1FwOnht/4ixRc4pk4SiWv+4KiTumbO8Vl666mPsnhd76iVBqmVoWy48yhEGSgr9lHjgPoiOMat2SZQvbPBVpnqSKKk2n0s01DnrFWXjb68UWuqDDfsOTXd+AEfPFdQDdDIn8OtuZZoWLntcZWvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732082628; c=relaxed/simple;
	bh=Ozaltp4C4l7bmLA2D6FC6asJnm22K3KHxhrw/v7r0g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0yhdQ4U5rC7YBMBVN4NyKbUd2iHywLp+SEusmVQeFoFxsha5UXk3iGSrRJSENbu6rZwUxXTfPkGQXIAHLwMmPMVPQd81BD755eCyrCL1vQWFazszOUMf27IZJynURsMVJgmmZwEG3AMvDU7UAuITCFRUE4QsCX2O/SaNHXsm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4926268D8D; Wed, 20 Nov 2024 07:03:40 +0100 (CET)
Date: Wed, 20 Nov 2024 07:03:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>, Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme: enable FDP support
Message-ID: <20241120060340.GA10449@lst.de>
References: <20241119121632.1225556-1-hch@lst.de> <20241119121632.1225556-15-hch@lst.de> <ZzzWQFyq0Sv7cuHb@kbusch-mbp> <20241119182427.GA20997@lst.de> <Zz0V6qv3oyKV_Kzp@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz0V6qv3oyKV_Kzp@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 19, 2024 at 03:49:14PM -0700, Keith Busch wrote:
> But more about the return codes for pretty much all the errors here.
> They'll prevent the namespace from being visible, but I think you just
> want to set the limits to disable write streams instead. Otherwise it'd
> be a regression since namespaces configured this way are currently
> usable.

True, we should probably just log an error and continue here.  I'll
update it for the next version.


