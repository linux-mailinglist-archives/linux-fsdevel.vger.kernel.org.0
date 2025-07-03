Return-Path: <linux-fsdevel+bounces-53793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D34AF73A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711B57B82DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A342E6D10;
	Thu,  3 Jul 2025 12:17:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806C2E6119;
	Thu,  3 Jul 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545022; cv=none; b=qmurSEpnETf7NVLjc97/CiE2/t2JaNPlRmqkomjT8IaeL9LsOpPypIhVEVlXF62BEoJskV3JYjzAehiSZgR53zb+Vz7v/wdPJmcjQQQSMqkuRxmjbMYTWP4DOSTP7Wq9SoVyCMSWqQ5GGEkGBbMTlf0xBW6v4V1GDdmC9nJhNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545022; c=relaxed/simple;
	bh=YhSYv4Apjbr3Oj47VGbhmJgYZ9AgT0VyunWVMHcnmU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQxPY6E1uY4/2REteJp+sZ3aEwCyXJBqBCpwB4FcDi7silEnav2VT2UbP2y5Nabu3XgCPAZ3m/Fg61GSjb6+aGx2aiH/4Ogewv60m0q/eeT0+5Ow+NlxBjvtYLHcI5DbppCaZyUCwKkSkTr4IlvKAgsICMVjsn5VLbsFZJ3fUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E0FB368C7B; Thu,  3 Jul 2025 14:16:54 +0200 (CEST)
Date: Thu, 3 Jul 2025 14:16:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	hch@lst.de, miklos@szeredi.hu, brauner@kernel.org,
	anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 03/16] iomap: refactor the writeback interface
Message-ID: <20250703121654.GA19114@lst.de>
References: <20250624022135.832899-1-joannelkoong@gmail.com> <20250624022135.832899-4-joannelkoong@gmail.com> <20250702171353.GW10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702171353.GW10009@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 02, 2025 at 10:13:53AM -0700, Darrick J. Wong wrote:
> > +    int (*writeback_range)(struct iomap_writepage_ctx *wpc,
> > +    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> 
> Why does @pos change from loff_t to u64 here?  Are we expecting
> filesystems that set FOP_UNSIGNED_OFFSET?

It doesn't really change, it matches what iomap_writepage_map_blocks
was doing.  I guess it simply doesn't fix the existing inconsistency.

> > +    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> 
> Nit:   ^^ indenting change here.

Yeah, RST formatting is a mess unfortunately.   I think the problem is
that the exiting code uses 4 space indents.  I wonder if that's required
by %##% RST?

> > +		if (wpc->iomap.type != IOMAP_HOLE)
> > +			*wb_pending = true;
> 
> /me wonders if this should be an outparam of ->writeback_range to signal
> that it actually added the folio to the writeback ioend chain?  Or maybe
> just a boolean in iomap_writepage_ctx that we clear before calling
> ->writeback_range and iomap_add_to_ioend can set it as appropriate?

What's the benefit of that?  A hole pretty clearly signal there is
no writeback here.

> Should this jump label should be named add_to_ioend or something?  We
> already mapped the blocks.  The same applies to the zoned version of
> this function.

The newer version already uses a map_blocks helper for both again.


