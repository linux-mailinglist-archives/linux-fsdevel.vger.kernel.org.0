Return-Path: <linux-fsdevel+bounces-18564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104408BA5F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF151C21D44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B272E620;
	Fri,  3 May 2024 04:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NBx+4+Ox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC16282E5;
	Fri,  3 May 2024 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709760; cv=none; b=AOvbwGigY5My+r9leqe0Hx5XZsMqs9Az+NTPM8HXhC5kDDGV1ae8ucf5qQxHZZjDcRpGh7J8cUn2YSb4O1ObWXy2J29dsd9ZvBi6fSTfRynZ2Yz5fFJFGXzxuJWulf0z795J8yzmkZRu8s66sh0JnuBfkWaOqVQpECIga0bQ6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709760; c=relaxed/simple;
	bh=JHozc1lJLorkZUnXT/A9NtPj/VKyF38FLBswt3L8pdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyRyfy+jIcHNZC4iHAdlapFZgGL558YA5+nHcJWiNjm4wg/l2nriacUhRFG2XyA5bNlJfYbQ2F4PxYQjpTBxwQ91vbdqs+Vhc27yo+loscotSUzRcl0/szR34RvH7SUFwLYHP7nAkrH4sWIpCbBxY05W0axnJR/ZOYx9OevIRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NBx+4+Ox; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KYL496NDtJ3Cfi5LpjPPAG/fu2r2wgakNsf4z3OY2l0=; b=NBx+4+Ox6BbjuUU9X4O948ttH5
	Bp7V+35CAqOGkTMymDBLcUezlMleSWCFMg/e3lOE9RqqE6pwO0fm6EPNb+/Gu0wRBhLCWtYqCnTa2
	j6TaTJkdZy725KkbSdwNJ5u5STrUuQq7lurmOJOBSQ989+03Y4y8CKCiIbB1lIMZQj8h+MnZtjaC4
	Bzo8MLJ3tKKYK+7YZ69+NJoOEGH+RpIe576KtNgblc9iOwczkBPDKJRv6dK1+3RUyDs7H0D2g/Zcv
	wuZ6Yjfe+JjBkcXDhseCilBXr33F2dANxwLJSVdmeWED6yUfZrSoONxU36Gfq5J3Co4ohjJvy+lgk
	g6uORDYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kKk-00A5MU-0F;
	Fri, 03 May 2024 04:15:42 +0000
Date: Fri, 3 May 2024 05:15:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 6/6] z_erofs_pcluster_begin(): don't bother with rounding
 position down
Message-ID: <20240503041542.GV2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV>
 <20240425200017.GF1031757@ZenIV>
 <7ba8c1a3-be59-4a2f-b88a-23b6ab23e1c8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba8c1a3-be59-4a2f-b88a-23b6ab23e1c8@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 26, 2024 at 01:32:04PM +0800, Gao Xiang wrote:
> Hi Al,

> This patch caused some corrupted failure, since
> here erofs_read_metabuf() is EROFS_NO_KMAP and
> it's no needed to get a maped-address since only
> a page reference is needed.
> 
> >   		if (IS_ERR(mptr)) {
> >   			ret = PTR_ERR(mptr);
> >   			erofs_err(sb, "failed to get inline data %d", ret);
> > @@ -876,7 +876,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
> >   		}
> >   		get_page(map->buf.page);
> >   		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
> > -		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
> > +		fe->pcl->pageofs_in = offset_in_page(mptr);
> 
> So it's unnecessary to change this line IMHO.

*nod*

thanks for catching that.

> BTW, would you mind routing this series through erofs tree
> with other erofs patches for -next (as long as this series
> isn't twisted with vfs and block stuffs...)?  Since I may
> need to test more to ensure they don't break anything and
> could fix them immediately by hand...

FWIW, my immediate interest here is the first couple of patches.

How about the following variant:

#misc.erofs (the first two commits) is put into never-rebased mode;
you pull it into your tree and do whatever's convenient with the rest.
I merge the same branch into block_device work; that way it doesn't
cause conflicts whatever else happens in our trees.

Are you OK with that?  At the moment I have
; git shortlog v6.9-rc2^..misc.erofs 
Al Viro (2):
      erofs: switch erofs_bread() to passing offset instead of block number
      erofs_buf: store address_space instead of inode

Linus Torvalds (1):
      Linux 6.9-rc2

IOW, it's those two commits, based at -rc2.  I can rebase that to other
starting point if that'd be more convenient for you.

