Return-Path: <linux-fsdevel+bounces-43206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39054A4F613
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 05:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641FB16CA37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 04:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445281C6FF2;
	Wed,  5 Mar 2025 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVsdTwxD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA41C5F13;
	Wed,  5 Mar 2025 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148988; cv=none; b=lnt11ocqwnxXxdzRKLYp9z86AjamD5lEnicrqXqh5GR+xDLzYUyNkyHgSfhnwvucyev5+sDq+GeT42AFHuhna4ZEM3KK+VSrQxAkY6pnfzmAia2uWJmdwsvVFSJKjCA18TPPQTJwRypN7L7MsGxaNVWtaWJhoAu+56fi2b9Ke5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148988; c=relaxed/simple;
	bh=KnWK4WBKusULKXh8rt/olNtibFsLjys9ZkCcpHBAKF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L29fkZBskXIydeKSFKULX7dXj4qeEoALveFg/tje5/kgFiRfF4r3tIthLBT+IDu1fa3JC3KtCtTUGdcrs0nHRr8D9HCP/mUs/loPIXmI54pZKpEcViYcPf8ppdXmxdwsnQ53ZDkKqYGAh6yUflS7sA3Em2hPpc+LgUArnDvuR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JVsdTwxD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r1eE+ff6D+t8LqacPATEDZTgYb5IuWoyzJOni46S3RU=; b=JVsdTwxDF3TrDOiibQ9AxJWPYc
	7S2xMAbht8HZrOHtJ58/lyn7wvY7UAe9Cri3cEgf5lSD7PRJBHDQvE6dYUXhrNHqWIN2Ms36T8YxY
	ajfRxA4Pfr6Px8SeQhU4Z35kN9MdquLBcmU8GrXWVt/4EUx97KejAlQGCouVcgZrb0eL2vgIe9NF4
	h++ZTnPmK0fqQOru4gDwPr43HeTDptIcOhBF+32j+XgzGkNjpY+pwg9XjiAKbTAgLVBvRvvG7XJF9
	nqczg/BEMBU+1kuz6NTY1hBP/FK+i3R+Iq9k8LbgDzCN3BBML7S6uXn/tZIhEOyU+TL6oA7oA9qV1
	lSTztJLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpgO8-00000004hYD-3cGK;
	Wed, 05 Mar 2025 04:29:44 +0000
Date: Wed, 5 Mar 2025 04:29:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Re: [PATCH] ceph: Fix error handling in fill_readdir_cache()
Message-ID: <Z8fTOEerurzqKybx@casper.infradead.org>
References: <20250304154818.250757-1-willy@infradead.org>
 <7f2e7a8938775916fd926f9e7ff073d42f89108b.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2e7a8938775916fd926f9e7ff073d42f89108b.camel@ibm.com>

On Tue, Mar 04, 2025 at 06:41:46PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-03-04 at 15:48 +0000, Matthew Wilcox (Oracle) wrote:
> > __filemap_get_folio() returns an ERR_PTR, not NULL.  There are extensive
> > assumptions that ctl->folio is NULL, not an error pointer, so it seems
> > better to fix this one place rather than change all the places which
> > check ctl->folio.
> > 
> > Fixes: baff9740bc8f ("ceph: Convert ceph_readdir_cache_control to store a folio")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > ---
> >  fs/ceph/inode.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index c15970fa240f..6ac2bd555e86 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -1870,9 +1870,12 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
> >  
> >  		ctl->folio = __filemap_get_folio(&dir->i_data, pgoff,
> >  				fgf, mapping_gfp_mask(&dir->i_data));
> 
> Could we expect to receive NULL here somehow? I assume we should receive valid
> pointer or ERR_PTR always here.

There's no way to get a NULL pointer here.  __filemap_get_folio() always
returns a valid folio or an ERR_PTR.

> > -		if (!ctl->folio) {
> > +		if (IS_ERR(ctl->folio)) {
> > +			int err = PTR_ERR(ctl->folio);
> > +
> > +			ctl->folio = NULL;
> >  			ctl->index = -1;
> > -			return idx == 0 ? -ENOMEM : 0;
> > +			return idx == 0 ? err : 0;
> >  		}
> >  		/* reading/filling the cache are serialized by
> >  		 * i_rwsem, no need to use folio lock */
> 
> But I prefer to check on NULL anyway, because we try to unlock the folio here:
> 
> 		/* reading/filling the cache are serialized by
> 		 * i_rwsem, no need to use folio lock */
> 		folio_unlock(ctl->folio);
> 
> And absence of check on NULL makes me slightly nervous. :)

We'd get a very visible and obvious splat if we did!  But we make this
assumption all over the VFS and in other filesystems.  There's no need
to be more cautious in ceph than in other places.

