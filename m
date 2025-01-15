Return-Path: <linux-fsdevel+bounces-39331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8FA12CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F2F1666EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232B1DAC97;
	Wed, 15 Jan 2025 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dz6bki97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290531DA313;
	Wed, 15 Jan 2025 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973032; cv=none; b=oZp8K+BBCf7g3RHSTU5+AYSHCfyfOfLoWi13Ut0p7sNyTieaPk8jcWW6PSqpV/uu6ton8TatfYDLVHl1JWsxlZ9DleJiXd4vYYv04NCejZYSc8w0DfOHOOz5hes/tufikEpLdi4m5CA9MDvLaon4tiZwETUHk2Mcw6FWK2GvLN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973032; c=relaxed/simple;
	bh=HPaYTVEypOwN1jVqiYLnAaU2yfZG0UxiOH79rPTb7A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO6o6GSuaEoOw1Us65dxfaOPQWsc+9NCx/YBxzQ8KQc0Jvuh5ywSWM7kNO/uutyM0HVRA+CRp27HojaQya+fFdp4NV6EgJvOipHGePrC5jnuG38Wu/XDTyJ8rWEcHAg4RDKjoK85oKMJCsSvmIB85wawXFxsDy+2WyGAt7S3D8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dz6bki97; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iFZH/qrvE9cPwBM5Scsg9nKR3U4eYSNRd+JFXwMnEt4=; b=dz6bki97d68QE0+2tK0fyQvi6T
	UuCwtBEDg3PFiWsTtgCfeIFNnoKBtFemjzZ1yEoDMpuI7hNvr0j6e3/m7pib7SUTPYSUd8uiz3NhW
	gS1jF4J/LH9rDfHEd6o3QxerNucNMcLM/VGqUKhpKQtEUjB9J5rYvLV5/Ao7zWkB6f7tOM9w+t1qy
	A3eLliXAQZiBO3g0RK9ANAXkGPnVfp47tApxmQPY2wyn2dxltvijGYd9HgYfztHCbKt7rdZb7/TAc
	FUxMieU2vrxrnULKyZYrK7LobYE4d0UW/yIgd4PwPG4vrw60IBRFMjFLRCxu4nAsAiNVRKmb+q3zh
	k2PTNqaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYA1w-00000001jSo-2cMd;
	Wed, 15 Jan 2025 20:30:24 +0000
Date: Wed, 15 Jan 2025 20:30:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <20250115203024.GB1977892@ZenIV>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
 <Z4gW4wFx__n6fu0e@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4gW4wFx__n6fu0e@dread.disaster.area>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 16, 2025 at 07:13:23AM +1100, Dave Chinner wrote:
> On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/dcache.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index b4d5e9e1e43d..1a01d7a6a7a9 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
> >  	/* Make sure we always see the terminating NUL character */
> >  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
> >  
> > -	dentry->d_lockref.count = 1;
> >  	dentry->d_flags = 0;
> > -	spin_lock_init(&dentry->d_lock);
> 
> Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...

include/linux/dcache.h:80:#define d_lock  d_lockref.lock

