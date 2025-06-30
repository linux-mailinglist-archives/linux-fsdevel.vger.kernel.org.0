Return-Path: <linux-fsdevel+bounces-53296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFF4AED3FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6668717247E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8121DDA15;
	Mon, 30 Jun 2025 05:43:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACC19F40B;
	Mon, 30 Jun 2025 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262202; cv=none; b=Acnn2TLvrWAxA2i6Ttpa1pQv/z+bsIKLhbgqzWX1KHm8WvACemOAo8D9K0cbX0ESUE+4SB6U2R3k1GhDpBJtV5YFFp2Th+3l6XlRiXuBHTX4IqtnJeJkJwl5MRYDmaDuekwPm8Yo5D+8nLQhND4/IDBPYtaB3Rsgqqffxv2w44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262202; c=relaxed/simple;
	bh=ZlS+nx0Km3PxiKn+xd47Kjpqv/msUR9APIhVUn+Jj8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdhu8fjjEtnUDAIqZjRdRvRZrh4V7xKWzvBzHaUnySQginK0Lz4QrkxkYHWzf5FVdrnH0plKNS9lFzKkskpJyyrFfV5TM2rI/lyFIqSrAxYgenpXBPXrFNVSey0nd9u0417YOdY8ZbRULTUFDxzrjRbGUI7QhQb92WaF3yUblQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D370A68AA6; Mon, 30 Jun 2025 07:43:15 +0200 (CEST)
Date: Mon, 30 Jun 2025 07:43:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 10/12] iomap: replace iomap_folio_ops with
 iomap_write_ops
Message-ID: <20250630054315.GB28532@lst.de>
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-11-hch@lst.de> <aF7ugUxtYQrjRl1D@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF7ugUxtYQrjRl1D@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 27, 2025 at 03:18:25PM -0400, Brian Foster wrote:
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index ff05e6b1b0bb..2e94a9435002 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -79,6 +79,9 @@ xfs_iomap_valid(
> >  {
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  
> > +	if (iomap->type == IOMAP_HOLE)
> > +		return true;
> > +
> 
> Is this to handle the xfs_hole_to_iomap() case? I.e., no validity cookie
> and no folio_ops set..? If so, I think a small comment would be helpful.

Yes, and I can add a comment.


