Return-Path: <linux-fsdevel+bounces-29191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A51976EB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC268B241DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41A186E30;
	Thu, 12 Sep 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jLgvOokA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2617D378
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158678; cv=none; b=cJ6hhIiIB5lsDUHWeWOFlS79CqiV9KdJbBg+1DE97Kzj8RE7TgS1fYsVqdL3ZJf0dZryteStSOw5pAo3IO67+EZCA7H6kyyCyEqOVs/FlflXhiB7QiGv9uYi3IV2laVWovJ+/r1oIjwk+yiPfAYctWttQO/nEQAfRhSrXZrom60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158678; c=relaxed/simple;
	bh=xo0SaPUtDL0U6EqO7RQOibEoif+a9Vh5u+mLVQmWH/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=L1OKz/qd7uxuQtYP9NtEvJc0+8MXyQH5gb7P3q8vMF4kPu6lX/z2rQJxsnDOKredzHpFxANHI5lmoKDs/VSpgwED14xDtEx5UYL4A/7o9K1enKUkQOvIzY23m5qrP805+07YyNEf73fJPNaESrqp0uKrnjhoIgZh1pdeqKBAjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jLgvOokA; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240912163113epoutp03911be4ab1b954fd55a1ecfab746a61f6~0jCsQ4kwQ0478904789epoutp03r
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240912163113epoutp03911be4ab1b954fd55a1ecfab746a61f6~0jCsQ4kwQ0478904789epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726158673;
	bh=vy7lCYSbdz26N4UI7fqWr6sAhZElmMyKMCnXT+wW9js=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jLgvOokAe+FhuM9YNK3Hy86Su/KXSz86Q+mc3gEvkdWV+q6u/Tnaqp+rXymB/BFjw
	 bmP85s6EXygQ5WqsP0m0CSc/cqRqwH8fMvxwM1aldaQbm+i6CssiiGaBCHSD49lS/S
	 oLz+a0/D/pOsZb9VfD7bIOjddotg/tpy0oJhI/Bc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240912163113epcas5p36c0a7ab9eec20e8b209022fda8ea0c0d~0jCrpc_cZ2285522855epcas5p3S;
	Thu, 12 Sep 2024 16:31:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X4NH338G0z4x9Pp; Thu, 12 Sep
	2024 16:31:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.1E.09640.F4713E66; Fri, 13 Sep 2024 01:31:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240912163110epcas5p400bbdbc9b6fbfcd8fc2cb06119bf1515~0jCpBPquT0871108711epcas5p4d;
	Thu, 12 Sep 2024 16:31:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240912163110epsmtrp2e4b05be92f9a9935b208ffd318ba7ec4~0jCpARmGE2388023880epsmtrp2H;
	Thu, 12 Sep 2024 16:31:10 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-f4-66e3174ffa9a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	37.90.08964.E4713E66; Fri, 13 Sep 2024 01:31:10 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240912163103epsmtip12a8aad761a334eca507fe293432399a7~0jCigBZNm1719617196epsmtip1M;
	Thu, 12 Sep 2024 16:31:02 +0000 (GMT)
Message-ID: <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
Date: Thu, 12 Sep 2024 22:01:00 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
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
In-Reply-To: <20240912130235.GB28535@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRzeubcvZjqvhdlDjROauTlmC8XSXdhgM9vkMkAbh2bTLNDRyyOU
	tukDkSzyENksDhQMmx2kMLCdJY7wHAhNlhbGmDIWGHawMXGULQF5FKIEELXtReW/7/zO953v
	fL9ffiyUU8zksTKVOlKjlCn4jO20Dse+EME73Km0sAEzB2+cKGfgs44lgFctrqL43xPPEHzs
	ZheCf9fYh+BXLn2K4K4mI4o3l7PwqUfLTHzVbGXiFfafAW4b348PX43Fe2wDNNxknmbipc5O
	Bm7p/wvBO9ZNKH59doGGD2300/EhYzXzyIvEyP14YuhxM42oqrjDIEYG9USL9XMG0dqQT3TX
	LiNE91gBg3BPj9OIsjYrIH6q7WUSyy27iBbXHCJlf5B1KIOUyUlNEKlMVckzlenR/PiTyUeT
	IyRhIoEoEj/AD1LKsslo/rEEqeCtTIUnMz8oR6bQe0pSmVbLD405pFHpdWRQhkqri+aTarlC
	LVYLtbJsrV6ZLlSSuihRWFh4hIeYkpXR535IU/+G5T6zcwuAi20AfiyIiaFldI5pANtZHKwb
	wJXaFab3goMtAVhqO0zhPwCcN540AJZP0P00keLbALS0twPqMAdg3fUVxCtgYzHwduld4MU0
	7FXYPvIFnaq/AAe+cdG8eCd2Fq6NVvs4/lg0LL3o9NVRjAvHXSbfOwEYH07PDPoMUMxMg9+6
	hxjeXzCwffBepd7L8cNeh13uIgalfQXemKtGvXyINfnBujU3nYp5DI5P9DAo7A9n+tuYFObB
	5XnbZj0LTj6ZpFH4HOxsLdvUHoYFfz6ge31Rj2/TD6GU1w54cd2FUE1hwwslHIodDB9XTG8q
	ufDXyw10ikLAvsJAqlVjAF5ZNaNfgiDjlq4Yt6Q3bklj/N+4FtCsIJBUa7PTSW2EWqQkP/pv
	2Kmq7BbgW4eQuE4wMbkotAOEBewAslB+ALuC8SSNw5bLPs4jNapkjV5Bau0gwjOer1DezlSV
	Z5+UumSRODJMLJFIxJFvSER8Lnv2sxo5B0uX6cgsklSTmn91CMuPV4CE5xws3DFbfJybtJZ/
	YiDx3rXexurG3DHLc8XStsqzwrkG6Ymo2JRQSZ0Os4uSMIVN0DFzs23ox/O/HOg6lc5JMuSn
	VPaLTV8Hn7Fc2nbKsG1l6ulu2bUbR9+uCeY6FzgXTKO7BJFcU3hRcg2RNzD17l2d47WXl1p0
	VwP3+sc3v8nTx+J505XCT5y7f5+0Xh4W1T9qM1dZWRtCi9q8UOa41a56MPiwJl4KqubPJe5B
	vi9YHI5D69Oel79/vP5MSUKAYOzDjQV2THdEb1mOJuu2Ni7UUMS7ELXep3wvr8RJlzrZCeGI
	o7mx9f6dQkfJwSPFp3P3us+/VF6VtCfl9P6eW3yaNkMmCkE1Wtk/HCMLyJcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCSnK6f+OM0g3n/mS1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbbfs9ntlj3+j2Lxfm/x1ktzs+aw+4g5nH5
	irfH+XsbWTymTTrF5nH5bKnHplWdbB6bl9R77F7wmclj980GNo+PT2+xePRtWcXocWbBEXaP
	z5vkPDY9ecsUwBvFZZOSmpNZllqkb5fAlXH0422WgjcCFc8PiTcwPuHtYuTgkBAwkdj9zLeL
	kYtDSGA3o8TdQ2fYuhg5geLiEs3XfrBD2MISK/89Z4coes0o0XNsDitIglfATuJE9zlGEJtF
	QFVi6+UeqLigxMmZT1hAbFGBJIk99xuZQGxhAVuJ7t7rYHFmoAW3nswHi4sIKEk8fXWWEWQB
	s8AyFomDU94yQWy7ySjxpKedEeRUNgFNiQuTS0EaOAV0JHZ+bGKDGGQm0bW1ixHClpfY/nYO
	8wRGoVlI7piFZN8sJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRnA60
	NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeSWyP0oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRES
	SE8sSc1OTS1ILYLJMnFwSjUwebOyBb/JDznTLcPvbDuvR9roMVdyubRI5AMJzbW39v343S/4
	deec34V/mVZ79rgHsoeFswUed0h4k7lQR+3BgSO5lZw7ZCaYCmYYV6tfZl10sF7X1CCm2X/q
	o1uS958c/CKhtvDwhQXT5v9w9LtUePnp1TRbZgWrRUm//E32PbGV4vMLq3N+KyfYdL//wiuP
	qUbVGU6ZLhxKvKo/X1x8+5D/GktEY780c0546GauZ4qntOUNFzxbutDq3y6GyzIy3K+bG1kZ
	e0XuXphTw3B0s+qcjROUNMNzPp7KZDoacOvjpJ8LdrNzv5ntvGnmjuiQycnPOBmUC65F+1RU
	srLe/yfVLrtp8ymTTgvJoDVKLMUZiYZazEXFiQB3nG6idgMAAA==
X-CMS-MailID: 20240912163110epcas5p400bbdbc9b6fbfcd8fc2cb06119bf1515
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com>
	<20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de>

On 9/12/2024 6:32 PM, Christoph Hellwig wrote:
> On Tue, Sep 10, 2024 at 08:31:59PM +0530, Kanchan Joshi wrote:
>> From: Nitesh Shetty <nj.shetty@samsung.com>
>>
>> The incoming hint value maybe either lifetime hint or placement hint.
> 
> .. may either be .. ?

Sure.

>> Make SCSI interpret only temperature-based write lifetime hints.
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
>>   drivers/scsi/sd.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index dad3991397cf..82bd4b07314e 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -1191,8 +1191,8 @@ static u8 sd_group_number(struct scsi_cmnd *cmd)
>>   	if (!sdkp->rscs)
>>   		return 0;
>>   
>> -	return min3((u32)rq->write_hint, (u32)sdkp->permanent_stream_count,
>> -		    0x3fu);
>> +	return min3((u32)WRITE_LIFETIME_HINT(rq->write_hint),
> 
> No fan of the screaming WRITE_LIFETIME_HINT. 

Macros tend to. Once it becomes lowercase (inline function), it will 
stop screaming.

    Or the fact that multiple
> things are multiplexed into the single rq->write_hint field to
> start with.

Please see the response in patch #1. My worries were:
(a) adding a new field and propagating it across the stack will cause 
code duplication.
(b) to add a new field we need to carve space within inode, bio and 
request.
We had a hole in request, but it is set to vanish after ongoing 
integrity refactoring patch of Keith [1]. For inode also, there is no 
liberty at this point [2].

I think current multiplexing approach is similar to ioprio where 
multiple io priority classes/values are expressed within an int type. 
And few kernel components choose to interpret certain ioprio values at will.

And all this is still in-kernel details. Which can be changed if/when 
other factors start helping.

[1] 
https://lore.kernel.org/linux-nvme/20240911201240.3982856-2-kbusch@meta.com/
[2] 
https://lore.kernel.org/linux-nvme/20240903-erfassen-bandmitglieder-32dfaeee66b2@brauner/

