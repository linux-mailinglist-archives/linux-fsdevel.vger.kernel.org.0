Return-Path: <linux-fsdevel+bounces-28198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 465EB967EBA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34BCB2161B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 05:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060A14F9E6;
	Mon,  2 Sep 2024 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rCxTO0L7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C20382
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254324; cv=none; b=Tt2EGGIlyRAZ27Vvyf8Tke8Rr3bTzwaF+xPRql0adpFuFHQ27J7rD2cJEHUawEgzD2fJWOFSvecGDxWA/avUoN+tdvICrcqbt79FfXqn7/Rj2ZJqHTdScqLv4ADIUwfZwHrcagjZfh3rwuqM8Fxety8hXFysSpqtCfsbX5riOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254324; c=relaxed/simple;
	bh=BdjiREE7l/FNldSgz5AseM3MCJoVK1RmC4kNMgchFtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=V+anZk1SgVii3ae0vuDxYDyemrDllUCsuG5nEB/SB2ltdnR+ZKL63D8gUMFjTbFn/2l8x+3AS02ern4eW1r0s2397Emuj5yp46h8ExmByJDC5xXm/WSh9vHruAR0pUo00WO4ucitQGBkqn3F6/uaWKWQLXWsMOYs3auLNscSZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rCxTO0L7; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240902051839epoutp03708ba210224b8a184335695016b30f52~xVamo_CjH2537125371epoutp03V
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 05:18:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240902051839epoutp03708ba210224b8a184335695016b30f52~xVamo_CjH2537125371epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725254319;
	bh=j48tXrfPFLQpQy7ehDudz1ll+W1pF1dhPhX8Mc3nQqc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rCxTO0L7UCcIFdxMmHf8dasIruE4sJkM+JTXoq/XbLrVESVOyEPP+7n3PKTNHm4WZ
	 0713y22C6yeaHHrPuO8vWOATp40SD7nEf9uYWaqiMMbtQl6QPNzwnUAqVYVJ3l9FOx
	 PM6QWs84fHlHYtYIYutJWszH4avkYyo/HMS1QNMs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240902051838epcas5p14c257efc542d4b9a274b9dc4c277d225~xVal_rM6o1678716787epcas5p1Q;
	Mon,  2 Sep 2024 05:18:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wxxqc65zdz4x9Pq; Mon,  2 Sep
	2024 05:18:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.2C.09743.CAA45D66; Mon,  2 Sep 2024 14:18:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240902051836epcas5p39b730254365bd2c759417178d2f6da95~xVajpRyl00854708547epcas5p3D;
	Mon,  2 Sep 2024 05:18:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240902051836epsmtrp1da38afc11821c9b95fb4d33e235eb199~xVajoayr80087300873epsmtrp1j;
	Mon,  2 Sep 2024 05:18:36 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-46-66d54aacd6fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.E4.07567.CAA45D66; Mon,  2 Sep 2024 14:18:36 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240902051833epsmtip1f4f6ade22e4a2ede413b18d72ce57cef~xVagrBjGC2920229202epsmtip1s;
	Mon,  2 Sep 2024 05:18:32 +0000 (GMT)
Message-ID: <3343ecc2-6c19-e509-5f17-ceaa4f88efae@samsung.com>
Date: Mon, 2 Sep 2024 10:48:31 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] fs, block: refactor enum rw_hint
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <0cfd7841-ea11-48c6-93fb-7817236c81c8@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJsWRmVeSWpSXmKPExsWy7bCmpu4ar6tpBnv6tS1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbrXr9nsTg/aw67g4jH5SveHufvbWTxmDbp
	FJvH5bOlHptWdbJ5bF5S77F7wWcmj903G9g8Pj69xeLRt2UVo8eZBUfYPT5vkgvgicq2yUhN
	TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAF6UkmhLDGnFCgU
	kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfHl3yH2
	gpksFWeu32JsYFzB3MXIySEhYCJx8sUC9i5GLg4hgd2MEv/W3GKCcD4xSnTPmMcG4XxjlPh4
	ajUjTEvLn5ksEIm9jBLHV39gA0kICbxllPjfGwti8wrYSWz6shWogYODRUBF4uvVIIiwoMTJ
	mU9YQGxRgSSJX1fngM0UFrCR2Ph7FdhJzALiEreezAe7QkRgKpPEgT8tYMuYQea/nrWAGWQo
	m4CmxIXJpSANnALWEsdOvYJqlpdo3jqbGaReQmA6p8TPG90sEFe7SDxfuR/qaWGJV8e3sEPY
	UhIv+9ug7GyJB48eQNXXSOzY3McKYdtLNPy5wQqylxlo7/pd+hC7+CR6fz9hAglLCPBKdLQJ
	QVQrStyb9BSqU1zi4YwlULaHxOVfy6Hh9o5Rov3JTpYJjAqzkMJlFpL/ZyF5ZxbC5gWMLKsY
	JVMLinPTU4tNC4zyUsvhEZ6cn7uJEZwHtLx2MD588EHvECMTB+MhRgkOZiUR3qV7LqYJ8aYk
	VlalFuXHF5XmpBYfYjQFxs9EZinR5HxgJsoriTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEk
	NTs1tSC1CKaPiYNTqoEp6mTPe+2fi6JPnXmmNNljf2fPniXNGsF3aq47fS5suD9pN89n723b
	f4Qcm/nK1G1TVAdv7Xf5QNeOjWJXmU7vj+qRdXc+0PK67ahJyl6R/20t/noT1eq829cKm6bs
	Pyr4UGsbt96CwJ99kQ1BsycZ7XhSw7ND4RNrd3s7T9jGOfkJp55t/R7GtZstWkZHJfv/coMb
	e7Qu8PGazFH88kn2xa+3ry+eLnK/Oc3+QLuOm0iO6/WCf75lfEv3dVyekvn2wmv+72+nWMjJ
	6J7nNGIoDefh2a9usO+e2YbFAk96Mk+/5J3ReNUrY5rsnWzDAoH9q/aLcl33+DflvM06n4XG
	adzqGywf5CzJaW/JNRdVYinOSDTUYi4qTgQAYNIahYwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7bCSnO4ar6tpBtc3s1usvtvPZvH68CdG
	i2kffjJb/L/7nMni5oGdTBYrVx9lspg9vZnJ4sn6WcwWG/s5LB7f+cxu8XPZKnaLSYeuMVrs
	vaVtcWmRu8WevSdZLOYve8pu0X19B5vF8uP/mCzWvX7PYnF+1hx2BxGPy1e8Pc7f28jiMW3S
	KTaPy2dLPTat6mTz2Lyk3mP3gs9MHrtvNrB5fHx6i8Wjb8sqRo8zC46we3zeJBfAE8Vlk5Ka
	k1mWWqRvl8CV8eXfIfaCmSwVZ67fYmxgXMHcxcjJISFgItHyZyYLiC0ksJtRomu1GURcXKL5
	2g92CFtYYuW/50A2F1DNa0aJxw3nmUASvAJ2Epu+bGXsYuTgYBFQkfh6NQgiLChxcuYTsJmi
	AkkSe+43gpULC9hIbPy9CmwvM9D8W0/mM4HMFBGYyiSx8sVVsAXMAm8ZJVoPHGGB2PaOUeLy
	wVvMIBvYBDQlLkwuBenmFLCWOHbqFdQkM4murV2MELa8RPPW2cwTGIVmITlkFpKFs5C0zELS
	soCRZRWjZGpBcW56brJhgWFearlecWJucWleul5yfu4mRnDMa2nsYLw3/5/eIUYmDsZDjBIc
	zEoivEv3XEwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1Oq
	gSm31EDtqie79SJx27+567d0x+9nKnY855R8YEvz7Hseq70UJ0ml5ziZuu0SnpNrPfXgBOfY
	LWxiR5buDf64VVOqaJfudYtyw3YRn0MvUrZdfd5QnqZoZKOx9tTO6jgRfrsTCoLc/30kC2Kj
	GE6daZyyTjBaufXrlDJVLY87HXMvFaYs5rasuTztfn7XxYy6U9E584RnnY1l67h5eYve9G5L
	ruZFPsHKPd+Pnjfbvia2VKvKxPzE7MINluWvvT5v235pwm+uHkd1C+GI18o37f4+UVln9se8
	4Ne7L3G6lq/dJH8+feC7Kd1umvu2svO/YmZ2RpzheNdpGve5ZmHVht0r2/znrDgX767Bz/tx
	hRJLcUaioRZzUXEiAMk9H9loAwAA
X-CMS-MailID: 20240902051836epcas5p39b730254365bd2c759417178d2f6da95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5@epcas5p3.samsung.com>
	<20240826170606.255718-2-joshi.k@samsung.com>
	<0cfd7841-ea11-48c6-93fb-7817236c81c8@acm.org>

On 8/30/2024 5:47 PM, Bart Van Assche wrote:
> On 8/26/24 1:06 PM, Kanchan Joshi wrote:
>>   /* Block storage write lifetime hint values. */
>> -enum rw_hint {
>> +enum rw_life_hint {
> 
> The name "rw_life_hint" seems confusing to me. I think that the
> name "rw_lifetime_hint" would be a better name.
> 

I can change to that in next iteration.
This change needs to be consistent in all the places. But more important 
in patch #3 (as we expose TYPE_RW_LIFE_HINT to userspace). Do you have 
comments on the other parts?

