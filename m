Return-Path: <linux-fsdevel+bounces-18051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01D8B5051
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 06:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477A51C21A46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 04:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4AD28D;
	Mon, 29 Apr 2024 04:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iUD8i6Sk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D279F9;
	Mon, 29 Apr 2024 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365708; cv=none; b=hhhPZZMSepA0/bThEMNCrYksjLwsNbv/P7G3EdwTHR91f2pro7UV4NmPGhq6/sMiwSFFMcQetGv4F0e7qRCcjrYhy0asL7VlIKjR22ofBv26OOmG4ORcJ4M0BX8kxPs/YfXLfjA1x/3lKk8A6nRpq3zQreVo0oDtY+cX0tek0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365708; c=relaxed/simple;
	bh=owcXP+fsTgaHZFyUzCBMT1bCDgfz3/4CftWoEv2Acic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMdjmxWcyDk2yVUinm4S+zGIJlSlm1VfkPG6PCy9uZwHVR9LoVL+HgZQ1jfyXhijIhLZAbzg7DNXBmgFuHyLYoMgFg3Cro2FwKG/3Rl5cGYMvHZv6pi/yca2X/RiEhjjzb3Cmntk8kvBjC3+5HsF74WttqrPd+Cn7ZrcOJ8RjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iUD8i6Sk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wZLTTPnjjgVPc51teM35bkMR46cidPv+y0mcRd/jT54=; b=iUD8i6SkDwuRDoyxK+6J+lVAFg
	kx4jy3bRbUcjCs4nzPAwR9bzpl1MCcr9+66rNBv8BQOwCgihP/M31/xiU6rvf6r13WjAAlIks3z5F
	E+gJ21n42uwY3TvDgrjA7tdv/JQh8D1KeiEzCU2Us7SeCgo05e1CnOVRq2+M0bZistaRxizzW2KyC
	/HeDnBbcWwCYkmXYrzI8i083Nx7QTWMMSQmUxm7GrcO6LVn3IiNzPC7vp3VGOHsxMSKBETn7Lm6Nu
	mwnCMr9QxVldF1Mzq06V2VhvSTzzsbErJ554QUzi9NbcdxhwnM2GlcAvjveaVySRBJmC5mAN3Xm7y
	ZqvYu4Nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Ipl-00000001RPG-2exv;
	Mon, 29 Apr 2024 04:41:45 +0000
Date: Sun, 28 Apr 2024 21:41:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <Zi8lCUjX8lByIVZI@infradead.org>
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <20240425182904.GA360919@frogsfrogsfrogs>
 <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
 <ZitKncYr0cCmU0NG@infradead.org>
 <5b6228ce-c553-3387-dfc4-2db78e3bd810@huaweicloud.com>
 <ZiyiNzQ6oY3ZAohg@infradead.org>
 <c4ab199e-92bf-4b22-fe41-1fca400bdc31@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ab199e-92bf-4b22-fe41-1fca400bdc31@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Apr 28, 2024 at 11:26:00AM +0800, Zhang Yi wrote:
> > 
> > Oh well.  Given that we're full in on the speculative allocations
> > we might as well deal with it.
> > 
> 
> Let me confirm, so you also think the preallocations in the COW fork that
> overlaps the unreflinked range is useless, we should avoid allocating
> this range, is that right? If so, I suppose we can do this improvement in
> another patch(set), this one works fine now.

Well, not stop allocating it, but not actually convert it to a real
allocation when we're just truncating it and replacing the blocks with
reflinked blocks.

But yes, this is a bigger project.

For now for this patch to go ahead:

Reviewed-by: Christoph Hellwig <hch@lst.de>


