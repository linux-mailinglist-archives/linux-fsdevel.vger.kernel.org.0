Return-Path: <linux-fsdevel+bounces-28210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A92968068
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768F6B22D51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56363185B65;
	Mon,  2 Sep 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FeRM+0RE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93561176AC3;
	Mon,  2 Sep 2024 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261491; cv=none; b=F15jnSNQKOIGKURy1wmMCq9DhkLvW4msE4qwNnU5jozmsg/OjTMxbTLT2ce4Qaenkim8aqrS5Bpf6pKX3Z4DknhwhMvv1NSxsjdpuad8Z6DKjb22FBK3bAnYUu4nAbRny2AfL9r3O55VFYiPJt1+VZ4W4nGyu0Roq0L4ugjz4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261491; c=relaxed/simple;
	bh=8SG2xh1jkiCTM4ugpuIMhAlktHVNfNcCiSUKizwKllU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=WMDYkht9Pogv4sIk8ZUi1BTE29OQyEkl8c0v4U3uqryaTonCcYj80qR4+I4I4Ed6+pYDYoSUpZkBn4z9Dn5T6v2dOWtllaM6O/QL1QSO3pNW5Z48J/QYkK4r3CFqccQYILY1CTDoENyNpdN6rE2rYX2NKhZGKSn1yp3mLmKayYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FeRM+0RE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240902071800euoutp02b3a22dafa6514101dac9ddcb66ea74f5~xXC0P85mL3039030390euoutp02C;
	Mon,  2 Sep 2024 07:18:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240902071800euoutp02b3a22dafa6514101dac9ddcb66ea74f5~xXC0P85mL3039030390euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725261480;
	bh=UwzlvCub2JKSbiVV9nJE1HuZGBizQcqajnXjPdQqvpU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FeRM+0RE+xox5Sj07+lyQ7kEJPQqvlVLqQ9EnGdV4sc/Hpy5BYsG4ShFHgDfeYjLR
	 seJbHSujrL6b3pKMeyeN6vJeREU73I3HFbCK+L2divwSZezZshQgCOw9i1eFOxPjL9
	 TYlpiy0GM3ECXqVz96BJH+oDK2a8NB7PwSXoDQGc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240902071800eucas1p22d0afbbd3a88fffd8eefa83a6f26f009~xXC0BJUZk0694506945eucas1p2n;
	Mon,  2 Sep 2024 07:18:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 68.9A.09620.8A665D66; Mon,  2
	Sep 2024 08:18:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240902071759eucas1p1447f8d6433df6bf3175d20980e56260a~xXCzY1D9o0652306523eucas1p1I;
	Mon,  2 Sep 2024 07:17:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240902071759eusmtrp2a2f610e308675a7756b53bc5efb4bf5b~xXCzVgpL01957819578eusmtrp2d;
	Mon,  2 Sep 2024 07:17:59 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-ad-66d566a8f4b0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.4E.14621.7A665D66; Mon,  2
	Sep 2024 08:17:59 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240902071759eusmtip21d15a780a3e48b3752436f6c57664bd1~xXCy5qgs-0438304383eusmtip2h;
	Mon,  2 Sep 2024 07:17:59 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 2 Sep 2024 08:17:57 +0100
Date: Mon, 2 Sep 2024 09:17:52 +0200
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
Subject: Re: [PATCH -next 00/15] sysctl: move sysctls from vm_table into its
 own files
Message-ID: <20240902071752.5ieq3khrnpjqq6qv@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826120449.1666461-1-yukaixiong@huawei.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaVBTVxTHe997eQlpQ59I5Yp0WlHqVJHWaTu9M8UOtmqfznSE9kNBp0qE
	xzJsTsLaahsqiARhJKBQwuqCgchiElOgUppooZBCZJQWkMWxQC1LiQGCAUya8HT02++c//mf
	e/4fLg93myE9edHxiYwoXhjrTfIJbbvVuF0R0RfxblbhelTacJVEmc12As012kg0ddMMkH34
	HwxVXFCTqMq6xEEPG7MAKjVmEGi8/QEXyWc3ofPXPJC86CSGrNW1XFTfcBFD9TNGDrqtzeOg
	nyT3uehGayeB7rSUkmjkqt0h/GrgINOZByQqXSnEUWdJDYGMLXUc1H92HKDWCgmB2ivXIdmE
	mYsshmmA7smKCKRWncNR11IXhsxlNg6Sp+cBZHzSwUHpc6MALT92bLe3LZJIadfgAW/Ti5l5
	BK2pGcDoSlUSnXFrhkOrFVtpVW02SavMMi7dIzcR9H89PVz69+Jlgi7vDKLPLIbRj8YHCbqu
	9SGgdT09gJ79pY8M9DjI9w9nYqOTGdE7H4fyo8aUBfgx5Supo6dkmAR0u0iBCw9S78MlfS/h
	ZDdKAWDv1EEp4Dt4HsApeS/OFnMANlU1Y88cvU+aCVa4AuB5g+T5VGPeHxhbqABcseSQTgtB
	bYZ5FivHySTlC43TQ7iT3aktcGK2m3QacOoOF47m1wOnsJYKhtOq66tDAioAnr7WzWF5Dez8
	cWz1WtyxqPJns8PMc/AGeMXGc7ZdqJ1QOci+C6mNcOHiCMHyCdilGXwaofBlqKvzYnk3nKwu
	5LC8Fk52aLgse0F7c8VqGEgVANhmM3HZQglgdfrC000fwYy7Y1znEZDaBcskySy6wv6ZNeyZ
	rlCmLcLZtgCePuXGGt+CypFp4izYVPJCsJIXgpU8D1YJ8FrgwSSJ4yIZ8XvxTIqfWBgnToqP
	9AtLiFMBx48w2DoWmoBi8pGfHmA8oAeQh3u7Cy7f6I1wE4QL075hRAlHREmxjFgPNvAIbw+B
	T/gbjBsVKUxkYhjmGCN6pmI8F08JltpQrLsfq+fF7Xn8QXk+sfza8WDesKvtz0slrsNvSv01
	+rT9iYE+dSlD+14/eYv/3b8tOfl9XaLAA1pQvLjXctw68lX/gOuu4oS2gk+CFWU19WBcrQ5S
	rKSnuX0oyw0xzJ5IitkRuD5r2+aj2dW7fQVdX99+6dsvt08ItoTppnMr91ebUkvJPbWfDpXl
	Zx92p0IPb7tuOTC3cSDHn8a8tE3xGTXtKYd8l0x/f66SX7iUu+J9Lvavz3J+ONoWEyG9e2hf
	VDRfNzQVOvC93pKs6K7RvqoJNmWedp/30QXcPLKcbtq5YiVqoqTBo0FGGSadr7oXlPKFp9/l
	38rX5YrGzOqQEIM3IY4S7tiKi8TC/wHK08vcgAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH8/ZcWowsx1LGgbko3cWIUCg3HwYIyzZztk/yZRecgQ5OAQfF
	tAWZiwtkuE1AQgsO5VY25hjXSrkNJuBw4WpbhdSh3DYCSBDEltsAoSs0y/z2y/N//788efPw
	MH426cZLkClZuUySKCT34YM7vRNelVKT1KfLegxKtLUkXGqz4rB8c4eEJ3csCKzjjzmg+bGR
	hB82NgmYu/ktghJjJg4zPVNcKF56Db5vcIHiwq85sPFzNRfqtRUcqF80EnCvJZeA1vS/uHCr
	ox+H4fYSEiZqrbbg9iABz3KmSCh5XoBBf1EVDsb2OgJG8mYQdGjScegpfxnUsxYurA0uIBhV
	F+LQqLuKwcDmAAcspTsEFGfkIjBu9xKQsTyJYOsfm93atU5CjbUJCz/KrF/KxZmmqoccplyX
	wmT+sUgwjb94MLrqyySjs6i5jKH4Gc48NRi4TN+1LZwp649gctZjGPPMI5yp65hDzO8GA2KW
	Ok3kKZdIUYg8OUXJHo5PVihDhafF4CsSB4HI1z9IJPY7fuYt3wCh94mQWDYxIZWVe5+IFsVP
	1+Rj52r2p01+o+akI71DFnLg0ZQ/fX+7Dc9C+3h86gaim9sKOPbgIN2wYiLs7EQ/f5BF7jKf
	MiN6de68vaBD9N26h2g3wKnX6dy1jb0CSXnSxoUxbJcF1BF6dklP7hYwaphLT6rq9wpO1Mf0
	gq5575EjFU5/16An7NY8RBdmFOD24ADdf316jzGbtfw3i83Es/ErdOUOb3fsQIXSNY+ySfum
	7vRqxQRu54v08vYsykNORS+Yil4wFf1vKkdYNRKwKYqkuCSFWKSQJClSZHGimOQkHbJdZUvP
	RuOvqGzeLOpGHB7qRjQPEwocb9y6L+U7xkq+uMDKk6PkKYmsohsF2P5Chbk5xyTbzlqmjBIH
	+gSI/QODfAKCAv2ELo4nh41SPhUnUbKfs+w5Vv5fj8NzcEvnRL6T9pU2wjRzJPZu50uas01N
	r/rLDeKrH/VVjod/MD9xjXCNJIPfbC/XdJQ6qOMaVF9mtCxPScIWsaqho44owXRsMRTF/+mz
	mtMyuN3zPjTErtQQJ9u9PjysV2lHNkKaMtNz2BWnxALS208jKP271d08My/tCm5mIt8OG1CO
	dQ+t6cz39EOjkojSIZPpU9cwU+/SxeiKVL18WFM/Ilv75IkqcCbVzzO49nidQAi33+u8MMyc
	is56+q6WGpVVW5zmPB5fkfL7ss1lB86k5be6Xi4aO9t6kHt6/vp5pfMbMj+1852hhKj8zZ+8
	Gq/47z/0YMsg0H52SK0ft3i6q6ZbhLgiXiL2wOQKyb+P58E+HgQAAA==
X-CMS-MailID: 20240902071759eucas1p1447f8d6433df6bf3175d20980e56260a
X-Msg-Generator: CA
X-RootMTR: 20240826120559eucas1p1a1517b9f4dbeeae893fd2fa770b47232
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826120559eucas1p1a1517b9f4dbeeae893fd2fa770b47232
References: <CGME20240826120559eucas1p1a1517b9f4dbeeae893fd2fa770b47232@eucas1p1.samsung.com>
	<20240826120449.1666461-1-yukaixiong@huawei.com>

On Mon, Aug 26, 2024 at 08:04:34PM +0800, Kaixiong Yu wrote:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.
> 
> All the modifications of this patch series base on
> linux-next(tags/next-20240823). To test this patch series, the code was
> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> x86_64 architectures. After this patch series is applied, all files
> under /proc/sys/vm can be read or written normally.
> 
> Kaixiong Yu (15):
>   mm: vmstat: move sysctls to its own files
>   mm: filemap: move sysctl to its own file
>   mm: swap: move sysctl to its own file
>   mm: vmscan: move vmscan sysctls to its own file
>   mm: util: move sysctls into it own files
>   mm: mmap: move sysctl into its own file
>   security: min_addr: move sysctl into its own file
>   mm: nommu: move sysctl to its own file
>   fs: fs-writeback: move sysctl to its own file
>   fs: drop_caches: move sysctl to its own file
>   sunrpc: use vfs_pressure_ratio() helper
>   fs: dcache: move the sysctl into its own file
>   x86: vdso: move the sysctl into its own file
>   sh: vdso: move the sysctl into its own file
>   sysctl: remove unneeded include
> 

Thx for this.

I passed this through 0-day testing and it return some errors. Please
address those build errors/regrssions before you send V2.

Best

-- 

Joel Granados

