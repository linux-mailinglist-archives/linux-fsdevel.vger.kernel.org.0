Return-Path: <linux-fsdevel+bounces-39182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A0BA112C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3640C166E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF84320CCF0;
	Tue, 14 Jan 2025 21:13:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-02.prod.sxb1.secureserver.net (sxb1plsmtpa01-02.prod.sxb1.secureserver.net [188.121.53.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E420C019
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889194; cv=none; b=ElyPZQ/qsjgdh/RI1CCdUlbcss57mltTLnlVfkhoNjj3OASdPDLUt2SlifwH1r4nhmY+K9cB2PxhmtnXGkcAsgyu6d50y2B1JIHEP1ckeRErwZOle4B1bbAxxtKuIUDi4WCCJ5QNFwMsSYNq7HEC6+SA9a3Aw9YfvGr+puMOSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889194; c=relaxed/simple;
	bh=ZsUAklFyOuksmPlU178jEOpXfuVBJvDb/Pk7y5VBAy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvX6LytOIXt0g/P4S6ZL1cybu/4HlZ1vPmVkQzvNxYCGmoQuXi4CuwXe5UTXvmEsNOo1saSJglBrUaoVgRB0CpqmjJx0kojx9ySK7bn7cepsFx6yJRgmHeYg+L6FEwh290jjIELH6/qPVYLeT9oboerhfwdq2Yz7Kc0/O/0hYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoDgtGdzwwNr3XoDhtVvgF; Tue, 14 Jan 2025 14:13:05 -0700
X-CMAE-Analysis: v=2.4 cv=L4LnQ/T8 c=1 sm=1 tr=0 ts=6786d361
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=ZqW0wvtL_bDeDkRxjCwA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <323bd5df-7e80-4056-95a5-516a6d8c0ad0@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:12:39 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Fix assertion in folio_end_read()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: squashfs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20250110163300.3346321-1-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20250110163300.3346321-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM1KVhj7Y2fal1E4Xrz7tUVNjtaHOFcZHhvZGmffEjBtGS1Ra7N632Ib0bFYCUjNDGrCuLGDov7vvDPT/wWsAbgJ1hgKxdr8v3ZGMHfPA5UkcoTbTfaN
 JaTm04FoqLVkJifgzpfjBqzaffgs/A9xV3T5YM95giAuw7LCy6aUrr9togptThwxB6acHWg7XI0QiFZIEm8WEwkYIQzNUt27VEbJu0xWJ7wO70csvA3Nh4pB
 FVUOgoamRDyMpcTtLAYDn4CHu3hQnUO8N6PPXG230iphiDXFP7atPbvHRJErpdNsg1h7lmGW5klX2phKRitFARZjxiCRyuk7J4ptj22Rv3Q=



On 1/10/25 16:32, Matthew Wilcox (Oracle) wrote:
> We only need to assert that the uptodate flag is clear if we're going
> to set it.  This hasn't been a problem before now because we have only
> used folio_end_read() when completing with an error, but it's convenient
> to use it in squashfs if we discover the folio is already uptodate.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   mm/filemap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 12ba297bb85e..3b1eefa9aab8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1505,7 +1505,7 @@ void folio_end_read(struct folio *folio, bool success)
>   	/* Must be in bottom byte for x86 to work */
>   	BUILD_BUG_ON(PG_uptodate > 7);
>   	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> -	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
> +	VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio), folio);
>   
>   	if (likely(success))
>   		mask |= 1 << PG_uptodate;

