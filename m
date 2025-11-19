Return-Path: <linux-fsdevel+bounces-69070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B94C6DD48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7A53D2DC93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2741134403B;
	Wed, 19 Nov 2025 09:54:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19DD342519;
	Wed, 19 Nov 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546065; cv=none; b=bUcJIaxqg1FTIllorh+Ovse97HywLyXDMIK0QjNTxv5ej1OP3DL0cQrBHUa32cc2f8xQJpCWM3MvTHYNmB7EBcax1KE/iafKH/DFUpZhmPrSpOjOiIBFfA7tqHlR6P1sgkB2JVI8AeOGzeZzPXxMQ6Ba/2OnvAP9G8+KnP3Cv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546065; c=relaxed/simple;
	bh=XgcZV+rtT97cf3WjGS7oGgXCEFQmbsT1cr2OI2zN4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOnbYMlP1VlRAL9JxR03WCx0UfrGkZ1LtDjxf6a9d93vdi0I9Z5qAA4wJuBnM718JjEitpx4oUTrH88gXhSuNyxLY7GGn8OUpbJgQqaMPBHOW3IHlhFdKzKV10Wj3UeEkd/9RMR6/57xPzxXd8yrnc1qwK16mO+tXnESHgsZz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B583D68B05; Wed, 19 Nov 2025 10:54:19 +0100 (CET)
Date: Wed, 19 Nov 2025 10:54:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/3] locks: Introduce lm_breaker_timedout operation
 to lease_manager_operations
Message-ID: <20251119095419.GB25764@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-2-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251115191722.3739234-2-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 15, 2025 at 11:16:37AM -0800, Dai Ngo wrote:
> Some consumers of the lease_manager_operations structure need
> to perform additional actions when a lease break, triggered by
> a conflict, times out.
> 
> The NFS server is the first consumer of this operation.
> 
> When a pNFS layout conflict occurs and the lease break times
> out — resulting in the layout being revoked and its file lease
> removed from the flc_lease list — the NFS server must issue a
> fence operation. This operation ensures that the client is
> prevented from accessing the data server after the layout
> revocation.
> 
> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")

This again does not fix anything.  It is infrastructure for your fix
in patch 3.


