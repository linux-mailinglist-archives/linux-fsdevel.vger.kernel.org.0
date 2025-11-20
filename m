Return-Path: <linux-fsdevel+bounces-69211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57592C727AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 08:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0BD962F235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 07:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1852EA176;
	Thu, 20 Nov 2025 06:59:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020322128D;
	Thu, 20 Nov 2025 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621987; cv=none; b=lk1igVyIVf621uKQMY508dM9oWOAU4YSEDssNdRQrnfZnKISSgwZr9fNHdjqImML/Co1cbXKRls6UbCLI1ZHKgByOH0/D2ysp+2GSCXZy8/ze59c/PNnrHvLJlMnc5tDHrXJgK5lo2bRxHTIJBikiUd1hjXeBPA4k30kydJ/yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621987; c=relaxed/simple;
	bh=Hvp4Y5ZUcU9tlOrdgJ6pcbhEb6PPT9n/dACxtoMXs7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVahE6jq3H9qFtNVgnZBfpBCn4STcEQhl6Ivx3MQIAdlF7pC3OC0uo9DrkhjKjDC7YkJn5p0C2OUG7iW1QVbrTF74wPb6yw27oASNJOdAbSkeX/kdXOuLdetU+63vHvu96t8xICPUp+LuZgCl9Ba7KRIO7hieNimznPnGmsl3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6A5668B05; Thu, 20 Nov 2025 07:59:40 +0100 (CET)
Date: Thu, 20 Nov 2025 07:59:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Dai Ngo <dai.ngo@oracle.com>,
	jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com,
	tom@talpey.com, alex.aring@gmail.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251120065940.GA30524@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com> <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com> <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com> <20251119100526.GA25962@lst.de> <dc1e0443-5112-4a5d-9b3c-294e32ab7ed4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1e0443-5112-4a5d-9b3c-294e32ab7ed4@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 09:09:04AM -0500, Chuck Lever wrote:
> On 11/19/25 5:05 AM, Christoph Hellwig wrote:
> > On Mon, Nov 17, 2025 at 11:40:22AM -0800, Dai Ngo wrote:
> >>> If a .fence_client callback is optional for a layout to provide,
> >>> timeouts for such layout types won't trigger any fencing action. I'm not
> >>> certain yet that's good behavior.
> >>
> >> Some layout implementation is in experimental state such as block
> >> layout and should not be used in production environment. I don't
> >> know what should we do for that case. Does adding a trace point to
> >> warn the user sufficient?
> > 
> > The block layout isn't really experimental, but really a broken protocol
> > because there is no way to even fence a client except when there is
> > a side channel mapping between the client identities for NFS and the
> > storage protocol.
> 
> Is the protocol broken, or just incomplete, assuming that other
> (unspecified) protocols are necessary to be provided?

I guess it depends on your definition.  There is no shared client
identify between NFS and the storage protocol.  So you need a side
channel communication protocol such as sneakernet to register the
client identities on the server.  And that even assumes you have
a fencing method at that level, which often might not be the case.


