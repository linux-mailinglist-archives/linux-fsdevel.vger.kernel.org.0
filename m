Return-Path: <linux-fsdevel+bounces-37664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7075F9F584A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B708188F1B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F731F9F6A;
	Tue, 17 Dec 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xMsxShaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB1F9F44;
	Tue, 17 Dec 2024 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469244; cv=none; b=uXaIJFAzHJ4daQVlvmr/cRwYLS8W8P3K3EB2J2770MJ/63VJygd3U2rNv9LtDyaIe982BxkAVWdwmjagZ6zUOpatBsRtlLz3+UowdPkUQROHJUt5KqMa2qM+cPdRpauz0QcUM+79jAd50HYGGlfRNi2gt3VCDpptOwc+ISCUz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469244; c=relaxed/simple;
	bh=wHSJk7+FHuZRJv7x/7v1vpPWsIMv2AxP6jZhoIxoF34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bqe1eXESYpLYZPI4xC66gRDMTGd8nmmIQmUeOeHgxWz9osIW2TVQMoQ1SuiIxmNYg7wRdhi0/RUoKJBuBCfi3umY9BY/EPkzV9cigi8qTL+4PWY7yYopqF6MxbTm/jRUfZptJR9RKDsrx2sCmIbv41wWa217aHsgaTqDL7zxpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xMsxShaM; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YCTjk2KGPz6ClY9B;
	Tue, 17 Dec 2024 21:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734469234; x=1737061235; bh=yzGOi3NneZYR9bDxI9UvolmG
	dtoJM/NJwZQblAerzBw=; b=xMsxShaMUHaL8dRP4HYD6O66fFleU39uHO+HIuCD
	GQ5jN4D1DZysGFmgqmPeiaGjpi8kwNKj0tpW6ZjU7SZ7f0RMNvYxDtnIr0RV9VjO
	yeagNhzqgBBcZzEMMCcz0MTL2mNcKczlvbuwaXZJp6O6kjK2l+wEEC6l8lGydl8K
	x6UXJovpiGP6PuuKldfeS4jIY9kmcruq9UnGDf/aGvk2vymwSZptfURnVYlVyAGC
	6jxONNxHNQKL8T265JNhVfSwbwT0tKLoBmbVsSSwa1b0icoyI3sY65XbuQx94ZHe
	op93Kjghvd2xrWGjy/sVnbD5mgU/PTo/zFFpF0WfkfYCvQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aFjAikwuH6uN; Tue, 17 Dec 2024 21:00:34 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YCTjT2220z6ClY97;
	Tue, 17 Dec 2024 21:00:28 +0000 (UTC)
Message-ID: <df925ada-24a0-4f69-bb46-4f2b7b94217b@acm.org>
Date: Tue, 17 Dec 2024 13:00:27 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-10-mcgrof@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241214031050.1337920-10-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 7:10 PM, Luis Chamberlain wrote:
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +/*
> + * The hard limit is (1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER).
> + */

A closing parenthesis is missing from the above comment.

> +#define BLK_MAX_BLOCK_SIZE      (SZ_64K)
> +#else
> +#define BLK_MAX_BLOCK_SIZE      (PAGE_SIZE)
> +#endif

Parentheses are never necessary around constants since the definition of
the constant should include parenthesis if necessary.

Thanks,

Bart.


