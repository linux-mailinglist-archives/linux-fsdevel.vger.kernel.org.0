Return-Path: <linux-fsdevel+bounces-40155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04EA1DD75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 21:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32C4165D25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09051991B2;
	Mon, 27 Jan 2025 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eW0JzDk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD407198E78;
	Mon, 27 Jan 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738010257; cv=none; b=TYomR7Xeh+4Ti9r1vfKOaRksltkv428D5hLmD3cALut6/udp7vF5SsPGkBN8/wHiq3DycCkSfSFzhGVMyP55vhrC7azFIKE7ay8LZkWKs1Yk8p/UplPWjvsObs0lrGia7yFS+MJdUFkXONGCAB1S3pCkDxZNQYz9/o9et0oquog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738010257; c=relaxed/simple;
	bh=iMbcZUv69qQvAjEYoxxnkH2qpTd+VBLZnLSwdYtvLMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2E7uafay1397hRWLOeT6aWWAgcEY+xLHlrzKhXPhTO/FHGOzaNIRQiJFEoPZk5TYWH9x5h5WVNyTmUHoTDo4tkWZntQM0juH5jA5e6oMwHf+P8hcgobN6z7K7VYOCCc2D1kovg9ZOQLXj3V8Pcasu/428MPPXEPyE+mAvzvX88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eW0JzDk3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YhgG11mbVzlgVnf;
	Mon, 27 Jan 2025 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738010245; x=1740602246; bh=iwV0z46Fzz4t3t3BKlYgt+TU
	1vyw8sZZQDFU149GUSk=; b=eW0JzDk3S2MIClpec4GGxqObmhdcV3aSh1m507+8
	FDO98Kofern8SdTViikFGsg+cGfvquWgNW+2UtF+QQBJJThakWoSyInE72/9E0Yb
	hVSr6O3LqmrwSBfZFtFt6a1h+0tjUZaKrYWAH4uzsfF76EedwppH6Ge3Rj//MnKC
	R3gkf7kh82UCvMwAYbkCXEJEKJdByEAoV0KM2nad5XAqH2CLHGQkc47pkIf1C8uE
	Z8g0Io4J64oMr56hO+tUiuwjYrQgmoD+SNXDh8kcdxj1JFRcVFBpECQrgn+EtvdQ
	c9pYbA6JJAtNLTQvxmBUm9I6Jxf4yKB+EOYmMyasuIJGsw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S9W6UBpvI2BN; Mon, 27 Jan 2025 20:37:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YhgFv0DG4zlgTWM;
	Mon, 27 Jan 2025 20:37:22 +0000 (UTC)
Message-ID: <833b054b-f179-4bc8-912b-dad057d193cd@acm.org>
Date: Mon, 27 Jan 2025 12:37:21 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Generalized data temperature estimation
 framework
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Greg Farnum <gfarnum@ibm.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
References: <20250123203319.11420-1-slava@dubeyko.com>
 <39de3063-a1c8-4d59-8819-961e5a10cbb9@acm.org>
 <0fbbd5a488cdbd4e1e1d1d79ea43c39582569f5a.camel@ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0fbbd5a488cdbd4e1e1d1d79ea43c39582569f5a.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/25 1:11 PM, Viacheslav Dubeyko wrote:
> On Fri, 2025-01-24 at 12:44 -0800, Bart Van Assche wrote:
>> On 1/23/25 12:33 PM, Viacheslav Dubeyko wrote:
>>> I would like to discuss a generalized data "temperature"
>>> estimation framework.
>>
>> Is data available that shows the effectiveness of this approach and
>> that compares this approach with existing approaches?
> 
> Yes, I did the benchmarking. I can see the quantitative estimation of
> files' temperature.

What has been measured in these benchmarks?

> Which existing approaches would you like to compare?

F2FS has a built-in algorithm for assigning data temperatures.

> And what could we imply by effectiveness of the approach? Do you have
> a vision how we can estimate the effectiveness? :)

Isn't the goal of providing data temperature information to the device
to reduce write amplification (W.A.)? I think that W.A. data would be
useful but I'm not sure whether such data is easy to extract from a
storage device.

Thanks,

Bart.

