Return-Path: <linux-fsdevel+bounces-23358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C10F92B161
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 09:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779611C21499
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885D14532C;
	Tue,  9 Jul 2024 07:41:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2213211E;
	Tue,  9 Jul 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510913; cv=none; b=odkpyLUM89wiNsKlwxqic7rb+1+T1Nez5wv37NnNEskd+dDIxwV+pljYKOkSV4KCWeWG/XlikbB3yBt9E+1lsxYQ5T+UoL+gZQGZR28RowWa9As3sQqFhbFaLg9jhOw4+yPyf9WFBrkstcxTP3d3wTanQfnXqP4C8o95Dxo5tb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510913; c=relaxed/simple;
	bh=zSTxAoqhlu8QzY9NKi0O5x6uZgsrI+UZRAPBq6ulouQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVw07A5O/lwxixlJFMkjrrgqMMOV84VWtiEC/0/U6i+jbtFrE0sNfKKiFGn0Oe10kLmZqfYKEesY79+SXBKiD5mea4xUW+0/FqPLxQtF82rYYItgwCnxCZ5alY3d2Vb/NDT3zSBnPhv5N7IISAokSw8Ziwog9ShiGpHgc4n044w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20A3668AFE; Tue,  9 Jul 2024 09:41:48 +0200 (CEST)
Date: Tue, 9 Jul 2024 09:41:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 08/13] xfs: Do not free EOF blocks for forcealign
Message-ID: <20240709074147.GA21491@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-9-john.g.garry@oracle.com> <20240706075609.GB15212@lst.de> <ZotEmyoivd1CEAIS@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZotEmyoivd1CEAIS@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 08, 2024 at 11:44:59AM +1000, Dave Chinner wrote:
> On Sat, Jul 06, 2024 at 09:56:09AM +0200, Christoph Hellwig wrote:
> > On Fri, Jul 05, 2024 at 04:24:45PM +0000, John Garry wrote:
> > > -	if (xfs_inode_has_bigrtalloc(ip))
> > > +
> > > +	/* Only try to free beyond the allocation unit that crosses EOF */
> > > +	if (xfs_inode_has_forcealign(ip))
> > > +		end_fsb = roundup_64(end_fsb, ip->i_extsize);
> > > +	else if (xfs_inode_has_bigrtalloc(ip))
> > >  		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
> > 
> > Shouldn't we have a common helper to align things the right way?
> 
> Yes, that's what I keep saying. The common way to do this is:
> 
> 	align = xfs_inode_alloc_unitsize(ip);
> 	if (align > mp->m_blocksize)
> 		end_fsb = roundup_64(end_fsb, align);
> 
> Wrapping that into a helper might be appropriate, though we'd need
> wrappers for aligning both the start (down) and end (up).

I think the above is already good enough.


