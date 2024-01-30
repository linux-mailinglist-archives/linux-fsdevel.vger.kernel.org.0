Return-Path: <linux-fsdevel+bounces-9539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC7A8426E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 15:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807771F23FDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938D6EB74;
	Tue, 30 Jan 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOfnV6yr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BD6DD1F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624830; cv=none; b=UqgGOyxrp2sMQdVAr8Qzd+qOHRpr1DvOcv9WgUNaCWun42MwOg1rJYxuok06wJ1Mft1Byy5c+aWEYU32H+H/iju+gd0eOvU4wOSrPFWjzgv9truAe09rleJbDGyHkvpVLpA0FOIrhNWF7iXblFiHUtfNEpgaYhJmb9DZTFDLdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624830; c=relaxed/simple;
	bh=5p3LgCdEGKk3NWs/IAlbX6OPgZW0pLlNEZJxIYqkGoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYhYj2qckK/Mt8sdfSHWiezEOUnGZq/KjOh8Qb5V3WvwPufR/ZDMWWOhcNhVLRyFVyxTbJZM6azeKPVJcMLSY0Dkwks2W2HoCvrhDBKQmoej2u+9ehYOTL0ydOeKDHSpBbRZSZ7Smws1sWap5c1yVltT+tcQu0xyOdAn5xpKf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOfnV6yr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706624828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaujk7yqT3tCcvpOY/dPJbxkbTmDPNwYZxgb8W+DENY=;
	b=UOfnV6yrXwvWYuaai4G4snjEZn+cvTnJ6QrLcrTEG4zJ/s6ceDKVBpDJK30fh6J/NRSsUw
	3Bw70MkEz7eB3V+b2CgCFmOFxx0mNeVoOj6xsTyWkTLVc5zO33UBXw4i3pd8WbOs+nPu20
	+p6tOe6IV/HQjxLYyrcs8q1d0JdF7MY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-iuQoh3B7NLejN0iWnFWjiw-1; Tue,
 30 Jan 2024 09:27:05 -0500
X-MC-Unique: iuQoh3B7NLejN0iWnFWjiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E1723806711;
	Tue, 30 Jan 2024 14:27:04 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9862134;
	Tue, 30 Jan 2024 14:27:03 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:28:22 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 06/19] writeback: Factor out writeback_finish()
Message-ID: <ZbkHhos9oxnUZL/1@bfoster>
References: <20240125085758.2393327-1-hch@lst.de>
 <20240125085758.2393327-7-hch@lst.de>
 <ZbgG+7QhHGMz/uMJ@bfoster>
 <20240130140459.GA31126@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130140459.GA31126@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, Jan 30, 2024 at 03:04:59PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 29, 2024 at 03:13:47PM -0500, Brian Foster wrote:
> > > @@ -2481,6 +2500,9 @@ int write_cache_pages(struct address_space *mapping,
> > >  				folio_unlock(folio);
> > >  				error = 0;
> > >  			}
> > > +		
> > 
> > JFYI: whitespace damage on the above line.
> 
> Thanks, fixed.
> 
> > 
> > > +			if (error && !wbc->err)
> > > +				wbc->err = error;
> > >  
> > 
> > Also what happened to the return of the above "first error encountered"
> > for the WB_SYNC_ALL case? Is that not needed for some reason (and so the
> > comment just below might require an update)?
> 
> No, this got broken during the various rebases (and is fixed again later
> in the series).  We need to return wbc->err from write_cache_pages at
> this stage, I'll fix it.
> 

Ok, I noticed it was added back once I got to more of the iter
abstraction bits and so figured it was a transient/unintentional thing.
The above tweak makes sense to me.

FWIW, I haven't stared at the final patch long enough to have a strong
opinion. I tend to agree with Jan that the error handling logic in the
current series is a little wonky in that it's one of those things I'd
have to go read the implementation every time to remember what it does,
but the broader changes all seem reasonable to me. So for patches 1-18
and with the above tweak:

Reviewed-by: Brian Foster <bfoster@redhat.com>


