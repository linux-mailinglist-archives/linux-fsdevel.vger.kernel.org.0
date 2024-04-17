Return-Path: <linux-fsdevel+bounces-17099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB58A7A64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262DC1F22229
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704AB657;
	Wed, 17 Apr 2024 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVzCuGwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6634B641;
	Wed, 17 Apr 2024 02:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320042; cv=none; b=FfjCaQ4PUS/baS5Y8egou7vuH5ugOVfeaidG84Lv0CR/g0oEsG8iGvRrPpK6cFykdUwscDVnPOjr+Lx27Q/bkP5ZJ2AwH2RC9iOFQW01C4arAq4cgX70DNR3DT11h26KuIxnHl3dW5B2e8iTvFe/OJ6SBZVtzSrRBc3Nk04K9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320042; c=relaxed/simple;
	bh=VGGPLLZVrLW6P5TXLxZ6+DI3U0Y+C2jpe7/dc+w0Zr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWoYH1lObOGHz/jVaGrJpNxX+4CY4pw01E8Qpdued8ty50Pa4L0itU7MDtLOgWMTP1PrYyOGtmUunfpcd3fTD2lDCMrvW75U45v5T5LA2qjyJof00X0KwSb+iH5z8gOwNF5M/TgqIhYbuSEa05KwPMNb2P7phNxWofBUOHwwSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uVzCuGwF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TWFexOv0rUewIywQbNEWUqP9XJQFe2vU+B3TSGgpdDg=; b=uVzCuGwFfmelKMSglrfEjygMih
	dPJfYCkoHlN4ljCRkG6XYHc3cW9h7a8Hf9APMwfReDNTE+Z3M+VJ9i1gZxsLx8ikcN+7zjeA3T3hX
	Qqyb7LEq6UDP57B4KdwkTZ1Piw0ZdL5CAFkYbA27i0G9ytjUgQuuU6BMUfwI+HgfjBZ9Mfq7n4pTX
	ALy2QG/F7QyeOeakNxo7ZTM7KUskf1uzRyptKComyLdXuh/qn2Fdk62V4tDe42UtUrqRa4ZFuVRWA
	++Q7jX+Ox62B9LKOht3oa8PNZa4EJflc0wqLq+hbbJIRnGKG4oIqw2E2uEZx5KrVnW1oHqQ/DHi6t
	Ia0gzOFw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwuoB-0000000ERSp-28W1;
	Wed, 17 Apr 2024 02:14:00 +0000
Message-ID: <444d629d-5682-4da6-8f74-94abc236608d@infradead.org>
Date: Tue, 16 Apr 2024 19:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] buffer: Add kernel-doc for bforget() and
 __bforget()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-7-willy@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416031754.4076917-7-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
> Distinguish these functions from brelse() and __brelse().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  fs/buffer.c                 |  9 ++++++---
>  include/linux/buffer_head.h | 10 ++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

