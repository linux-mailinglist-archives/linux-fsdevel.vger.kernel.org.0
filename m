Return-Path: <linux-fsdevel+bounces-10532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6200584C09B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A1E1C21793
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66941CD19;
	Tue,  6 Feb 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pfa8rj8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0C1C698
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260718; cv=none; b=sfeFjMJN0E/FHSBPhSVVKQhUKLwSyWEvGoXcBANnGqwN3kyuAvXkimIB/uf6KCr44AkNGKPWQP+0Vh+IWk8z7w6dhgI+9BAkgcxG7zbirO0qeRuiIseGBdi32drj68fn3xEe8vyQeYP/rIdmprWdM2OR1buNBUGewBrfjELEpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260718; c=relaxed/simple;
	bh=7QPoO7PifBqJV8sy2/s5zmKco4E+SsITAiGa1p+M0P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kpSSAeFclpSYYtbzPTNZIO110mVbita8+iqbW+AlOSfUWUuCOK20jObE1G8aJZfLbT+wERLerBsxjQi8aXEOWl7+stH/+1QfH1PduMzV/Cp3Vg9ZAM7i9JaTOl3cMtpITNHB0hthDRf4YVq6SSK0WL0PkPSdf46rLVDWonL0ivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pfa8rj8d; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240206230506euoutp027189469d20d3300a68ce11ff1abab4be~xaJFGmzUI2396223962euoutp02W
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 23:05:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240206230506euoutp027189469d20d3300a68ce11ff1abab4be~xaJFGmzUI2396223962euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707260706;
	bh=D4NpkGWJwWN6KnAZDRStVR1XHUjwfMp1ZAHQ8qzkVao=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pfa8rj8dbIwzK+cyaHBQw651DYw0zn2wQAB/v0T+a20uPePX/SoOAUoNUQn4TOOp7
	 GcvKTqjxKF4+5H33n9gNoCnw/yfnJ9zBgkeiadTha7oweTqpsiOlgZYr0ioy564/6e
	 p++ptNojMCe55bYb4oR7n86XHWS92BIDMoDluoxQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240206230505eucas1p2ca96067cf9ce25b9432df241865ccfeb~xaJD59HbV1545315453eucas1p2D;
	Tue,  6 Feb 2024 23:05:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E0.3A.09539.12BB2C56; Tue,  6
	Feb 2024 23:05:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240206230505eucas1p1b952da8c57de5dea32339b22e3c98b94~xaJDfaVsD1596415964eucas1p1l;
	Tue,  6 Feb 2024 23:05:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240206230505eusmtrp1b65b0d431452d003e4821a4d574ce28b~xaJDe1ijJ0618706187eusmtrp1W;
	Tue,  6 Feb 2024 23:05:05 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-f8-65c2bb219805
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.A7.10702.02BB2C56; Tue,  6
	Feb 2024 23:05:05 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240206230504eusmtip1e06c0fdfbc890e18793aae24260a5951~xaJCxAlLA1460514605eusmtip1h;
	Tue,  6 Feb 2024 23:05:04 +0000 (GMT)
Message-ID: <65bedd1f-2dd4-49e3-8865-0e6082129e78@samsung.com>
Date: Wed, 7 Feb 2024 00:05:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next: /dev/root: Can't open blockdev
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>
Cc: Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Linux Regressions
	<regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org,
	lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter
	<dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, Anders Roxell
	<anders.roxell@linaro.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240206-haarpracht-teehaus-8c3d56b411ea@brauner>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87qKuw+lGtz8L2dxa8pvJou/k46x
	W7w+/InR4sO8VnaL2dObmSz23tK22LP3JIvF5V1z2CwOLmxjtNh6bxq7xa1P/BYb33awW5z/
	e5zVgdfj969JjB6bVnWyedy5tofN4/a/x8weLzbPZPQ4s+AIu8fnTXIem568ZQrgiOKySUnN
	ySxLLdK3S+DK+L9+JkvBbZ6K9bcusjQw/ubqYuTkkBAwkfh3+xtTFyMXh5DACkaJbbP62SGc
	L4wSy47vgMp8ZpS4emQ5I0zLulnLWSASyxklfv2+wgbhfGSUmNL3iQmkilfATuJF3z12EJtF
	QEWiY+kCdoi4oMTJmU9YQGxRAXmJ+7dmgMWFBQwltrbNArOZBcQlbj2ZDzZHRCBCYvaFRYwg
	C5gFtjFLfD7fwgaSYANq6HrbBWZzCthLfG9+zQTRLC/RvHU2M8Sp8zklPl8NhbBdJB48eQ/1
	grDEq+Nb2CFsGYnTk3vA3pEQaGeUWPD7PhOEM4FRouH5LagOa4k7534BbeMA2qApsX6XPogp
	IeAo8fCrI4TJJ3HjrSDECXwSk7ZNZ4YI80p0tAlBzFCTmHV8HdzWgxcuMU9gVJqFFCqzkHw/
	C8kzsxDWLmBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY2k7/O/5pB+PcVx/1DjEy
	cTAeYpTgYFYS4TXbcSBViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoR
	TJaJg1OqgclS2aglZlHwSr7PC07r1WSrBhvnZ594aaSSLjPzbHnJv+8/vz1cbbOLPf1Yjpi4
	D7OO6THLb34Xpq/Mq3xsdGvar/rthonvcxLc5JNf7FPd6uQcX+UUfdbVuyb67vWy7vsr1+X9
	fz9jwrfd90TD5+pHTVkq/vHBrEc5BvOsLhp8X6gTq73yO9vtRYeqnwoeCvDb2BngfsjMTPXH
	xhkcC4Mb91wRmH3slvXRxx2OvwrDDdh5GvSnzXt54WdZ5r1gExvuon/zTu6rvzVN/Y70Z5tg
	D+ULRatattw52yLzqoepKIdvudTqRfcmX/5SLp0mfWzX9r2lTSsmMDTvPBB+6+3nur05mabP
	RPfk1vy//kxWiaU4I9FQi7moOBEA3ElHgNwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7qKuw+lGrQdZrK4NeU3k8XfScfY
	LV4f/sRo8WFeK7vF7OnNTBZ7b2lb7Nl7ksXi8q45bBYHF7YxWmy9N43d4tYnfouNbzvYLc7/
	Pc7qwOvx+9ckRo9NqzrZPO5c28PmcfvfY2aPF5tnMnqcWXCE3ePzJjmPTU/eMgVwROnZFOWX
	lqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl/F8/k6XgNk/F
	+lsXWRoYf3N1MXJySAiYSKybtZwFxBYSWMooMX2JMkRcRuLktAZWCFtY4s+1LrYuRi6gmveM
	EmenHwBL8ArYSbzou8cOYrMIqEh0LF3ADhEXlDg58wnYUFEBeYn7t2aAxYUFDCW2ts0Cs5kF
	xCVuPZnPBGKLCERIdM06zQqygFlgG7PEqsZ/TBDbZjFLzLkxC2wbG1B311uQMzg5OAXsJb43
	v2aCmGQm0bW1ixHClpdo3jqbeQKj0Cwkh8xCsnAWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswt
	Ls1L10vOz93ECIzmbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4zXYcSBXiTUmsrEotyo8vKs1J
	LT7EaAoMjYnMUqLJ+cB0klcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fE
	wSnVwFS4u2nehjPxZUdVX3uWVvJvszr0hsljk+HPv7LfthWFt19vnLCSIWM127f253PFz/id
	b5h5Y7ra1D3uB2xObn6cmdr9/tp+XV+dg/yvOU0iupj+PdkXE6Tx62+V/sSAGq6phtcuXr05
	02DPuo5diWGW0TyKrKfmaRpPFlmivUDlxK5rGxN6RAWWLT9ccflqQ95684C83reHU9W/Su0T
	UFGxDmC6fcbR2bNxsd/a05KqPLOOnon7PKHuxmFjt1dVO10WM67myM2b+tZ3KlOa55YvOYkP
	lAWva2q1Ndl+2hfjK7G+YmJS4SRjyblM4kHG7MzM515f158WaNWnXFQyb9fFyMlfnRlddNNE
	meR/vFBiKc5INNRiLipOBAB/HpkRbwMAAA==
X-CMS-MailID: 20240206230505eucas1p1b952da8c57de5dea32339b22e3c98b94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240206230505eucas1p1b952da8c57de5dea32339b22e3c98b94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240206230505eucas1p1b952da8c57de5dea32339b22e3c98b94
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
	<20240206101529.orwe3ofwwcaghqvz@quack3>
	<CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
	<20240206122857.svm2ptz2hsvk4sco@quack3>
	<CA+G9fYvKfeRHfY3d_Df+9V+4tE_ZcvMGVJ-acewmgfjxb1qtpg@mail.gmail.com>
	<20240206-ahnen-abnahmen-73999e173927@brauner>
	<20240206-haarpracht-teehaus-8c3d56b411ea@brauner>
	<CGME20240206230505eucas1p1b952da8c57de5dea32339b22e3c98b94@eucas1p1.samsung.com>

Hi Christian,

On 06.02.2024 16:53, Christian Brauner wrote:
>> On it.
> Ok, can you try:
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super.debug
> please?


I've also encountered this issue during my linux-next daily tests and I 
confirm that the above branch works fine.


I've applied the diff between e3bfad989976^2 and the above branch 
(bc7cb6c829e2), which looks following:

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 279ad28bf4fb..d8ea839463a5 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -19,6 +19,7 @@
  #include <linux/ramfs.h>
  #include <linux/shmem_fs.h>
  #include <linux/ktime.h>
+#include <linux/task_work.h>

  #include <linux/nfs_fs.h>
  #include <linux/nfs_fs_sb.h>
@@ -208,6 +209,10 @@ void __init mount_root_generic(char *name, char 
*pretty_name, int flags)
                                 goto out;
                         case -EACCES:
                         case -EINVAL:
+#ifdef CONFIG_BLOCK
+                               flush_delayed_fput();
+                               task_work_run();
+#endif
                                 continue;
                 }
                 /*


onto next-20240206 and it fixed all boot problems I've observed on my 
test farm. :)

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


