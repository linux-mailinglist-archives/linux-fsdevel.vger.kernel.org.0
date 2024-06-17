Return-Path: <linux-fsdevel+bounces-21800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072B90A63E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 08:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F61C26377
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D74187322;
	Mon, 17 Jun 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V/IEwK45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711A19BC6;
	Mon, 17 Jun 2024 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607569; cv=none; b=d/FTh2F7Csl5hsud5KL12mgVHsgGHVrq42QhlN928DPpYFwwc2Pbl1IIGufEzkW+WHQjby2aTtm3yjJ8SJrUxjtRkstKe49u2KCLpdx2HifxPJzIAQlX84lCqbR2FDL9wXEYzfAxXScoNwDB943vRYM2dhiqwO7N5GbOfy8s3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607569; c=relaxed/simple;
	bh=olrwLSlxifw9+6rImO9yJABZFPb7HwWO627zpZFlwGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnqOhArmIxFgGG7zX4qYkJNvPfzGSE+bOITtYc8KU+Ha7f+vlLB5f0X2UItFmAL26/Pzno423MCdQN0XAGrKVKzcAskmusKcguzMDdZIavkA+AIZ3Mv+0hCQwBCm0MwSjYhmauH785jY2ct+sNHbomhgzZe7c/+2bsjBiQWbVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V/IEwK45; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NJyBy3EQeoN6bisU+MmbRSDktS2n66CGWu+GuFyxNmQ=; b=V/IEwK45sloXtbyf8pxMAGiHTW
	92Y4uPTDjont6KxepX8+MaBC0reiI/ssyyDEIKBUXzxMNPvjNRX3Bjp31bKWIffc5FtoahbD9N8S8
	QGZhoJW17nLu/DHhZp34BEzOdZMH2CVhwB+XoXRqlNHZ795+DCwzkra7YNbix3WnlRC+aRybODBiI
	TeH2FCiInxVxljf3Dz/TKF4duPVMX/53eDJ2sX0asoEsqQTzhuq6BvEaPsP33Lmm1OElTVcJhoMcX
	0/jJsLNBnn19NRMfSI9zdgSXTEoMJhxxcvRy7z+8s5CkV9ftRVnun6RpccLRJxQpAlGvGcvszYqqq
	hjk05J7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6Ks-00000009W5G-2c5l;
	Mon, 17 Jun 2024 06:59:26 +0000
Date: Sun, 16 Jun 2024 23:59:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH -next v5 7/8] xfs: speed up truncating down a big
 realtime inode
Message-ID: <Zm_ezp1TaIoAK1-P@infradead.org>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
 <ZmveZolfY0Q0--1k@infradead.org>
 <399680eb-cd60-4c27-ef2b-2704e470d228@huaweicloud.com>
 <ZmwJuiMHQ8qgkJDS@infradead.org>
 <ecd7a5cf-4939-947a-edd4-0739dc73870b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd7a5cf-4939-947a-edd4-0739dc73870b@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 15, 2024 at 07:44:21PM +0800, Zhang Yi wrote:
> The reason why atomic feature can't split and convert the tail extent on truncate
> down now is the dio write iter loop will split an atomic dio which covers the
> whole allocation unit(extsize) since there are two extents in on allocation unit.

We could fix this by merging the two in iomap_begin, as the end_io
handler already deals with multiple ranges.  But let's think of that
when the need actually arises.


