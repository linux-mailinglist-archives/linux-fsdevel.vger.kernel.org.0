Return-Path: <linux-fsdevel+bounces-21698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F926908723
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9C1F22985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF31922CF;
	Fri, 14 Jun 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="loIp9n8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A75FBB7;
	Fri, 14 Jun 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356413; cv=none; b=WydwDLdYJtGFjvsKosgTFdB+dialW8x389hAEg6IVv0AxX4phdbAwL+6DBT3zBS5sALWvNlUVZULvrCcbWwPwC7o8cUiQzNVB73hZgR66QBhtiGWLSdZCZZ/a8roxZp3wHomPlV5PjTRqyqKZgYfnPerxxGAI+cEjZrsAbki/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356413; c=relaxed/simple;
	bh=WysQkcsjHsZaBSJnIBgs479ThPkkcLzyNfHVNY3NAwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxPMRif8lsgkz0+DbovfejY6J8oCMjyzOrVEwxD1hkIA45EP7YeMoH5HD9NYeyyIcqdkZRWTLCo2ZgKsfuoDHBovgxGYRduMyqUOv0t6nvVK8oCkhuuRLHW2B0FFkElPa3IJ7trZ89bVcK8c2vlf7CdwE+VnxiGjVpSNgq/9cnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=loIp9n8s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2FLvUNKmUUOI9oGFN4S5Yxt9b1DL4nZ5rhrTKzw0Pbg=; b=loIp9n8s3in8Fncb4yXeksH5pb
	JHfIfqs8ikcnros3eS6WxI/BtagbryOeQX4DrzmsD+/Pv724JvM57Kb+DC888DvrERtK+z0sISV0q
	MmtST+wywd3Yq8rXR2ZKG5ZcY4MSMQJ+2sslNKRZh4WCqhlKIEN9Ha34UN81sekZmlFU80ngqPbcv
	ZOMqQLiLPUdrVvLfs0JeelkDgAnP76bVzCyj8YKcRUYJiX/N5HCaiL61IaVaIVxSwnCgVizd+qrW4
	FYFAh9626pkN2QpwNX+scOXldavm+DoxfAyL6W1TbBCgOiGQXvYc3q60Nfa+3oHRBXXIyfubIal34
	irmevVWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI2zy-000000028xX-2zBc;
	Fri, 14 Jun 2024 09:13:30 +0000
Date: Fri, 14 Jun 2024 02:13:30 -0700
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
Message-ID: <ZmwJuiMHQ8qgkJDS@infradead.org>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
 <ZmveZolfY0Q0--1k@infradead.org>
 <399680eb-cd60-4c27-ef2b-2704e470d228@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399680eb-cd60-4c27-ef2b-2704e470d228@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 14, 2024 at 03:18:07PM +0800, Zhang Yi wrote:
> Thanks for your suggestion.
> 
> Yeah, we could fix the realtime inode problem by just drop this part, but
> for the upcoming forcealign feature and atomic feature by John, IIUC, we
> couldn't split and convert the tail extent like RT inode does, we should
> zero out the entire tail force aligned extent, if not, atomic write could
> be broken by submitting unaligned bios.

Let's worry about that if/when those actually land.  I also see no
rason why those couldn't just use partially convert to unwritten path
offhand (but without having looked into the details).


