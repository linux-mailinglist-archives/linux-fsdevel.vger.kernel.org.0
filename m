Return-Path: <linux-fsdevel+bounces-6470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D881805F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 05:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50C6285ABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 04:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00CBE5A;
	Tue, 19 Dec 2023 04:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vTxZLBCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9828BE1;
	Tue, 19 Dec 2023 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/SEF6/0irzPlvPamDsq84bR9kjT+1u9iAzLJI9PQf8w=; b=vTxZLBCbJX7xG8/wyWBJmVznXP
	BI5vBw/mEikFJCVVWYttJEczkTPZ+0fXTupoYM57veFUTHd9d0HdiuVd27HgRrD2PtA70B/x4LkE6
	iUNuUuU1+uy3S8aw0SvGQVaGD+hkHfW7m1YH/WMutIl2ZvTDOp97QJ85eM8eU/orS2YP3EX4+k5Ld
	hzyyj7sguxNWWitho0g0jVvnWf/6Wi+psP3Fh9gh5Ry18qJLG2c3k6ewnEkox5Lyosd4QWQI/FVrG
	B6aQfv2iVn07xlZ6bWlntAFN+jQlX7v+8QFulTfmVMf/PFV5p0b405x4f2PA2ndhTbOBmfkLOIQwl
	IgRGD0/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFRNK-00HZi9-G4; Tue, 19 Dec 2023 04:06:34 +0000
Date: Tue, 19 Dec 2023 04:06:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: shr@devkernel.io, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: fix arithmetic for max_prop_frac when setting
 max_ratio
Message-ID: <ZYEWyn5g/jG/ixMk@casper.infradead.org>
References: <20231219024246.65654-1-jefflexu@linux.alibaba.com>
 <20231219024246.65654-3-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219024246.65654-3-jefflexu@linux.alibaba.com>

On Tue, Dec 19, 2023 at 10:42:46AM +0800, Jingbo Xu wrote:
>  	} else {
>  		bdi->max_ratio = max_ratio;
> -		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
> +		bdi->max_prop_frac = div64_u64(FPROP_FRAC_BASE * max_ratio,
> +					       100 * BDI_RATIO_SCALE);
>  	}

Why use div64_u64 here?

FPROP_FRAC_BASE is an unsigned long.  max_ratio is an unsigned int, so
the numerator is an unsigned long.  BDI_RATIO_SCALE is 10,000, so the
numerator is an unsigned int.  There's no 64-bit arithmetic needed here.

