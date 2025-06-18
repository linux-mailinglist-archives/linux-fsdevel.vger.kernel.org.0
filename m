Return-Path: <linux-fsdevel+bounces-51998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC2ADE2A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EB6177ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3441EF092;
	Wed, 18 Jun 2025 04:39:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A61DFDA1;
	Wed, 18 Jun 2025 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221547; cv=none; b=UKpMnNe/6/OvtcdkeLSX5FN0pjQ89kOI2JBrc9Po+hqO9UkIqG4vtgqHmkRxPtkzL3AAXaJph1FxdgB8F/70RCKkxHVJ0KEn3oSLNn/971Rvvf4hpfg2W08ritcyL0evd9f7hiX0j8k7hxZhTlnPdSk8bys2pBy9m1v3EMkoFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221547; c=relaxed/simple;
	bh=gVWdIXcfyb1mtgzZAUThUNzPJy8YTRJD2rnPe0KX97U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQnX0jMnAuJ9/iwDHcsEllowj7EaKWUH9QhfAAVkUQ8MEDy+2bfn17wUdJA9Bn1m82yReJu77PsFAEVwO+oAGnCgvdif4o/J0D8b00zNQItMRJZl5jdwxYmEu++wUpLXAYwyiror5Sx+psUMl2nBgKln6uNvifAQ6BShAiBxf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 630D768D0E; Wed, 18 Jun 2025 06:39:01 +0200 (CEST)
Date: Wed, 18 Jun 2025 06:39:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 03/11] iomap: refactor the writeback interface
Message-ID: <20250618043901.GB28041@lst.de>
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-4-hch@lst.de> <CAJnrk1br2LkVvRgMAojU6sQ9KAc0pTzcd_hxGx7MMqZuEyr_yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1br2LkVvRgMAojU6sQ9KAc0pTzcd_hxGx7MMqZuEyr_yA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 17, 2025 at 11:33:31AM -0700, Joanne Koong wrote:
> > +               struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> 
> end_pos only gets used in iomap_add_to_ioend() but it looks like
> end_pos can be deduced there by doing something like "end_pos =
> min(folio_pos(folio) + folio_size(folio), i_size_read(wpc->inode))".
> Would it be cleaner for ->writeback_range() to just pass in pos and
> len instead of also passing in end_pos? I find the end_pos arg kind of
> confusing anyways, like I think most people would think end_pos is the
> end of the dirty range (eg pos + len), not the end position of the
> folio.

i_size could change under us.  See commit b44679c63e4d ("iomap: pass byte
granular end position to iomap_add_to_ioend") which addes this end_pos
passing for details.

> > -       return 0;
> > +map_blocks:
> 
> nit: should this be called map_blocks or changed to something like
> "add_to_ioend"? afaict, the mapping has already been done by this
> point?

Sure.  Or maybe I just need to refactor the code to keep a separate
map_blocks helper and wrap it in a writeback_range one to make things a
bit easier to follow.

