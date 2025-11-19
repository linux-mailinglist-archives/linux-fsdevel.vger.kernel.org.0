Return-Path: <linux-fsdevel+bounces-69068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF8C6DD3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B60D828B09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019C343203;
	Wed, 19 Nov 2025 09:53:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B3340D9D;
	Wed, 19 Nov 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546019; cv=none; b=dwaibecRo/jfyva6D2lb6a1jSTynB4Mn+uVw+LKu2juOFwoLqHQ5C/+ARr8mEf52UijRFUhMq/BtA+T7zOShyCBNiGklITEQ5YNl2NUpVtF6MF/DbJXBQej8kFMhZw8pi0HwAIFD8CkKFg32Sdp2bGrnPAOto1zGbObnFf9Ftig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546019; c=relaxed/simple;
	bh=iBdUcDjg7wuNRxfTA/XFPs0JAztWGuVr/Lgkq4q5NBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MplEyHqE2EOYdLsocbYMS77RbIhgCtlwpjYidJVC2VRMbztRHuoyXLHsRKlXy1/sHFHGNiXV+w+dBB+jWxVWaN1UYdfL9melihf/eXa4EARhJAWRfmOZseRrBOYXmdd/59xcZKVN2bZz8ie0xo6lDsHyx+HAMaPoxbXSWRayKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F41E168B05; Wed, 19 Nov 2025 10:53:30 +0100 (CET)
Date: Wed, 19 Nov 2025 10:53:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] locks: Threads with layout conflict must wait
 until client was fenced.
Message-ID: <20251119095330.GA25764@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-3-dai.ngo@oracle.com> <5d19304ea493177c35d0ce13abe6dbf358240fa1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d19304ea493177c35d0ce13abe6dbf358240fa1.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 01:21:32PM -0500, Jeff Layton wrote:
> > +	if (type == FL_LAYOUT && !ctx->flc_conflict) {
> > +		ctx->flc_conflict = true;
> > +		ctx->flc_wait_for_dispose = false;
> > +	}
> 
> I don't like special casing this for FL_LAYOUT leases. It seems like we
> ought to be able to set up a lm_breaker_timedout operation on any sort
> of lease.

Yes, this should check for a lm_breaker_timedout operation instead.

> > +
> > +	/* for FL_LAYOUT */
> > +	bool			flc_conflict;
> > +	bool			flc_wait_for_dispose;
> 
> I'm also not a fan of this particular bool. Waiting for any
> lm_breaker_timeout operations to complete seems like something we ought
> to just always do.

Yes.

> In the trivial case where we have no special fencing
> to do, that should just return quickly anyway.

Exactly.


