Return-Path: <linux-fsdevel+bounces-20625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2648D635C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD491F27CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB615B56E;
	Fri, 31 May 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="my6Ym7N5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D5158D94;
	Fri, 31 May 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163174; cv=none; b=B0xy9t76AfZv2mo9NHrIEjFI24aXU3d58hLE/OCS0mB17XtQbCNsY1NZn8xcernfiAdbrt2ZefeEhoL9cjQA+SPIDyPojgtoCBebIToWn/XdwBxLkg33nptZT5UhEKwKBl2LKjjQpSN1o4zzTOnJy0OGC44bgaW/k81MWIQCLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163174; c=relaxed/simple;
	bh=/LONncp3AO+tmHozqvhG1bzguZyRoNp3DcO5tp/CUxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgmxwC0sB0SQ4Zd2Agrov4xW00wP2YDbCpEzIJ3mLTctT5GAAvnaFlDZdPDrojc59gFkFUPmzidPoGyYR5QuDnd6et7vz4Kge992ebGwvKNF1KXq0G080xoIzflidHUYmnqfGDGOqqxGEGeJRXG52sYI8Li867epCo9QJkRWoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=my6Ym7N5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T0o85Dh6Rf+KB5Efb2D+maZs/SPUfL+PFS9preD6H9k=; b=my6Ym7N5mT5q5HFeIxdeZEM4FJ
	/ipgy1rFUaARDe+xigX/P2IyDdk9ZtNrPhNC1YWFivCv0lcwPPBK23PSJMZfU+AP1Dt6xheE2m4OR
	s3Xi7MmsYtciHW5wREALG5lyM7uIrSGp34HmDESqTlg+LoXjFGUPRbhx2xeS/TEIVDNq8XpZk4dgS
	gZXpV16iu8UeS6ADCb3fN89KY5XKMaURL37u4en/I4co+5jEFbRC1X3k1z8yji/Fgb8pE3Ku1ieOp
	+vXDUmLjZ05tVGvNeNOwNWcV3gxHX9gwKaJ007z9dyhStCOpMjEhIq6eDw76EPVnEGW+qwLs8Tksl
	IGppF6+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2aA-0000000AOUG-3RUm;
	Fri, 31 May 2024 13:46:11 +0000
Date: Fri, 31 May 2024 06:46:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 8/8] xfs: improve truncate on a realtime inode
 with huge extsize
Message-ID: <ZlnUorFO2Ptz5gcq@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-9-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +/*
> + * Decide if this file is a realtime file whose data allocation unit is larger
> + * than default.
> + */
> +static inline bool xfs_inode_has_hugertalloc(struct xfs_inode *ip)
> +{
> +	struct xfs_mount *mp = ip->i_mount;
> +
> +	return XFS_IS_REALTIME_INODE(ip) &&
> +	       mp->m_sb.sb_rextsize > XFS_B_TO_FSB(mp, XFS_DFL_RTEXTSIZE);
> +}

The default rtextsize is actually a single FSB unless we're on a striped
volume in which case it is increased.

I'll take care of removing the unused and confusing XFS_DFL_RTEXTSIZE,
but for this patch we'd need to know the trade-off of when to just
convert to unwritten.  For single-fsb rtextents we obviously don't need
any special action.  But do you see a slowdown when converting to
unwritten for small > 1 rtextsizes?  Because if not we could just
always use that code path, which would significantly simplify things
and remove yet another different to test code path.


