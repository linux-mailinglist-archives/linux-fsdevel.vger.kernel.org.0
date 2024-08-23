Return-Path: <linux-fsdevel+bounces-26916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732095D01D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9181C217F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AF918950A;
	Fri, 23 Aug 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sJDoujMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A81891B2;
	Fri, 23 Aug 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423389; cv=none; b=kzf3vOflNxUe6Ws39gIHI8smtmI9a2NzoKcah5iwfJ84TeMeEpjxgt5eriN07xeOIwdwmqhP87MVp8yPNnlOj22uKDHEAtVhRBf0OMlgLOfYHCI70YQrBnAt51haQAT+KbRq0OuNYYKZEyenI70do79iBdr6Fz8rlvQit59QTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423389; c=relaxed/simple;
	bh=JSd5s7LYZr0ql/S80VXn66iP7Y1KXH7m/YrLDCfDu+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eU4gddFMrZoQIflmovqViHMY+mM4x2H01MUFwcQga/wUvhchkPgSz0VeNCTdQnPr4vYGKUAzWmYCaNDR/Tw2exNIuFJGVy8FAZzqyEFEqSRR8wxKqOV6sXxyV1mjObOT9p3WkZfZ6YFky2XLBIqimbu2AsPydg5FA7jmhVbGkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sJDoujMd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V6/MxKATzyOOmRfgy5jl1cCAM7hvAHmUzrh8d3M3N94=; b=sJDoujMdqdCzjbdtMH4ztfRj1+
	txdxCbSdDBH/LexPtFcSVI9HSgo8UX40XCHPqmniTQCqWByhpD89LMVbavXwaj5LAhpUNktNPWYiK
	NTpEadLd2Tc2crKyHIN4GakQl2Mj6aa1nigm45Ca1N8tk7MhBhL+BsBtG7uOtAGiA/NoCvrHT3S95
	kMLRO9B/XRw0d56orBKf9opsuxFtnfpenF+bHlwvqiZ8CenYU/TeDEZKY3UN8dBCFqx/cdy5uJeU2
	OHP+P11jXffDTNggeXSSh3X/31zgW3JG5CpRrHQMW8QIdYcUl++CokVNM08hinDVpaUNERtqiYKhz
	vkQPG0FA==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1shVIN-004597-Oz; Fri, 23 Aug 2024 16:29:43 +0200
Message-ID: <0db4644c-c113-1473-3a73-6d1a8a1d3b5f@igalia.com>
Date: Fri, 23 Aug 2024 11:29:30 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Documentation: Document the kernel flag
 bdev_allow_write_mounted
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net
References: <20240819225626.2000752-2-gpiccoli@igalia.com>
 <20240820162359.GI6043@frogsfrogsfrogs>
 <170545d7-3fa5-f52a-1250-dfe0a0fff93c@igalia.com>
 <20240823012710.GY6082@frogsfrogsfrogs>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240823012710.GY6082@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/08/2024 22:27, Darrick J. Wong wrote:
> [...]
>>
>> + Control the ability of directly writing to mounted block
>> + devices' page cache, i.e., allow / disallow writes that
>> + bypasses the FS. This was implemented as a means to
>> + prevent fuzzers to crash the kernel by breaking the
> 
>                 "...from crashing the kernel by overwriting
> the metadata underneath a mounted filesystem without its awareness."
> 
>> + filesystem without its awareness, through direct block
>> + device writes. Also prevents issues from direct writes
> 
> You can do it with buffered writes to the block device pagecache too.
> 
> "This also prevents destructive formatting of mounted filesystems by
> naïve storage tooling that don't use O_EXCL."
> 
> --D

Thanks! Just sent the V2.

