Return-Path: <linux-fsdevel+bounces-10690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351D84D6EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354651C22599
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC72576A;
	Thu,  8 Feb 2024 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kEqDNOBB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E601EA95
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350694; cv=none; b=nZkMkLWKpy7g7f6ywHgG14ej5LBbWIj+24PBPsFgTs+9nTisAu9UUc6usdRSclUuEATc+wdvVvdRL732nkeRcMfViCq4QSRdMhBlIXvdbYAR9rzJcVp0WxBJXMGXB7z6HuMhr8RUAebkA/fkWoms3tyoF+gqN02kjMmzoEZtJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350694; c=relaxed/simple;
	bh=gabRMLM/A1bSe96IN7Y/ex0LcrEYgjRU+pNBbVb/BTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSWpwztPz5RPmse53r2sKN3Mu67fSYYv1/kv0vBb0VvNFA2pyvowZuAbVWmHjmY0w/UO/nZPN+UX/FB/fRZCpVP6mxhzC+CQA1EleLRJNSO0n1pyMhJT+GnUI0eI1Cp70LkCrxkvCcH6qhMLcX5O1mw/yIn4njyrWwROt1v2U4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kEqDNOBB; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707350684; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kW65nYleLzY2lUSoH1IvIy3wzpupQ+VfBfFUwoZ7Shw=;
	b=kEqDNOBB9ttvgCkypsJvazevXG8CSY9mKb5QGu4rD8VI17a8bW0oc0atl8ZlzoUobYCN/iQspGOjn+5A2l9j1kSdqbU/mX2m3nt7whL3ZLbjVjHeX8CuVwDi2Qz2UmBuwZ+uCwJD/tkszdwqtv1HfvtC/fJgksX6UutSj/hiuoM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W0Hs1fb_1707350683;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W0Hs1fb_1707350683)
          by smtp.aliyun-inc.com;
          Thu, 08 Feb 2024 08:04:43 +0800
Message-ID: <d13251fc-dfd0-4634-9d3f-43a8afe47752@linux.alibaba.com>
Date: Thu, 8 Feb 2024 08:04:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fuse: Create helper function if DIO write needs
 exclusive lock
Content-Language: en-US
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
 Amir Goldstein <amir73il@gmail.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-3-bschubert@ddn.com>
 <2d0d6581-14de-46c4-a664-f6e193ab2518@linux.alibaba.com>
 <b9308f8b-cda3-486f-be23-6e84cc0c8b6d@fastmail.fm>
 <f365c731-9cc5-4340-9c1e-f6f5ab422140@linux.alibaba.com>
 <072d2ac6-6281-404c-8897-39748c763b39@fastmail.fm>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <072d2ac6-6281-404c-8897-39748c763b39@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 10:13 PM, Bernd Schubert wrote:
> 
> 
> On 2/7/24 14:44, Jingbo Xu wrote:
>>
>>
>> On 2/7/24 9:38 PM, Bernd Schubert wrote:
>>>
>>>
>>> On 2/6/24 10:20, Jingbo Xu wrote:
>>>>
>>>>
>>>> On 2/1/24 7:08 AM, Bernd Schubert wrote:
>>>>> @@ -1591,10 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>>>  	else {
>>>>>  		inode_lock_shared(inode);
>>>>>  
>>>>> -		/* A race with truncate might have come up as the decision for
>>>>> -		 * the lock type was done without holding the lock, check again.
>>>>> +		/*
>>>>> +		 * Previous check was without any lock and might have raced.
>>>>>  		 */
>>
>>
>>>>> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
>>>>> +		if (fuse_dio_wr_exclusive_lock(iocb, from)) {
>>>> 			^
>>
>> I mean, in patch 2/5
>>
>>> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
>>> +		if (fuse_io_past_eof(iocb, from)) {
>>
>> is better, otherwise it's not an equivalent change.
> 
> Ah thanks, good catch! Now I see what you mean. Yeah, we can switch to
> fuse_io_past_eof() here. And yeah, 3/5 changes it back.
> Fortunately there is actually not much harm, as
> fuse_dio_wr_exclusive_lock also calls into fuse_io_past_eof.
> 

Yeah fortunately we needn't retest it as patch 3/5 changes it back.

The whole series is good.  The comment is just from per-patch basis.

Thanks,
Jingbo

