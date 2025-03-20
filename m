Return-Path: <linux-fsdevel+bounces-44612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E14A6AAA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57DD48628D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D788223336;
	Thu, 20 Mar 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GLJEwlp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74338F9C;
	Thu, 20 Mar 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486531; cv=none; b=ZPxAlnARBVMNj7Bp0rOuoy/UqTG3e9mG8IrA4rgW6YfIoRBO8POVZfJO/4xcsaoAriWH4DBqaC+QSIp6gZb6XAefkRJ/WZ8BqpRXFjWQjFlQNckx5RUPVTqJQ20ObTn4zuP0UPdVLWr5ve8MXAFeIndxEFogNOkp2YhSaxvSPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486531; c=relaxed/simple;
	bh=DzWx9rY27EbKze2WDG0ZrbD2xKmzNdCYcTYlQVrVJF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnKN0hTHaWtim5T+yiEBJQmzTpqiWZsjts33ZQ+EPgfP+RJdXj59Bvanpdy+xgikgCpB8sn0BBRIvWrUHQlkSEF3FBfTWKa2f8JKov4CswCISAfjOgkvN8wSzxBy28idLU7uP9inBGB945kgLn4101/194Ae7TCKCLynipMYAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GLJEwlp6; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZJVhJ1BGvzm2sXp;
	Thu, 20 Mar 2025 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742486524; x=1745078525; bh=L+t1vbF5G6CUMHJJ4SRep41J
	v1AETPf0sQm4+Lu8AlA=; b=GLJEwlp6gcF+mZvr6HrFHGcZhV356tgrCb1VIDzJ
	OcDLpHSnuELn6lcz38pcZxa0hlTZ++3UPatWxmWJUtLzJldFEOg8+Yd28BtYvQIb
	4sBDyZG42ugs6C6phnsRntde6oiNsytdjQO/PS57tuhbXPWZ0Mh/Xul1X4gyeD3l
	FO1wLHDib6SPKX/JwQsiCPOJ/YJctX0TOmG++89mMBdsubySRkX1ze4ZSXQblTk3
	F/8ZVra2U8AMICAfryDuV76SdSQHFTxZUvzi17mb8S5+Ho30lOIrt4WAnYasS+d0
	HodS76jFKXbFD3XMXjQOfqU+enUGlu0ZYE//aOq4RfLv8Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7OPQbcCVP3Sy; Thu, 20 Mar 2025 16:02:04 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZJVgx00Zqzm1HcN;
	Thu, 20 Mar 2025 16:01:47 +0000 (UTC)
Message-ID: <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org>
Date: Thu, 20 Mar 2025 09:01:46 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
To: Luis Chamberlain <mcgrof@kernel.org>, leon@kernel.org, hch@lst.de,
 kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org,
 brauner@kernel.org, hare@suse.de, willy@infradead.org, david@fromorbit.com,
 djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
 da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250320111328.2841690-1-mcgrof@kernel.org>
 <20250320111328.2841690-3-mcgrof@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250320111328.2841690-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 4:13 AM, Luis Chamberlain wrote:
> -/*
> - * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
> - * however we constrain this to what we can validate and test.
> - */
> -#define BLK_MAX_BLOCK_SIZE      SZ_64K
> +#define BLK_MAX_BLOCK_SIZE      1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
>   
>   /* blk_validate_limits() validates bsize, so drivers don't usually need to */
>   static inline int blk_validate_block_size(unsigned long bsize)

All logical block sizes above 4 KiB trigger write amplification if there
are applications that write 4 KiB at a time, isn't it? Isn't that issue
even worse for logical block sizes above 64 KiB?

Thanks,

Bart.

