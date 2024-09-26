Return-Path: <linux-fsdevel+bounces-30182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CA398762B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34291C24F25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E413632B;
	Thu, 26 Sep 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G71ETbkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F157611E;
	Thu, 26 Sep 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362873; cv=none; b=dv01nS5N88Nl7TM2Gyk/UiNosqDwAxaHPu9B1biygjTSey3+n7+E3b5wviGph+lDvgiUreCjrvV/a5/uVirhINt+pso/Kpa9HPx3MhXqFVqJ8FzgRNvYGqiysCn4fkdJijw28EfOEfzsPU8S5SSBFrCidy641ykUycrDn4EvXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362873; c=relaxed/simple;
	bh=xt+lwaa8Bhd6R3nAk5b0ke55SJtmalMMKqPtuZLAfeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5zHOhm0hCjnQlxkNTnPS/HGEgLLCDcYBm48yIqcNMwIxsLTeIb2QqIkLlj1qqwqnB28cF1VAzKs0zRPfnw1pRBhgGkBC3l9kz/6Bin0MKMzDrDuk3oJGMFLyP/bjDVm6shGeEUlnFMPQL42pbicewOosYwYWLceo/vZhetRNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G71ETbkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3744C4CECD;
	Thu, 26 Sep 2024 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727362873;
	bh=xt+lwaa8Bhd6R3nAk5b0ke55SJtmalMMKqPtuZLAfeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G71ETbkNuOvxdCDcYwz1RthpPynvTuSaqF+qzvKT1QXOY4quc8y79x/kV+Dsqli4Z
	 AgYyN/ebZfjIa3T2gVhgXID2u1WLYfO4YlhMfVxZE97hrpoClionXb+C7XExXUYtLS
	 2T5x13+SfXcfVLVpX281Tex4m3BoR+3ZsVL83Nae6oeqVVfVeUpVwYvkaKulbOGjW1
	 kROSiaq0bu2NzVMuS8V2QlcRHHizeMW53ysAlMkQjaAjoJS9joBiGe8zDXVAdzJwnS
	 3zkquPaq6YnbM79fDb2Ol6plnjSDWdlFMOkU8uIA4p11k2UH8smlYuI0+PtweVoMmE
	 sn+KNsFVQ4VJA==
Date: Thu, 26 Sep 2024 11:01:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	trondmy@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: filemap: Fix bounds checking in filemap_read()
Message-ID: <ZvV3N0F1ZR9Y7SAr@kernel.org>
References: <c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com>
 <ZuSCwiSl4kbo3Nar@casper.infradead.org>
 <ZuipUe6Z2QAF9pZs@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuipUe6Z2QAF9pZs@dread.disaster.area>

Hi Willy,

On Tue, Sep 17, 2024 at 07:55:29AM +1000, Dave Chinner wrote:
> On Fri, Sep 13, 2024 at 07:21:54PM +0100, Matthew Wilcox wrote:
> > On Fri, Sep 13, 2024 at 01:57:04PM -0400, trondmy@kernel.org wrote:
> > > If the caller supplies an iocb->ki_pos value that is close to the
> > > filesystem upper limit, and an iterator with a count that causes us to
> > > overflow that limit, then filemap_read() enters an infinite loop.
> > 
> > Are we guaranteed that ki_pos lies in the range [0..s_maxbytes)?
> > I'm not too familiar with the upper paths of the VFS and what guarantees
> > we can depend on.  If we are guaranteed that, could somebody document
> > it (and indeed create kernel-doc for struct kiocb)?
> 
> filemap_read() checks this itself before doing anything else:
> 
> 	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
>                 return 0;
> 
> i.e. there is no guarantee provided by the upper layers, it's first
> checked right here in any buffered read path...
> 
> -Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com

Linus merged the NFS LOCALIO changes via the NFS client tree a couple
days ago.  LOCALIO teased out this filemap_read infinite loop bug, so
it is important to fix this for 6.12 (probably should get marked for
stable@ too):
https://lore.kernel.org/all/c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com/

(weirdly, Trond's reply to you didn't make it to the linux-nfs or
linux-fsdevel list archives, but Dave's above reply covers the same)

Trond also offered this additional filemap_read negative check:
https://lore.kernel.org/all/482ee0b8a30b62324adb9f7c551a99926f037393.1726257832.git.trond.myklebust@hammerspace.com/

Could be you've been busy with travel or whatever, but for future
reference, should linux-mm and/or Andrew always be cc'd on filemap
fixes?

Thanks,
Mike

