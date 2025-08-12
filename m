Return-Path: <linux-fsdevel+bounces-57470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF365B21FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D505064AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067222DE6E9;
	Tue, 12 Aug 2025 07:42:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931C1A9F99;
	Tue, 12 Aug 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984535; cv=none; b=GajG21Podo/Iwh/Icw32NcvvI0c8Ba5gxJGpr4A0wtiP2U5g7i9ASaDCHn9sJuGV7iMu1JfyCuxSqK3QdbImycPRbY7VgKPi5qWuFGKQHxXcuHoksyBsofrNR32ApUvDeIUaLVTyPL8PLeVDT1JLP0pzPjWSG1vFtzTx0Lxh85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984535; c=relaxed/simple;
	bh=2bDgS+ERamckfItWvQxozxtyLSoxJdXeKZpx75U/LHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhNbL4eQBJyUJcplryFYPLmd7vsawiQmr5G9D9OQiHDUx5I/OXCKqo9SjbRkN9UvFJulPLKWhxIDMg8gK0lOxrVUtgqnZwuv7F4Vw8Y8jzjwS2rJovhrrlshrs4phJSLZQ7chuWHEaaO+b7iX+bnPn4yZEybZuOY1Q7rBdsusbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3632568AA6; Tue, 12 Aug 2025 09:42:09 +0200 (CEST)
Date: Tue, 12 Aug 2025 09:42:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org
Subject: Re: [PATCH RFC 12/29] fsverity: expose merkle tree geometry to
 callers
Message-ID: <20250812074208.GB18413@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-12-9e5443af0e34@kernel.org> <20250811114813.GC8969@lst.de> <20250811153822.GK7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811153822.GK7965@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 11, 2025 at 08:38:22AM -0700, Darrick J. Wong wrote:
> > Just curious, why does xfs need this, but the existing file systems
> > don't?  That would be some good background information for the commit
> > message.
> 
> Hrmmm... the last time I sent this RFC, online fsck used it to check the
> validity of the merkle tree xattrs.

I saw a few users, so it does get used.  But patches exporting something
should in generaly document what the use case is.

> > > +	if (!IS_VERITY(inode))
> > > +		return -ENODATA;
> > > +
> > > +	error = ensure_verity_info(inode);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	vi = inode->i_verity_info;
> > 
> > Wouldn't it be a better interface to return the verity_ino from
> > ensure_verity_info (NULL for !IS_VERITY, ERR_PTR for real error)
> > and then just look at the fields directly?
> 
> They're private to fsverity_private.h.

Indeed.  Is ensure_verity_info ven the right thing here?  I.e.
should quering the paramters create the info if it wasn't there
yet?


