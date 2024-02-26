Return-Path: <linux-fsdevel+bounces-12808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E21867659
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14F7287E42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C325127B74;
	Mon, 26 Feb 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQr75EHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD6604B7;
	Mon, 26 Feb 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953722; cv=none; b=h+AnfZ6dFeiCqzc0CoqDOauYBGvePbRkdHAjQ4y4umhD4xI5V2+mmFbaNu144pWg4TG8w3U43COhxDlmhUnm8vAKhdJaL/bymZb+UlGvHEFZqAVVA2VqWgX3GY4Q2Hh8rZs2IbpGWav3IDMZeIn+aM67YtSTObmZoaEJimhApRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953722; c=relaxed/simple;
	bh=R7d2acqprmU8yb3JpCgLFrgbVNL0FKm8LJuXH4PTBR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIVW+MI2vCMOl1Pt+DuMVG16A2D0jtPxL9mX5GQYlhZLhMNJNlbbiOhm39dN+uGDLQ89oMJbrrdv94CpzKosvFHWFp5et0VnErKi7KCygYByD5aQrI2CoQ+RuahiRMxfnXlpFyyCMx1SJRHxiGL7RBYkD4DbN7T5GdSM+fFldI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OQr75EHy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FOEO53PWfz8jVV9tqBTYQ+FUQRTS1bvm3k8jdLn41jA=; b=OQr75EHyHvbJCafMkmm/u1U9WI
	rSXH+ccZ23rmyziIKdQuyZHcIOIEAarZQfY3CZ+sW2Bs2bcKF0Jf5btQQux+Fe4wU5/ihvYNKUvZ2
	3wC21wd5ZMtIyb6yDO1Tl3deOcGLOMsj8hZwpQs/rtG5GSki/I/GJWEMcPnvpzk7Pd9Hn1AE17tDo
	1XfjuN4IMv3/ZassAySEFV9njPS2tsqul4pzMedj8i6IorgoDdqTU/Xkn4IRSsLLipvXMzJPny8Qo
	Ximm6jprNiDZNDAd7NUxwMxhCIEOH48MXeQ7ytjySnL5agTbNCVV893+/Iv1RpIHaTBlcUefT/SCp
	NU/gvkiA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reavd-0000000HEuq-0Ow6;
	Mon, 26 Feb 2024 13:21:57 +0000
Date: Mon, 26 Feb 2024 13:21:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, djwong@kernel.org,
	gost.dev@samsung.com, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 12/13] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <ZdyQdGkSIw9OsSqc@casper.infradead.org>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-13-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-13-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:35AM +0100, Pankaj Raghav (Samsung) wrote:
> +	if (check_mul_overflow(nblocks, (1 << sbp->sb_blocklog), &bytes))

Why would you not use check_shl_overflow()?

> +		return -EFBIG;
> +
> +	mapping_count = bytes >> PAGE_SHIFT;
>  	/* Limited by ULONG_MAX of page cache index */
> -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> +	if (mapping_count > ULONG_MAX)
>  		return -EFBIG;
>  	return 0;
>  }
> -- 
> 2.43.0
> 

