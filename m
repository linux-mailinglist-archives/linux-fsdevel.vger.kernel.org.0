Return-Path: <linux-fsdevel+bounces-9646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F684408C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35B4B2BCA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138657BB06;
	Wed, 31 Jan 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XGNnZ0by"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B31E522;
	Wed, 31 Jan 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707386; cv=none; b=PyqlaCU/L6ZqYVsaDCsXXxu7xEtoOAiz7Yzz0R3PRirCqglBO3cTDRb5HukEmdME/ZRQjEcp+B17eMrh7YHX8dNdDwTFOpbHrtknFgdcoW1jMp9BeI7iElqg/mhGbhoX5fj+NHDIiBnpwVPfsrwQu9ipo9L04bnSNem/FxTEWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707386; c=relaxed/simple;
	bh=YQht/u0phIhzG4JyAB0wIm3E7hLpF4h34ToDD8I5L7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4niH8aO1Jqt2G6f3ASr0IGL/iFVSf4Yb5UHuyZnpxzf7mcS1STJfjHHfOMF+6GYocXLpqh9n0w2YSGSXiiIYvelR4Sjs3wPBY+qPRXLCMdKS3q3SvXpEONoVHy4xyWVRbMtAXZoIc1zfjsu9Px2ipz35rT5XSM4Cq9yXNOcEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XGNnZ0by; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EHA+jUqUbNzf5uT+1UDGDC5e+7VYrb44W22h6Huqt1s=; b=XGNnZ0byfBPCCe1GoUPgxoHT9U
	+NnzNks6SJI4h+TraDzrF6ox4yJKrRwwEoeNLJ78bXrRb6/OhjXWwNIb7WcW8x4KCntx9ItSVXOYO
	VHOoeYRHGT/IFVUWYT37eEiDVtod9+5AFx4s/6BZIN6lW1XC7MFs0SCu8LALWUeDITQPHNyLV23iM
	ZjsR7pU9/kZpOop8Lyd66uvF2klKOK+1USXJ29s+EXBSEhAfU5JKF+GUCr4kuzl8Fk5SdiUUGP0VB
	9i7jqjZ/zOqvz7pUCkQ0vrJtL8HWS6gfbovWRHD62gjjjJ2kleBFTGa+uHcs2liPXVmeXFtlyQDwe
	UOhvRcxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAYD-0000000ClG2-3Fv0;
	Wed, 31 Jan 2024 13:22:49 +0000
Date: Wed, 31 Jan 2024 13:22:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Yu Zhao <yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv6 1/1] block: introduce content activity based ioprio
Message-ID: <ZbpJqYvkoGM7fvbC@casper.infradead.org>
References: <20240131105912.3849767-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131105912.3849767-1-zhaoyang.huang@unisoc.com>

On Wed, Jan 31, 2024 at 06:59:12PM +0800, zhaoyang.huang wrote:
> change of v6: replace the macro of bio_add_xxx by submit_bio which
> 		iterating the bio_vec before launching bio to block layer

Still wrong.

