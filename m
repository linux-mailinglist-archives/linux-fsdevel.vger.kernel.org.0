Return-Path: <linux-fsdevel+bounces-47033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBFA97E42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE443ABBDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960FC266B59;
	Wed, 23 Apr 2025 05:44:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9C10F9;
	Wed, 23 Apr 2025 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387067; cv=none; b=A9+8lfPrlxSTL0zSVXHw7+abyaNSKC7Rg8pNbOW/Fv6q28J1uanSmgZEn0lbR4T4mMVJoIveLWCCkJbwIqTsSKeXoDDsVFLD47NQheNLGUnnoa3c7oUDTdp5cpiFuSFrk9kDchh3OnhDHv8D82n1vLSiPbKRieU6uPWwFrikgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387067; c=relaxed/simple;
	bh=vHQ9VFc+0soOfFI8ISh26uJ8XchOpT7J+OMvJ41bij4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWCqQAAY5WxsLgEbRLbDob8HrQbkwY17y3XWgdQE5ex6mqaBzm9pVsGdF5fXdLXFhT9b1vzD0eHQURzKVemYy1LY5ELkMliKmh0dymA2dwS9pDuADvFHxmSDkGo7WrFI2SvgILyiYyxwzM9j5jyog2opZLpfOi3DZPbntS/6ClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CD6E68AFE; Wed, 23 Apr 2025 07:44:20 +0200 (CEST)
Date: Wed, 23 Apr 2025 07:44:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	catherine.hoang@oracle.com, linux-api@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250423054420.GB23087@lst.de>
References: <20250415121425.4146847-1-john.g.garry@oracle.com> <20250415121425.4146847-12-john.g.garry@oracle.com> <aAa2HMvKcIGdbJlF@bombadil.infradead.org> <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 07:08:32AM +0100, John Garry wrote:
> So consider userspace wants to write something atomically and we fail as a 
> HW-based atomic write is not possible. What is userspace going to do next?

Exactly.

>
> I heard something like "if HW-based atomics are not possible, then 
> something has not been configured properly for the FS" - that something 
> would be extent granularity and alignment, but we don't have a method to 
> ensure this. That is the whole point of having a FS fallback.

We now have the opt limit, right? (I'll review the reposted series
ASAP, but for now I'll assume it)  They can just tune their applications
to it, and trigger on a trace point for the fallback to monitor it.


