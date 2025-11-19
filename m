Return-Path: <linux-fsdevel+bounces-69072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56EC6DDC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67B044ECDE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D03451CC;
	Wed, 19 Nov 2025 09:57:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8E3446D9;
	Wed, 19 Nov 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546273; cv=none; b=r66BBFFEjHoaH6NxcagoJOIZomQzhUfaD78F9RtIFiXEoC+MDzs2Ej0VsF8GWL0I1RRBD3R69f17+WDtO1AzqmYMZNQ+er+u7VyBIGOf7iPRebGeJcx7TP7mGecvHwrfTjhw1gvDNFptsmnNtPoN+3h4SIRXB37Vb4X1/VHE+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546273; c=relaxed/simple;
	bh=hd7Z63Ge5XS+csciAXESIuEXFuCWgQTPKN3QDmFRwPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9BrT6Io3Akl64gvMG7Etvhpijb8HDjAwFM6oA7WcCEEfY0NIlZPGv7yiswjZ1UYKmtysidM6g+jKACMZyzp5XWWoK2RM/zITwjYtT8u4yHbiVCuH0B8+ejejQ+YUuMVUZ1MTT6I6Aakuc4YZRdlKLf8U0pRNscpGj3cXvznDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8161568B05; Wed, 19 Nov 2025 10:57:48 +0100 (CET)
Date: Wed, 19 Nov 2025 10:57:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251119095748.GD25764@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com> <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 10:55:27AM -0500, Chuck Lever wrote:
> > +		if (nfsd4_layout_ops[type]->fence_client)
> > +			nfsd4_layout_ops[type]->fence_client(ls, nf);
> 
> If a .fence_client callback is optional for a layout to provide,
> timeouts for such layout types won't trigger any fencing action. I'm not
> certain yet that's good behavior.

It is a for type layouts for which we have explicit least breaks.
Maybe we need to find a way to formalize that?


