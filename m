Return-Path: <linux-fsdevel+bounces-20084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB5B8CDFA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 05:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724311C20E23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AB328DB;
	Fri, 24 May 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jmtu2KN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626AF1E892;
	Fri, 24 May 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716519965; cv=none; b=UmoSR5FVIXyzE9BN25YfOgtHz75xSLpnbIYl9eVQCONUQs0wx8/g5M+woXONbejo5yRhJUz3JoTvRaimiFrtyoufKr784lXl2hECGwM0mKUR8MUcwsb0AteB1Mmc2/BdgRCGdwejX2loEKC0iQ8po3M1XEuByX3LoNZlWCHCj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716519965; c=relaxed/simple;
	bh=3ac3aDOUSyhZhlc2IzxHBt2wt1QJlTH7EB3FwNHBrlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1Fd5Ov0Hm2SI/5MOCECccTaB40WE5yYX80mDbW5Zq91KbgE0ZWKifk/m3qTovwHSt6A4KhsHYihsMv3oeT8cMZiFZvgPVtJ9zdWcu8lP3MhghBAu2Vg8itrUi4c/adrS8mlmDgyhcXG01N2NNEMdE1mMTNARGYRE1LOCB7O1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jmtu2KN8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bvCaQQNewdoOyjlJKFKuh3jGJ8NqvGaj8xV2P8qvIyU=; b=jmtu2KN8qcXDpnYpWr60sypBYH
	mWrR5w8ho4fOS088iy2520XmhFMg3fXNY3OsFM+RfISEUdKA7nc7j68a4hzrYsxfcM2WRFTx0majP
	EVOUZP5lMXLqv8fMtKrfIRnIUiZT0s8qCf0OvIgwEKY9kDyefqtLil/v83hGwRooqsmueh2cYWhbv
	fIMoHR1i9vENcSk/KhIt52slwM4IFRW8ugSOoEvBpEhzmtRKv9OB8obQXylgmSSbYtngM4JfQnHmi
	X7KQlmijfK/dgeQ82RcbhAvQ7SEwZ6ngzDPVnhJEi33knd80n62sA3s5Ad8h8YZ07jtb29bIsRcbd
	TbMpC6fA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sALFd-00000002Lpz-12Xc;
	Fri, 24 May 2024 03:05:49 +0000
Date: Fri, 24 May 2024 04:05:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jung-JaeJoon <rgbi3307@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modified XArray entry bit flags as macro constants
Message-ID: <ZlAEDbOR6Ch-Y__C@casper.infradead.org>
References: <20240524024945.9309-1-rgbi3307@naver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524024945.9309-1-rgbi3307@naver.com>

On Fri, May 24, 2024 at 11:49:45AM +0900, Jung-JaeJoon wrote:
> From: Jung-JaeJoon <rgbi3307@gmail.com>
> 
> It would be better to modify the operation on the last two bits of the entry 
> with a macro constant name rather than using a numeric constant.
> 
> #define XA_VALUE_ENTRY		1UL
> #define XA_INTERNAL_ENTRY	2UL
> #define XA_POINTER_ENTRY	3UL
> 
> In particular, in the xa_to_node() function, it is more consistent and efficient 
> to perform a logical AND operation as shown below than a subtraction operation.
> 
> - return (struct xa_node *)((unsigned long)entry - 2);
> + return (struct xa_node *)((unsigned long)entry & ~XA_INTERNAL_ENTRY);
> 
> Additionally, it is better to modify the if condition below 
> in the mas_store_root() function of lib/maple_tree.c to the xa_is_internal() inline function.
> 
> - else if (((unsigned long) (entry) & 3) == 2)
> + else if (xa_is_internal(entry))
> 
> And there is no reason to declare XA_CHECK_SCHED as an enum data type.
> -enum {
> -	XA_CHECK_SCHED = 4096,
> -};
> +#define XA_CHECK_SCHED          4096

Thank you for your patch.  I agree with none of this.  Rejected.

