Return-Path: <linux-fsdevel+bounces-8307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49836832AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 14:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F13D1C21E2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B72537F8;
	Fri, 19 Jan 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aQN6qU1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF252F81
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672601; cv=none; b=U+NnLR4aKDApr0fOHGaeu3Xr2XIWRzFa/FxKTvLV1MYwusK65US7WhWNisy8DGsM6QFKaRbx3F4XWGwd6rvm0rQITuncbKCdJ7CDVWxsytiRnvmKDpi8V42B/7U3e+ZR5ebp/CAUTQReonU9yGtyHAU8IE/vlcmdd+2QhUjyDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672601; c=relaxed/simple;
	bh=xKDBjhSIQeHRiyBuvswYCR7Q2MyTamGKnI7gDtPSo9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BbtGs6Run+Axw5nWLzUPEhiZ5+KcuMFQOCcciffVpeXWJskhepyP/RTQ2yScrEn8l4ZWp66XS7Bjo2M8N24pkRqNjMpszcMWHguPc7gS+Qj2K9XJeATFk4DfMjg1K9xDtG/EC4dU0jET/UtUkHdUlYJyMgpFluDles0tpR/li8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aQN6qU1F; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240119135635epoutp031d6030d294c5e4386e8a7521838ed289~rxDBQZcrD2935029350epoutp036
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 13:56:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240119135635epoutp031d6030d294c5e4386e8a7521838ed289~rxDBQZcrD2935029350epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705672595;
	bh=W+RflgyenszR5l0ujHluv04CpVMqFfMdltxcbwxC4Dc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aQN6qU1FoblAU800GFvBwsWPll2Cam2INs5dplxzXu8ct9OQzcymxeILiy/ja/IuU
	 ckReS347iDXXN0Sriu3iNgkVrfdeIwMbMTH8Rph+nElfSuV6xZwOvZcYhEWqx5401Q
	 5bhQulUXPxGIjvNAeI4MfKLBWP1jQnRka4aacF7U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240119135634epcas5p239b4222d5ff49b2334f45d2e8ee4c237~rxDAMYUOz2244622446epcas5p2V;
	Fri, 19 Jan 2024 13:56:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TGh405bybz4x9Pp; Fri, 19 Jan
	2024 13:56:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.38.10009.09F7AA56; Fri, 19 Jan 2024 22:56:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240119135631epcas5p395210d5cb1880721719bdb46349b1625~rxC9fdr862438224382epcas5p36;
	Fri, 19 Jan 2024 13:56:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240119135631epsmtrp24f31082e3acee7b1d7b4302edc898d3e~rxC9d9Vsa2247922479epsmtrp28;
	Fri, 19 Jan 2024 13:56:31 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-c7-65aa7f90f7b7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	36.C8.08817.F8F7AA56; Fri, 19 Jan 2024 22:56:31 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240119135629epsmtip191f7c61126b6f0e860791b7e09a9cbeb~rxC7wT0ZV0975809758epsmtip1G;
	Fri, 19 Jan 2024 13:56:29 +0000 (GMT)
Message-ID: <9fa04d79-0ba6-a2e0-6af7-d1c85f08923b@samsung.com>
Date: Fri, 19 Jan 2024 19:26:28 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Daejun Park
	<daejun7.park@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <9b854847-d29e-4df2-8d5d-253b6e6afc33@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmuu6E+lWpBkt3qlmsvtvPZvH68CdG
	i2kffjJb/L/7nMli1YNwi5WrjzJZ/Fy2it1i7y1tiz17T7JYdF/fwWax/Pg/Jovzf4+zOvB4
	XL7i7XH5bKnHplWdbB67bzaweXx8eovFo2/LKkaPz5vkPDY9ecsUwBGVbZORmpiSWqSQmpec
	n5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKqSQlliTilQKCCxuFhJ386m
	KL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj/bvcgvv8FbcWWzYw
	ruDtYuTkkBAwkejo/M7YxcjFISSwm1HiSMMUNgjnE6PEpyVX2CGcb4wSk29vYoJpefV6DytE
	Yi+jxLHeOVDOW0aJnbc3sYJU8QrYSWyctYsdxGYRUJWYtGoTI0RcUOLkzCcsILaoQJLEr6tz
	wOLCAlESSybvZQaxmQXEJW49mQ+0jYNDRMBD4tYbP4jwDyaJGdcUQcJsApoSFyaXgoQ5Bawl
	Jv6cyQRRIi/RvHU2M8g5EgIHOCQuzpjHDHG0i0Tnp6eMELawxKvjW9ghbCmJz+/2skHYyRKX
	Zp6DerJE4vGeg1C2vUTrqX5mkL3MQHvX79KH2MUn0fv7CdiVEgK8Eh1tQhDVihL3Jj1lhbDF
	JR7OWAJle0h8utnHBAmpE8wSD1r/s01gVJiFFCizkDw/C8k7sxA2L2BkWcUomVpQnJueWmxa
	YJSXWg6P7eT83E2M4GSs5bWD8eGDD3qHGJk4GA8xSnAwK4nw8quuShXiTUmsrEotyo8vKs1J
	LT7EaAqMnYnMUqLJ+cB8kFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8T
	B6dUA1PL5JC5793/bXlzR4m/buEOYZ9Q++9iK6uFt7IedHWdFfYzo/7QZ8sGm5WX3j9Z7n4t
	yI5/XnzJv3vfnBQvTas8yXNVY5N0ofGxe/fXKR9WKfth8sBkf+bzB03Hsnd+UfOcPEdm2sSe
	CHeRe3Xbz8e+cbyyM/ef3QIRQ7N+Had5/zoaEycfk8pwrgzfeuPs/YjzQmwMDWU5bU2TXJdN
	dnt1f9nhvz5zV/0xkUo+OtfSIN9Zwv7ymtgJTfeiDF8FebTw2p66oHBgmtbLe4x7m5Zf263b
	9E7j9dzaIyLiVa+rXzmsvv2hwLDrybWqDOYfkQ9llKYKBzV7MdVqHjKTV978JnvX2wpjn0iP
	73MYnaYrsRRnJBpqMRcVJwIAGnf/1E8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG5//apUgx1d8har7/azWbw+/InR
	YtqHn8wW/+8+Z7JY9SDcYuXqo0wWP5etYrfYe0vbYs/ekywW3dd3sFksP/6PyeL83+OsDjwe
	l694e1w+W+qxaVUnm8fumw1sHh+f3mLx6NuyitHj8yY5j01P3jIFcERx2aSk5mSWpRbp2yVw
	Zax/l1twn7/i1mLLBsYVvF2MnBwSAiYSr17vYQWxhQR2M0ocv1YBEReXaL72gx3CFpZY+e85
	kM0FVPOaUeLAtkvMIAleATuJjbN2gRWxCKhKTFq1iREiLihxcuYTFhBbVCBJYs/9RiYQW1gg
	SmLJ5L1gvcxAC249mQ8U5+AQEfCQuPXGD2Q+s8AvJomGx9ehlh1hlni99x87SBGbgKbEhcml
	IL2cAtYSE3/OZIKYYybRtbWLEcKWl2jeOpt5AqPQLCRnzEKybhaSlllIWhYwsqxilEwtKM5N
	zy02LDDKSy3XK07MLS7NS9dLzs/dxAiOPC2tHYx7Vn3QO8TIxMF4iFGCg1lJhJdfdVWqEG9K
	YmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUyFzTb1hcsvBIbs
	6Q7be3+H9+ndu868fvgyoT95usqf3cv+fdr1cuHLOUcaDP9wmr89yz1hz/Vqmzs9Qj0sfzc0
	Jz1y+xBimvp47spf7WX//vyZLXc18lzDDTvXYGf+670ini0G79Wjj8zJZHxjc39b64R/y6zT
	GDrj9V+EHF6nLWZ8p+NHts+KzFuls8q11p/ZXxUYv7q8vj9mrp3xzX8+Uy+95urczdK1J9G0
	q/N/o/J02/WCW9eEJmz9Gc1c8W2TpMqvyZ4hlxmE9sQ/eDNP/6iwsY4Pl/vvXKGVkRObY3R8
	jvJP/qq+Jz/wyDwbgXlXZDZ32z9//F056IjcZjVJ4advXb9leKvtunow6ly3EktxRqKhFnNR
	cSIAf9GIDCsDAAA=
X-CMS-MailID: 20240119135631epcas5p395210d5cb1880721719bdb46349b1625
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240103230906epcas5p468e1779bf14eeaa6f70f045be85afffc
References: <20231219000815.2739120-1-bvanassche@acm.org>
	<20231219000815.2739120-7-bvanassche@acm.org>
	<20231228071206.GA13770@lst.de>
	<00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org>
	<20240103090204.GA1851@lst.de>
	<CGME20240103230906epcas5p468e1779bf14eeaa6f70f045be85afffc@epcas5p4.samsung.com>
	<23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>
	<b294a619-c37e-cb05-79a8-8a62aec88c7f@samsung.com>
	<9b854847-d29e-4df2-8d5d-253b6e6afc33@acm.org>

On 1/19/2024 12:24 AM, Bart Van Assche wrote:
> On 1/18/24 10:51, Kanchan Joshi wrote:
>> Are you considering to change this so that hint is set only on one inode
>> (and not on two)?
>> IOW, should not this fragment be like below:
>>
>> --- a/fs/fcntl.c
>> +++ b/fs/fcntl.c
>> @@ -306,7 +306,6 @@ static long fcntl_get_rw_hint(struct file *file,
>> unsigned int cmd,
>>    static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>>                                 unsigned long arg)
>>    {
>> -       void (*apply_whint)(struct file *, enum rw_hint);
>>           struct inode *inode = file_inode(file);
>>           u64 __user *argp = (u64 __user *)arg;
>>           u64 hint;
>> @@ -316,11 +315,15 @@ static long fcntl_set_rw_hint(struct file *file,
>> unsigned int cmd,
>>           if (!rw_hint_valid(hint))
>>                   return -EINVAL;
>>
>> +       /*
>> +        * file->f_mapping->host may differ from inode. As an example
>> +        * blkdev_open() modifies file->f_mapping
>> +        */
>> +       if (file->f_mapping->host != inode)
>> +               inode = file->f_mapping->host;
>> +
>>           inode_lock(inode);
>>           inode->i_write_hint = hint;
>> -       apply_whint = inode->i_fop->apply_whint;
>> -       if (apply_whint)
>> -               apply_whint(file, hint);
>>           inode_unlock(inode);
> 
> I think the above proposal would introduce a bug: it would break the
> F_GET_RW_HINT implementation.

Right. I expected to keep the exact change in GET, too, but that will 
not be free from the side-effect.
The buffered-write path (block_write_full_page) picks the hint from one 
inode, and the direct-write path (__blkdev_direct_IO_simple) picks the 
hint from a different inode.
So, updating both seems needed here.

