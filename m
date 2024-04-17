Return-Path: <linux-fsdevel+bounces-17100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC2C8A7A66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF931F222A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 02:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC2469D;
	Wed, 17 Apr 2024 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+WADREx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD033187F;
	Wed, 17 Apr 2024 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320084; cv=none; b=kMgAmYcqLJAhKZRl0pXw0Ce3lBrPPMKSrLathKU4bnmQpY0HTjLZU2eaAkN/dYeB+Mm4M61p15NBA+K+85wfty3JTiB88YcDcvprCiBwzYX+rP7zXADrVWWRBwts7aae/QkW9pLS9X5PWCXoKtWEWjRxvpbyZFJiXqk5FBtcFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320084; c=relaxed/simple;
	bh=ZazigS3AMQcOYZUY9Qyumx/ad5tZtQXhQ5jy0E9cSJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tUo+zWszSJetaQdme2N9NmNPr5rp/ji29TIzZv05iRvKao8zyWMaaSp3lg5ic9jvFCjkgtni7TgmlQWRXj64CPAQTRMsf62ZRvDvH5B2cFWKClBsCkCkFS1jgHVxFuaXAwXV6R+NwE7DHd1EF6ImwcAl9rOJ+DTViLsaMnP+ap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p+WADREx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=Cpbwf9J/BjnGxflxyOXiye2UjEKahQ5hazTzX4Rg3OY=; b=p+WADRExeJvhawW6UMBLPbKB9W
	dzeaGGXKH5HF+zH4bJS7J4UYmH0OirFIKaXGlz7RvudPkB0dCBCLZbtKZk7J5LiDQY66BQSzw/iy1
	7nRH1jiOn9GRSlrTeekwDd5VncghDHPQzSJ+nKkEz24Hwtih8PbIXTZLC18l2iSTGkBXzxyXamexN
	03C81h2t1EsT9Sb8i5VefQ2VqJPV5YkrnZc9mjsuXXEa05en5+z4RQCFZPWoxDPJZW5VQBOu3A8ZX
	M5fhAkFkMBsgcpXGyX+Emv40yTXWdA254PI1QZ70ugKgpm1w2o1KvpoC0p5L++dUfkJvc8Rx/uRG4
	fa1FG2lg==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwuos-0000000ERX7-0Ax0;
	Wed, 17 Apr 2024 02:14:42 +0000
Message-ID: <0ae4d9c1-805c-4316-959e-c1fa13d18956@infradead.org>
Date: Tue, 16 Apr 2024 19:14:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8a/8] doc: Split buffer.rst out of api-summary.rst
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240417015933.453505-1-willy@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240417015933.453505-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/24 6:57 PM, Matthew Wilcox (Oracle) wrote:
> Buffer heads are no longer a generic filesystem API but an optional
> filesystem support library.  Make the documentation structure reflect
> that, and include the fine documentation kept in buffer_head.h.
> We could give a better overview of what buffer heads are all about,
> but my enthusiasm for documenting it is limited.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/filesystems/api-summary.rst |  3 ---
>  Documentation/filesystems/buffer.rst      | 13 +++++++++++++
>  Documentation/filesystems/index.rst       |  1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/filesystems/buffer.rst
> 

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

