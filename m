Return-Path: <linux-fsdevel+bounces-20623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D368D631F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A3B29B39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5964158DAD;
	Fri, 31 May 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yza6EQ+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21691EB2F;
	Fri, 31 May 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162574; cv=none; b=Uf9kh6s9saCS3MTqtfDjrbiNRIenpRtuP6aoA8M9/8Z4IQdYWBKeFbr5HBsPLlgvBvhPSf9dum4JBQkU5sVdUftcNNhgvF8REQnsAE8Kvc3I5SaYVigaIoaH4WtxPss9CP95F8nTfWB285fzi/7KGQuw/tn2J3dWcq71aWXJJ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162574; c=relaxed/simple;
	bh=vQ11bK9p/errhGU+cq6SulAeneFsqE5o8JUd2PnAQdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKLPegt8x+1kheH9AGLFRz7Cp0wvJV6kwiYqPymRNSya9l14cEyr3qxBleMqVsjL/x9AgoJFZKNFAGvZr4uF0O+6Lw+FdTdzpVr7R77dID/mOR7gggMXIa+dCc1K+l5xHXY244K6CsIacKUw5okbkP7IVcG6SWiqRE/Acq6OZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yza6EQ+l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WHxUhk+JvUedQtAT8ttJV6/LW6nSiIM50H+9WqdW+Nc=; b=yza6EQ+lK+43+PHW4DgB5EwMDk
	ky5eitb+serbJk9uK/4AyEhJkS0vf7EQGFv7gdb5HqgH1yB3FWdttmEz3IT3Yz+Hf88FHX+bcfZ6Z
	MzHdPARO5FYuKJVRjWGH1SHUDfGHEuCWNN7yHLSA35tghg/u974kAgwSbXxMLKMwOyCjuJsgClRxa
	S/e6JMoGcBdvf1tYmdVPHg+NrFDDQj8VXsiI6PHtYbZHzynXCVplOKvuSNv1na32NOL9Q4pcmNIG4
	LbZ8TeAp3OcaLsGyCqtL07qfnGrcORWSZB+tE8i0rrlHoH3YoYP1Ypat2tRel+Lj0huSfwmBzujGA
	CfIzorrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2QW-0000000AMYi-2Acy;
	Fri, 31 May 2024 13:36:12 +0000
Date: Fri, 31 May 2024 06:36:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 6/8] xfs: correct the truncate blocksize of
 realtime inode
Message-ID: <ZlnSTAg15vWjc1Qm@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-7-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 05:52:04PM +0800, Zhang Yi wrote:
> +	if (xfs_inode_has_bigrtalloc(ip))
> +		first_unmap_block = xfs_rtb_roundup_rtx(mp, first_unmap_block);

Given that first_unmap_block is a xfs_fileoff_t and not a xfs_rtblock_t,
this looks a bit confusing.  I'd suggest to just open code the
arithmetics in xfs_rtb_roundup_rtx.  For future proofing my also
use xfs_inode_alloc_unitsize() as in the hunk below instead of hard
coding the rtextsize.  I.e.:

	first_unmap_block = XFS_B_TO_FSB(mp,
		roundup_64(new_size, xfs_inode_alloc_unitsize(ip)));


