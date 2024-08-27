Return-Path: <linux-fsdevel+bounces-27468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBE1961A25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1F9284FA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B11D4174;
	Tue, 27 Aug 2024 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sJrWBI2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319271D3643
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799087; cv=none; b=OHbgjKp6mUuCH8eHpLXEAwYL4aeXupUeSCIvrVUUepdV1szhu/pCyWUl7Miwc0B4OPJd6sJ9SXqsCoEYlW//JhLgvRKuKZ66V3GbDzi35gp3Dp8fA7et4T4OKjKuCs5+dIkF+kVmolQd/TpuhMGdQCRRCffd6QdfANJKnpxbc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799087; c=relaxed/simple;
	bh=uZEV6Er55Y1nv1xBlG+kUchSJelI/Jfm4FIRafbGjV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEVxf+w1OncqLWB06TrlZwKWQzuaUeMiYMgM1rU0nJHwevYVnUEda8qvhU8Pigv2GBCaeaGh9jjuDPu4EU5DBL9/rClWijO7OabtUL04LTkS+viYKpMBQVEGIwRbgI/OB1oX3WcVJ/7tYi1Sh7LQIRcU7cEPfkMJkwqaswGyYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sJrWBI2F; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201e64607a5so43494805ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724799085; x=1725403885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJGHZxh5R6ZTtzzS/6NHcFwTfwgCDmdEBZWgyIzoMVk=;
        b=sJrWBI2FJL5ddMRADH+qo3A+SmTzsmuUmxnq6ndGO4pxZQFlS5VB+0sWQJDf1j1YF9
         cnSFDgsnTkdVrQ3UEMKvf2+mZBQ6qwuu2aP6vpS7Ac2qIIRXLDsUIaeWYZdGonuH/lxQ
         OHTeWtS4/Lzp2DFNMWw3dljnviTQ88zIZ5ZcHqzWz90bORq8ewtUD5W5rcOycr2Ar4gv
         4uhBqYAbuIGEi8LAg2DCpsQe9QKyH05+lb/DWQYXLvdwNfo5QSQMhWzPw0jbtG/HbqtL
         9dwFZT89JGwPkXy0/gzhxDmKFoKXnWYScQBclRcBm2nP2j7NCvXjDvptjjEgeoMqYG1F
         NHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724799085; x=1725403885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJGHZxh5R6ZTtzzS/6NHcFwTfwgCDmdEBZWgyIzoMVk=;
        b=Y+hkyR61Su+Z+eGpODOUvk+NUi3K7hXOua1whVpaLdFpaojugHB+2wlcrsqyixonto
         okMijVOj49wtBmE9+SozBoVAZfS0rf4X7yTM44JUWrV0hb+SgFJ++bNb/UtN542WqApk
         S4cIq0RcNrHRxS5smoxYpGEuVgrI63+sUeMhg37IEt9E+/aaVFTC6gxbdTWYAhe0lHT/
         eXVD0Sn977qvF8HBaBxnASiiF7+9fMH5bXwiVDqNL9z4SNIhkLuB5oBGJM4chhqZUvMG
         rCb/J2BPBMGJ5rqcRsasedol7GbHhRgYZXfDrIczxRxg4N7uNxFUPOS/El8B0rj4NURI
         pKCw==
X-Forwarded-Encrypted: i=1; AJvYcCUvYdWuJ2AYBLA9/wvd5/zy63l/xCTvKLGQNaCUbqlxkRHXcmfARphXNlPB0yjqt8MrNRap0q3NEo27iVfN@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMD+EydnsrGGJaqI+loroKBOSeDSYBxjiOs/R6ASQjfPw++tU
	KEtLpNcVxOeHTWcFUbL8j0pBiM9xi4I66IukLgejXAUbjizYQRYjlTFmSqsdC20=
X-Google-Smtp-Source: AGHT+IFtWGzsf+t9jppqitVe4iRyVZpKNl+Rv44cEroZBBCOkbsjRtNxvNObXq1JQJhWQRM7TkpVTg==
X-Received: by 2002:a17:903:244c:b0:203:a156:54af with SMTP id d9443c01a7336-203a15655dcmr223343795ad.17.1724799085373;
        Tue, 27 Aug 2024 15:51:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbf79sm87443545ad.125.2024.08.27.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:51:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sj522-00F3c9-04;
	Wed, 28 Aug 2024 08:51:22 +1000
Date: Wed, 28 Aug 2024 08:51:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] xfs: convert perag lookup to xarray
Message-ID: <Zs5Yac5V0pbz1PMF@dread.disaster.area>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-5-hch@lst.de>
 <20240821162810.GF865349@frogsfrogsfrogs>
 <20240822034548.GD32681@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822034548.GD32681@lst.de>

On Thu, Aug 22, 2024 at 05:45:48AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 21, 2024 at 09:28:10AM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 21, 2024 at 08:38:31AM +0200, Christoph Hellwig wrote:
> > > Convert the perag lookup from the legacy radix tree to the xarray,
> > > which allows for much nicer iteration and bulk lookup semantics.
> > 
> > Looks like a pretty straightforward covnersion.  Is there a good
> > justification for converting the ici radix tree too?  Or is it too
> > sparse to be worth doing?
> 
> radix trees and xarrays have pretty similar behavior related to
> sparseness or waste of interior nodes due to it. 

And the node size is still 64 entries, which matches up with inode
chunk size. Hence a fully populated and cached inode chunk fills
xarray nodes completely, just like the radix tree. Hence if our
inode allocation locality decisions work, we end up with good
population characteristics in the in-memory cache index, too.

> So unless we find a
> better data structure for it, it would be worthwhile.

I have prototype patches to convert the ici radix tree to an xarray.
When I wrote it a few months ago I never got the time to actually
test it because other stuff happened....

> But the ici radix tree does pretty funny things in terms of also
> protecting other fields with the lock synchronizing it, so the conversion
> is fairly complicated

The locking isn't a big deal - I just used xa_lock() and xa_unlock()
to use the internal xarray lock to replace the perag->pag_ici_lock.
This gives the same semantics of making external state and tree
state updates atomic.

e.g. this code in xfs_reclaim_inode():

	spin_lock(&pag->pag_ici_lock);
	if (!radix_tree_delete(&pag->pag_ici_root,
			       XFS_INO_TO_AGINO(ip->i_mount, ino)))
		ASSERT(0);
	xfs_perag_clear_inode_tag(pag, NULLAGINO, XFS_ICI_RECLAIM_TAG);
	spin_unlock(&pag->pag_ici_lock);

becomes:

	xa_lock(&pag->pag_icache);
	if (__xa_erase(&pag->pag_icache,
			XFS_INO_TO_AGINO(ip->i_mount, ino)) != ip)
		ASSERT(0);
	xfs_perag_clear_inode_tag(pag, NULLAGINO, XFS_ICI_RECLAIM_TAG);
	xa_unlock(&pag->pag_icache);

so the clearing of the XFS_ICI_RECLAIM_TAG in the mp->m_perag tree
is still atomic w.r.t. the removal of the inode from the icache
xarray.

> and I don't feel like doing it right now, at least
> no without evaluating if for example a rthashtable might actually be
> the better data structure here.  The downside of the rthashtable is
> that it doens't support tags/masks and isn't great for iteration, so it
> might very much not be very suitable.

The rhashtable is not suited to the inode cache at all. A very
common access pattern is iterating all the inodes in an inode
cluster (e.g. in xfs_iflush_cluster() or during an icwalk) and with
a radix tree or xarray, these lookups all hit the same node and
cachelines. We've optimised this into gang lookups, which means
all the inodes in a cluster are fetched at the same time via
sequential memory access.

Move to a rhashtable makes this iteration mechanism impossible
because the rhashtable is unordered. Every inode we look up now
takes at least one cacheline miss because it's in some other
completely random index in the rhashtable and not adjacent to
the last inode we lookuped up. Worse, we have to dereference each
object we find on the chain to do key matching, so it's at least two
cacheline accesses per inode lookup.

So instead of a cluster lookup of 32 inodes only requiring a few
cacheline accesses to walk down the tree and then 4 sequential
cacheline accesses to retreive all the inode pointers, we have at
least 64 individual random cacheline accesses to get the pointers to
the same number of inodes.

IOWs, a hashtable of any kind is way more inefficient than using the
radix tree or xarray when it comes to the sorts of lockless
sequential access patterns we use internally with the XFS inode
cache.

Keep in mind that I went through all this "scalable structure
analysis" back in 2007 before I replaced the hash table based inode
cache implementation with radix trees. Radix trees were a far better
choice than a hash table way back then, and nothing in our inode
cache access patterns and algorithms has really changed since
then....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

