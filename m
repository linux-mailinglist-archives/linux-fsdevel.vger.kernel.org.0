Return-Path: <linux-fsdevel+bounces-8300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F9832831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 11:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFDD1F21B58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D54F218;
	Fri, 19 Jan 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NT+o9HMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A794F1E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661408; cv=none; b=m8E3gOoT6rN/RdG7bEF+/yKtVy/lF1mbzKQI8OVwt0CguqHYVkg9m8oZzkwjuyHJXabwhgCMTmqo2LxD6ka3tqeUBCoYu21NLVppkkCs9WHyedoqyLrYj1MmpiXDFan4lPaR6bLsJ+DLjnuK5GAV2dbSVQYujKi3zq7Pdpk/nus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661408; c=relaxed/simple;
	bh=tGoB7JeJrVvsEO8FAhtOIEoP4bkRyys9m96tlqrusD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=t6M+sOQ2vMajIRwhKj9T6BmWuhcisCShp1CMoXZU0/MpeP5p9zjXAQzPWWYfITSHkIufVmqXAiRJv3supMg1UmJfW6AeBInaCjNTxeCEzqY6R7F997az4RB9qJr2IYaG9nMeXEzPt1A6etcMJwI2kZYAj7vXd3EIEv5jtbtFGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NT+o9HMi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240119105002epoutp02daab275c894be67fddc0c90127bea5ab~rugImFvle3065530655epoutp02C
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 10:50:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240119105002epoutp02daab275c894be67fddc0c90127bea5ab~rugImFvle3065530655epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705661402;
	bh=F3DPTfqKO7hJD5IqJwz2IGnFSpfgUj5ecIVPSn9tXe0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NT+o9HMiGneVmqdcK4gfYTf9r+p1dUR/9t83lKeBPX4o0WHRo/drcPUfFqK8A6Ejw
	 ZuLvUCwHHKH1gemXQVwaIK1EYAXt6QymuBChl1jGko9/L8YLu8U3jbjrJK9tJqIKWU
	 /PIcsg1dO07JhkM5xJcFLWfdST1S9cDU68SOOz/s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240119105001epcas5p48d96cc15144303fe7e908c37f86fb2b4~rugIAGYJy1260212602epcas5p41;
	Fri, 19 Jan 2024 10:50:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TGbwl6tzXz4x9Pr; Fri, 19 Jan
	2024 10:49:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CD.F6.10009.7D35AA56; Fri, 19 Jan 2024 19:49:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240119104959epcas5p21b6dab5c92adcd46851961ec97a70689~rugF3_jdj2795227952epcas5p2X;
	Fri, 19 Jan 2024 10:49:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240119104959epsmtrp127ed211a9df8f2af6d9b60c32ed19dc6~rugF3NY_71402214022epsmtrp1O;
	Fri, 19 Jan 2024 10:49:59 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-9b-65aa53d78f4c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.C6.18939.7D35AA56; Fri, 19 Jan 2024 19:49:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240119104957epsmtip27650c67e90444a664caf57d1862b8f53~rugEO3WZk2153321533epsmtip2y;
	Fri, 19 Jan 2024 10:49:57 +0000 (GMT)
Message-ID: <88fd90f6-41c4-99d1-0b4a-d65221c3fb04@samsung.com>
Date: Fri, 19 Jan 2024 16:19:56 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
	<javier.gonz@samsung.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	lsf-pc@lists.linux-foundation.org, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, slava@dubeiko.com, Bart Van Assche
	<bvanassche@acm.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ZahL6RKDt/B8O2Jk@dread.disaster.area>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmlu714FWpBn/aTC2mH1a0mPbhJ7PF
	lmP3GC0e3/nMbrH3lrbFnr0nWSzmL3vKbtF9fQebxb7Xe5ktPl1eCCS2zGZy4Pa4fMXb49GT
	g6weB9e/YfE4tUjCY/OSeo/JN5YzevRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3
	cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCRSgpliTmlQKGAxOJiJX07m6L80pJUhYz8
	4hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjKuvl7EX3OKveN7YytzAeJuni5GD
	Q0LAROLa25QuRi4OIYHdjBLX9j1khXA+MUpsOnCREc7Z8+4pSxcjJ1jHgo9z2CASOxkl5v6+
	ygLhvGWU2PFqORtIFa+AncTFxwfAbBYBVYnO6ytYIOKCEidnPgGzRQWSJH5dncMIcoewQI5E
	+xRvkDCzgLjErSfzmUBsEYEUid/r9oLNZxY4yiSx8PsZZpB6NgFNiQuTS0FqOAWMJeY+72OE
	6JWXaN46mxni0C0cEtuPhEHYLhJd3a1QcWGJV8e3sEPYUhIv+9ug7GSJSzPPMUHYJRKP9xyE
	su0lWk/1g61lBlq7fpc+xCo+id7fT5ggocgr0dEmBFGtKHFv0lNWCFtc4uGMJVC2h8SHJxPB
	NgkJ3GCS2Pm/ZAKjwiykMJmF5PlZSJ6ZhbB4ASPLKkbJ1ILi3PTUYtMCo7zUcnhsJ+fnbmIE
	J2Atrx2MDx980DvEyMTBeIhRgoNZSYSXX3VVqhBvSmJlVWpRfnxRaU5q8SFGU2DkTGSWEk3O
	B+aAvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamHxiPK3v/Ol0
	LdNsmf81MDmqzMvvgN7V5G6G5puB0XEbpjb72nk+fcfyq3Kp39faxd/MS/oSrjFeZJusmtUs
	r2+lXqIlsP7iaq7kpP+qky4qzPO42i7cJDHV9Gj/hxVfRa+u62N62mMc6t1/t26HlMjsdzKs
	AVd/v/y/76WewqrjM9vkMvZbsR5XWbzap6zi/zP1fTHZDfuvZy5ZwtLx6OPD67N5p4esLdY8
	avu/oPLNei6BRYubZinMsGB//37qyzkP0kMOxgmsX3Avnu+LsNvpl9u8orVVJBosMmquBR6O
	lym793Ru21zdVfGOCR0HvcoinZmfZxxtUr24/H8048T3do3NB6X4pOp+XP13UYmlOCPRUIu5
	qDgRALYbOaJJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO714FWpBrtW81lMP6xoMe3DT2aL
	LcfuMVo8vvOZ3WLvLW2LPXtPsljMX/aU3aL7+g42i32v9zJbfLq8EEhsmc3kwO1x+Yq3x6Mn
	B1k9Dq5/w+JxapGEx+Yl9R6Tbyxn9OjbsorR4/MmuQCOKC6blNSczLLUIn27BK6Mq6+XsRfc
	4q943tjK3MB4m6eLkZNDQsBEYsHHOWxdjFwcQgLbGSUW3lrHDJEQl2i+9oMdwhaWWPnvOTtE
	0WtGiQNL28CKeAXsJC4+PsAGYrMIqEp0Xl/BAhEXlDg58wmYLSqQJLHnfiNTFyMHh7BAjkT7
	FG+QMDPQ/FtP5jOB2CICKRItX2aDzWcWOMokMf3yVWaIZTeYJCat+8IO0swmoClxYXIpSAOn
	gLHE3Od9jBCDzCS6tnZB2fISzVtnM09gFJqF5IxZSPbNQtIyC0nLAkaWVYyiqQXFuem5yQWG
	esWJucWleel6yfm5mxjBsaYVtINx2fq/eocYmTgYDzFKcDArifDyq65KFeJNSaysSi3Kjy8q
	zUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamCasXFCwfuO7beevCq8wmW//KNe
	sqHhF5bZW6KP5OTLpWpEf9k+YfbVB2ZfJr3fHX7GTW1L4zk+t3QTb9nz82Tu8Vb8Kv+5perR
	+49H6ux+/DMtfmF4T+9ZUl3b9U2le2bm2d450Kq8eHKi5cW8oIou/nU/5z+dwjCzt7h5aanw
	hai/UZMuSG3g//qOYaXbyQeOAdqTkuQEJEWsL9SJZt+f0FJX0nTPgvf4qQJredf7qTeTD+nc
	DRbdm1Ms2M90eabbQp0nYl9XL0m3fnS3hpGx7XrmOufW6H3rljp8fXE14ZNQVv+cBU78Ptrr
	WBreV7/xm+1af4dDe+vU5Cd9yzv6n8y2NPh1XOi84X0N47OPlViKMxINtZiLihMBx+t5mSQD
	AAA=
X-CMS-MailID: 20240119104959epcas5p21b6dab5c92adcd46851961ec97a70689
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
	<20240115084631.152835-1-slava@dubeyko.com>
	<20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
	<86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
	<20240117115812.e46ihed2qt67wdue@ArmHalley.local>
	<ZahL6RKDt/B8O2Jk@dread.disaster.area>

On 1/18/2024 3:21 AM, Dave Chinner wrote:
> On Wed, Jan 17, 2024 at 12:58:12PM +0100, Javier González wrote:
>> On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
>>>> On Jan 15, 2024, at 8:54 PM, Javier González <javier.gonz@samsung.com> wrote:
>>>>> How FDP technology can improve efficiency and reliability of
>>>>> kernel-space file system?
>>>>
>>>> This is an open problem. Our experience is that making data placement
>>>> decisions on the FS is tricky (beyond the obvious data / medatadata). If
>>>> someone has a good use-case for this, I think it is worth exploring.
>>>> F2FS is a good candidate, but I am not sure FDP is of interest for
>>>> mobile - here ZUFS seems to be the current dominant technology.
>>>>
>>>
>>> If I understand the FDP technology correctly, I can see the benefits for
>>> file systems. :)
>>>
>>> For example, SSDFS is based on segment concept and it has multiple
>>> types of segments (superblock, mapping table, segment bitmap, b-tree
>>> nodes, user data). So, at first, I can use hints to place different segment
>>> types into different reclaim units.
>>
>> Yes. This is what I meant with data / metadata. We have looked also into
>> using 1 RUH for metadata and rest make available to applications. We
>> decided to go with a simple solution to start with and complete as we
>> see users.
> 
> XFS has an abstract type definition for metadata that is uses to
> prioritise cache reclaim (i.e. classifies what metadata is more
> important/hotter) and that could easily be extended to IO hints
> to indicate placement.

That sounds very useful.

> We also have a separate journal IO path, and that is probably the
> hotest LBA region of the filesystem (circular overwrite region)
> which would stand to have it's own classification as well.

In the past, I saw nice wins after separating the journal in XFS and 
Ext4 [1]. This is low-effort, high-gain item.

[1]https://www.usenix.org/system/files/conference/fast18/fast18-rho.pdf

