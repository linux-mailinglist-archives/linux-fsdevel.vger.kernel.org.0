Return-Path: <linux-fsdevel+bounces-48320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB4AAD499
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 06:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E6980965
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 04:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8161CAA87;
	Wed,  7 May 2025 04:47:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B194D86359
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593252; cv=none; b=iuDoKDgXqAUnllsauHPbWUeynGOJqklkPPW5uEJTKoWk9QGNd7YyOqunrCqN/i/rX0kv6qXbCejm9raAsxfphqOReq6Tih5fhQtNeo27qQpqKAVAUi7582tBM/02pJiJR/hkgPTI6PTCsMC1HsB2nOC/ePFJbzuTvnDoh/X+Lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593252; c=relaxed/simple;
	bh=Ty/kjUYjiyCPnzOoFDrYsu6swjLw8M5zxkQP5ccqy34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+0eAaMGjSMcUuHPQcQ8eUic75gX/C+pIm4vQGCXvXMYrEqNcHCmbdAdrhDPUvECn2Q98x08aPN6yJzH0DIaXF+gKpfK7HVOF90L1TMgPlj8f4yJ1Q9cgm7Qt/mTw2sFudNmAoPyFlJC9UVs901arVaWWn5/bFgE/x1a0O4Nq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF14B68B05; Wed,  7 May 2025 06:47:25 +0200 (CEST)
Date: Wed, 7 May 2025 06:47:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Bongio <jbongio@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove redundant errseq_set call in
 mark_buffer_write_io_error.
Message-ID: <20250507044725.GB28402@lst.de>
References: <20250506234507.1017554-1-jbongio@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506234507.1017554-1-jbongio@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 06, 2025 at 11:45:07PM +0000, Jeremy Bongio wrote:
> Fixes: 4b2201dad2674 ("fs: stop using bdev->bd_super in mark_buffer_write_io_error")

That commit only changed how to find the superblock, but the number
of errseq updates did not change.  You'll need to go further back
to find the original introduction.

>  	if (bh->b_assoc_map) {
>  		mapping_set_error(bh->b_assoc_map, -EIO);
> -		errseq_set(&bh->b_assoc_map->host->i_sb->s_wb_err, -EIO);
>  	}

and please drop the superflous braces here.


