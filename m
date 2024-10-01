Return-Path: <linux-fsdevel+bounces-30446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFC098B770
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D821C2127E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F501BFDF0;
	Tue,  1 Oct 2024 08:43:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014319B587;
	Tue,  1 Oct 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772189; cv=none; b=qvKHXQ382OX62swoKxgdSOE6dOBNhGsssIZEVxFAZDavddeHrIQ+35iLrGI61Rdmn3OT0D1gHkJ6zTlv1yb4R3atu86IQlytD2Xn7oYMveDpxlP5kzPkFjfhd/MHXKRwACtovycLTYXHNA8S1UDFGfk6gsKjuoEz/Wq15Dijs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772189; c=relaxed/simple;
	bh=47m0NuQueB2uxpcTSyYqVnsgzJVO7bg0RTDz2umFsAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4dM7S88C965e3Jfy9CfkZ+jJf9aeGY1lLvA3nFVoQEVMsYDrJH1L+PM36RhhyugQnC2yhgDBTZjRsCrLHlph044DkXsZnhIDwtlH8YINk53Lup/H4F4BVop9Yswo07LzKNQefGXKKIHghzk42NsOHIz/Jj6gf/uBPz8WQ8QY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CBED227AAE; Tue,  1 Oct 2024 10:43:03 +0200 (CEST)
Date: Tue, 1 Oct 2024 10:43:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 5/7] xfs: Support atomic write for statx
Message-ID: <20241001084302.GD20648@lst.de>
References: <20240930125438.2501050-1-john.g.garry@oracle.com> <20240930125438.2501050-6-john.g.garry@oracle.com> <20240930163716.GO21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930163716.GO21853@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 30, 2024 at 09:37:16AM -0700, Darrick J. Wong wrote:
> Ok, so we're only supporting untorn writes if they're exactly the fs
> blocksize, and 1 fsblock is between awu_min/max.  That simplifies a lot
> of things. :)
> 
> Not supporting sub-fsblock atomic writes means that we'll never hit the
> directio COW fallback code, which uses the pagecache.
> 
> Not supporting multi-fsblock atomic writes means that you don't have to
> figure out how to ensure that we always do cow on forcealign
> granularity.  Though as I pointed out elsewhere in this thread, that's a
> forcealign problem.

It does simplify things a lot, and is probably a good idea for
the initial version.  But I suspect support for atomic writes
smaller than the block size will be really useful and we should
eventually support them, but maybe now on reflinked files or
alwayscow.

