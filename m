Return-Path: <linux-fsdevel+bounces-23759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A981C932818
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D40BB228AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E819B582;
	Tue, 16 Jul 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iDnW/9Zq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46119B3CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139432; cv=none; b=ocrtsd7UUxwtk2iYiGflK6KEqubbv5izjaPZuMmY1FVkvQKxfDyspSPJ+wY/kw1U9qREFR09ApOTuTmBdwim7bjgX7HEna2n98QzQ/glVyt/97WVfTe1CrOx1bJ+Do1kFrLN2wktcalgf8vBmjDinfHYIEoXTB/+KOtF0cTXfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139432; c=relaxed/simple;
	bh=EyjHSgHtEE2QiyHm0eTIJGb6awCiW6GpKsXEilVPt1M=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=qBLTtIgBw+OOMl5XoPJE/7xA+MRaQ6GYA4orwHRUtfQA4Kd7MpqAVSOjHzPB/qpkCzNEXzdN8Jlm8liTjYUXx/PdO1UQ+f6eaghr+hTJ0W/qKnLb2B0j7d1yrmlcwDbPQdy/H4ifAAs6tmQPAbqEFkXOH0OcyV6EaE/EOU1fwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iDnW/9Zq; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240716141704euoutp01d3c15d3d15adaa453b481f0d7bee316f~ity-2YiAN2204922049euoutp01E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 14:17:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240716141704euoutp01d3c15d3d15adaa453b481f0d7bee316f~ity-2YiAN2204922049euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721139424;
	bh=YACcv9BnNidhkssSMiXRLLRpbe0KedK8tj/31WFDyt8=;
	h=Date:From:To:CC:Subject:References:From;
	b=iDnW/9Zqt7DflM4OCs5hFZAK1Y07gA9/yY/5GysIZ+rzqEBSu84D6fL7ybW5cEorC
	 7RRTgzyPUR3l/dzVT1C38NuETNE9LvXd41aBA6QZ/7EqDNIbwvM4EkTUyFxrdDUoPF
	 h9fyYQ4x+B9ONXMvrGkCvAwfVVrdQFWozR4jxXcA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240716141704eucas1p249b4e56cec88c18b54440b6909ba6a53~ity-ohLpr2326023260eucas1p2-;
	Tue, 16 Jul 2024 14:17:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 4C.7E.09620.FD086966; Tue, 16
	Jul 2024 15:17:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6~ity-JtRme2675326753eucas1p2f;
	Tue, 16 Jul 2024 14:17:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240716141703eusmtrp1cf005c630bc078c4d62f11c3eae60e55~ity-JFkkv0611306113eusmtrp1C;
	Tue, 16 Jul 2024 14:17:03 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-8f-669680df92a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.CF.09010.FD086966; Tue, 16
	Jul 2024 15:17:03 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240716141703eusmtip2590a943316251bb03d751924354a77bc~ity_2eG9b3028830288eusmtip2f;
	Tue, 16 Jul 2024 14:17:03 +0000 (GMT)
Received: from localhost (106.210.248.174) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 16 Jul 2024 15:17:02 +0100
Date: Tue, 16 Jul 2024 16:16:56 +0200
From: Joel Granados <j.granados@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Jeff Johnson
	<quic_jjohnson@quicinc.com>, Joel Granados <j.granados@samsung.com>, Kees
	Cook <keescook@chromium.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
	<linux@weissschuh.net>, Wen Yang <wen.yang@linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87r3G6alGexZpmtxpjvXYs/ekywW
	l3fNYbP4/eMZk8WNCU8ZLRq33GW1eNT3lt3i/Zr7rA4cHrMbLrJ4bFrVyeZxYsZvFo+FDVOZ
	PSbuqfP4vEnOo7/7GHsAexSXTUpqTmZZapG+XQJXxvutK1gLFkpXtJ5ezt7AeEO0i5GDQ0LA
	RKJjsnAXIxeHkMAKRonD5+eyQjhfGCX+/e5hg3A+M0ps7Z7H2MXICdax88UZqKrljBKLPp9i
	hKtq7JsF5WxllJj85x5YC4uAqkTz6llgNpuAjsT5N3eYQWwRASOJzy+ugI1iFtjPJDH563lW
	kISwgIHEnFldbCA2r4CDxNepu5ghbEGJkzOfsIDYzAJ6EjemTmED+YJZQFpi+T8OiLC8RPPW
	2cwQpypLvH+wjwXCrpVYe+wMO8guCYE3HBKv991jg0i4SCxpW8AOYQtLvDq+BcqWkTg9uYcF
	omEyo8T+fx+gulczSixr/MoEUWUt0XLlCVSHo0RLx09WSLjySdx4KwhxEZ/EpG3TmSHCvBId
	bUIQ1WoSq++9YZnAqDwLyWuzkLw2C+G1WUheW8DIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10v
	OT93EyMwRZ3+d/zrDsYVrz7qHWJk4mA8xCjBwawkwjuBcVqaEG9KYmVValF+fFFpTmrxIUZp
	DhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dUA5PXQf2Zz00nGKkdm5CQe4lH7UVZTWHJJbcW
	AZ/MFw7pPy8cKN36yWph5faEif81T2/Or+a9qh71oFwi9ozxWwG3ty/9og2Y7jm1Lkzo0vt+
	pSe9/eeGHeGnF/vuD74Tk8Wh8a0obWuFcMrMhvU2rxOYFh4vDM/z59Ysm2bzbP3i5mCGJWU7
	2z9dKm8I/W8wzzE4Qv2l4y/tRMUDisl7JK/z9W5Uy//4nqtyu9OMSZ3ZwecesK55oPLz94Tm
	l2+uz5z2vsT0xt23t3WkNE8uP8nVxCkyb1moyh81+ebaKxveKbQ/vCJWNevy8Qyhf9t2ZDs4
	+c1TS8lc9UpjX/6++A9Z+k8uBVlxS//kZLvAKa7EUpyRaKjFXFScCADSsuxPwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7r3G6alGVxbL2hxpjvXYs/ekywW
	l3fNYbP4/eMZk8WNCU8ZLRq33GW1eNT3lt3i/Zr7rA4cHrMbLrJ4bFrVyeZxYsZvFo+FDVOZ
	PSbuqfP4vEnOo7/7GHsAe5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
	TUpqTmZZapG+XYJexvutK1gLFkpXtJ5ezt7AeEO0i5GTQ0LARGLnizOsXYxcHEICSxklNjx6
	xAyRkJHY+OUqK4QtLPHnWhcbiC0k8JFRYvIBFYiGrYwS+6/9ZARJsAioSjSvngVmswnoSJx/
	cwdskIiAkcTnF1fANjAL7GeS6H9+mwkkISxgIDFnFsRUXgEHia9TdzFD2IISJ2c+YQGxmQX0
	JG5MnQJUwwFkS0ss/8cBEZaXaN46G+pQZYn3D/axQNi1Eq/u72acwCg0C8mkWUgmzUKYNAvJ
	pAWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo3HbsZ9bdjCufPVR7xAjEwfjIUYJDmYl
	Ed4JjNPShHhTEiurUovy44tKc1KLDzGaAoNiIrOUaHI+MB3klcQbmhmYGpqYWRqYWpoZK4nz
	ehZ0JAoJpCeWpGanphakFsH0MXFwSjUwqdTsSdvVyLos1PXbm8C6lbMmLZLYWJ9VknDoyHJN
	713TQwoMCudLSq/avN+wXC5X5HSfksZO11MmOc6+5xMFU5sPssXf2LT03deQvicPk6uUkpR+
	ON/c0ydo6zpDbdkKHrmw3/+dVkfM/fqmbbl48JwLB+qrn919y7h6Qva/710/j1wWtV9lIV+V
	x6NmpPVw513rd2dTq7vuszm8nGLCe3h67B3hHaoCqrMs76Q+5Ey27NQ9c3vigieW8c9+3VR9
	7/L0ZnjLL6MfsSvOXLPzMFve4C9c68ybtEX8x7e2ycFNTO9nMPPIzqlWDL8kPHdR68S9sksX
	ST/kKj1VZypSNClS0VLC/p6svmC5+Ju5SizFGYmGWsxFxYkA2exFYE8DAAA=
X-CMS-MailID: 20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6
X-Msg-Generator: CA
X-RootMTR: 20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>

Linus

Note: I have update the capabilities in my signing key. I don't think
anything changes on your side, but thought I'd mention it for good
measure. Pulling from https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
would probably solve any unforeseen issues.

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.11-rc1

for you to fetch changes up to acc154691fc75e1a178fc36624bdeee1420585a4:

  sysctl: Warn on an empty procname element (2024-06-13 10:50:52 +0200)

----------------------------------------------------------------
sysctl changes for 6.11-rc1

Summary

* Remove "->procname == NULL" check when iterating through sysctl table arrays

    Removing sentinels in ctl_table arrays reduces the build time size and
    runtime memory consumed by ~64 bytes per array. With all ctl_table
    sentinels gone, the additional check for ->procname == NULL that worked in
    tandem with the ARRAY_SIZE to calculate the size of the ctl_table arrays is
    no longer needed and has been removed. The sysctl register functions now
    returns an error if a sentinel is used.

* Preparation patches for sysctl constification

    Constifying ctl_table structs prevents the modification of proc_handler
    function pointers as they would reside in .rodata. The ctl_table arguments
    in sysctl utility functions are const qualified in preparation for a future
    treewide proc_handler argument constification commit.

* Misc fixes

    Increase robustness of set_ownership by providing sane default ownership
    values in case the callee doesn't set them. Bound check proc_dou8vec_minmax
    to avoid loading buggy modules and give sysctl testing module a name to
    avoid compiler complaints.

Testing

  * This got push to linux-next in v6.10-rc2, so it has had more than a month
    of testing

----------------------------------------------------------------
Jeff Johnson (1):
      sysctl: Add module description to sysctl-testing

Joel Granados (8):
      locking: Remove superfluous sentinel element from kern_lockdep_table
      mm profiling: Remove superfluous sentinel element from ctl_table
      sysctl: Remove check for sentinel element in ctl_table arrays
      sysctl: Replace nr_entries with ctl_table_size in new_links
      sysctl: Remove superfluous empty allocations from sysctl internals
      sysctl: Remove "child" sysctl code comments
      sysctl: Remove ctl_table sentinel code comments
      sysctl: Warn on an empty procname element

Thomas Weiﬂschuh (3):
      sysctl: always initialize i_uid/i_gid
      utsname: constify ctl_table arguments of utility function
      sysctl: constify ctl_table arguments of utility function

Wen Yang (1):
      sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array

 fs/proc/proc_sysctl.c    | 70 ++++++++++++++++++++++++++----------------------
 include/linux/sysctl.h   |  2 +-
 kernel/locking/lockdep.c |  1 -
 kernel/sysctl-test.c     | 50 ++++++++++++++++++++++++++++++++++
 kernel/sysctl.c          | 31 +++++++++------------
 kernel/utsname_sysctl.c  |  2 +-
 lib/alloc_tag.c          |  1 -
 net/sysctl_net.c         | 11 ++------
 8 files changed, 105 insertions(+), 63 deletions(-)

-- 

Joel Granados

