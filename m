Return-Path: <linux-fsdevel+bounces-32702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B699ADFCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BB61F22934
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0A1C4A1B;
	Thu, 24 Oct 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PKWcctag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A311C2301;
	Thu, 24 Oct 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760409; cv=none; b=LbXOmGK/XaDzaP5Wp1LjKetDNCtw/trsTIs4/pICLYXt9LuPMJ+D3Eioga1eUeT50n/2ity35S3VSosDauv7AdvGquyUqRGXi3mKUEXro8n7g5L0xQ4kiA7Z4j1ar3bOS/kBk3urXOf6GFbbuRhXJzmnhh5wj81ybnmYFSUmW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760409; c=relaxed/simple;
	bh=5ohQDOoW3mIzHXRtqUK6vuWfWTSWfm/8yu4VqsKy41w=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=HMrzvhzYQRXB8n06+feDYBrI8MNMS+xGcHyl9Z8O3ip896gkkabPD6f7p/EjrTI2IiM+ekjF0n6d34+WlBaxxkkpD7uUasHYkaRWB3vnJA2hUqIN8KV8V4NRgiDp847cXivlW55lXC7OHReukpaBBdMEsFcq8MH5fAnNZOjkBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PKWcctag; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241024090002euoutp018a0108ce9bcef735dfc2001bcd9eb563~BV_v9kCks2844428444euoutp01c;
	Thu, 24 Oct 2024 09:00:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241024090002euoutp018a0108ce9bcef735dfc2001bcd9eb563~BV_v9kCks2844428444euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729760403;
	bh=h4aMns0vuxoj2DGKLLnGNiIIfjWEYlc98f5DfBMf9BA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PKWcctagUKqph0utZfFpZKN3KY/qjUavkEMXcM5jAgjkTBCJp4r2ARpnEC7BANlm7
	 JkrukntINZ7KkZXYQxfxUDlegETw9QtlYjv92KU4Phx0kwXFVK8Cb6ddt5KslCN2Ql
	 qnONcceyEgshb3vORqGH8/vgxFhRkUXBlqYCjLiE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241024090002eucas1p29b6425c21e9270f2caf6bc3f05b4341f~BV_vl5fpu2350923509eucas1p2R;
	Thu, 24 Oct 2024 09:00:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.A8.20397.29C0A176; Thu, 24
	Oct 2024 10:00:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241024090001eucas1p143fc38cbcaa9538710040c2d957e9f6f~BV_u8PgHB0678306783eucas1p1j;
	Thu, 24 Oct 2024 09:00:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241024090001eusmtrp2dcdd7d123acd3c24d819eddc1fef8d71~BV_u1ZF280636006360eusmtrp2P;
	Thu, 24 Oct 2024 09:00:01 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-a5-671a0c92f203
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.E9.19654.19C0A176; Thu, 24
	Oct 2024 10:00:01 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241024090001eusmtip1faaa6f50c4bd058871f85094590722b6~BV_ujLojm1676816768eusmtip1x;
	Thu, 24 Oct 2024 09:00:01 +0000 (GMT)
Received: from localhost (106.110.32.107) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 24 Oct 2024 10:00:00 +0100
Date: Thu, 24 Oct 2024 10:59:58 +0200
From: Joel Granados <j.granados@samsung.com>
To: yukaixiong <yukaixiong@huawei.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>, <ysato@users.osdn.me>,
	<dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <luto@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <kees@kernel.org>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<joel.granados@kernel.org>
Subject: Re: [PATCH v3 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
Message-ID: <wk7dqsx42rxjt76dowrydumhinwwdltw7e5ptp7fh4rc4c4sji@jrtopui4fpwb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79b33640-fc81-b4c1-4967-30189d9a4b23@huawei.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+69vfcCVsoj9ghL3GC6SRBksvlLnG4ak91tmmxZ9lC3jEZu
	ihnUppWhBGfrA6bII1WE0SpVnDyKAoWhiAQFBgNGyxScgqBjdBusvFpBAYG1XN387/N7fM/5
	fk9yWNLXygSwuxR7eJVCFhtEe1JVTVOWVbpFAfLVpW1SMJSW0HCkep6C+domBCPORHCWzdHw
	T4MDwXzvXwTknaug4ezUtAj+LktBYLAepmCidJqE9qHTDIwcnKHA1tTPgH40GOyVRSSYzFvh
	VLkU9NmHCJi6UMzApdJ8An7Jv0fBpWGrCDqq0kVwWfOAgWu1LRTcumqgoa9k3jW43iaCseP9
	NBienCShJbeIAuvViyK4k2lDcPO6kYDaPA0FTcYloPvTwcBkmx1B61QS9OiyKUg+X07A8Zos
	BNYOCwOj6dcI0JakknDXOkBDhTmLhNbpVgIcp+dEoNemI2g/WCIC62yzCLTO+whmHrucpJ1v
	YVxXn3C9SN0jGkzzlSR02jqod9Zzj46kU1zJmRLEGXs+4BrsoyRXWXSX4IzmeO52zTbucOOw
	iHtYnYG4isIQLv/aIMGZi4/SnNmhYziLfoziRiwWhvs5Z4b68OXtnm9F87G7vuFV4RuiPGNO
	3rhAK9u995ZnnkMalOJ1DHmwWBKJG09YKDf7SgoRnjTsPIY8XfwQ4e4/xhmhcCLcXt9OP1Ok
	duUTwqAAYXv5FeK/rdmseiQUlQg35Y8jt4SSLMfmjAzGzbQkFFvt90g3+0tW4CHbNO0WkJK7
	Xtg2bFpw4ifZgW/dNiywWLIVz5T/RArsg1u+H1jok66DjDUOl5h1cSAumGPdbQ/JBmxq7BYJ
	VoNwV2YvJfB+3FrZTQisW4R/PPqFwJtxW8ZZRmA/PNRc+ZRfxPPVeQvJsOQEwnVzY4xQmBC+
	oJ14etI6fLhz4KliI249lIbchrBkMb4z7CP4XIx1Vdmk0Bbj75J9he0V2NRnpzJRcO5zyXKf
	S5b7fzIjIouRlI9Xx8l59RoFnxCmlsWp4xXysJ2748zI9efa5ponrqDCofGwekSwqB5hlgzy
	F/8as1TuK46W7UvkVbu/UsXH8up6FMhSQVLx8uhlvK9ELtvDf83zSl71bEqwHgEaQnVAHil7
	7zPzFvXuvtWppM2RNbxW42jI0a9P6vG2+EzYGqiIqi/ftPxeRT0OaY7LexKQ2L93i3ZdgXpa
	4ancuKwtMzrqwJJVCfTaG5P3V+aYZuv2J+nlQ46bBZeH76i9Ix1J4Yn2QK3nvqhc6Rsfn2Rb
	lL2NsqVdFYnv1z3enBC1aQP/Svds/wy70kOsOSW/qA+u9gpXp/Rs32i1TTlDz5z71L/20J4H
	fm+nvdTyw0dKHRu/bVzTgGp+G8x5obcsJHlz56D086vfdnzCOiLyGl8T3/RJGkhLKPNI1Y4o
	X9+R/apJYVCo3l2+yeosapTK5aGp3JBVOeg847Fm4qh3O86UBlHqGFlECKlSy/4FvpOZEOIE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1CUZRTGe7/bLgixAcUXgmPbCMLYcl04MIiOTuNHDTOVAw1a4YorkNzc
	BUzUCUwyEQEJpLjEJsR1A3dBChdEYcUWgkVuBogJgdxBLqawwrawNfnf877Pc37nzJn3ZeOm
	M5QlOzQiWiiKEIRxKUOide3u4DuXjSyDHSVqW8itlFKQWKslQFvfjGB2MQ4Wr61RMNW0gEA7
	OIZB/tUqCn5cXiFh/Np5BLnqcwQ8rVzBoW0yjwWzZzUEjDYPsyBn7m2Yri7FoVzuC1dkFpCT
	9RUGy0VlLKioLMDg94IHBFTMqEnoqEkh4Zf4Ryyoq1cR0HUjl4KHUq3OuNVKwpPkYQpyX2Tg
	oMouJUB942cS/kgbRdB5S4JBfX48Ac2SNyD98QIL/m6dRtCyfBoG0rMI+LpQhkGyIhOBuqOd
	BXMpdRgkSC/i0KceoaBKnolDy0oLBgt5ayTkJKQgaDsrJUG9epeEhMU/EWie6ya5VKhi6Vp/
	q9tIwzMKyrXVOHSPdhC7dzLPElMIRvqDFDGSgfeZpuk5nKku7cMYiTyG6VUEMOeUMySzVJuK
	mKoSe6agbgJj5GUXKEa+kM5i2nOeEMxsezuL+e07DfHBWwd4XqLImGjh1pBIcfRO7kEncOY5
	eQDP2dWD5+Ti/qmnM5/r4O11RBgWGisUOXgf4oVk3C6iotpMvpClXUXx6PymJGTApjmu9MWe
	AiwJGbJNOT8hurNmFNMbVrRsqYfUazP6RW8SpQ/NI1rTOETqD9WInijo30gRnG20PDWVta4p
	zg5aPf0AX9fmHBt6cnRloxrn9G2iR2fKiXXDjHOQ7urN3dDGHF9aI7uD66nfYPRqUSWpN16j
	Vd+PbIRwHVWiWNCR2Dq9mS5eY69fG3C86XJl/7+jcumetEFCr8/Qi6uPURoyy36JlP0SKft/
	kgThZchcGCMODw4XO/PEgnBxTEQwLygyXI50776mebn6V1Q6Oc9rRBgbNSKajXPNje+FvBls
	anxEcDJOKIoMFMWECcWNiK/bxWXc8vWgSN3HiYgOdHJz5Du5unk48j3cXLgWxlS3+qgpJ1gQ
	LTwmFEYJRf/VYWwDy3jsw6a8iTxVY6Jdgq1Xi1duRWixjbtH0Hv2DSc+bvsrrhKL5Z+yGrqv
	8LSS3tTu1UbJS1TMnJ2ryGqLC1dCLfJLAiKatjGG96/vKyCLB6NsZqwbmrp2qwWmJYeVg75j
	pwzbfDL80QC5fUdC31rjkML2uMjv0P7rn3ymqUX3LJ8aLWmclzXbfeqPdRbZBlaY+NitjvQa
	+B8/yW+dV/jJRB8VB5i479ozPPjo3TMWNbEPP9dmKlUXshRT+fF7OrdeqT8c/rwvJJm5bTR+
	YK9G+cppyYmKffVThRVfWu23HtD2bPHJ7LZWOrzabHFns/Jmh7+LzC87ubWtv2fXoudRF5OB
	sYZxLiEOETjZ4yKx4B/VplmkgAQAAA==
X-CMS-MailID: 20241024090001eucas1p143fc38cbcaa9538710040c2d957e9f6f
X-Msg-Generator: CA
X-RootMTR: 20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd
References: <CGME20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd@eucas1p1.samsung.com>
	<20241010152215.3025842-1-yukaixiong@huawei.com>
	<ngknhtecptqk56gtiikvb5mdujhtxdyngzndiaz7ifslzrki7q@4wcykosdnsna>
	<79b33640-fc81-b4c1-4967-30189d9a4b23@huawei.com>

On Thu, Oct 24, 2024 at 04:07:10PM +0800, yukaixiong wrote:
...
> 
> 
> >>   mm/swap.c                          |  16 ++-
> >>   mm/swap.h                          |   1 +
> >>   mm/util.c                          |  67 +++++++--
> >>   mm/vmscan.c                        |  23 +++
> >>   mm/vmstat.c                        |  44 +++++-
> >>   net/sunrpc/auth.c                  |   2 +-
> >>   security/min_addr.c                |  11 ++
> >>   23 files changed, 330 insertions(+), 312 deletions(-)
> >>
> >> -- 
> >> 2.34.1
> >>
> > General comment for the patchset in general. I would consider making the
> > new sysctl tables const. There is an effort for doing this and it has
> > already lanted in linux-next. So if you base your patch from a recent
> > next release, then it should just work. If you *do* decide to add a
> > const qualifier, then note that you will create a dependency with the
> > sysctl patchset currently in next and that will have to go in before.
> >
> > Best
> >
> 
> Sorry,  I don't understand what is the meaning of "create a dependency 
> with the sysctl patchset".
The patches in the sysctl subsys that allow you to qualify the ctl_table
as const are not in mainline yet. They are in linux-next. This means
that if these patches go into the next kernel release before the
sysctl-next branch, it will have compilation errors. Therefore the
sysctl-next branch needs to be pulled in to the new kernel release
before this patchest. This also means that for this to build properly it
has to be based on a linux-next release.

> 
> Do you just want me to change all "static struct ctl_table" type table 
> into "static const struct ctl_table" type in my patchset?
You should const qualify them if the maintainer that is pulling in these
patches is ok with it. You should *not* const qualify them if the
maintainer prefers otherwise.

Please get back to me if I did not address your questions.

Best

-- 

Joel Granados

