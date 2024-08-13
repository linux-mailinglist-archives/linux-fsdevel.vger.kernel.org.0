Return-Path: <linux-fsdevel+bounces-25822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E2950E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA8A283ECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68671A705B;
	Tue, 13 Aug 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TW6VX0bv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B61A2C22
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582830; cv=none; b=hUoO50qqEU7JxoHlMHcwFQaIE7CoEPinTIH7FOlSIYkKt3BMb/pcaqZ0z0xBBypc9AnDdJ6831q/VLIxPZsx8gii7lxBcuGzyYG0Zxci6RYhnawSF2atwtpNsGJoAwH1/wWOsTyDcX2JO6bIphopJiW5dv2LkVf5qYmI1C21fys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582830; c=relaxed/simple;
	bh=ZN3tQzymTcmkQlUYs7RbGxBnq7TrctXTajoNfjnwxo0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=iQXwSBCtxzxhkfGBqolKKfqrDmnAISkuT7tgR+XI5HYGBLhyFacX6RiIzCIB+uC1wz7ahHHxzH3HqdmVvzED+PSNWSYwhxbRJ+X+3wFs0zFpebCRK2epX8Izb70qOLCbewcOx4AFm3DvtaEkmR2mwnJnGAP3I+NXy4w+78FmeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TW6VX0bv; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240813205211euoutp01ec6b83972bdb3dbae365bfc57b440e2d~rZP_7JKfw3024630246euoutp01V
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 20:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240813205211euoutp01ec6b83972bdb3dbae365bfc57b440e2d~rZP_7JKfw3024630246euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723582331;
	bh=g+qkzRHS3jw4WsS4cpx+f6NKTPUS5U6hZ0ljXErcJ/0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TW6VX0bvlvjgk71PbdSuPpReR/Fn6mST0KrC233BOyvxsfAu3fiPb7i9/vJIL/M9i
	 U97mXD3sEBDxIipBftTbImZF9uZmCs9X1gcyAmqX429wislJt8mp2NkN04rUMsCcc3
	 A11HZPF/KmHpqvq689zmoE8BQSJyEA3BTncckCpo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240813205211eucas1p105be0b63fdc114cebdf671c1200ef5f5~rZP_mOx9t2986729867eucas1p1m;
	Tue, 13 Aug 2024 20:52:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 8A.EF.09620.B77CBB66; Tue, 13
	Aug 2024 21:52:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240813205210eucas1p2b33ab34444638bf4c50c17439e2ff392~rZP9XwwkM1908019080eucas1p29;
	Tue, 13 Aug 2024 20:52:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240813205210eusmtrp166e8803dfad48d96d33ea45cbb31d63e~rZP9XKPSL0985809858eusmtrp1e;
	Tue, 13 Aug 2024 20:52:10 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-c4-66bbc77bf47e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.F9.09010.A77CBB66; Tue, 13
	Aug 2024 21:52:10 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240813205209eusmtip18a8659cf509cb224c86ff56e5c2b2100~rZP9IkMtb0042300423eusmtip1D;
	Tue, 13 Aug 2024 20:52:09 +0000 (GMT)
Received: from localhost (106.210.248.67) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 13 Aug 2024 21:52:09 +0100
Date: Tue, 13 Aug 2024 22:52:04 +0200
From: Joel Granados <j.granados@samsung.com>
To: Solar Designer <solar@openwall.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Kees Cook
	<keescook@chromium.org>, Thomas Wei??schuh <linux@weissschuh.net>, Wen Yang
	<wen.yang@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <20240813205204.c4na3lcdhvqfiz4d@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806185736.GA29664@openwall.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87rVx3enGTw6KWtxpjvXYs/ekywW
	l3fNYbP4/eMZk8WNCU8ZLRq33GW1OHqsi9niUd9bdov3a+6zOnB6zG64yOKxaVUnm8eJGb9Z
	PBY2TGX2ePrnLpvHxD11Hp83yXn0dx9jD+CI4rJJSc3JLEst0rdL4Mr4dusza0GbSMXzO7UN
	jL/4uxg5OSQETCTePF/BCGILCaxglFi1PgbC/sIo8W6vRhcjF5D9mVHi96aZjDANFxrXsEEk
	ljNK3H/QwAhXtfv2C6jMFkaJS/uXMoG0sAioSqxftZ0NxGYT0JE4/+YOM4gtIqAusfz4alaQ
	BmaB7UwSEw5cAtshDLRj15yJLCA2r4CDxJmF+xghbEGJkzOfgMWZgQYt2P0JaCgHkC0tsfwf
	B0iYU8BIYtqGbqhTlSQWHVgHZddKnNpyiwlkl4RAO6fE74uT2SESLhKzjm+BKhKWeHV8C1Rc
	RuL05B4WiIbJjBL7/31gh3BWM0osa/zKBFFlLdFy5QlUh6NES8dPVpCLJAT4JG68FYQ4lE9i
	0rbpzBBhXomONiGIajWJ1ffesExgVJ6F5LVZSF6bhfDaAkbmVYziqaXFuempxcZ5qeV6xYm5
	xaV56XrJ+bmbGIGp6fS/4193MK549VHvECMTB+MhRgkOZiUR3kCTXWlCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTGu2LPXg6XaZccTTgf1VzrMX/E9F
	f07nPPTBcTW7SW/kBOFvH7lT1/beaTHwUW9w2HlcYGF+ts4tBgF5xa9LXLba62Z9TWO8f/7f
	2xkGr6vv9U64XDG5ev+xPSe1G0uEa9PeBDRZnFxYffHaTPH10reqnXJ+75b/bf/QYGWl323z
	g2fzUsPXZz+zjs9iOJh2OLp3za9it8UH/8Rveqt290dQ98Kd31pW2XH9mH+ZPdQvcRd732JW
	YY3uZ+vmSqVzuC4/NLtbNJHD0M654tHJCDHJku6vbOIrXzwodtx6ptqh5Nk6Jw/rmN9NqstU
	5hoa/a8Nm/FrnknCPDEhFde/bnYXGgvWhO1ZdsIommFzrRJLcUaioRZzUXEiALpvO3W8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7pVx3enGbydzWlxpjvXYs/ekywW
	l3fNYbP4/eMZk8WNCU8ZLRq33GW1OHqsi9niUd9bdov3a+6zOnB6zG64yOKxaVUnm8eJGb9Z
	PBY2TGX2ePrnLpvHxD11Hp83yXn0dx9jD+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
	MzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4dusza0GbSMXzO7UNjL/4uxg5OSQETCQuNK5h62Lk
	4hASWMoo8bOhlw0iISOx8ctVVghbWOLPtS6wuJDAR0aJy59DIewtjBK3ruSC2CwCqhLrV20H
	q2ET0JE4/+YOM4gtIqAusfz4alaQBcwC25kkJhy4xAiSEAbavGvORBYQm1fAQeLMwn2MEFfs
	YZRo6z7FDpEQlDg58wlYETPQ1AW7PwFt4ACypSWW/+MACXMKGElM29DNCHGoksSiA+ug7FqJ
	z3+fMU5gFJ6FZNIsJJNmIUxawMi8ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzA+tx37uWUH
	48pXH/UOMTJxMB5ilOBgVhLhDTTZlSbEm5JYWZValB9fVJqTWnyI0RQYFhOZpUST84EJIq8k
	3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oqgck/JlhdsvRIS0N5ovDR
	+VlvvlqW2TCU/N5xKKj4kvpnZ/eVKduX1R2/mG26/pdulMhOAdsDohsnRX8KXqFwjznq3p+v
	XXv2+evONT65iE/y4T5Hp2nbdhnLKHIuiI7OyhYPLXDzzXuVzO8y61X4I3f5uaKP9galfn91
	1/L4xwmiWv+jMvJee230Ordqxs4Jjjxrsj3/7fm5hmHWwQnZF6z9e2NS5HPFWmUW77jaVlK1
	fhsfxwHvbR/OLj2w/5+Ze9Mr80VtCy3mXA5KW2x4fsWlXwUMpp78t874FqkqrXhebhMkxWn6
	cZrH7b37759+d6D72Hu5wzkvTi30L3D8dLYri+05h82ZG42h828x9wUrsRRnJBpqMRcVJwIA
	jH4YdlgDAAA=
X-CMS-MailID: 20240813205210eucas1p2b33ab34444638bf4c50c17439e2ff392
X-Msg-Generator: CA
X-RootMTR: 20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>
	<20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
	<20240806185736.GA29664@openwall.com>

On Tue, Aug 06, 2024 at 08:57:37PM +0200, Solar Designer wrote:
> On Tue, Jul 16, 2024 at 04:16:56PM +0200, Joel Granados wrote:
> > sysctl changes for 6.11-rc1
> > 
> > Summary
> > 
> > * Remove "->procname == NULL" check when iterating through sysctl table arrays
> > 
> >     Removing sentinels in ctl_table arrays reduces the build time size and
> >     runtime memory consumed by ~64 bytes per array. With all ctl_table
> >     sentinels gone, the additional check for ->procname == NULL that worked in
> >     tandem with the ARRAY_SIZE to calculate the size of the ctl_table arrays is
> >     no longer needed and has been removed. The sysctl register functions now
> >     returns an error if a sentinel is used.
> > 
> > * Preparation patches for sysctl constification
> > 
> >     Constifying ctl_table structs prevents the modification of proc_handler
> >     function pointers as they would reside in .rodata. The ctl_table arguments
> >     in sysctl utility functions are const qualified in preparation for a future
> >     treewide proc_handler argument constification commit.
> 
> As (I assume it was) expected, these changes broke out-of-tree modules.
> For LKRG, I am repairing this by adding "#if LINUX_VERSION_CODE >=
> KERNEL_VERSION(6,11,0)" checks around the corresponding module changes.
> This works.  However, I wonder if it would possibly be better for the
> kernel to introduce a corresponding "feature test macro" (or two, for
> the two changes above).  I worry that these changes (or some of them)
> could get backported to stable/longterm, which with the 6.11+ checks
> would unnecessarily break out-of-tree modules again (and again and again
> for each backport to a different kernel branch).  Feature test macro(s)
> would avoid such further breakage, as they would (be supposed to be)
> included along with the backports.
> 
> Joel, Linus, or anyone else - what do you think?  And in general, would
As mentioned by Thomas; These changed must not be backported and
therefore there is not concern about backport consequences.

> it be a good practice for Linux to be providing feature test macros to
> indicate this sort of changes?  Is there a naming convention for them?
I don't think that would be a good practice. IMO, a good way to handle
these things in out-of-tree modules is the LINUX_VERSION_CODE hack. You
can see it here for the same reason :
https://github.com/cryptodev-linux/cryptodev-linux/commit/99ae2a39ddc3f89c66d9f09783b591c0f2dbf2e9
...

Best

-- 

Joel Granados

