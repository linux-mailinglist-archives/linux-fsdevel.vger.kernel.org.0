Return-Path: <linux-fsdevel+bounces-10607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9084CC69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0762D2877C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5547C08B;
	Wed,  7 Feb 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="oU9M4k6D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gb8DcpHq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E276911
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315224; cv=none; b=cEpELV5lvfJfpaFyaqy5lu4byFy3ESBOawrehuMOXaSJ08XRmUqvdcKAI6rIbpxfOZKTWP6iph6qNJbi+BXj10JKwR4ziwJTbvShslfHuUaDGFpkaa/ztKTqCNvx2wxCaZo0RDpS4HgA/PeGyk0QnCojKdaUeWzdBuD/S+KyDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315224; c=relaxed/simple;
	bh=G6tzeJr76VHxPlPVdoe+8wZ5pa59ZRbDtThMgyx2sOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQAfR3PjwJ4NiYipA8n3iFR/lA1lfaOl7SHU2Pj0idpqt5qqWh+vLHM+fKbdhVYSL/FKkW/MiPe3OeTY4VpH+GQ5A5LOYXAzqnQ25bsroonD86UCW6LDTZkz2ZHj+jT8pWJ6fc/vZdl5e08rgyjDNZZ3ddyLyPneYB6GwNvKUZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=oU9M4k6D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gb8DcpHq; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 6E1483200A40;
	Wed,  7 Feb 2024 09:13:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 07 Feb 2024 09:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707315220;
	 x=1707401620; bh=iAO/OIi3ik5Urj6tyMRalIrN5Nfid4IRZULp8S5CUNY=; b=
	oU9M4k6DgX9PARVLzypu9B88NijnoIUFwqKIQL6IxcT2YbMR196WiQVVebAm2tVI
	oiDi7L1yDmdSv3PTcTvu1UFNQJsOw4MDVAEyif5VxLx2NSCqGu4jAQyahChqb08J
	g0B4xWafJ8dZoWaWNIt5+P9l4EaipY+ZEG4nOyv+g+mGSbeNjUluFlWTgsRoaYgK
	00gRhoZ+kLxL5CYIk1Sw+B5HPAAQGftYoJR7/LexHZc/1s+F30NeG78SXeZ6diS8
	E48fpy59QV/+1XMfJx6Ye6AfOQjots6pQowzogMyQP4+tP+KwURbq/u/rZTSX5Av
	Q+gwzm7WAGfaLo9o8PFpkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707315220; x=
	1707401620; bh=iAO/OIi3ik5Urj6tyMRalIrN5Nfid4IRZULp8S5CUNY=; b=G
	b8DcpHq6ckTp16QEHLzV6cP+M+a1HTcyiMgRVNC/sfqxeTSakyqRcIzbKrSBLC1a
	JP3jwCLS7BmvDP4v6GHVYyScnT3QPfZVmhvlUP4lY4R/ymgrRFx2Srh1+mPmBlJ8
	Sa7VWpkOlBnG2QToFNuP4GodvUdq5GdjKj/yXfr3cQbWM7IieWd3oiDCBAv50Il3
	9KDVPxRMFVV7AopC9bQgcYiv3IXuwcomLhh+xOB3ecmpE8WKt47cTMAng0kkZx8E
	8SJWNGdWiY2GlNlzW7KsyZSzoGc84GZYnk2bwwYB82XEswNmpto9WJr0jatyE6Bi
	Jrckvt9bDADI6LiA7xmSw==
X-ME-Sender: <xms:FJDDZU48W8xUXLP-Q5WOwwXj7Q0Y5TAFjXe_YG0I6mdFl6CC_ovaAg>
    <xme:FJDDZV7d5H6ZoNGgjBEsP4zTGivkwerwMFRyMHI9tHtnkTjoI03l-wLuO5xOvM4c3
    vuu12-HDWgBKoKi>
X-ME-Received: <xmr:FJDDZTcNXTRLDNfoyGk1cPiPo9XazWFCZ3AbN09OEnR0RjVon9WGtI4FkK3hfKgoxh9SeD_JwyGeGlUUzfM8kXsI3-dTPMBrZ8MLapn8C1iywrCxS8G9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgf
    dvledtudfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthh
    husggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:FJDDZZJ2FQvVb8pdlqJM4z19Tk21X5911lKmtF6Ks35uU866Wo_Wyw>
    <xmx:FJDDZYJshifIZaYFsvbJqsmywFl-yDCy1bk385VX5egJOyeZ6DrZIg>
    <xmx:FJDDZaybd96cXcVt3D7XGvQ3TY9S0LUSHQl9UpjpFa90jwjPHDIXyw>
    <xmx:FJDDZdGmlmRXX8-6tJgQADnBusDpNZwEFGQh5vbPH9CaLvLLqt5bXw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 09:13:39 -0500 (EST)
Message-ID: <072d2ac6-6281-404c-8897-39748c763b39@fastmail.fm>
Date: Wed, 7 Feb 2024 15:13:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fuse: Create helper function if DIO write needs
 exclusive lock
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert
 <bschubert@ddn.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
 Amir Goldstein <amir73il@gmail.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-3-bschubert@ddn.com>
 <2d0d6581-14de-46c4-a664-f6e193ab2518@linux.alibaba.com>
 <b9308f8b-cda3-486f-be23-6e84cc0c8b6d@fastmail.fm>
 <f365c731-9cc5-4340-9c1e-f6f5ab422140@linux.alibaba.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <f365c731-9cc5-4340-9c1e-f6f5ab422140@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 14:44, Jingbo Xu wrote:
> 
> 
> On 2/7/24 9:38 PM, Bernd Schubert wrote:
>>
>>
>> On 2/6/24 10:20, Jingbo Xu wrote:
>>>
>>>
>>> On 2/1/24 7:08 AM, Bernd Schubert wrote:
>>>> @@ -1591,10 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>>  	else {
>>>>  		inode_lock_shared(inode);
>>>>  
>>>> -		/* A race with truncate might have come up as the decision for
>>>> -		 * the lock type was done without holding the lock, check again.
>>>> +		/*
>>>> +		 * Previous check was without any lock and might have raced.
>>>>  		 */
> 
> 
>>>> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
>>>> +		if (fuse_dio_wr_exclusive_lock(iocb, from)) {
>>> 			^
> 
> I mean, in patch 2/5
> 
>> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
>> +		if (fuse_io_past_eof(iocb, from)) {
> 
> is better, otherwise it's not an equivalent change.

Ah thanks, good catch! Now I see what you mean. Yeah, we can switch to
fuse_io_past_eof() here. And yeah, 3/5 changes it back.
Fortunately there is actually not much harm, as
fuse_dio_wr_exclusive_lock also calls into fuse_io_past_eof.


Thanks,
Bernd

