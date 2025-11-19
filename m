Return-Path: <linux-fsdevel+bounces-69074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D634C6DE4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CE1C368497
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D75347FD7;
	Wed, 19 Nov 2025 10:08:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A333E344;
	Wed, 19 Nov 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546887; cv=none; b=i0YAeeG4nx04INQxleWK7/JKiEuKxgdWSnS1L6RgtSxo39MAoWwSC7mkMyisoYTjgJ0/mzb17s47bRTyLOrtR1uT8N6i66UOrMnqG3BuvqPQ6T+Poct/P58CpeIi7MNw90+dfh5DrIepUZK282CV4kpqnxw5/BmdBVUhZ7JPc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546887; c=relaxed/simple;
	bh=urIwC2Ra9skd49y4aDKzJOF5kw2jdqYayTXq5I58Is4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubK6V9HVK8jsFP6hNzhx/IpCV0Z7dwXAjscNvD1gEQtPyei9iza6DnrtN33GlwSMwYT50Cnj14HiNcYQw5D7JWfXlKEMYmk/ktuqIAd/uiO+0/qWVw8Ja5x0jUG92OR/oxKWrfkfpFr3m0nBf1W4VC085OHx6Dtosfu8geBZHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD45068B05; Wed, 19 Nov 2025 11:08:00 +0100 (CET)
Date: Wed, 19 Nov 2025 11:08:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
	neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251119100800.GB25962@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com> <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com> <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com> <09209CBD-6BEE-4BCE-8A13-D62F96A5BD87@hammerspace.com> <aeb05ba9-83c5-45a4-a75b-f76fc4686e7c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb05ba9-83c5-45a4-a75b-f76fc4686e7c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 02:00:07PM -0800, Dai Ngo wrote:
> Perhaps I overstated the severity of the risk. The real issue is, in the
> current state, SCSI layout recall has no timeout and if there are enough
> activities on the server that results in lots of layout conflicts then the
> server can hang.

All this is really caused by the synchronous waiting.  I'm not against
the workaround here, but I think we need to address that.  There's
really no reason to consumer threads for this waiting activity and
we'll need to stop doing it.


