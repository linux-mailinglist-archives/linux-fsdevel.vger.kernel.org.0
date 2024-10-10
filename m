Return-Path: <linux-fsdevel+bounces-31521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF5998111
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0DB1F27B03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0671BBBD6;
	Thu, 10 Oct 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IqZAcmoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A61A070D
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550291; cv=none; b=e01BzwbECq5pxgr+0vnpEUxOd3YFAapuJMvZrtC4ZbKtIfRhlC2D7EskPS1o0jQyGP2zoY5iP4+l4fksarjkQS/vuVWaiUeLww0fBrZiUgSVHFt5T/QN2Jr+vbKRTXHygTsGdJi9T1FO9JRahdokXXVdlTzPunrqtpEDq4dIIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550291; c=relaxed/simple;
	bh=AmTwx/e9IvoNu67kS/GGVL8h9ra60KlBhAIFm2ZaWus=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 In-Reply-To:References; b=Z5YZoX1LuLPS03EjB/d4t4md25F0njPuchFsE3B4lnvvABJGkgYikU4Cs9dGRCTHeytjx42+ByXKwL8PNSeIV8Dt8VbcL7lMNwWN+pIYv2hpBVT61UyXjLAs/LA/0QxnvZoFmp2wF8mbmFZlNohYL+qu3dXo4lLpqOJCT3NmZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IqZAcmoG; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241010085126euoutp021a8f33b09cec6c25c8e9671ac0b6efba~9C1PL6Zjb0499304993euoutp02N
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 08:51:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241010085126euoutp021a8f33b09cec6c25c8e9671ac0b6efba~9C1PL6Zjb0499304993euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728550286;
	bh=YeM0dPO1+nOm8boXRksVmRulqdYkOpcgua7bJ4stkko=;
	h=Date:CC:Subject:From:To:In-Reply-To:References:From;
	b=IqZAcmoG0fPWQx0EFoivcYxhT2gEZNmrPnNzRmSzrnyrkJxe9fMs6x57IY0z8yj5C
	 GshqEPkfH7VPrZ+DdvsnZm0SECacEqzpjl0v2Eg7je3Nyi2zBmZ/WzAs8fSi8ef6WD
	 UtN9d8BPnCHIsS1WjADypsgZpvpAEnY647kuWv/I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241010085126eucas1p133b991680631c9903f010a922665f94a~9C1O634Qn1720817208eucas1p1F;
	Thu, 10 Oct 2024 08:51:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 28.9B.09624.E8597076; Thu, 10
	Oct 2024 09:51:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241010085125eucas1p2ad657cb4a5d0bbb9a6a8579406983210~9C1OmfLjj1034510345eucas1p2f;
	Thu, 10 Oct 2024 08:51:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241010085125eusmtrp191ce25df44c285f7699f77502cf3a01e~9C1Ol7M4q0373503735eusmtrp1r;
	Thu, 10 Oct 2024 08:51:25 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-ac-6707958ee44f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 76.CA.19096.D8597076; Thu, 10
	Oct 2024 09:51:25 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241010085125eusmtip1dffecbfff70e1fa8a4350908291cce88~9C1OcEOHr1248812488eusmtip1r;
	Thu, 10 Oct 2024 08:51:25 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 10 Oct 2024 09:51:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Oct 2024 10:51:24 +0200
Message-ID: <D4RZXQ8GR1C4.35P1KFUAWX09N@samsung.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-bcachefs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
From: Daniel Gomez <da.gomez@samsung.com>
To: Theodore Ts'o <tytso@mit.edu>, Kent Overstreet
	<kent.overstreet@linux.dev>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <20241009035139.GB167360@mit.edu>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned2+qezpBmdfslnMfv6V2WJC42pW
	iz17T7JYXN41h83iUd9bdovWnp/sDmweJ2b8ZvFY2DCV2aPpzFFmj8+b5AJYorhsUlJzMstS
	i/TtErgypv2ZwVxwQbXi1Km7TA2Mq+W6GDk5JARMJK5cvs3cxcjFISSwglHi+/y/bBDOF0aJ
	lxeesEM4nxklNj26xAbTcvPMHUaIxHJGidZdB1jgqr5e7IZq2cwoMW39BWaQFl4BQYmTM5+w
	gNjMAtoSyxa+ZoawNSVat/9mB7FZBFQlbn+/wApRbyKxZ8oXsKnMAjMZJW5vvAFWJCxgLLHu
	5zqwZjag5n0nN4HFRQQCJJ7PWs0McZ+axP/+iWDLOAX0JHqPbYa6W1FixsSVLBB2rcSpLbeY
	QBZICDzgkFi+4B1UkYvEhgWv2CFsYYlXx7dA2TISpyf3QDWnSyxZNwvKLpDYc3sW0NUcQLa1
	RN+ZHIiwo8SKpg3MEGE+iRtvBSH+5ZOYtG06VJhXoqNNaAKjyiykEJqFFEKzkEJoASPzKkbx
	1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMDkcvrf8U87GOe++qh3iJGJg/EQowQHs5IIr+5C
	1nQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJmWTz6ZT
	OA5ts8w5//Z8B/d9rSd/9t7+7Wmd3FuyL+rt/QDedJ6eAoatTO6uxd71l3+/s7nR/EOPK7Hl
	Q8SSeTLL9nHzaz5Z1Dtp9nFHr6sSDU39G95Nk7d/ZP3ffN7pnMDssrKGv0krTwXW3H8jUJH/
	qGPtZYHi4+1+zDnbKqZ8yyvjU8+wZzPR8bSa724h/zJK6HLy87LDHB2bVH3WPTXacXf+2qQC
	C4+zfZMe8+62XKxkH5Ff87uDP1d75mzeuTs32939FHSg74C9c67GTf08Q/t3rO5fdK88ql7w
	Kijawco5oLReP5KrYun0ndtktRN+MaxuNL4xPe1G89KF+98tD8oxSnbwjcqTX3JYiaU4I9FQ
	i7moOBEAuWXb7p0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7q9U9nTDe42GlnMfv6V2WJC42pW
	iz17T7JYXN41h83iUd9bdovWnp/sDmweJ2b8ZvFY2DCV2aPpzFFmj8+b5AJYovRsivJLS1IV
	MvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQypv2ZwVxwQbXi1Km7
	TA2Mq+W6GDk5JARMJG6eucPYxcjFISSwlFFi+8x+VoiEjMTGL1ehbGGJP9e62CCKPjJKHPx+
	lx3C2cwo8eFuFwtIFa+AoMTJmU/AbGYBbYllC18zQ9iaEq3bf7OD2CwCqhK3v19ghag3kdgz
	5QsLyCBmgZmMErc33gArEhYwllj3cx1YMxtQ876Tm8DiIgJ+ErsmfIQ6SU3if/9EFogrXrBI
	fH97nAkkwSmgJ9F7bDMbRJGixIyJK1kg7FqJz3+fMU5gFJmF5NhZSI6dheTYBYzMqxhFUkuL
	c9Nzi430ihNzi0vz0vWS83M3MQLjb9uxn1t2MK589VHvECMTB+MhRgkOZiURXt2FrOlCvCmJ
	lVWpRfnxRaU5qcWHGE2Bvp7ILCWanA9MAHkl8YZmBqaGJmaWBqaWZsZK4rxsV86nCQmkJ5ak
	ZqemFqQWwfQxcXBKNTBJpl04N5Pb+1AVQ6ZPvrN5KtezLzU9p5cvsTaOsLvox+zUt1IxbF2I
	stOF7/d/WUUp2nKYbJt++2ZU9j7fDnn2+P2nN9Y2vlbTrFp4Z1tGwleLiyUq8+/1TGGYIFvE
	EN/EtcRhb7Sbe5O20k39MFau9bYZT3U3eYjou18PELxl/jiqUk/r4NaY1d9P51nfSAkpf6u+
	IKrkoeGUxypZsQyC2zfeufTnkYmtru214p2nriVXLO3bJtKd+MalmcEph7Hs6fELNVu23+Cp
	X/5rhtBk+WXLZ8jveOJduSvnVulN25MqEyZGf4/7nsUc+6c8xvDE2kUnVXX3Lcr+fv3tNtfn
	DUpNUTpHg+/s4ldsV1BiKc5INNRiLipOBADKHAdvSAMAAA==
X-CMS-MailID: 20241010085125eucas1p2ad657cb4a5d0bbb9a6a8579406983210
X-Msg-Generator: CA
X-RootMTR: 20241010085125eucas1p2ad657cb4a5d0bbb9a6a8579406983210
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241010085125eucas1p2ad657cb4a5d0bbb9a6a8579406983210
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
	<CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
	<x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
	<CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
	<e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
	<CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
	<2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
	<20241006043002.GE158527@mit.edu>
	<jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
	<20241009035139.GB167360@mit.edu>
	<CGME20241010085125eucas1p2ad657cb4a5d0bbb9a6a8579406983210@eucas1p2.samsung.com>

On Wed Oct 9, 2024 at 5:51 AM CEST, Theodore Ts'o wrote:
> On Sun, Oct 06, 2024 at 12:33:51AM -0400, Kent Overstreet wrote:
>>=20
>> Correct me if I'm wrong, but your system isn't available to the
>> community, and I haven't seen a CI or dashboard for kdevops?
>
> It's up on github for anyone to download, and I've provided pre-built
> test appliance so people don't have to have downloaded xfstests and
> all of its dependencies and build it from scratch.  (That's been
> automated, of course, but the build infrastructure is setup to use a
> Debian build chroot, and with the precompiled test appliances, you can
> use my test runner on pretty much any Linux distribution; it will even
> work on MacOS if you have qemu built from macports, although for now
> you have to build the kernel on Linux distro using Parallels VM[1].)
>
> I'll note that IMHO making testing resources available to the
> community isn't really the bottleneck.  Using cloud resources,
> especially if you spin up the VM's only when you need to run the
> tests, and shut them down once the test is complete, which
> gce-xfstests does, is actually quite cheap.  At retail prices, running
> a dozen ext4 file system configurations against xfstests's "auto"
> group will take about 24 hours of VM time, and including the cost of
> the block devices, costs just under two dollars USD.  Because the
> tests are run in parallel, the total wall clock time to run all of the
> tests is about two and a half hours.  Running the "quick" group on a
> single file system configuration costs pennies.  So the $300 of free
> GCE credits will actually get someone pretty far!
>
> No, the bottleneck is having someone knowledgeable enough to interpret
> the test results and then finding the root cause of the failures.
> This is one of the reasons why I haven't stressed all that much about
> dashboards.  Dashboards are only useful if the right person(s) is
> looking at them.  That's why I've been much more interested in making
> it stupidly easy to run tests on someone's local resources, e.g.:
>
>      https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-=
quickstart.md
>
> In fact, for most people, the entry point that I envision as being
> most interesting is that they download the kvm-xfstests, and following
> the instructions in the quickstart, so they can run "kvm-xfstests
> smoke" before sending me an ext4 patch.  Running the smoke test only
> takes 15 minutes using qemu, and it's much more convenient for them to
> run that on their local machine than to trigger the test on some
> remote machine, whether it's in the cloud or someone's remote test
> server.
>
> In any case, that's why I haven't been interesting in working with
> your test infrastructure; I have my own, and in my opinion, my
> approach is the better one to make available to the community, and so
> when I have time to improve it, I'd much rather work on
> {kvm,gce,android}-xfstests.
>
> Cheers,
>
> 						- Ted
>
>
> [1] Figuring out how to coerce the MacOS toolchain to build the Linux
> kernel would be cool if anyone ever figures it out.  However, I *have*

Building Linux for arm64 is now supported in macOS. You can find all patch
series discussions here [1]. In case you want to give this a try, here the
steps:

	```shell
	diskutil apfs addVolume /dev/disk<N> "Case-sensitive APFS" linux
	```
=09
	```shell
	brew install coreutils findutils gnu-sed gnu-tar grep llvm make pkg-config
	```
=09
	```shell
	brew tap bee-headers/bee-headers
	brew install bee-headers/bee-headers/bee-headers
	```
=09
	Initialize the environment with `bee-init`. Repeat with every new shell:
=09
	```shell
	source bee-init
	```
=09
	```shell
	make LLVM=3D1 defconfig
	make LLVM=3D1 -j$(nproc)
	```
=09
More details about the setup required can be found here [2].

This allows to build the kernel and boot it with QEMU -kernel argument. And
debug it with with lldb.

[1]
v3: https://lore.kernel.org/all/20240925-macos-build-support-v3-1-233dda880=
e60@samsung.com/
v2: https://lore.kernel.org/all/20240906-macos-build-support-v2-0-06beff418=
848@samsung.com/
v1: https://lore.kernel.org/all/20240807-macos-build-support-v1-0-4cd1ded85=
694@samsung.com/

[2] https://github.com/bee-headers/homebrew-bee-headers/blob/main/README.md

Daniel

> done kernel development using a Macbook Air M2 while on a cruise ship
> with limited internet access, building the kernel using a Parallels VM
> running Debian testing, and then using qemu from MacPorts to avoid the
> double virtualization performance penalty to run xfstests to test the
> freshly-built arm64 kernel, using my xfstests runner -- and all of
> this is available on github for anyone to use.




