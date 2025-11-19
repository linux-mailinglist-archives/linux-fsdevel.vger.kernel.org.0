Return-Path: <linux-fsdevel+bounces-69073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6EC6DE17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4B3302D985
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AE346FA2;
	Wed, 19 Nov 2025 10:05:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7633DECA;
	Wed, 19 Nov 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546733; cv=none; b=Tv1E1nEKET7fMXd/lq7V65QrkTVLP+oUGaCBU1q4n4E4VkIgHRoY2Q/y1FbM4RYAQrrxB4WB7oI8bC+9sXcLDRLfceaWvZwTHtLK1v+h1gLSBjaACOA9jGuyAY9jqzl/prT49Dmn3bN9DaxGGfBtAmsAZ9+EECkUKwJTSVTScpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546733; c=relaxed/simple;
	bh=QFwXvrh+s8t/zlzvGdyk857ITKwb8vfRVxCeEDVa8T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op/uXiN0NJLg/xFCig4Z64FOsOgWTwVfxYulNbkZpBvcDhKUngBvi8ov6qzo1IJK15ca9xNEp/Pgd899EmOsbtgajlLxyxxYh0hAL0Q5iUMxpDm9P2IRRw+xuB90QLadhGUUdghKANAl+9otQNJ+ctAmTskJmVzSU4/+/6ZyDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 756C868B05; Wed, 19 Nov 2025 11:05:26 +0100 (CET)
Date: Wed, 19 Nov 2025 11:05:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
	neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251119100526.GA25962@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com> <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com> <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 11:40:22AM -0800, Dai Ngo wrote:
>> If a .fence_client callback is optional for a layout to provide,
>> timeouts for such layout types won't trigger any fencing action. I'm not
>> certain yet that's good behavior.
>
> Some layout implementation is in experimental state such as block
> layout and should not be used in production environment. I don't
> know what should we do for that case. Does adding a trace point to
> warn the user sufficient?

The block layout isn't really experimental, but really a broken protocol
because there is no way to even fence a client except when there is
a side channel mapping between the client identities for NFS and the
storage protocol.

I'd be all in favour of deprecating the support ASAP and then removing
it aggressively.


