Return-Path: <linux-fsdevel+bounces-37318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A889F0F79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBF51883194
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948C1E1C09;
	Fri, 13 Dec 2024 14:47:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31CA1E00BF;
	Fri, 13 Dec 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101267; cv=none; b=gbsj7I9pYE5tYT920LBCKoHYF8vx8/OGryZfE779Nely5ACOYv9vFIOjHBnLJwv80gUuXwk3nXwZbX5XJNIWGYeFLOx/O6YBffDRTTy14PEoPxX279me72uUsj9kpiwCN2Hbz2OAwkZyXqvwYstgKjIe0+DIftZonRRNFNJHNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101267; c=relaxed/simple;
	bh=L6CFcyMqqVLdt5CWJ0q58cYARtig/SXPSyyR5Z3hqe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhFCr80u4UeNEtxyeAdvlTt5wpFq0yUE6Xzdc4bNjp/DeSNrc5doQPF7Bt1mrrdktGP6VXN0iUKBHD4ur5wIXV+QeuwQquvx2TCrRzc6vGeJMNAmqOGbgx8oduCH5LrL8p9lFJfw+7YAP935pjFsPcBFWKA2wvEyEjbgSTrHZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAEFB68AA6; Fri, 13 Dec 2024 15:47:40 +0100 (CET)
Date: Fri, 13 Dec 2024 15:47:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20241213144740.GA17593@lst.de>
References: <20241210125737.786928-1-john.g.garry@oracle.com> <20241210125737.786928-3-john.g.garry@oracle.com> <20241211234748.GB6678@frogsfrogsfrogs> <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com> <20241212204007.GL6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212204007.GL6678@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 12:40:07PM -0800, Darrick J. Wong wrote:
> > However, I still think that we should be able to atomic write mixed extents,
> > even though it is a pain to implement. To that end, I could be convinced
> > again that we don't require it...
> 
> Well... if you /did/ add a few entries to include/uapi/linux/fs.h for
> ways that an untorn write can fail, then we could define the programming
> interface as so:
> 
> "If you receive -EBADMAP, then call fallocate(FALLOC_FL_MAKE_OVERWRITE)
> to force all the mappings to pure overwrites."

Ewwwwwwwwwwwwwwwwwwwww.

That's not a sane API in any way.

> ...since there have been a few people who have asked about that ability
> so that they can write+fdatasync without so much overhead from file
> metadata updates.

And all of them fundamentally misunderstood file system semantics and/or
used weird bypasses that are dommed to corrupt the file system sooner
or later.


