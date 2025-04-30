Return-Path: <linux-fsdevel+bounces-47722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA72AA4C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE1A3AB180
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2ED25DB11;
	Wed, 30 Apr 2025 12:59:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588A33086;
	Wed, 30 Apr 2025 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017955; cv=none; b=C4egciiktdreT/bF6JYicafRh6HruVI85+0PIbvY03PgJNoED/n8rRRz5EQ31xG5nPhZkeULLqvlSx68ip2vE677IPDqQx7cXyId56ckHKBg1ENjSeRL1zNEdN4IA0mTAocu+Q/bd31LUaVBAtbFmv4UIfbmSzIgfx2idFKovbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017955; c=relaxed/simple;
	bh=XZoHiZ+bZMB/yj+8myQMKA00svbtX13JjK8sRJtWc20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsxbndkLRFqjhk7Nrpj+ygvlkHEg70gegSB5a5e4Us8PHJb3Nb31WZ9/HGFeayxOc/FtK4s3YnMlLB+bIXhIcbxkTVYxU6JDu56JpyzYInqTHu0YEOkANXYVTvMsVsrEK8jc8u1PzsJMWiMxWnM1v4WWOsnikzDM+8FeQwuHgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A553A68CFE; Wed, 30 Apr 2025 14:59:06 +0200 (CEST)
Date: Wed, 30 Apr 2025 14:59:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v9 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250430125906.GB834@lst.de>
References: <20250425164504.3263637-1-john.g.garry@oracle.com> <20250425164504.3263637-6-john.g.garry@oracle.com> <20250429122105.GA12603@lst.de> <20250429144446.GD25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429144446.GD25655@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 29, 2025 at 07:44:46AM -0700, Darrick J. Wong wrote:
> > So this can't be merged into xfs_setsize_buftarg as suggeted last round
> > instead of needing yet another per-device call into the buftarg code?
> 
> Oh, heh, I forgot that xfs_setsize_buftarg is called a second time by
> xfs_setup_devices at the end of fill_super.

That's actually the real call.  The first is just a dummy to have
bt_meta_sectorsize/bt_meta_sectormask initialized because if we didn't
do that some assert in the block layer triggered.  We should probably
remove that call and open code the two assignments..

> I don't like the idea of merging the hw atomic write detection into
> xfs_setsize_buftarg itself because (a) it gets called for the data
> device before we've read the fs blocksize so the validation is
> meaningless and (b) that makes xfs_setsize_buftarg's purpose less
> cohesive.

As explained last round this came up I'd of course rename it if
we did that.  But I can do that later.


