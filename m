Return-Path: <linux-fsdevel+bounces-40490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70AA23E23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 14:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E8C163A99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483671C3BF9;
	Fri, 31 Jan 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IRCrVGRa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E741C245C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329081; cv=none; b=aXmq0mK8sJFNBK+JTdllgvthvZYuZxOoh/Hjd+HD01zzPnJgb7Z6c/CEVlGkgFHsuiCljyp5GoSH8SiW0SC0L6nKy6SuHy5XSR5XtIxy0NbfGR04rDxU9OnRkyuHmMrh6pso5H7VS1+tjIh3BMAOtFqX7M8Rom03J3gwDbbpfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329081; c=relaxed/simple;
	bh=LZGSTGyPYKuePoSMcqCKlxfYS+MScEGdpk1BF3pNv2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oa//s9toJ0i/YVH6ywfhlz8jfgxkUULQalMrNcJ5FxHLNG4URF4vL7sq4ed0bae4aANqDm2hv4B381fcm+tccKPJkhCws0XLVefwRucEroNZ7NwTpWlPHf2fhNdZxhKy+O85knKcnc7306lWgy1xCeiYWXwkxWwWVP1mWEPhMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IRCrVGRa; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250131131116epoutp0145400dfcff9522aae05f2bb357380af5~fyRXaUSZh0504405044epoutp01J
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 13:11:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250131131116epoutp0145400dfcff9522aae05f2bb357380af5~fyRXaUSZh0504405044epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738329076;
	bh=YPz+mnqDAuRhGxytNtDUw+AGJf9uG05dBV7mBgFPIKU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IRCrVGRa6VS9kX6aIc6NydUxFpJieh136u3IO68XyvcNoPXNALZAUkIWUMtLgCNO/
	 Psou2bDZvqiFTwBMYoEXilZ7GJW0uUuppktX15Sq/T95RyWnGmVlm9pkc7A1RvbP3F
	 hJURz1a1G50AxantaFlineDgZ0k6jgaPP8Od9zKo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250131131116epcas5p271bc8ad5d1711023c4b2d089800fcf9f~fyRXGK7j81952019520epcas5p2K;
	Fri, 31 Jan 2025 13:11:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Ykx9G5Mhgz4x9Pv; Fri, 31 Jan
	2025 13:11:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.E3.19956.2FBCC976; Fri, 31 Jan 2025 22:11:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250131131114epcas5p1b067a3bba165e1c0bf17d0326546282d~fyRVLeJBw0442704427epcas5p1w;
	Fri, 31 Jan 2025 13:11:14 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250131131114epsmtrp201e3e29812477ac3dc894c62795c1af3~fyRVK5I_d0528805288epsmtrp2i;
	Fri, 31 Jan 2025 13:11:14 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-54-679ccbf2ae18
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.FE.33707.2FBCC976; Fri, 31 Jan 2025 22:11:14 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250131131113epsmtip2c6fd8f56e41d50bcffd6222c053ed5dc~fyRUAnqkL2324023240epsmtip2z;
	Fri, 31 Jan 2025 13:11:13 +0000 (GMT)
Message-ID: <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
Date: Fri, 31 Jan 2025 18:41:12 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, josef@toxicpanda.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250130142857.GB401886@mit.edu>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmlu6n03PSDU5N0bL489DQYu8tbYtL
	j1ewW+zZe5LFYv6yp+wW+17vZbZo7fnJ7sDusXlJvcfkG8sZPZrOHGX2mLB5I6vH501yAaxR
	2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcoKZQl
	5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
	tk+4z1qwmL/ix4qprA2Ms3i6GDk5JARMJI7MOs3WxcjFISSwm1FixtvPjBDOJ0aJtbenssM5
	e/8uYINp2dezjxkisZNR4k3nd6iWt4wS1z53MYJU8QrYSRz4NhPMZhFQlXhw9BYbRFxQ4uTM
	JywgtqiAvMT9WzPYQWxhARuJ7l2HwGpEBBQlbrV8AdvALLCDUWLhqV1MIAlmAXGJW0/mA9kc
	HGwCmhIXJpeChDkF9CQOdb+AKpGX2P52DjPEpa0cEucW6ELYLhKXPm6GigtLvDq+hR3ClpL4
	/G4v1GfZEg8ePWCBsGskdmzuY4Ww7SUa/txgBVnLDLR2/S59iFV8Er2/n4BdIyHAK9HRJgRR
	rShxb9JTqE5xiYczlkDZHhKXVm1mggTVBkaJO/OPsE9gVJiFFCqzkDw5C8k3sxA2L2BkWcUo
	mVpQnJueWmxaYJyXWg6P8OT83E2M4CSq5b2D8dGDD3qHGJk4GA8xSnAwK4nwchyeky7Em5JY
	WZValB9fVJqTWnyI0RQYPROZpUST84FpPK8k3tDE0sDEzMzMxNLYzFBJnLd5Z0u6kEB6Yklq
	dmpqQWoRTB8TB6dUA5NAi8a5SMOT0x99+m4/o+NKbE7a7JIXsc8sax9xXW89IvRWaPYF15TH
	nTH7Hk3MWSop8dBf4CPjPb2XR+cuXLAqVJZBe6fSw88XspxeZO8QOCveyaD5wKa47MSS2K2L
	17fMKM2TlDxadFdj3Un7N/zmFgJTJ879d8YxSyTn+ez77dJh3T+jtEKcLKbe26FkKFWy7I0+
	97J73Le6PsQ5S85Sndn6ynDShov6k226rlw6kvXobRtP687Uk/bbju99wzH334u73hrHjIw6
	165vNX72rMv1+AzL6E1X6/ae8bxR0HY+gSOUcc3dTrOyeSfWnnMRtbn1Q//clKyfD6+KlKdN
	3pSVP+tSoSOv7OPOJYs5lFiKMxINtZiLihMBlXZXACsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO6n03PSDaZ8FbX489DQYu8tbYtL
	j1ewW+zZe5LFYv6yp+wW+17vZbZo7fnJ7sDusXlJvcfkG8sZPZrOHGX2mLB5I6vH501yAaxR
	XDYpqTmZZalF+nYJXBnbJ9xnLVjMX/FjxVTWBsZZPF2MnBwSAiYS+3r2MXcxcnEICWxnlDh4
	agcTREJcovnaD3YIW1hi5b/n7BBFrxkleh43soIkeAXsJA58m8kIYrMIqEo8OHqLDSIuKHFy
	5hMWEFtUQF7i/q0ZYIOEBWwkuncdAqsREVCUuNXyBWwzs8AORokj3z8xQmzYwCgx4/UnsKnM
	QGfcejIf6CQODjYBTYkLk0tBwpwCehKHul8wQZSYSXRt7YIql5fY/nYO8wRGoVlI7piFZNIs
	JC2zkLQsYGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREcK1pBOxiXrf+rd4iRiYPxEKME
	B7OSCC/H4TnpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxS
	DUzRKxV+d2VfORY4PVPrzcHVRV6vbnNs6u77L2l1+j2f0vF7q+veT/15yTTjWmSnyP6OQ/NO
	iom8bxD6a2s09b+5vG/YZe+3s/0i8r9nHH1u18D0rZUh4/EVbftmiaabOqJLd326Lbd3+Yk5
	L2q0z/tlcF+exLbO5jr/71OBNbIP/2178vem16+TS6c02DMzplkbL9Pm21fVbH/rRfoZlpXs
	Css7OArsZzaYpOx4milns8u1z+TZXA3rPKsj2/d94dMvsT94Z/2apLUxuxkTr2Vw2mb/npZZ
	fqxIZ6mK2Pwjf1uWp2VkLrTNXj3LsfR5wyXvT92pV5cdSz6l/1f35Y0pYdM2+ddN+K/Brq99
	ZsJaJZbijERDLeai4kQAcymx2gQDAAA=
X-CMS-MailID: 20250131131114epcas5p1b067a3bba165e1c0bf17d0326546282d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
	<20250130091545.66573-1-joshi.k@samsung.com>
	<20250130142857.GB401886@mit.edu>

On 1/30/2025 7:58 PM, Theodore Ts'o wrote:
> On Thu, Jan 30, 2025 at 02:45:45PM +0530, Kanchan Joshi wrote:
>> I would like to propose a discussion on employing checksum offload in
>> filesystems.
>> It would be good to co-locate this with the storage track, as the
>> finer details lie in the block layer and NVMe driver.
> 
> I wouldn't call this "file system offload".  Enabling the data
> integrity feature or whatever you want to call it is really a block
> layer issue.  The file system doesn't need to get involved at all.
> Indeed, looking the patch, the only reason why the file system is
> getting involved is because (a) you've added a mount option, and (b)
> the mount option flips a bit in the bio that gets sent to the block
> layer.

Mount option was only for the RFC. If everything else gets sorted, it 
would be about choosing whatever is liked by the Btrfs.
   > But this could also be done by adding a queue specific flag, at which
> point the file system doesn't need to be involved at all.  Why would
> you want to enable the data ingregity feature on a per block I/O
> basis, if the device supports it?

Because I thought users (filesystems) would prefer flexibility. Per-IO 
control helps to choose different policy for say data and meta. Let me 
outline the differences.

Block-layer auto integrity
- always attaches integrity-payload for each I/O.
- it does compute checksum/reftag for each I/O. And this part does not 
do justice to the label 'offload'.

The patches make auto-integrity
- attach the integrity-buffer only if the device configuration demands.
- never compute checksum/reftag at the block-layer.
- keeps the offload choice at per I/O level.

Btrfs checksum tree is created only for data blocks, so the patches 
apply the flag (REQ_INTEGRITY_OFFLOAD) on that. While metadata blocks, 
which maybe more important, continue to get checksummed at two levels 
(block and device).

