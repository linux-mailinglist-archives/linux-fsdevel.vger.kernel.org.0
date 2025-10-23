Return-Path: <linux-fsdevel+bounces-65304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753FC00D23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED4C0501B81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB330DEB2;
	Thu, 23 Oct 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CQZ66iSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DA30BB81
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219715; cv=none; b=AQ0Yc5/NZyGKIp2xYPANJGcXOYtA+Y1Nln6oXA30rIafOk1zSCormo+sbJjxAQoSenFk8vc/A49C5q37K0NAzlbc5329xHV8oclYDBwVVYA4QZEo88TQhz5bvaJyKiqexBh5afIYugIZTVB7GSoZrHZIAawFomm84Qgc7rt8w+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219715; c=relaxed/simple;
	bh=yAU8SANMviwuHmsErc/rikdhHx00oY4QFmNUYec28q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TvKkiUJ+He9sq9vgOmq0VyEFegJK1CDyCak/5J+cMmXP3sQ9rRsa1/1UZO2X0a2x3lGDkDWR4COuRO0E6FY8gPbtjuiN5jylfsYh9cHvgbGkZdXycMrOpZuuvUEzM8ev79Zd1xvwzfbd9yWj07IvqxRaCJNQ5BBRi9aI4lyMUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CQZ66iSY; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251023114145epoutp021fe0e8af83761a6ccfc0551a8cfa0450~xG-2orDQY1530715307epoutp02R
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 11:41:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251023114145epoutp021fe0e8af83761a6ccfc0551a8cfa0450~xG-2orDQY1530715307epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761219705;
	bh=N+oN6QIkhg+yxG+jofXiwToGHW0SdPwLgjc3KiwgdQg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CQZ66iSYqNmHIJkk+0ZfYZ6mI08ULjkdlQ2Gb9uroSSh4A/ksYaZoznFo38EuldpN
	 Pmev3HPm6H3BdGroe6RJS8mWtP3FGeyhi9EH8wCaMFqggcHAjUosc196egoDvoXfOW
	 1d/8tMTtEuQQIK5VON5bdvQ9G1SER5CLfXjMrlvI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251023114144epcas5p4915a81068b8c2110682c4ce6ea36272e~xG-157QXg0607706077epcas5p41;
	Thu, 23 Oct 2025 11:41:44 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cskdg5VR5z2SSKZ; Thu, 23 Oct
	2025 11:41:43 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251023114142epcas5p10a1abeff9e1326fc9c846001906c9986~xG-0B0nat0254002540epcas5p1U;
	Thu, 23 Oct 2025 11:41:42 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251023114136epsmtip1a3b96a88ae62950abac3f8a8a7dd3abc~xG-uRBGdX1343713437epsmtip1Q;
	Thu, 23 Oct 2025 11:41:36 +0000 (GMT)
Message-ID: <81330754-1aee-4807-a982-1fed37c016af@samsung.com>
Date: Thu, 23 Oct 2025 17:11:36 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, jaegeuk@kernel.org, chao@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <bfpv6jrjo4avzk76ex77dwpzaejglu5gsf2pqpmmgwrmqdkkk3@imsbtnrcelee>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251023114142epcas5p10a1abeff9e1326fc9c846001906c9986
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
	<20251014120845.2361-1-kundan.kumar@samsung.com>
	<aPa7xozr7YbZX0W4@dread.disaster.area>
	<6fe26b74-beb9-4a6a-93af-86edcbde7b68@samsung.com>
	<bfpv6jrjo4avzk76ex77dwpzaejglu5gsf2pqpmmgwrmqdkkk3@imsbtnrcelee>

On 10/21/2025 5:41 PM, Jan Kara wrote:
> On Tue 21-10-25 16:06:22, Kundan Kumar wrote:
>> Previous results of fragmentation were taken with randwrite. I took
>> fresh data for sequential IO and here are the results.
>> number of extents reduces a lot for seq IO:
>>     A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
>>           Base XFS                : 1
>>           Parallel Writeback XFS  : 1
>>
>>     B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
>>           Base XFS                : 4
>>           Parallel Writeback XFS  : 3
>>
>>     C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
>>           Base XFS                : 4
>>           Parallel Writeback XFS  : 4
> 
> Thanks for sharing details! I'm curious: how big differences in throughput
> did you see between normal and parallel writeback with sequential writes?
> 
> 								Honza

Thank you for the review, Jan.

I found that the IOPS for sequential writes on NVMe SSD were similar
for both normal and parallel writeback. This is because the normal
writeback already maxes out the device's capacity. To observe the
impact of parallel writeback on IOPS with sequential writes, I
conducted additional tests using a PMEM device. The results, including
IOPS and fragmentation data, are as follows:

A) Workload 6 files each 1G in single directory(AG)      - numjobs = 1
     Base XFS           : num extents : 1 : 6606 MiB/s
     Parallel writeback : num extents : 1 : 6729 MiB/s - No change

B) Workload 12 directories(AGs) each with 12 files of 1G - numjobs = 12
     Base XFS           : num extents : 4 : 4486 MiB/s
     Parallel writeback : num extents : 5 : 12.9 GiB/s - +187%

C) Workload 6 directories(AGs) each with one 20G file    - numjobs = 6
     Base XFS           : num extents : 7 : 3518 MiB/s
     Parallel writeback : num extents : 6 : 6448 MiB/s - +83%

Number of CPUs = 128
System RAM = 128G
PMEM device size = 170G

