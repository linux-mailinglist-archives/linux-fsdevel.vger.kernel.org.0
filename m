Return-Path: <linux-fsdevel+bounces-9394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2BB840A2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A2B285807
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64517154440;
	Mon, 29 Jan 2024 15:36:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15825152E0C;
	Mon, 29 Jan 2024 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542605; cv=none; b=Z8snm1q4yDEqwjDYwLXf6sOPBV49goYe2XaJkuH+13Wb56rGSzwWyAYCcRu9MrtzF9mxkRnwS4TW8yso3YoE1A0T4/JpnIxSm1zurattXktNQN6eBLJ60b+52EA5WA0b3OB6ExpdjCTdR1KxXoP6FvGNbHC/3rrEqQlcMgEgdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542605; c=relaxed/simple;
	bh=zv0WUBglE/3n9IHDyT3lvkRQXF0JBB9p+9w+yVAJI+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIS0v6IflnCDcguYaQaFFsAYs6PKOoiBPWYXVrTfxLIQwFoJE4CowPl4g+5c6f7a0Y9aaj9pUWGEAZD1BIGa2OBRFuTfpEXMRb5is7a53v2hapnQFi0/fr/hTaoz+rFYfuTitwf9LjmEelfOFzeHD+jc2Q1DZDxraU4qR+wlfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF05168C4E; Mon, 29 Jan 2024 16:36:37 +0100 (CET)
Date: Mon, 29 Jan 2024 16:36:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] fs,drivers: remove bdev_inode() usage outside
 of block layer and drivers
Message-ID: <20240129153637.GA2280@lst.de>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org> <20240129-vfs-bdev-file-bd_inode-v1-2-42eb9eea96cf@kernel.org> <20240129143709.GA568@lst.de> <20240129-lobpreisen-arterien-e300ee15dba8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-lobpreisen-arterien-e300ee15dba8@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 29, 2024 at 04:29:32PM +0100, Christian Brauner wrote:
> On Mon, Jan 29, 2024 at 03:37:09PM +0100, Christoph Hellwig wrote:
> > Most of these really should be using proper high level APIs.  The
> > last round of work on this is here:
> > 
> > https://lore.kernel.org/linux-nilfs/4b11a311-c121-1f44-0ccf-a3966a396994@huaweicloud.com/
> 
> Are you saying that I should just drop this patch here?

I think we need to order the work:

 - get your use struct file as bdev handle series in
 - rebase the above series on top of that, including some bigger changes
   like block2mtd which can then use normal file read/write APIs
 - rebase what is left of this series on top of that, and hopefully not
   much of this patch and a lot less of patch 1 will be left at that
   point.

