Return-Path: <linux-fsdevel+bounces-67436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0404EC401FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 14:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F644260CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838B2E3AE9;
	Fri,  7 Nov 2025 13:30:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4231E8329;
	Fri,  7 Nov 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522252; cv=none; b=bfz6aQcYvn8KepkRpQ52U4YPnqYWUeHx8hxQJUaTNPjCESpQXses2dF5l0cglb6Rt0Gk173UqIRcjWbW/nC15M9OZP9Cy/a+PGva93mzEhZDncVA8HpkYFad7N74UeYxzhnNPif72kMvqcNh4k1ohGhpUY/PfO9GOYUaBM5jCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522252; c=relaxed/simple;
	bh=fIrg1WkQ6vuzpTq+HkV4PcBaI/j1CsekmcpW4pvLqRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh3hMqh1KF1q73zCJ/VHy+yLbc8ohStCGc0aw6w+7GnawJjfEW/ggKpDNcpmrfHr7IoSLzJdhev6aLnJfe4kw2LPxBtEWvrrUCVVTq98fK6CTqvlWz5ifNHrR4g/AcTz0CnUtz72iomGe/jnyiJiWGV8ymw3Nbky03QFkWWU13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81FD2227AAE; Fri,  7 Nov 2025 14:30:46 +0100 (CET)
Date: Fri, 7 Nov 2025 14:30:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [Patch 0/2] NFSD: Fix server hang when there are multiple
 layout conflicts
Message-ID: <20251107133045.GA5158@lst.de>
References: <20251106170729.310683-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106170729.310683-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 09:05:24AM -0800, Dai Ngo wrote:
> When a layout conflict triggers a call to __break_lease, the function
> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
> its loop, waiting indefinitely for the conflicting file lease to be
> released.
> 
> If the number of lease conflicts matches the number of NFSD threads (which
> defaults to 8), all available NFSD threads become occupied. Consequently,
> there are no threads left to handle incoming requests or callback replies,
> leading to a total hang of the NFS server.
> 
> This issue is reliably reproducible by running the Git test suite on a
> configuration using SCSI layout.

I guess we need to implement asynchronous breaking of leases.  Which
conceptually shouldn't be too hard.


