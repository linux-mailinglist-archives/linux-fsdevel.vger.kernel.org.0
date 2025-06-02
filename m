Return-Path: <linux-fsdevel+bounces-50363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1EACB335
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0503164DB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBF1DED64;
	Mon,  2 Jun 2025 14:22:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3E23C51E;
	Mon,  2 Jun 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874163; cv=none; b=TkYCYrQtPliuXOGztZvz/G9JXRxo7bDRio1NLxQVDSTMdWMcQXtwT8kwmqWjnaSZb7kAFtMgLDofmU9tRpcKq1DCt/pQZlcf3Gp8Ya+DKvo8WKFkr4kMAk9Tdf0r/NI20VXc7JfFkSMOjOWAQK2iO78LPM25OowEWFbPza7fsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874163; c=relaxed/simple;
	bh=lsykdZzInxgKaeL1+f/eXy7iNfse9H1/+bVW9ZO9P7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU6YfovHjEiuOXCpSknWyU2SiapxkqeudZtZPkcUaWcLavsKhEEXO22L4Js+trDQGB8AMiBQBDgUZAEuIB4wcfFCe7DfFNfPZe6L9mNX6CH1HLE2Hiuc/YFKT1A0Iqll0L95by950OryQ5Luj44rDJccYZZC4url/xm6X6jTpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DB8D68C7B; Mon,  2 Jun 2025 16:22:38 +0200 (CEST)
Date: Mon, 2 Jun 2025 16:22:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 12/13] nfs: add support in nfs to handle multiple
 writeback contexts
Message-ID: <20250602142237.GD21996@lst.de>
References: <20250529111504.89912-1-kundan.kumar@samsung.com> <CGME20250529113306epcas5p3d10606ae4ea7c3491e93bde9ae408c9f@epcas5p3.samsung.com> <20250529111504.89912-13-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111504.89912-13-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 29, 2025 at 04:45:03PM +0530, Kundan Kumar wrote:
>  	if (folio && !cinfo->dreq) {
>  		struct inode *inode = folio->mapping->host;
> +		struct bdi_writeback_ctx *bdi_wb_ctx =
> +						fetch_bdi_writeback_ctx(inode);
>  		long nr = folio_nr_pages(folio);
>  
>  		/* This page is really still in write-back - just that the
>  		 * writeback is happening on the server now.
>  		 */
>  		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
> -		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx_arr[0]->wb,
> -			    WB_WRITEBACK, nr);
> +		wb_stat_mod(&bdi_wb_ctx->wb, WB_WRITEBACK, nr);

Similar comments to fuse here as well, except that nfs also really
should be using the node stat helpers automatically counting the
numbers of pages in a folio instead of duplicating the logic.


