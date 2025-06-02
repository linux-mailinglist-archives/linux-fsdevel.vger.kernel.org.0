Return-Path: <linux-fsdevel+bounces-50373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E762ACB921
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E591889E99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFFA22259E;
	Mon,  2 Jun 2025 15:55:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057921B9C7;
	Mon,  2 Jun 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879717; cv=none; b=tgj5Mz+fdqFyWYSYY6saGky7Qui+4xnt9VkLqDAB+KaKaJcSq0nPyDNs8Et7waCfjXl2H55VLfpLCkwujmY4p0VCnx9JtMo0MgLLf4XIVfQIY1gPX40AbmLTmltxWJEhICSB04a73JUFh9ZhHpECKYYPQ5as+IsUFRA8uMAOdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879717; c=relaxed/simple;
	bh=U9CVtds9r4vKRgqZ9DGijanSlfaOhZleFJNCwfqZfVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcxUn92ENum2lkdgvXbWrh0cuvawquAhC1pqkOKQqlbThV1RzXI7dicMCASPAX9zKiPZdYEK5cdApivDryEZnE14VUnp5QWMatDo16A4V57KnIKY4wz/a5aQ6UgqeUefXMxp345eKKtRkKzaN0FmqtiBIq+TfUCsV9qMcyuLUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17D6168C7B; Mon,  2 Jun 2025 17:55:07 +0200 (CEST)
Date: Mon, 2 Jun 2025 17:55:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>,
	jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	axboe@kernel.dk, ritesh.list@gmail.com, djwong@kernel.org,
	dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH 10/13] fuse: add support for multiple writeback
 contexts in fuse
Message-ID: <20250602155506.GA29981@lst.de>
References: <20250529111504.89912-1-kundan.kumar@samsung.com> <CGME20250529113257epcas5p4dbaf9c8e2dc362767c8553399632c1ea@epcas5p4.samsung.com> <20250529111504.89912-11-kundan.kumar@samsung.com> <20250602142157.GC21996@lst.de> <99f79383-479e-4df1-9650-61fa3c600171@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f79383-479e-4df1-9650-61fa3c600171@bsbernd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 02, 2025 at 05:50:48PM +0200, Bernd Schubert wrote:
> > Same here.  On pattern is that fuse and nfs both touch the node stat
> > and the web stat, and having a common helper doing both would probably
> > also be very helpful.
> > 
> > 
> 
> Note that Miklos' PR for 6.16 removes NR_WRITEBACK_TEMP through
> patches from Joanne, i.e. only 
> 
> dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> 
> is left over.

That'll make it even easier to consolidate with the NFS version.


