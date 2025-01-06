Return-Path: <linux-fsdevel+bounces-38457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3037A02DE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C787A1DAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFA1922F6;
	Mon,  6 Jan 2025 16:40:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4213DB9F;
	Mon,  6 Jan 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181615; cv=none; b=DRpain3d+b3Q1Rqk5gkNwV3Of3awANuCbDmdhryaGjZzqXyeaZMJeIZyCNfpruU6nTnGWVJEN82YDwOHRvJ9zbpG8JAw97IbFGIjfZqWuRhu8FiwNkZ6dvUr/RbBjzxZqPkje/GidXyvyV1FeMMXPMolG0Atlh/NXSpMbZL1kBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181615; c=relaxed/simple;
	bh=XSpy1Szte8IG9c1/vqcq/VSt6ZGL/ojq1Ub+YwyGU2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhrvxys5/jAMF+SFG9SQjbHTJMv+m3F+joG+whgzg7g8ZfoSq6eHPrtW6BbzsBallAv2+Gc5SucHSZZqY3/FVhBmz2rgTG5NUSI5nNnY258MKqysOF/Ej2F/F5w0RK29InrkWlIV6hGZEVj+j0S8OGUMFcrg2FLo8jJJM+bREbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E3E168C7B; Mon,  6 Jan 2025 17:40:08 +0100 (CET)
Date: Mon, 6 Jan 2025 17:40:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: add STATX_DIO_READ_ALIGN
Message-ID: <20250106164008.GA29273@lst.de>
References: <20250106151607.954940-1-hch@lst.de> <20250106151607.954940-3-hch@lst.de> <o2gecwhofinap2qolyomkaijaeaorbqnqw4othvpwl4eqhdieo@a57gqldklqi7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o2gecwhofinap2qolyomkaijaeaorbqnqw4othvpwl4eqhdieo@a57gqldklqi7>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 05:32:14PM +0100, Jan Kara wrote:
> > Add a separate dio read align field, as many out of place write
> > file systems can easily do reads aligned to the device sector size,
> > but require bigger alignment for writes.
> > 
> > This is usually papered over by falling back to buffered I/O for smaller
> > writes and doing read-modify-write cycles, but performance for this
> > sucks, so applications benefit from knowing the actual write alignment.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> So if I understand right dio_offset_align is guaranteed to work for all DIO
> (i.e., maximum of all possible alignments), dio_read_offset_align is
> possibly lower and works only for reads.

Yes.  If you think this needs to be made more clear I'm open to
suggestions to improve the wording.


