Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C163197CC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgC3NU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 09:20:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgC3NU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MJCgOUEW8BzVvh8w7blL/dFDhkt5EMD9LfcMnUWKMzU=; b=qK3lRE+KkWFZl8d23RcdBm6dPk
        N9/utmsRdB0KHKhtqHKigBTfrq2eYhoQgE6+S4QYXcTiGb3QJkHaJbioVMyPfKLUCCa+hlbASrkbH
        x9eDboHIyCbKPJq/njxYG5XStVBvPPlUMjLkHKXLrsGhdA8xOAoYs7DcoQ5dkGW6xbbtUJ6BPwjSw
        Px3WKjlYdSQ/+otL63yaS00J9KNcmU2oglHRZhjNVHUZrl10TarvH68UBSLlTWtKUCUPrQH8MTIfO
        auK+z1ot+e5setANEGV8A+iJH74+T/osThh0OBdxpUIqKiKif4L5zWgjzBtGZbd/dR+cO9kPi0EOS
        IRNaHGnw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIuL6-0007Bd-5i; Mon, 30 Mar 2020 13:20:28 +0000
Date:   Mon, 30 Mar 2020 06:20:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] XArray: simplify the calculation of shift
Message-ID: <20200330132028.GA22483@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-3-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330123643.17120-3-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:36:36PM +0000, Wei Yang wrote:
> When head is NULL, shift is calculated from max. Currently we use a loop
> to detect how many XA_CHUNK_SHIFT is need to cover max.
> 
> To achieve this, we can get number of bits max expands and round it up
> to XA_CHUNK_SHIFT.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  lib/xarray.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 1d9fab7db8da..6454cf3f5b4c 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -560,11 +560,7 @@ static int xas_expand(struct xa_state *xas, void *head)
>  	unsigned long max = xas_max(xas);
>  
>  	if (!head) {
> -		if (max == 0)
> -			return 0;
> -		while ((max >> shift) >= XA_CHUNK_SIZE)
> -			shift += XA_CHUNK_SHIFT;
> -		return shift + XA_CHUNK_SHIFT;
> +		return roundup(fls_long(max), XA_CHUNK_SHIFT);

This doesn't give the same number.  Did you test this?

Consider max = 64.  The current code does:

shift = 0;
64 >> 0 >= 64 (true)
shift += 6;
64 >> 6 < 64
return 12

Your replacement does:

fls_long(64) = 6
roundup(6, 6) is 6.

Please be more careful.
