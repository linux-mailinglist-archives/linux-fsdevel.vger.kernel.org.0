Return-Path: <linux-fsdevel+bounces-21615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F490676B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371542819EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35913D893;
	Thu, 13 Jun 2024 08:47:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670113D285;
	Thu, 13 Jun 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268451; cv=none; b=iC3+9jK8GL1rOyz+s5LSezEFT21y4cUNWm46TZ9n5Kyv1qfQPiUDm+jAWedzHHyol6b886eEzgYRT0n5naSAyR1kjaGgD5l2HDn1ktiCXszfHLARSz1n4wLfTNFtIY80jqqYrgYZjcD9egXh21JBN7Ln+JbphT//2djjTD27dXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268451; c=relaxed/simple;
	bh=1jn2IOyVFJmKqsbYasAJ7Focahse7tNeIcTWErY6sB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXGr5NDJQXzU0jD3NOfGSc4gf5IHvQwgbYcQEWDHSVpktZSoZFttz2cmQanCknCKKoXwrqUI/JnC8ciVSZDEE/3YM3jKYYDFKvuNe5UmPS61FvavURwPqFkQNuDDtkWwiOD4DiyItchvYBVPDqk0YrKgBjR2WtOTTGA5RjzCReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F2D968AFE; Thu, 13 Jun 2024 10:47:26 +0200 (CEST)
Date: Thu, 13 Jun 2024 10:47:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
	mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 11/11] xfs: enable block size larger than page size
 support
Message-ID: <20240613084725.GC23371@lst.de>
References: <20240607145902.1137853-1-kernel@pankajraghav.com> <20240607145902.1137853-12-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-12-kernel@pankajraghav.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 07, 2024 at 02:59:02PM +0000, Pankaj Raghav (Samsung) wrote:
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -3019,6 +3019,11 @@ xfs_ialloc_setup_geometry(
>  		igeo->ialloc_align = mp->m_dalign;
>  	else
>  		igeo->ialloc_align = 0;
> +
> +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> +	else
> +		igeo->min_folio_order = 0;
>  }

The minimum folio order isn't really part of the inode (allocation)
geometry, is it?


