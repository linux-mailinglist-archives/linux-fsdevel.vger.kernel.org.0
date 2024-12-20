Return-Path: <linux-fsdevel+bounces-37984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A6E9F9A79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 20:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9C164591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 19:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65E72236FF;
	Fri, 20 Dec 2024 19:28:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-13.prod.sxb1.secureserver.net (sxb1plsmtpa01-13.prod.sxb1.secureserver.net [188.121.53.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D062210FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722893; cv=none; b=jSPzAlt8uTpc3bzC6tY9oyKoXzQcbgNm68PIuASgElifGqyQjcqDbu1CKnF4I9YcuO/OwXTZ+giNOwOqgz7DXxX14gTu6iCZv1OgN3mlEJxa6S3YMIr/QivIs1DF6mZqbeoUoSMLCXobTRy+BU6+mEXsvMGn8UKoaxwkt9CY5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722893; c=relaxed/simple;
	bh=c5DTgljHEuwsMIPHnI1SKSGPvQpRtCaOnf7XBFcVduI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyeqe/gqClA0xuskuVU5FxVDjTvXTu9DXiRsNQ9pw43gdK7jeEcRExSfZ4ry+fg6xVlhEo9LQrM7pQqwtw0zCmDMq6hnYJs86lvSmILklyJCCJsXMv3nimihrYtx62c0ZJmiEmLStqtMRgj/VYKw06/WCUJUA2HK26BehRQjrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id Ohy2t3NRDsKJaOhy4t3nDS; Fri, 20 Dec 2024 11:43:20 -0700
X-CMAE-Analysis: v=2.4 cv=eLDpjGp1 c=1 sm=1 tr=0 ts=6765bac9
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=feLtDDcTkb7NPGqLxvQA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <7a9355eb-810d-4f5b-90ed-bf4f4ae7e161@squashfs.org.uk>
Date: Fri, 20 Dec 2024 18:42:57 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
To: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241216162701.57549-1-willy@infradead.org>
 <20241216162701.57549-5-willy@infradead.org>
 <ac706104-4d78-4534-8542-706f88caa4b7@squashfs.org.uk>
 <Z2W2Z2Tq4WMNluWU@casper.infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <Z2W2Z2Tq4WMNluWU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNY0SypDjKq+msefzXXDnKtirnRkNAvJhWWiV276jvbZ4vG82fbsFNs5uk+ZZSClx+Br8phl6nzuaxTSFv3+EsAO+SNbG+zy3/9lOEk027RXhqEZtoXz
 U2BSqFrJR8J5n2tq3EWDVxPQt7vZeUynYcEs0QtTcDkCOhjNmbzANjvO9v0tsBP6Vq6BGf1p2xxMsCQ2sHuKpJrZr4wQ6c6ElMbAwnbTicwmMnk/hgQZgXk9
 RYewiNG+palSjDqiMTSbz5iKlWTuwtcxkeTbQPBYBtt+lf5SyiK2gNDzA1FXJwCCwktzL0Qlqh4K+LBWe0hPnXfZUX3oaC4taI1amXlIl/qaqoViuStzyaum
 sk66vwQq



On 20/12/2024 18:24, Matthew Wilcox wrote:
> On Fri, Dec 20, 2024 at 06:19:35PM +0000, Phillip Lougher wrote:
>>> @@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>>>    			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>>>    		struct folio *push_folio;
>>>    		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
>>> +		bool filled = false;
> 
> ahh, this should have been filled = true (if the folio is already
> uptodate, then it has been filled).  Or maybe it'd be less confusing if
> we named the bool 'uptodate'.
> 
> Would you like me to submit a fresh set of patches, or will you fix
> these two bugs up?
> 
> Thanks for testing!

Np.

Andrew Morton is kindly handling Squashfs patch submission to Linus for me,
and so I can't easily fix them up.

Andrew what you like done here please?

Thanks

Phillip

