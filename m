Return-Path: <linux-fsdevel+bounces-29187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05173976E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D8C1C23F52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D481B78FC;
	Thu, 12 Sep 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="juCHpSrz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BC1AE845
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156427; cv=none; b=YcmSRp5OBK0OK1ymhJbQntUelYwKxwyX9T70PbtsXOyhxp3QhF4N8nasS7eZtH1ip0NrICEYT0SkPnJAe5BLiETX23ufXP0/BGY53yDY7vw40LjEdqOVjBrorQFL6gUpHOCI6axZag8bCN3ubG/BBEghxzuLkdsoBe3yDYiPXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156427; c=relaxed/simple;
	bh=MfiPHHWzcUPoikcC2AWklYrH0eF6L02pHjZztFDf2eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YTmJXb5G1jz6EGtM6UYPZtybFseV2uYlPeelwKowwWYHL228MSFnVwESYTXfj+w9+STglzbToQSVl4B5Z4bTa1DffUVhn+Sf87APuhmXRyRiQ5z/+kATxqPS5mZb/KKEMODr4SQe462LKm0quDL9KCZTikdhcWkskBURalZBTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=juCHpSrz; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240912155342epoutp03bd8f3c846509990842d4736fa5a22974~0ih7gzxY60753907539epoutp03P
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:53:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240912155342epoutp03bd8f3c846509990842d4736fa5a22974~0ih7gzxY60753907539epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726156422;
	bh=9wrJPxVcc/Q0n8avU1W8+UAE/X30MRSqz63B1JmEJYc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=juCHpSrzp5D0fbMEiPIVarNtOXxM+3192tqHcOqZIuwGC9LyggBunP62dIic2KJ7B
	 6/saSe/IjfDXtORBvv0nLdEzWiP8aF8To2W/nmAAatFjta5MnFyGJYs2I+FoW5pBTG
	 yD9U03arrubMyc1kRJC9dsGs8xKQXGDxOHAZMD+Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240912155341epcas5p4042f379347eb854cba992f62811d8755~0ih6aqcbT0034400344epcas5p4T;
	Thu, 12 Sep 2024 15:53:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X4MRm0lwSz4x9Pq; Thu, 12 Sep
	2024 15:53:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.FD.09642.38E03E66; Fri, 13 Sep 2024 00:53:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240912155339epcas5p4d1a3fcdb4c2e159b08c1b93a58654532~0ih4w2vs70034400344epcas5p4S;
	Thu, 12 Sep 2024 15:53:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240912155339epsmtrp2c63fbfadc476b3d0f006b8ce374a049a~0ih4vqQ-m0049700497epsmtrp2Z;
	Thu, 12 Sep 2024 15:53:39 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-fc-66e30e83d58a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.A2.07567.38E03E66; Fri, 13 Sep 2024 00:53:39 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240912155336epsmtip1ed839d5dba50a0141cd7184e5d5708a4~0ih1yNt722433024330epsmtip1f;
	Thu, 12 Sep 2024 15:53:36 +0000 (GMT)
Message-ID: <5e453909-bcc4-2184-66e0-81587e5256b7@samsung.com>
Date: Thu, 12 Sep 2024 21:23:35 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240912130146.GA28535@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zbVRTHvb9faQva8ZMOucOgpRHicJRWSrmYFTFj+DPwB6Izhhigoz8e
	oS1NH8oW1xHYGLIBA/dwFYE5pFsngwIZHVDD2AOYTOpgCBUQeTgGY7yWCdtAW8qU/z7n3O+5
	33vOyWXiHvkMb2a6QkOpFBIZl+5Gu3xte0Bg7pbxFH5bYSi6OFxMRzPXFgE6Nb+Co3+G72Fo
	sO0Khi5cvIGhb0/nYmiiVo8jUzETjQ8tMdBKtZGBStv7AbLY3kJ3vn8ftVq6aKiiepKBjv5m
	piNDxxqGLj+twNGlmTka6lntcEE9+jJGxCtkb1802TNiopGnSm/Ryd7bWrLe+BWdbKg6SLZU
	LmFky2A2nVyYtNHIokYjILsrrzPIpfrXyPqJWSyWFZ+xM42SSCkVh1IkZ0rTFalibvRHibsS
	Q0R8QaAgDIVyOQqJnBJzI2NiA6PSZfaeuZzPJTKtPRUrUau5QeE7VZlaDcVJy1RrxFxKKZUp
	hUqeWiJXaxWpPAWleUfA578dYhcmZaTVzVgZyjmvrMp5GyMbFLILgCsTEkJYlNNPc7AH0QLg
	rw/iCoCbnRcBNJytw5zBYwDPmw7hzyvqBh4xnAcWAFs7l4EzmAWwpn/cxaFiEeHw8U+G9Xtp
	hB+0PijBnfmXYdeZifW8J7EXPrlbBhzMJsTw7Op5hoNxwgvaJiowB28luHBy+va6AU5U0+AP
	Cz30AsBk0ont0Pq11qFxJXbAH2+e26h9HTbNluEOPSRqXeHPOUUbz46EjTXlwMlsON3RyHCy
	N1x6aKE7OQOOjo3SnPwlNDcUuTj5XZj9bMDF4YvbfWubg5xeW2Dh0wnMkYYEC+bneTjVvnCk
	dHKj0gv++U3VBpPQdqKP7pzVIIBNo92044Cj3zQW/ab29Zva0f/vXAloRrCNUqrlqZQ6RBms
	oL74b+HJmfJ6sP4lAqLNYGx0ntcOMCZoB5CJc7eySuljKR4sqWTffkqVmajSyih1Owix76cE
	9/ZMzrT/KYUmUSAM4wtFIpEwLFgk4HqxZg5/J/UgUiUaKoOilJTqeR3GdPXOxi5UWV5KShjR
	R3LabJY5//1ixV1+y4tTwr3tmqk1HS7vPmk9OVBvkFbHdz3RHUt8NSto6o5597iOF+xrEi8L
	rIcbdM1zZa2VoUfcj0uu9BbKVy/FWUOuc9m8BFnUsd9Tks4EaLwPJFQFfcz3vcF+4abqwL6V
	NyN+6bz6aYnne4d8hnLdg0/EuX+49nB1l3/sbr+FW38Nf/CZ2TVFZsp7lCdavCdwi/EyzrPM
	z5Kjik8rjTF/NB0MV5F7jH0+7IgjNXtWFXmd5fH95/yO+o++EVdbbkL8Zh2RCt2z7keHbzP4
	MMN23M/l5Qz6oqvCsWnWrgaDv5tuiPHJcttgflXQ31rEpanTJIIAXKWW/AtYiBogmwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSnG4z3+M0g4Mr+C1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbbfs9ntlj3+j2Lxfm/x1ktzs+aw+4g5nH5
	irfH+XsbWTymTTrF5nH5bKnHplWdbB6bl9R77F7wmclj980GNo+PT2+xePRtWcXocWbBEXaP
	z5vkPDY9ecsUwBvFZZOSmpNZllqkb5fAlbHh9QX2gvfiFQs+3GJvYOwV7mLk5JAQMJHYcOML
	excjF4eQwG5GiRk915ggEuISzdd+sEPYwhIr/z2HKnrNKDFt0m1WkASvgJ3Et33LWUBsFgFV
	iQtvJjJDxAUlTs58AhYXFUiS2HO/EWyosICtxMK/K8CGMgMtuPVkPlhcREBJ4umrs4wgC5gF
	lrFIHJzylgli201GiWeLbwNlODjYBDQlLkwuBWngFNCRWHNsMdQgM4murV2MELa8xPa3c5gn
	MArNQnLHLCT7ZiFpmYWkZQEjyypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOCUoKWx
	g/He/H96hxiZOBgPMUpwMCuJ8E5ie5QmxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0
	xJLU7NTUgtQimCwTB6dUA9PBqxtCXdt35Wd/cXIRkzGcPUvCnWeW806LFimtObP9b078NHH2
	lGCvMwKLP+f/eveKcXqSsLr4KV7t+W8krik9Xfwrz+ZN8VpW30TBRb/K7Y1/tWffWdf9oLxg
	JSuL9bHM589LmBf9Mrav+26vrXn30NpC4Ykssx/0nOpe6Ldns49xosill94bJgctOiDml5J2
	46LIpICEC0+Nld5vTzKaGX+kqDbOKaOru33xhR8ZXJKnzjSf0ZxyZOaUBi8ZPXnmRA0uh7pI
	Ob3Pikcj7882WpR8UmbL5CLVvxmBtU/9e6ZM2b+kb2Xo7hM5PCo394TeZ2pT8hUV3rSR9+Xs
	a9mmO0VO8qxbMulz34mko5+VWIozEg21mIuKEwHamc83eAMAAA==
X-CMS-MailID: 20240912155339epcas5p4d1a3fcdb4c2e159b08c1b93a58654532
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
	<20240910150200.6589-4-joshi.k@samsung.com> <20240912130146.GA28535@lst.de>

On 9/12/2024 6:31 PM, Christoph Hellwig wrote:
> On Tue, Sep 10, 2024 at 08:31:58PM +0530, Kanchan Joshi wrote:
>> This is similar to existing F_{SET/GET}_RW_HINT but more
>> generic/extensible.
>>
>> F_SET/GET_RW_HINT_EX take a pointer to a struct rw_hint_ex as argument:
>>
>> struct rw_hint_ex {
>>          __u8    type;
>>          __u8    pad[7];
>>          __u64   val;
>> };
>>
>> With F_SET_RW_HINT_EX, the user passes the hint type and its value.
>> Hint type can be either lifetime hint (TYPE_RW_LIFETIME_HINT) or
>> placement hint (TYPE_RW_PLACEMENT_HINT). The interface allows to add
>> more hint add more hint types in future.
> 
> What is the point of multiplexing these into a single call vs having
> one fcntl for each?  It's not like the code points are a super
> limited resource.

Do you mean new fcntl code only for placement hint?
I thought folks will prefer the user-interface to be future proof so 
that they don't have to add a new fcntl opcode.
Had the existing fcntl accepted "hint type" as argument, I would not 
have resorted to add a new one now.

You may have noticed that in io_uring metadata series also, even though 
current meta type is 'integrity', we allow user interface to express 
other types of metadata too.

> And the _EX name isn't exactly descriptive either and screams of horrible
> Windows APIs :)

I can change to what you prefer.
But my inspiration behind this name was Linux F_GET/SET_OWN_EX (which is 
revamped version of F_GET/SET_OWN).

>> +	WRITE_ONCE(inode->i_write_hint, hint);
>> +	if (file->f_mapping->host != inode)
>> +		WRITE_ONCE(file->f_mapping->host->i_write_hint, hint);
> 
> This doesn't work.  You need a file system method for this so that
> the file system can intercept it, instead of storing it in completely
> arbitrary inodes without any kind of checking for support or intercetion
> point.
> 

I don't understand why will it not work. The hint is being set in the 
same way how it is done in the current code (in existing fcntl handlers 
for temperature hints).

>> --- a/include/linux/rw_hint.h
>> +++ b/include/linux/rw_hint.h
>> @@ -21,4 +21,17 @@ enum rw_lifetime_hint {
>>   static_assert(sizeof(enum rw_lifetime_hint) == 1);
>>   #endif
>>   
>> +#define WRITE_HINT_TYPE_BIT	BIT(7)
>> +#define WRITE_HINT_VAL_MASK	(WRITE_HINT_TYPE_BIT - 1)
>> +#define WRITE_HINT_TYPE(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
>> +				TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
>> +#define WRITE_HINT_VAL(h)	((h) & WRITE_HINT_VAL_MASK)
>> +
>> +#define WRITE_PLACEMENT_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
>> +				 WRITE_HINT_VAL(h) : 0)
>> +#define WRITE_LIFETIME_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
>> +				 0 : WRITE_HINT_VAL(h))
>> +
>> +#define PLACEMENT_HINT_TYPE	WRITE_HINT_TYPE_BIT
>> +#define MAX_PLACEMENT_HINT_VAL	(WRITE_HINT_VAL_MASK - 1)
> 
> That's a whole lot of undocumented macros.  Please turn these into proper
> inline functions and write documentation for them.

I can try doing that.

