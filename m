Return-Path: <linux-fsdevel+bounces-61083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D912B54EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBE3580116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546930C36D;
	Fri, 12 Sep 2025 13:10:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F166309DC6;
	Fri, 12 Sep 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682601; cv=none; b=ffK3+BDS1zj9UQsa2qn2+V7pGOUB98ZWnQi1ymGIyRZh01nsei7IbI8+WLMDYKNfcxLVH8xS3uCZFL7xYJFEhwgApNbfSuZiJyfcjqxcgHEGvbgBtaDZ+uEQSwrhMOyYj5ocqj0ulCRyiuZbqDeH90VNlhrmapS9QS6kyEvsGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682601; c=relaxed/simple;
	bh=A65bF41Ieqrq9K+IwzU4tiorMOIGX0Ztr+kfK9r/PUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkq115Efmnyy+abhBvuRbDUtQFbT5ODGmcUrqj6IdCQJWDM5UFxemuPKeAFO74jP3WHafqrNg3u33UKRW5t0ZrH+CZ1bPbX+gfNpbOB9LImWRZ29YBtNfGsqKLUcAzhZGU/wXsAuyCFkUyxtiUKA4LborAm6p78zMRc4hj2zEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89A8968BEB; Fri, 12 Sep 2025 15:09:53 +0200 (CEST)
Date: Fri, 12 Sep 2025 15:09:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <20250912130953.GA6754@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-2-9e5443af0e34@kernel.org> <20250729222252.GJ2672049@frogsfrogsfrogs> <20250811114337.GA8850@lst.de> <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh> <20250912071859.GB13505@lst.de> <khoyx76se2x2z2ktzelsklcqnbjl4budasczm2mjknkgvlsbph@gckk675qmqkj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <khoyx76se2x2z2ktzelsklcqnbjl4budasczm2mjknkgvlsbph@gckk675qmqkj>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 12, 2025 at 01:56:45PM +0200, Andrey Albershteyn wrote:
> > > In addition to being bound by the isize the fiemap_read() copies
> > > data to the iov_iter, which is not really needed for fsverity.
> > 
> > Aka, you want an O_DIRECT read into a ITER_BVEC buffer for the data?
> > 
> 
> hmm, but we want fsverity merkle tree to be in page cache to use the
> "verified page" flag.

Oh, right.  There's this thing called caching :)

> As far as I understand iter_bvec will need a
> page attached anyway, so this is the same. Or am I missing
> something?
> 
> And with direct io there's no readahead then, and we don't get any
> benefit going through vfs instead of directly calling to iomap.

Yeah, strike my idea.  So yes, you probably do want a lower level
interface that just reads the pages and gives you access to them.

> 
> -- 
> - Andrey
---end quoted text---

