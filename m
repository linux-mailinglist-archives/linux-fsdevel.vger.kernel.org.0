Return-Path: <linux-fsdevel+bounces-8401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6449835E3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C341C21B51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418239ADE;
	Mon, 22 Jan 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GJefkC1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0A39ACD
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915919; cv=none; b=K6seONZONtfykEllu0YJEvAbVQv3PhDUWwNOHqgDaeHFish7hNBNIcbI0Khf+MRrOy+f+Rk9m+It3V6QQkGygf/2FEFsNXR9wIPie4HBXX9xLdYWR9wIZtS9TJWz1rgP/Dq/hPp6K0wYQ0ykPaV0z8O/lMcuAcAfMf+Dgao9TmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915919; c=relaxed/simple;
	bh=Lfr82Fnth4Mk+rcFRQy9knLdb7m8SMc+4M01JliXsXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=BGiLGKpuakACpidtZFgbhnMveLwj2+ISZ1gfLl+AwRNMdBGT1AIMo19LNOA0G97p2pKwwTBx1N/MN1Z/IXh+k+1y4P3NscXvra1F3mnUayaT/+rG0PXU/dHs+R4UIU3JLB4QyS2Pc3D3/miUZjkNep6smgWhn0quGNpDn1n8oSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GJefkC1T; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240122093154epoutp04bffc1a38874ce0d15b35d85768458f94~soXxhYOKb2418024180epoutp04R
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 09:31:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240122093154epoutp04bffc1a38874ce0d15b35d85768458f94~soXxhYOKb2418024180epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705915914;
	bh=GV2tQQgiZaNmvp2+JB7Yud6Btg8vLHCkS5jyGrUxZfk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GJefkC1T5lRmUXEcLgmd5c69lYr8mw/69zErxrl731HfLgGS7+PeEAHeTalyTP7wQ
	 SSvb1xsMVu5+5mLU8N1k0+6aV2Xjr/RgRP0iF5kYP9Twz1dFemIb5jfIIfLeuWhKAr
	 t8Rggk2sAJgasbGbzuZxQcFPdMJAJg0Z9aKIM+P8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240122093153epcas5p1c5743e793b110dc6392d85abb6bdda17~soXw47HPz2251022510epcas5p1R;
	Mon, 22 Jan 2024 09:31:53 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TJQ3C5Hqdz4x9Q1; Mon, 22 Jan
	2024 09:31:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.BA.08567.7063EA56; Mon, 22 Jan 2024 18:31:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240122093151epcas5p2e032680a61f4ec16dc7d5a673fe179ed~soXuWsvtF2485624856epcas5p2r;
	Mon, 22 Jan 2024 09:31:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240122093151epsmtrp15a662e156f6a0bfb6c1f2c20593709f3~soXuV-eT00622206222epsmtrp15;
	Mon, 22 Jan 2024 09:31:51 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-5d-65ae36077b44
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.1A.08755.6063EA56; Mon, 22 Jan 2024 18:31:50 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240122093149epsmtip218553fe229c75c443b2a5b17f8c6b45d~soXslkvkm1156211562epsmtip2K;
	Mon, 22 Jan 2024 09:31:49 +0000 (GMT)
Message-ID: <85be3166-1886-b56a-4910-7aff8a13ea3b@samsung.com>
Date: Mon, 22 Jan 2024 15:01:48 +0530
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
From: Kanchan Joshi <joshi.k@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Daejun Park
	<daejun7.park@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9fa04d79-0ba6-a2e0-6af7-d1c85f08923b@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmui672bpUg91HNCxW3+1ns3h9+BOj
	xbQPP5kt/t99zmSx6kG4xcrVR5ksfi5bxW6x95a2xZ69J1ksuq/vYLNYfvwfk8X5v8dZHXg8
	Ll/x9rh8ttRj06pONo/dNxvYPD4+vcXi0bdlFaPH501yHpuevGUK4IjKtslITUxJLVJIzUvO
	T8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlVJoSwxpxQoFJBYXKykb2dT
	lF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ1x/mgfe8EroYortz+z
	NDDe4+9i5OSQEDCRWDuvk6WLkYtDSGA3o8S3BX2sEM4nRokTj1cwg1QJCXxjlGhuLOpi5ADr
	6NsRBFGzl1Hi1br3UN1vGSX+9P9nBGngFbCT2PJyO5jNIqAq8fPdTRaIuKDEyZlPwGxRgSSJ
	X1fngNUIC0RJLJm8F2wZs4C4xK0n85lAlrEJaEpcmFwKYooIeEjceuMHUfGDSWLGNUUQm1PA
	XmJ/ZzMLRFxeonnrbGaIx45wSKz+qwJhu0j83vaDDcIWlnh1fAs7hC0l8bK/DcpOlrg08xwT
	hF0i8XjPQSjbXqL1VD8zyAnMQNes36UPsYpPovf3EyZIiPBKdLQJQVQrStyb9JQVwhaXeDhj
	CZTtIfHpZh8TJKD+Mku8WniTbQKjwiykMJmF5PdZSL6ZhbB5ASPLKkbJ1ILi3PTUZNMCw7zU
	cnhkJ+fnbmIEp2Itlx2MN+b/0zvEyMTBeIhRgoNZSYT3huS6VCHelMTKqtSi/Pii0pzU4kOM
	psDImcgsJZqcD8wGeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1
	MIl3HQ7ZvlLkjlaYiUdbpNFByZiLjI+vLNtvIliRdOpGS1fFQqn+yuCznPy/OrTq3G4b/vhl
	9XyX67SEBu4vqVO4fmnWFDR7M6TFbHV6ySfuUbJW8cf2eEZf9/mLFhZJvW4xYmWN1+coqWHN
	7ezhezHl82qNKS2LLs/5tG/S/Fj5V4bz7l8y0PNXDj3DdDa158aFkMKQef/22rY+fSw+d27U
	aubyDTeTfH7IP5qeP3X7/ytvLT//f9Mvu0m/qujzlF7Bu893bv74qmmnOnvBfZ89NX7hN06l
	KCbGWMuevfB8rfnnJpYj/QIfRR9Nf+K46eu/QxIs9eKflLfmJIfwqyQffrfpTfzOp6+Xu3Ba
	HVViKc5INNRiLipOBAClUBUOTgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvC6b2bpUg/drLS1W3+1ns3h9+BOj
	xbQPP5kt/t99zmSx6kG4xcrVR5ksfi5bxW6x95a2xZ69J1ksuq/vYLNYfvwfk8X5v8dZHXg8
	Ll/x9rh8ttRj06pONo/dNxvYPD4+vcXi0bdlFaPH501yHpuevGUK4IjisklJzcksSy3St0vg
	yjh/tI+94JVQxZXbn1kaGO/xdzFycEgImEj07QjqYuTiEBLYzSixvOcsaxcjJ1BcXKL52g92
	CFtYYuW/5+wQRa8ZJd50HmYCSfAK2ElsebmdEcRmEVCV+PnuJgtEXFDi5MwnYLaoQJLEnvuN
	YPXCAlESSybvZQaxmYEW3HoynwnkCDYBTYkLk0tBTBEBD4lbb/xAVjEL/GKSaHh8HWrvT2aJ
	KSu72EB6OQXsJfZ3NrNAzDGT6NraxQhhy0s0b53NPIFRaBaSM2YhWTcLScssJC0LGFlWMUqm
	FhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER5+W5g7G7as+6B1iZOJgPMQowcGsJMJ7Q3Jd
	qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQYmq6eeUWzp
	JeY75rf7MefbuqRNzt5ybbPrFtFCuz2iS3Tna08WPu50JDWrjE157dIlXEXvTsQtOtF0vuv9
	jdbpgR+3BnY5lrO53GqJCTBcODfc4e0f6diKrUpvOW/t5w1+HT3HZs8+Sa+1wapv+exnm62M
	kQt5a/imTfrxdOHrIjw/Fs1/u+gLQ1iGpLVtWpQm29JPjQ/LSs0SpM/tmfLp/JwKpt57Hpvq
	+aMOTuSMTplZIGURXfP0v3Bz0k07v+/+qUnM0kvCmt5tLm5irf22n8vrw5MvPqf59r6x3Vyr
	ZHJh/bf9e1RlJsVVbQnv/TojdUXI6rUFZ22T75Uqn116pnuTydrr978YybXp3Q9VYinOSDTU
	Yi4qTgQAB8xnWC0DAAA=
X-CMS-MailID: 20240122093151epcas5p2e032680a61f4ec16dc7d5a673fe179ed
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

On 1/19/2024 7:26 PM, Kanchan Joshi wrote:
> On 1/19/2024 12:24 AM, Bart Van Assche wrote:
>> On 1/18/24 10:51, Kanchan Joshi wrote:
>>> Are you considering to change this so that hint is set only on one inode
>>> (and not on two)?
>>> IOW, should not this fragment be like below:
>>>
>>> --- a/fs/fcntl.c
>>> +++ b/fs/fcntl.c
>>> @@ -306,7 +306,6 @@ static long fcntl_get_rw_hint(struct file *file,
>>> unsigned int cmd,
>>>     static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>>>                                  unsigned long arg)
>>>     {
>>> -       void (*apply_whint)(struct file *, enum rw_hint);
>>>            struct inode *inode = file_inode(file);
>>>            u64 __user *argp = (u64 __user *)arg;
>>>            u64 hint;
>>> @@ -316,11 +315,15 @@ static long fcntl_set_rw_hint(struct file *file,
>>> unsigned int cmd,
>>>            if (!rw_hint_valid(hint))
>>>                    return -EINVAL;
>>>
>>> +       /*
>>> +        * file->f_mapping->host may differ from inode. As an example
>>> +        * blkdev_open() modifies file->f_mapping
>>> +        */
>>> +       if (file->f_mapping->host != inode)
>>> +               inode = file->f_mapping->host;
>>> +
>>>            inode_lock(inode);
>>>            inode->i_write_hint = hint;
>>> -       apply_whint = inode->i_fop->apply_whint;
>>> -       if (apply_whint)
>>> -               apply_whint(file, hint);
>>>            inode_unlock(inode);
>>
>> I think the above proposal would introduce a bug: it would break the
>> F_GET_RW_HINT implementation.
> 
> Right. I expected to keep the exact change in GET, too, but that will
> not be free from the side-effect.
> The buffered-write path (block_write_full_page) picks the hint from one
> inode, and the direct-write path (__blkdev_direct_IO_simple) picks the
> hint from a different inode.
> So, updating both seems needed here.

I stand corrected. It's possible to do away with two updates.
The direct-io code (patch 8) should rather be changed to pick the hint 
from bdev inode (and not from file inode).
With that change, this patch only need to set the hint into only one 
inode (bdev one). What do you think?

