Return-Path: <linux-fsdevel+bounces-40483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD62A23B9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3EE7A3A34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3C19D06E;
	Fri, 31 Jan 2025 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sOwd33Tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81E198E60
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317018; cv=none; b=mvtYvz99rA/9aSBe8tGRE6cV/TtFf4lnQTh2JdBrNbdzn4Bofj/2FwCcAh/THU9uTELDVbT3xt3n+LyLfFRb0qezLR8MltrjpalN+taAKwlgvwotyQYoPU3lMycNc57n5QSq4yS+q7Z2eGWmOx5Etgq1au/qyzPyckD6IL1TKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317018; c=relaxed/simple;
	bh=nMqKf30XZFIbEzMVzsyjeqUU4yYnRRuGDbyyXS5a2uU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=S50lR2Nl3KR1hJb7zRb9BWiDntglXFFrhXjNexw535Mi2C6W/nH18V8evjoSp37yzhTNSeOL7MQTxap6SMTtUEjgV6wbAt6psZzgH8stSy7Qeld3OVOuTJmiFyra4GvUj6RIXy4psTEzgTgPcjl6Ylk5AMcg1RdpqSOfOPD0AaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sOwd33Tl; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250131095007epoutp02c91df057a40961ade233ae30731dd9eb~fvhvW93SQ2393923939epoutp02P
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 09:50:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250131095007epoutp02c91df057a40961ade233ae30731dd9eb~fvhvW93SQ2393923939epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738317008;
	bh=SA1GKC+8ffdTI33xq3R8WFrjWW7iByFdDcRzH+4jTHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sOwd33TlIQdfooKZJE1KM5LXzClSBOaFE+TJEalo/puBuL8dKF0vwE2lulefoxr7y
	 Cj0A6Vof5j3UZllOiQhw/tr9g4Noh4z/COY9vzmOgkt5Z87EKCiPHYcEtjZraLeJxs
	 p06gpPwrprvOk0mCubTzDZAtZpxZOaHYkqLG+vDc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250131095007epcas5p4cdddd0782b5609ff28150a73a4491235~fvhujwa7a1247312473epcas5p4s;
	Fri, 31 Jan 2025 09:50:07 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Ykrj92VCNz4x9Pp; Fri, 31 Jan
	2025 09:50:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.7A.20052.DCC9C976; Fri, 31 Jan 2025 18:50:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250131094019epcas5p1c083e0001d21f67e7e1e5074974700d3~fvZLRiDsx0040000400epcas5p1X;
	Fri, 31 Jan 2025 09:40:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250131094019epsmtrp13fc172188694304000b254ed8219e940~fvZLQm7KO0577005770epsmtrp1L;
	Fri, 31 Jan 2025 09:40:19 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-2e-679c9ccd09dd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.AA.18729.38A9C976; Fri, 31 Jan 2025 18:40:19 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250131094017epsmtip11b2b72f6577ff8a72596c9aa45d7b87e~fvZJrrLHZ1087510875epsmtip1c;
	Fri, 31 Jan 2025 09:40:17 +0000 (GMT)
Date: Fri, 31 Jan 2025 15:02:09 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Dave Chinner <david@fromorbit.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, hch@lst.de, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250131093209.6luwm4ny5kj34jqc@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z5qw_1BOqiFum5Dn@dread.disaster.area>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhu7ZOXPSDZZeEbRomvCX2WL13X42
	iy2X7C22HLvHaHHzwE4mi5WrjzJZHP3/ls1iz96TLBb7Xu9ltrgx4Smjxe8fc9gcuD1OLZLw
	2LxCy+Py2VKPTas62Twm31jO6LH7ZgObx7mLFR59W1YxenzeJBfAGZVtk5GamJJapJCal5yf
	kpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0qZJCWWJOKVAoILG4WEnfzqYo
	v7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO6P52TTGgmPCFbN2XGJt
	YJwh0MXIySEhYCKx8dZXpi5GLg4hgd2MErv6FrFBOJ8YJVY8vscO4XxjlOj/vIgZpqVz+w+o
	qr2MEpdbHzJCOM8YJfZsesYEUsUioCrR8PUSUIKDg01AV+JHUyhIWERATWLSpB3MIPXMAveA
	mvetYANJCAs4SUxdsIAFxOYVMJO43X+bHcIWlDg58wlYnFPAWOLD/Y9g80UFZCRmLP0KNkhC
	YC2HxLkNN9ggznOROPjlHjuELSzx6vgWKFtK4mV/G5SdLXGocQMThF0isfNIA1TcXqL1VD/Y
	m8wCGRIPm2ewQsRlJaaeWscEEeeT6P39BKqXV2LHPBhbTWLOu6ksELaMxMJLM6DiHhIXVpwC
	mwkO4daVGRMY5Wch+W0WknUQtpVE54cmIJsDyJaWWP6PA8LUlFi/S38BI+sqRsnUguLc9NRi
	0wLDvNRyeIwn5+duYgSnZC3PHYx3H3zQO8TIxMF4iFGCg1lJhDf23Ix0Id6UxMqq1KL8+KLS
	nNTiQ4ymwLiayCwlmpwPzAp5JfGGJpYGJmZmZiaWxmaGSuK8zTtb0oUE0hNLUrNTUwtSi2D6
	mDg4pRqY3O0sNnNud1msybnLr9v5ysMtOyXOez4Rj33pKyybZ3Bo6y1jzsWl36armzguaGSc
	clOvoilLuDD/psXO7q0tyt9PPk+S0HZ/yHR1RpGEqajXQj6NFxXr4xbMyO1vUdQMsT0W5K3n
	ZSH773RmsHBA5d4/Co8/zjw6gbuf+6iw0LbvKdc/8j+2PJx8ak34H11GZs6di197dntEtRgX
	xh9Qi75iLS2bzLJp9pHvEU7TWj1q3L4cXB3kfG+Z808vC8MW95lFeWeFhXIfvC9SYbxkvnPm
	rg0rbdi4n+zjNxPdlPnj3f+Iv7P7mbZ1v5wyZU6j6rM+4ZiI3edKtmzd9f/s+jSdnKpH9r/6
	uhTNLJOVWIozEg21mIuKEwFVzNwHUgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTrd51px0g7n9ohZNE/4yW6y+289m
	seWSvcWWY/cYLW4e2MlksXL1USaLo//fslns2XuSxWLf673MFjcmPGW0+P1jDpsDt8epRRIe
	m1doeVw+W+qxaVUnm8fkG8sZPXbfbGDzOHexwqNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgy
	Zj3ZyFTwQ6Bif+MZpgbGJ7xdjJwcEgImEp3bf7B1MXJxCAnsZpTY/vohK0RCRmL33Z1QtrDE
	yn/P2SGKnjBKLN/3lwUkwSKgKtHw9RJjFyMHB5uArsSPplCQsIiAmsSkSTuYQeqZBe4xSlze
	t4INJCEs4CQxdcECsF5eATOJ2/232UFssM0zZ7BCxAUlTs58AlbDDFQzb/NDZpD5zALSEsv/
	cYCEOQWMJT7c/8gEYosC3Tlj6VfmCYyCs5B0z0LSPQuhewEj8ypGydSC4tz03GLDAsO81HK9
	4sTc4tK8dL3k/NxNjOBI0tLcwbh91Qe9Q4xMHIyHGCU4mJVEeGPPzUgX4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwDT1SsdLxpkMAfvNL54wWK4arj1H
	v9V6Cu+2vilXpuQKdOzaImjyxjJBoCIhU9/1oU3D27PZaxeE8psbHVt6sGSZz701JxW7o2I/
	vT6lUPdxYz5v9mt22wMHA73+NYUcf5FzKetE98/kabPKzj46HqCSLLxVbvqzGimOrGpxhcNv
	Ofa05zw92nhFh8HwJw+j0iwBjYJPBZ6HYzf/2Nn/5rV7Ra7pdpet8863cYfe+ak9a/+BxLkV
	sRrMSelHJGPc3a8mbejK3nq+6neUX/aaO+dbg6fzHrmQMllwU0t0ziehRpu2iBrdvT7cPY8s
	C6pUX+oo/N3fxFVuGvLi6OwVF+bPY/za3vT09f7znMWWfUosxRmJhlrMRcWJAFnGqekTAwAA
X-CMS-MailID: 20250131094019epcas5p1c083e0001d21f67e7e1e5074974700d3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_1a4dc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
	<20250129102627.161448-1-kundan.kumar@samsung.com>
	<Z5qw_1BOqiFum5Dn@dread.disaster.area>

------1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_1a4dc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>IOWs, having too much parallelism in writeback for the underlying
>storage and/or filesystem can be far more harmful to system
>performance under load than having too little parallelism to drive
>the filesystem/hardware to it's maximum performance.

With increasing speed of devices we would like to improve the performance of
buffered IO as well. This will help the applications(DB, AI/ML) using buffered
I/O. If more parallelism is causing side effect, we can reduce it using some
factor like:
1) writeback context per NUMA node.
2) Fixed number of writeback contexts, say min(10, numcpu).
3) NUMCPU/N number of writeback contexts.
4) Writeback context based on FS geometry like per AG for XFS, as per your
   suggestion.
>
>What kernel is that from?
>

6.12.0-rc4+ 
commit d165768847839f8d1ae5f8081ecc018a190d50e8

>i.e. with enough RAM, this random write workload using buffered IO
>is pretty much guaranteed to outperform direct IO regardless of the
>underlying writeback concurrency.

We tested making sure RAM is available for both buffered and direct IO. On a
system with 32GB RAM we issued 24GB IO through 24 jobs on a PMEM device.

fio --directory=/mnt --name=test --bs=4k --iodepth=1024 --rw=randwrite \
 --ioengine=io_uring --time_based=1 -runtime=120 --numjobs=24 --size=1G \
 --direct=1 --eta-interval=1 --eta-newline=1 --group_reporting

We can see the results which show direct IO exceed buffered IO by big margin.

BW (MiB/s)         buffered dontcache %improvement  direct  %improvement
randwrite (bs=4k)    3393    5397	 59.06%	    9315      174.53%

>IMO, we need writeback to be optimised for is asynchronous IO
>dispatch through each filesystems; our writeback IOPS problems in
>XFS largely stem from the per-IO cpu overhead of block allocation in
>the filesystems (i.e. delayed allocation).

This is a good idea, but it means we will not be able to paralellize within
an AG. I will spend some time to build a POC with per AG writeback context, and
compare it with per-cpu writeback performance and extent fragmentation. Other
filesystems using delayed allocation will also need a similar scheme.


------1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_1a4dc_
Content-Type: text/plain; charset="utf-8"


------1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_1a4dc_--

