Return-Path: <linux-fsdevel+bounces-50364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70930ACB3C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB62C404858
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB3226CE6;
	Mon,  2 Jun 2025 14:24:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A520E026;
	Mon,  2 Jun 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874251; cv=none; b=XVHTiFBsAp+l0DRC1bQT7PrbnLV2jO4GuoRwywrrMbcHei5zbL5h8HLX3iECztc0wYuaqNKhlevdjARmqoOAJ010Q/+Cdc67F1YhzQ2Eta245jKmlG5t7+QidIcsxi7V/ni0uljU/xxCC6/6M/Bfdho+p9hRIduVbS9crVnusfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874251; c=relaxed/simple;
	bh=Ty/ggLvGy0LpeeBlq8XqYQYZ33weKKPJqE7+/JpCaJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj2AMcIOupj7FvTkBYz/mTfLyVsl9Li/DLpIRl+Nt+fwq167/fpYQUwVn0AiuGyiFyBuAOALXuG1ReX+otoa6AjqjFZpu2juoJuE46l7K+RuQ2KQqJBdwRGqKcnv6hc8BtdO9oF7bWnkLP/e+kdEMv1mvbPqZJ8RN6tTW0Sk5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A052D68C7B; Mon,  2 Jun 2025 16:24:05 +0200 (CEST)
Date: Mon, 2 Jun 2025 16:24:05 +0200
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
Subject: Re: [PATCH 04/13] writeback: affine inode to a writeback ctx
 within a bdi
Message-ID: <20250602142405.GA22563@lst.de>
References: <20250529111504.89912-1-kundan.kumar@samsung.com> <CGME20250529113232epcas5p4e6f3b2f03d3a5f8fcaace3ddd03298d0@epcas5p4.samsung.com> <20250529111504.89912-5-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111504.89912-5-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 29, 2025 at 04:44:55PM +0530, Kundan Kumar wrote:
> @@ -157,7 +157,7 @@ fetch_bdi_writeback_ctx(struct inode *inode)
>  {
>  	struct backing_dev_info *bdi = inode_to_bdi(inode);
>  
> -	return bdi->wb_ctx_arr[0];
> +	return bdi->wb_ctx_arr[inode->i_ino % bdi->nr_wb_ctx];

Most modern file systems use 64-bit inode numbers, while i_ino sadly
still is only an ino_t that can be 32-bits wide.  So we'll either need
an ugly fs hook here, or maybe convince Linus that it finally is time
for a 64-bit i_ino (which would also clean up a lot of mess in the
file systems and this constant source of confusion).


