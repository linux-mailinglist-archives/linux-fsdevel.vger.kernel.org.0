Return-Path: <linux-fsdevel+bounces-29636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2597BBDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CF5B22834
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736F189907;
	Wed, 18 Sep 2024 12:02:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6C282E5;
	Wed, 18 Sep 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726660927; cv=none; b=TEJ29Zmf7hyXx87EozjJ/WxTyl9Ub6EyWoHZvI/QJf7IabIIrJHILSR8qZafsbzeSA8tTqwKSCWtTF592oMMvAJ6q85bjGKC/9YXqjrSGuG/tHaofKzqrzDE0XTzWQWE+y9Z2+ue5Y4bSml92YvtdOmowjGOctiv0UIck7MV6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726660927; c=relaxed/simple;
	bh=9zV0BAFi1NuJZpjoIZAVRCxBV2f3YQrxAA4kfHyPlws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm58EnvBvHoKFJ+0CGjKQNkZ6SWPorffHQQhJP4bWPFMaHG+lPNhvUUWaILEphCmh3FtmFDVu7CArvKVR0aj6mIKfTTQ4ol1hNxHnh7+SFonjJzYy+ExQpe4BgLv2qKPuIj/7vEJt4BojpwahQaMhoUFL6spqMwQ5Q8vg3eNSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B102227AAD; Wed, 18 Sep 2024 14:01:59 +0200 (CEST)
Date: Wed, 18 Sep 2024 14:01:59 +0200
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
Message-ID: <20240918120159.GA20658@lst.de>
References: <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com> <20240917062007.GA4170@lst.de> <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com> <20240918064258.GA32627@lst.de> <197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 18, 2024 at 01:42:51PM +0530, Kanchan Joshi wrote:
> Would you prefer a new queue attribute (say nr_streams) that tells that?

No.  For one because using the same file descriptors as the one used
to set the hind actually makes it usable - finding the block device
does not.  And second as told about half a dozend time for this scheme
to actually work on a regular file the file system actually needs the
arbiter, as it can work on top of multiple block devices, consumes
streams, might export streams even if the underlying devices don't and
so on.

