Return-Path: <linux-fsdevel+bounces-43777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD86A5D778
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91950189F037
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C820B805;
	Wed, 12 Mar 2025 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IE/CMyvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD641F4181;
	Wed, 12 Mar 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765282; cv=none; b=n9Ah6H+p88bwRWg6TKUT0BmcptIsmuDnotpfyIcg6qtrCeX41P2wgbRuTdfeYqVTQijzDOSYC/EhYVbQCfSWIypyYlDm6cChKrDLmbCHR/S/jHI6VujmuENEpkmSH6XDHXp5uH9gFz3ETj+kBW/QgAi1Oj0htbt6rVqw60hITTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765282; c=relaxed/simple;
	bh=cnZgslxTanP0oI2nLXjeVlcdmxK2yGVfuoqMz7ed8kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK0hiJqAixyxT0jRbXYRQvid8M5UjCf3svFMLJURA0VS9aYqi+iGSCE0pqogS75h5j0nSDbbV/wP1H/Wz8VtvpM+7xhk2vVy2mWYg9LS230Xed+Kn6gfvYUD0RwlJVqbtUKhK9VzgV7qUn+flsqA5QRUsq7G4YVEnTlySH94tOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IE/CMyvS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4GQRd6qaaZyIdDf8A/hW6reZHZJRKrk0RW8ox+x6jeA=; b=IE/CMyvS81/EeRI2/EQjZ/vG2f
	ZhmDsJ7bN5Xw4SrBL29X44aoUsXGjmRRMccfBV3vjaicrRQg/As/Wz6TJxNbuAcG8ItQCQfobcER/
	GdpLUyVbPCgfDu7GrPCwGbdr3dLw2gbD7NqtcTFWfuywjOiFHH96d8Um+NFtgkdWWERcue6h2y4ei
	TXMMaVZtyWieKTHYVujtlXdwfohExUlZrBem/l2Zl9i103p9r0hGG6e560KNjZfk7nhNeIYgfMmpH
	D6BeJVEqvkxfhNl3dJML1QYJgM+z5RiG3oTLazYiDli31b6Dz/4E9SaEVj1vN4mfnidNQC2Qz5H/t
	qh6qDqzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGiO-00000007j8f-2Mz6;
	Wed, 12 Mar 2025 07:41:20 +0000
Date: Wed, 12 Mar 2025 00:41:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 08/10] xfs: Update atomic write max size
Message-ID: <Z9E6oMABchnZIBfm@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-9-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 10, 2025 at 06:39:44PM +0000, John Garry wrote:
> For RT inode, just limit to 1x block, even though larger can be supported
> in future.

Why?

> +	if (XFS_IS_REALTIME_INODE(ip)) {
> +		/* For now, set limit at 1x block */

Why?  It' clearly obvious that you do that from the code, but comments
are supposed to explain why something non-obvious is done.

> +		*unit_max = ip->i_mount->m_sb.sb_blocksize;
> +	} else {
> +		*unit_max =  min_t(unsigned int,

double whitespace before the min.

> +++ b/fs/xfs/xfs_mount.c
> @@ -665,6 +665,32 @@ xfs_agbtree_compute_maxlevels(
>  	levels = max(levels, mp->m_rmap_maxlevels);
>  	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>  }
> +static inline void

Missing empty line after the previous function.


