Return-Path: <linux-fsdevel+bounces-46161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5FA8387F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D358C462DE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA931F17EB;
	Thu, 10 Apr 2025 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Nd5ESIvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDF1E25F2;
	Thu, 10 Apr 2025 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263509; cv=none; b=uWRitI2f4wret6X4RGb4I2LR3t0FvSCKk77e1KEQsXmftE06AIMyCY5VvROonkLEuJi2Gqb8FaLIlWyALZIcvG/c7yMuPe7xWvJaRHPQ2pYdoXvWysHs+9I1mlGl2/ivIQmxKTS6Oh3Vm596lnjeQb+Bk3rxQ4OuFPhpShNrbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263509; c=relaxed/simple;
	bh=ZGU+BCvrhtz5IgmxOBljHoJpzaAGGcDbjZR9CI4QC78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sd2DSM4epL5n5dX/7GT1SXYdk7f7jWimMs/rMTg6MHGHfEJ6xCBb+CMak0G0017LWkMJWbwvcOXud+Ux5mdTYL73ZMuC0xM8JCJF0xKRs4Au+sapk7wqheGsmV1ZcBhvWBzzLmSx0HRBmj13Qf3It73cMSqc5DKjIN1zgz/1E24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Nd5ESIvX; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744263469;
	bh=Cb9L6MLAek6T3m5TCwcfdG/zC/w2d7rvXsOS6wA5Z6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Nd5ESIvXfFVV87gxLf99oX40nwOuHitFc+QqcqTJ0U9ODeFvOkao5tT7vyIo6TTJk
	 IbgQsUreVm7Dw3EHCxXW39mKF7M8l1MsyB3v6OO9bJtu18gIx3evcc3EbDxJEXfiyQ
	 geQge5VWOoc70GmaUVW/L3apAPgV7ntwIqXOrzFw=
X-QQ-mid: bizesmtpsz4t1744263464tedbade
X-QQ-Originating-IP: ladzBLJIHMgI3oJtEfMCVMmqD0ZH8liBvMxdzI0duUA=
Received: from [10.7.13.51] ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 13:37:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10781156828433277354
EX-QQ-RecipientCnt: 7
Message-ID: <75EE8C762B61A1E0+70ff3f7f-2ddd-4109-ac57-d395a69302f3@uniontech.com>
Date: Thu, 10 Apr 2025 13:37:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: skip unnecessary ifs_block_is_uptodate check
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangyuli@uniontech.com, gouhaojake@163.com
References: <20250408172924.9349-1-gouhao@uniontech.com>
 <20250409153020.GR6283@frogsfrogsfrogs>
Reply-To: 20250409153020.GR6283@frogsfrogsfrogs.smtp.subspace.kernel.org
From: Gou Hao <gouhao@uniontech.com>
In-Reply-To: <20250409153020.GR6283@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NY7N4KDmsCacKx80AhAbX7veQtwRMi0iGEhGlPyQp6oHViGtpBiz7AOl
	P+uSFUJVvuL5g79+csjN7mruyoZHRlOQyNkYJm2xsSzA2AeqcqP2BjL8hgs8BifoVwfSCuy
	wjc95V+2Ucm5pRkMEOerLrEXq+iIZWHJIlu+Zmu7SO3qqFRy/iJVVIUP01AyhdILs1CnPF5
	JpadGK3hwnl8eYyCp8j+l7bXYT4+pJDhmRouRmFavKb9HiUakG+YD5rUYz6X2DV2iaF/SN3
	JDyT/xfxRuIPA9FmyY60TfG719il01T4VDw+Aj5L24teUTviS8QX44+TZmmg8Y7N7gVquba
	foQkzbFMCvybYJ3L6Z4vpyfp4kQDztDXJoRp3R+HLOLfxwdIMoq6R7TJP0KlNXEhbrODU70
	NK8SOjOt/uMpAETELyqGScJV4PH2ITh1kbN9J8Ji8lMbV5vVHDVsKhJ/mH6Nrc2vhjACmAW
	auwUHmpTNFZGDk/morxYOy+0XdMpD0+GUOZH7DBR6ETDgzOEORgZ+BLODYdD7B0eQpm5dcw
	Q3c11QoWz8VFen2OSECl9NQY9RG0Uo1zal7hY54tud1djUPNmPuusCdAdGKUbjBAMzjw3WZ
	IS9vsByX+PQTzW7HEXaTLnevcdSZwifHUqVP2ReWE6vSbIDVGvRL0gg9ciBl/6H6KCX5drc
	QxpjSVAln9O2ki9OWo80KpygFTNpt0BYFwBz+WwMcu76Ebs55X5FXLzIEUBx5O4a9iGKh4P
	dmL1CoQB947xh0dqw7NzL8ICmNSJhbQAZ2uVFy9Svto0NKHYR4wNtwsWUpBBjza7gA/VrM9
	dAXZP5eBTDFVLotPoh+g5qTWJMvoyJRViOZMRqp2b29uyY96kIanhZCBWLRLetORwUNEDjr
	4TzQzOKFxBs4nzmg/KZ3x0u/a1CDtBQJPUP+qo7sAwyIfqqEFWBSgr5HU+idexL5i701hRy
	iN3BtJE294Wn7sX4kScXmf1T8JSG4vfVeX3safaqK2b6HtBfFqc3aqAdw
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0


On 2025/4/9 23:30, Darrick J. Wong wrote:
> On Wed, Apr 09, 2025 at 01:29:24AM +0800, Gou Hao wrote:
>> After the first 'for' loop, the first call to
>> ifs_block_is_uptodate always evaluates to 0.
>>
>> Signed-off-by: Gou Hao <gouhao@uniontech.com>
>> ---
>>   fs/iomap/buffered-io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 31553372b33a..2f52e8e61240 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -259,7 +259,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>>   		}
>>   
>>   		/* truncate len if we find any trailing uptodate block(s) */
>> -		for ( ; i <= last; i++) {
>> +		for (i++; i <= last; i++) {
> Hmmm... prior to the loop, $i is either the first !uptodate block, or
> it's past $last.  Assuming there's no overflow (there's no combination
> of huge folios and tiny blksize that I can think of) then yeah, there's
> no point in retesting that the same block $i is uptodate since we hold
> the folio lock so nobody else could have set uptodate.
>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D

Thank you for your review. The explanation is very clear. I will revise the

commit message and send the V2 patch.

--

thanks,

Gou Hao

>
>>   			if (ifs_block_is_uptodate(ifs, i)) {
>>   				plen -= (last - i + 1) * block_size;
>>   				last = i - 1;
>> -- 
>> 2.20.1
>>
>>

