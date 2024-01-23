Return-Path: <linux-fsdevel+bounces-8542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB014838E49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308531F24D6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C55DF30;
	Tue, 23 Jan 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lpacmLSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D245DF1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012229; cv=none; b=Kd85w7P7FGwIAQDwWJiZxnIxdDJvMWQDxOzziwh86C+5IW6DnIgeJD7HiX2yRSinqh2yrN75u2vuKwwEneOTZYxWJWMRGIsh9Yi7EzMWoh4TZfvw/WQfASmMv1VgYXckBkSygKr0hABduYnqaO++yUKDvrMT1i1CwpFIAQIrGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012229; c=relaxed/simple;
	bh=imzXfzj9Mz2WYh709kompIJxnI7EtSqg5p4gmd8D7u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=U8y4iDaOnXNC74gwjyoHi3utatNYTjr8kbk/am2JTUETECvqlrBOM9S7ArPwTeC8ybKpNM4G/9AHgoeMVxocnj2mYK4Rwx+zzHhv9d9JtVTAc9FFonPTyIvgY/pbyhiFxMa29u9W28ecm3SdP78h6heD42Xl22H1dDZqDSFSBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lpacmLSv; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240123121658epoutp04767fea8981101b34feb8c01341c0deaf~s_RL0N1IO1458614586epoutp04P
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 12:16:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240123121658epoutp04767fea8981101b34feb8c01341c0deaf~s_RL0N1IO1458614586epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706012218;
	bh=VJDSvXJfTACTi00FTu9C3MOUzMWL79ai+VA/vLu2f+s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lpacmLSvdQpRA4ONjiGvEWdBrWPp+xmx/DCmt9fRxQB4e8tdINkqPA2F2qs6ohqGK
	 3f1rp7d7/nhvBG34sSAjJwK/ANTs7IEIKu87a+fRXCIDAJ+BSIgk9wznJ3+93F9Pb1
	 RLjqEy/9B86kXNb1CI+YC6+mSw/JXBy0bTqN6QZc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240123121658epcas5p40610e0760894d467c8a3aa82bb501560~s_RLc8puv0351403514epcas5p4e;
	Tue, 23 Jan 2024 12:16:58 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TK5gD5L65z4x9Pt; Tue, 23 Jan
	2024 12:16:56 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.23.19369.83EAFA56; Tue, 23 Jan 2024 21:16:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240123121656epcas5p46e583609192022c6dca8d75e618e1738~s_RJofRPN0573305733epcas5p4K;
	Tue, 23 Jan 2024 12:16:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240123121656epsmtrp1f198caf7cdf5b3359dc8fa09ef26fd0e~s_RJnlWlQ0683506835epsmtrp1J;
	Tue, 23 Jan 2024 12:16:56 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-bc-65afae38dfee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.1E.08755.83EAFA56; Tue, 23 Jan 2024 21:16:56 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240123121654epsmtip155135df5a224d59190d3e85828ea72d6~s_RH6dVJl2470924709epsmtip1K;
	Tue, 23 Jan 2024 12:16:54 +0000 (GMT)
Message-ID: <4f36fc64-a93b-9b2c-7a12-79e25671b375@samsung.com>
Date: Tue, 23 Jan 2024 17:46:53 +0530
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
In-Reply-To: <edefdfbc-8584-47ad-9cb0-19ecb94321a8@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmhq7FuvWpBt2T1SxW3+1ns3h9+BOj
	xbQPP5kt/t99zmSx6kG4xcrVR5ksfi5bxW6x95a2xZ69J1ksuq/vYLNYfvwfk8X5v8dZHXg8
	Ll/x9rh8ttRj06pONo/dNxvYPD4+vcXi0bdlFaPH501yHpuevGUK4IjKtslITUxJLVJIzUvO
	T8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlVJoSwxpxQoFJBYXKykb2dT
	lF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ1x9ehRloL/HBWHn+1k
	amCczd7FyMEhIWAiceV7SRcjF4eQwB5GiQtLz7NBOJ8YJR6veM0K4XxjlGjuXsrcxcgJ1jGv
	bzM7RGIvo0TjrW4o5y2jxK5pz5hAqngF7CRmvp3ACmKzCKhKtG17ywgRF5Q4OfMJC4gtKpAk
	8evqHLC4sECUxJLJe8E2MAuIS9x6Mp8J5D4RAQ+JW2/8IMI/mCRmXFMECbMJaEpcmFwKYnIK
	WEs8na8CUSEvsf3tHGaQayQEDnBI9L6fzATxpYvExJWKEOcLS7w6voUdwpaSeNnfBmUnS1ya
	eY4Jwi6ReLznIJRtL9F6qp8ZZAwz0Nb1u/QhVvFJ9P5+AjWdV6KjTQiiWlHi3qSnrBC2uMTD
	GUugbA+JTzf7mCDh9JhF4vCHG4wTGBVmIQXJLCSvz0LyzSyEzQsYWVYxSqUWFOempyabFhjq
	5qWWw2M7OT93EyM4GWsF7GBcveGv3iFGJg7GQ4wSHMxKIrw3JNelCvGmJFZWpRblxxeV5qQW
	H2I0BUbORGYp0eR8YD7IK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mD
	U6qBSaJebPuzClHJx+lb4u79b/4iYDlVqZb5d2hDSd2bLwvCw3cVCatfWWp+f/Gewr/J/XH3
	Iw8fvyn9UvBDS05Y65vcy4eOvr24ad82o9Kcs3pcb/87lD075nvRp1i6j8HGILFeZgXbXku1
	3riLYucygzUYVyWq3C+/zRJadnnL11czBJvYMwUy6yslPy5hii9035nteUssac6+SOvrbg96
	/mhzTi5je5pyqa+H9euVT/M/M9y5/87l0rLMXQ0dq6LdTBpEQ/W/7Gpn38/jUjWr1EaiqHdK
	pc4pwQnLzF9ekzb+qPtspsu6TTOWXqrU9t55eN7BngUz/ynv6WC/cKxwy+NHTU+6d+abLL3y
	ZUNFtxJLcUaioRZzUXEiAHwQNRdPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnK7FuvWpBnueclusvtvPZvH68CdG
	i2kffjJb/L/7nMli1YNwi5WrjzJZ/Fy2it1i7y1tiz17T7JYdF/fwWax/Pg/Jovzf4+zOvB4
	XL7i7XH5bKnHplWdbB67bzaweXx8eovFo2/LKkaPz5vkPDY9ecsUwBHFZZOSmpNZllqkb5fA
	lXH16FGWgv8cFYef7WRqYJzN3sXIySEhYCIxr28zkM3FISSwm1Hi0ZaNrBAJcYnmaz+gioQl
	Vv57DlX0mlGiees0FpAEr4CdxMy3E8AaWARUJdq2vWWEiAtKnJz5BKxGVCBJYs/9RiYQW1gg
	SmLJ5L3MIDYz0IJbT+YDxTk4RAQ8JG698QOZzyzwi0mi4fF1qGX3WSQWrt3LCFLEJqApcWFy
	KYjJKWAt8XS+CsQYM4murV2MELa8xPa3c5gnMArNQnLFLCTbZiFpmYWkZQEjyypGydSC4tz0
	3GLDAsO81HK94sTc4tK8dL3k/NxNjODo09Lcwbh91Qe9Q4xMHIyHGCU4mJVEeG9IrksV4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwCTPE73CeoLEqQdu
	Jt1OukYP+VY5TjW4ObusPk8n1eBx+9PakxZ7rtixupybsO5dNGP/VfY3X6PDjn86tInbzNVz
	tdDignsJO5N8Ku6Y60/S5uR/12wt/EZ1QuGbF5U5BpPipjVMiu9YsrAq73Ky18wi6fuf96ty
	z3mYeOvbv1b54qTXTyPdGFbMlswSO8hrb87gP1O0uO/lbb+Pdx5MmpZ0XNxiP6u6uX5ggcX+
	1cIfGzexKueue1V7uGbHsqZVPu4Zc1L+W4nf+84cG7xfKKvuuqd8z875PZW/ne6sEF2foPk2
	9H4e35IlcgeevZa/sybqXeql3ZaWjLL8BSd+LpXad/Vob6jvxvBpOpfW+SuxFGckGmoxFxUn
	AgAxbQ8XLQMAAA==
X-CMS-MailID: 20240123121656epcas5p46e583609192022c6dca8d75e618e1738
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
	<9fa04d79-0ba6-a2e0-6af7-d1c85f08923b@samsung.com>
	<85be3166-1886-b56a-4910-7aff8a13ea3b@samsung.com>
	<edefdfbc-8584-47ad-9cb0-19ecb94321a8@acm.org>

On 1/23/2024 1:39 AM, Bart Van Assche wrote:
> On 1/22/24 01:31, Kanchan Joshi wrote:
>> On 1/19/2024 7:26 PM, Kanchan Joshi wrote:
>>> On 1/19/2024 12:24 AM, Bart Van Assche wrote:
>>>> I think the above proposal would introduce a bug: it would break the
>>>> F_GET_RW_HINT implementation.
>>>
>>> Right. I expected to keep the exact change in GET, too, but that will
>>> not be free from the side-effect.
>>> The buffered-write path (block_write_full_page) picks the hint from one
>>> inode, and the direct-write path (__blkdev_direct_IO_simple) picks the
>>> hint from a different inode.
>>> So, updating both seems needed here.
>>
>> I stand corrected. It's possible to do away with two updates.
>> The direct-io code (patch 8) should rather be changed to pick the hint
>> from bdev inode (and not from file inode).
>> With that change, this patch only need to set the hint into only one
>> inode (bdev one). What do you think?
> 
> I think that would break direct I/O submitted by a filesystem.
> 

By breakage do you mean not being able to set/get the hint correctly?
I tested with XFS and Ext4 direct I/O. No breakage.

