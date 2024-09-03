Return-Path: <linux-fsdevel+bounces-28452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48596A898
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 22:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FCCB23AC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4871D58B5;
	Tue,  3 Sep 2024 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mMoooUuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1741DB55E;
	Tue,  3 Sep 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395930; cv=none; b=HALikaZJlh6GQK1a/lmbUHwReGE6CBLTpaeaKXzDEGG+M5QpjZ8Kq4YENaZKrQIlncFbOJntJaOB9yXhK8NQaCwysQ84LOZFLnS3Ow/MvJ56ROjvM4y02IKzVKr7s3yh4ApA1z3Yjdauec+P0GrZ3Mj3vvXsOHIVD+QCgBFurLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395930; c=relaxed/simple;
	bh=VFoTsRtt68RVoeAi9VLYHfQjDg2XerBSNoRzzGDciSo=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=Ai5DEiTsC0owbX1voIwXvZ70YMp+vmXAi2tL2aS5rW8XWE5LM/AlM1DJ+S3proryq+rNXOfdkWHWozH10BDdWo3zOM9NViyiARpfh5h4krOHpKj8SfK+nIvAqhzg/bYd/YNRpUHTllBuDY3s3RZoDBYpKXZUikCvDIVsADNxW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mMoooUuF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240903203845euoutp02183ff4c4ac8e027bf3c3115036f0ad8b~x1nPvaRt71652516525euoutp02i;
	Tue,  3 Sep 2024 20:38:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240903203845euoutp02183ff4c4ac8e027bf3c3115036f0ad8b~x1nPvaRt71652516525euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725395925;
	bh=GNR+eK42esfILSIOqFtg0aWfjz42sOarNmVsVFV8tbQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mMoooUuFfjML3nBfHfvdD4YlzKAeEDyDBWppHqsKVLHh7Mqvyku7hM3JBmIXdlF0s
	 HXBv/PQYboc5x6cN+nsU4RznuqxX3T4KnQ+M5GqILJL8t6sdvJZ9kD8VoaFrFEozSB
	 deuA7ZWMsd/ISwD3UlTQ5x41vrDVbioEb5F1WiOw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240903203844eucas1p2401ddb0040b75475278124294f250e08~x1nOqUo5r0264902649eucas1p2C;
	Tue,  3 Sep 2024 20:38:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 45.5A.09620.4D377D66; Tue,  3
	Sep 2024 21:38:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240903203843eucas1p113cca3d7efa156bf50ddf1c9f555978b~x1nNTZbbE1114411144eucas1p1U;
	Tue,  3 Sep 2024 20:38:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240903203843eusmtrp28d9d32636f0230899b8eabf94334c70a~x1nNSG5l32626626266eusmtrp2o;
	Tue,  3 Sep 2024 20:38:43 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-6f-66d773d4a31f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 12.E7.14621.2D377D66; Tue,  3
	Sep 2024 21:38:42 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240903203842eusmtip2d7b8f85193e728a15f68f839e5e4e855~x1nM8-Kqe1124611246eusmtip2J;
	Tue,  3 Sep 2024 20:38:42 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 3 Sep 2024 21:38:42 +0100
Date: Tue, 3 Sep 2024 22:38:37 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kaixiong Yu <yukaixiong@huawei.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>, <ysato@users.osdn.me>,
	<dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <luto@kernel.org>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <willy@infradead.org>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
Message-ID: <20240903203837.cbzs3ziuh6eq4kvo@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903033011.2870608-1-yukaixiong@huawei.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTZxjG8/WcnlNqao6VwBeBQICBsoEbLORTtglmWY7GbXjJnE4iFQ5g
	5GZLN9ziVhQHEgSsjEtBLpMBcpXSlFWBDjDUQtZuXDKEAZNR5xzXIiI62rUczPzved/n+b3f
	+/7x8TDhLLGNdzoxhREniuI9CT6u7l01+g9Jfot5c/weRKXNDQS6pLHiaOmWhUD/9JgBso7/
	xUHl37cSqHL1ORc9upUBUKkxHUem3ikSlcx7oYIWZ1RSeJGDVqvrSNTUfIODmmaNXPSLOoeL
	2mR/kKi9Q4+jwdulBJposNqMn/q5aCF7ikCl/+ZjSK+4iSPj7UYuGskzAdRRLsNRb4UTkj80
	k+hp/wxAY/JCHLUqv8NQ3/M+DjJft3BRSVoOQMY1HRelLU0C9OKZbbpVu0KgeqsKC91Br1zK
	wWnVzfscukIppdPvznLp1lo/Wll3maCVZjlJG0oWcHrOYCDpe0UvcLpMf5DOXomiF02jON3Y
	8QjQXQYDoOc7h4lw5+P8d6KZ+NOfM+Kd70Xy48ZM9/HkPl7qxN0JUgaWiCzgwIPU21ButnKz
	AJ8npGoB1GVlc9jiCYAKdSvHnhJSSwA2zHBfEuNjSxgbqgGw/EIfYAtb6IpRhrOECkD5nJNd
	45Q3zNOVrU8iqDegceZ3zK4dKV/4cP5nwg5j1CAJJ682AbuxlfoMmh4Ur4cEVChcnpwjWL0F
	6oun1x/AbIMq7phtfZ5Nu8AaC8/edqDehf0tGYDd1At2VXeTrD4P+1Sj66dBqmgTnCkY4bDG
	+1Dek7UBbIWPdaoNwBVaNeUbwDUAtZYFki3qAaxOW96gQ2D60DRp3wJSYVBbfpKVm+HI7BZ2
	z81Qri7E2LYAZn4rZEEfWD8xg+cBL8UrlyleuUzx/2UVAKsDzoxUkhDLSIISmS8CJKIEiTQx
	NiAqKUEJbD+i36Jb/hHUPl4M6AYcHugGkId5OgoiWoZjhIJo0bkvGXHSSbE0npF0Axce7uks
	eC3anRFSsaIU5gzDJDPily6H57BNxlGoU/bknsr/2L/NaVF3fABbKM14+sGuvzX5pyy7tZSD
	a1uNPqRq5+GevZFDJ7qOlS2saH9ovtw+dT1zn5kQ1QWqDUNH02BgmuPZzo/ikq+ElumLzO0R
	PmMTRcqepvSr7S5rq4dCvq4KzJv2CC42Fd/wDQrennvANdXJtJ9fGSHrfJBvmPegzrvH+iik
	Kfs9Bo54BmjazxS8fnYw8Y5bavGzrz5Uph5xq9fXHsuculalcExKbfWP8mo8uker2uWdSaQn
	bAopORCjqbTkCmrzHckB0l3tlyz9NfDcnxe9w08EjYbNxX8aedBNcyF4bZ/vN9lhvYf5br6d
	uxd7Iod3fJIb/mSvJy6JE73lh4klov8AfRsoZoAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH/fU+emGQXMvrJ8yhhWWTQaG89qsDNAuwu4S5jT0jcayBC5hR
	ML3tHi5T8BEGkgbwwSwVq2QMOinQMnQqOpHASme7QGC4ShEFxA1FWhzjIazQLfO/zznn+/3m
	5ORQmOAIGUjtLlCw8gJpvpD0xM3LPfaIPu63nKjiGzFI03yORId/XMGRs2WZRH9edwC0MnyP
	h06fNZLozPwCgSZbSgDSWA/haLz7Dh/VTIegE60BqKb6IA/N1+v4SN9cx0P6B1YC/dquItD5
	ott8dLnDhKP+ixoS2c+tuAY/mQn0qPwOiTRLxzBkUjfiyHqxiUBDFeMAdZwuwlG31h9VTTj4
	6C/zFEC2qmocGQ3HMdS70MtDjlPLBKopVgFkfdJDoGLnCECLf7vSV67Okej7lTZs+xZm7rAK
	Z9oab/IYrUHJHOp6QDDGhjDGoCslGYOjis9Yah7hzEOLhc/8/M0iztSa3mbK57KYmfHfcaap
	YxIw1ywWwExfGSDfCtgpSpAXKhXsprxCTpEozBCjaJFYgkTRsRKROOblXVuj44SRSQnZbP7u
	T1l5ZNLHojzb+E18Ty/1ub3Lzi8CTrIMeFCQjoXDNidWBjwpAf0tgL0LNsI9eBa2zg78yz5w
	abCMdItmABxdniXcRRuAztFpsKrC6VBY0VPLW2WSDofWqVvYKvvSL8CJ6Rtrbozu58ORSv2a
	wYfOgOOjJ9dE3vR2+Hjk4dpOAroCQNt1b3d/PTSdHMNXGXOFai85XBrKxUHwu2Vqte1BJ0Jz
	awlwbxoCr9V38t38FXQ+mQAVwEf9VJL6qST1/0lagOmAL6vkZLkyTizipDJOWZAryiqUGYDr
	K9u7540XQO0fM6JOwKNAJ4AUJvT13tU6kCPwzpZ+sZeVF2bKlfks1wniXKeoxAL9sgpdb12g
	yBTHR8WJY+MlUXGS+BhhgHdqvzVHQOdKFewnLLuHlf/n41EegUW8I750s/CsUTX14pBqW3bL
	Jq+SpgMasyFky4U0nWAxSPaq4oexdy+1J0Nn91xsw3MbBjdTd0OPDiWPRC/ZehoWPhgkUdh0
	uk6bkpLSHHJ//Qn7Ps80Ll2/sdRRExw6V6lN31ld8gvj2Bem23FgLKWJn370Naf+StvXEZcn
	+7sy3ik3vlKa2VedYLz/ZrB+XdjjdZhXxevPJAtM4fsTg4KHE2b96ywwukhWMPtZaiLppwv8
	8qVtx07VHb+dpgnAhfd83i8zf2SIpDe/Z6rfcL67fO+H+8Ov9r0hTZLH9EcuPu+vCdqqvhur
	k6RG8BR2AUzS+nFerfjG8IMY4XHL1ChyKIU4lycVh2FyTvoPClcIMx4EAAA=
X-CMS-MailID: 20240903203843eucas1p113cca3d7efa156bf50ddf1c9f555978b
X-Msg-Generator: CA
X-RootMTR: 20240903033105eucas1p2b9d0b874da268fecb49905d90340de09
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240903033105eucas1p2b9d0b874da268fecb49905d90340de09
References: <CGME20240903033105eucas1p2b9d0b874da268fecb49905d90340de09@eucas1p2.samsung.com>
	<20240903033011.2870608-1-yukaixiong@huawei.com>

On Tue, Sep 03, 2024 at 11:29:56AM +0800, Kaixiong Yu wrote:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.
> 
> All the modifications of this patch series base on
> linux-next(tags/next-20240902). To test this patch series, the code was
> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> x86_64 architectures. After this patch series is applied, all files
> under /proc/sys/vm can be read or written normally.

This move make a lot of sense. The question with these multi-subsystem
patchsets is how do they go into mainline. For now I have added this to
sysctl-testing to see if it needs more work. I can push this through the
sysctl subsystem, but you need to get reviewed-by for all of the commits
in different subsystems. I'm also fine with this going in through some
other subsys if anyone wants to take it?

Best

-- 

Joel Granados

