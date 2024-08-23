Return-Path: <linux-fsdevel+bounces-26923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C42395D296
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAD81F23021
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8EA18A6A7;
	Fri, 23 Aug 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RSY+AlbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127B4C62B;
	Fri, 23 Aug 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429495; cv=none; b=e/4J4a09dwRf6+50VASqtwBLQ04JY4EIpCFLodyvWBnLFjDHN6DOKyFAgiH72xKTyhsWuP024Oxa9rvdBjKFcadhIzN7wL7ymDi70k2yqzyf4EhMYtMhsLMvVk9qyUHgFPYJLIKN1S5HeJ0PdfjHsyBqzTiJjcxhRT2jHSGfDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429495; c=relaxed/simple;
	bh=ZWDyf+nErovNeJ6GkhBmSpKa+K7/CO5U+w0e6zbxjPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSzRUdZMNMRfz6Apyewo4ryORcVOPK/GmOJeI2w+RVm2p9YlglHr155nbIsPWjvsizP0Ag1DaQ8De1fWei+RgdwFfwJVN5LblDKkSfbdO47oTIke3OvMk35gjPPjaZsulZv/8JCGOMxt8mWDRjILEaaj3lG4Q5dkp+Vy1+CsswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RSY+AlbD; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wr4nd13mQzlgVnK;
	Fri, 23 Aug 2024 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724429490; x=1727021491; bh=h2YCubCc91QxFmANTA7npfN2
	gufp8WsN0ehvCsJe3UM=; b=RSY+AlbD8jin1XnLmS2NjbvqwjplT1nMVIeggTG7
	PP4XSh4B6KslW1FPbOKdAs0S2VDE12lyNcETE+zKERVJppGAVYhViBify9jGfd2b
	IBfSfK5SAYVQZLCjWkaupQnUw+xwpImWlRE2ZdNjeTj0UkOLhXQsh8I8xCD++gzO
	2m7H+j8wy4Jh/u4Z1mZMWEfWuIl598clh7xlZazhT/2xlgW3wrK7v/tQHbx89gxJ
	k5IFwb3JDxB/zEXggkJGP5wyjSMOC3hwxIdec9F6n5aaXrK5WuOsYl9BQ/si9I95
	8KYKo98OBuFb30CH1xfHMkG64y6rlF2eYvILUMlTSqbwjg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id c4IPwVF-IJrq; Fri, 23 Aug 2024 16:11:30 +0000 (UTC)
Received: from [172.20.20.20] (unknown [98.51.0.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wr4nW2hXDzlgVnF;
	Fri, 23 Aug 2024 16:11:26 +0000 (UTC)
Message-ID: <35febff2-e7cc-4b57-9ba5-798271fe0e3b@acm.org>
Date: Fri, 23 Aug 2024 09:11:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Documentation: Document the kernel flag
 bdev_allow_write_mounted
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org
Cc: corbet@lwn.net, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
References: <20240823142840.63234-1-gpiccoli@igalia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240823142840.63234-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 7:26 AM, Guilherme G. Piccoli wrote:
> +	bdev_allow_write_mounted=
> +			Format: <bool>
> +			Control the ability of directly writing to mounted block
> +			devices' page cache, i.e., allow / disallow writes that
> +			bypasses the FS. This was implemented as a means to
> +			prevent fuzzers from crashing the kernel by overwriting
> +			the metadata underneath a mounted FS without its awareness.
> +			This also prevents destructive formatting of mounted
> +			filesystems by naive storage tooling that don't use
> +			O_EXCL. Default is Y and can be changed through the
> +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> +

Does this flag also affect direct I/O? If so, does this mean that the
reference to the page cache should be left out?

Thanks,

Bart.

