Return-Path: <linux-fsdevel+bounces-59169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDBEB35648
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003AC3BFA4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8A283C90;
	Tue, 26 Aug 2025 08:02:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6161D5178;
	Tue, 26 Aug 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195327; cv=none; b=YiWAPr7bLtaGPKob/e8wI9DrSB0F3IOj4KFGMJxkxs0YFqW1S6aR/e+zY46M2pcet02S/+8XBq9H+shihQJ5P3hrrn3kfyXfiZh4SOSts6WM0FeDkK+d8ufT1O8lzs20nUx+Ly5pzH9Y+y5Z87TTqRsg3Wjgp7M8QXUdsZDigeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195327; c=relaxed/simple;
	bh=n/Tqydyh65lEECKEPzhd6XkDIOw2QWBJQ49RNnonqsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUeSJLPUYEXaAe71527nEyYNWJ4YsPJsave1rbWEndF49eX92iMdYX+E1cy5pgCqquhaoYJ3MYfKVaQiWZnLvsOdj4dUbnoLFsptDOKUruKGBxXCPiBOoUQ7P4EOV6P2Sqsl9BZ2RX48iNXuVcRKIJF5YAABIpJvxyKohwroPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13EB367373; Tue, 26 Aug 2025 10:02:01 +0200 (CEST)
Date: Tue, 26 Aug 2025 10:02:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCHv3 3/8] block: align the bio after building it
Message-ID: <20250826080200.GA23095@lst.de>
References: <20250819164922.640964-1-kbusch@meta.com> <20250819164922.640964-4-kbusch@meta.com> <20250825074744.GF20853@lst.de> <aK0Bsf6AKL8a0wFy@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK0Bsf6AKL8a0wFy@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 25, 2025 at 06:37:05PM -0600, Keith Busch wrote:
> On Mon, Aug 25, 2025 at 09:47:44AM +0200, Christoph Hellwig wrote:
> > Also with this we should be able to drop the iov_iter_alignment check
> > for always COW inodes in xfs_file_dio_write.  If you don't feel like
> > doing that yourself I can add it to my todo list.
> 
> I'm unsure about the commit that introduced that behavior, so I think
> you should remove it if you know its okay. :)

Yeah.

> Specifically, we have this in the comments and commit message:
> 
>   check the alignment of each individual iovec segment, as they could
>   end up with different I/Os due to the way bio_iov_iter_get_pages works 
> 
> bio_iov_iter_get_pages() might submit the segments as separate IO's
> anyway for other reasons. I am not sure why the alignment conditions are
> handled specifically here.

I'll take another look.  Basically what this wants to prevent is
bio_iov_iter_get_pages creating bios not aligned to file system
block size.

