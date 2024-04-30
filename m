Return-Path: <linux-fsdevel+bounces-18369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD838B7B20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E1F1F238AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954C77112;
	Tue, 30 Apr 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LXCwQTb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6A770FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489756; cv=none; b=uiQIIHp59SxSpBZzIlODca/RkWGhOVMm1HCBeC0PFclXr9vv7/MX31FTImfY9yWVPDPkthktPQvDKm0LQHU3yZ2svAtx9NixTnO3f2ZVm+tjfHx2e3P4ETQTJ78IOF+wp6T0mKxpEtawgAe7poZZ07qVLqtOs7QEn5mint/Bzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489756; c=relaxed/simple;
	bh=p6c7mgKhD08Bg4rfaeDdQgqKRdTN/YmcMRvGhX0QEOs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=lLgYjiO/OiLCPRwvGaNLErSrIenksY6T1wQiR50Boo53Pr4PezIVZOpEQg2kYuKDXUsybrsGnG5NvCFZeChWnM9UGU3t9ngIP4xcJK0Ddae8kOVvm05nu+H2UUgQ7oChV0ftFxpohZM00+S1o5b/wx6XEuyx/TVgzEdveKuxsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LXCwQTb3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240430150911euoutp01468ee7bf43d633fee3424350f8a710a7~LF1hZWvxU3201632016euoutp01o;
	Tue, 30 Apr 2024 15:09:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240430150911euoutp01468ee7bf43d633fee3424350f8a710a7~LF1hZWvxU3201632016euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714489751;
	bh=NSecfwl9JObqbcgop1n1j6UxyGkK39WChJNRZES0/Is=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LXCwQTb3p2LnAJXM6dXjKS8PxdBLmEDPeYNGkf0YH9wF8TcGFFA9X2Ippu2MohBt1
	 g1GO+NKn8aoY4a4EyBGLPVLLr+MUDv46VAjWu6e5C1VTd64Dk4/dnZBMlI3fxqMnYY
	 BfMsMhQIUH5/cjvGNd1pqG7IwMDPZlFNkEMrEqf8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240430150911eucas1p12084be8c83e765c44615356c4c59bd41~LF1hKHjzc2056020560eucas1p1I;
	Tue, 30 Apr 2024 15:09:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.91.09624.69901366; Tue, 30
	Apr 2024 16:09:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240430150910eucas1p125e6166525c2f1768b276c38b09a0e6c~LF1gtHXbe1625716257eucas1p1W;
	Tue, 30 Apr 2024 15:09:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240430150910eusmtrp2e8bbcafab47f25bd6efa6bf40aa52f39~LF1gshV9t0445504455eusmtrp2a;
	Tue, 30 Apr 2024 15:09:10 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-6e-66310996551e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.D0.09010.69901366; Tue, 30
	Apr 2024 16:09:10 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240430150910eusmtip1d7618857406a6ed4375b21af8734acd3~LF1gepCvx1714617146eusmtip1X;
	Tue, 30 Apr 2024 15:09:10 +0000 (GMT)
Received: from localhost (106.210.248.68) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 30 Apr 2024 16:09:09 +0100
Date: Tue, 30 Apr 2024 17:09:05 +0200
From: Joel Granados <j.granados@samsung.com>
To: kernel test robot <lkp@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, Linux Memory Management List
	<linux-mm@kvack.org>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
	<keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [linux-next:master 7116/7122]
 init/main.c:613:(.init.text+0x358): relocation truncated to fit:
 R_RISCV_GPREL_I against symbol `__setup_start' defined in .init.rodata
 section in .tmp_vmlinux.kallsyms1
Message-ID: <20240430150905.ix3fbtjrtnwfcyiv@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="oiroaqkce55dhyqr"
Content-Disposition: inline
In-Reply-To: <20240430150302.rqply6lqrfh7uqov@joelS2.panther.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87rTOQ3TDB48YbQ4051rsWfvSRaL
	e2v+s1q8an7EZnFjwlNGi0MrrzA5sHnMbrjI4rF4z0smj02rOtk8Nn2axO7xYvNMRo/Pm+QC
	2KK4bFJSczLLUov07RK4Mi4e6WMveB5a0b3/PEsD43evLkZODgkBE4n/R/pYuxi5OIQEVjBK
	XO1dwwjhfGGUWDP3NjuE85lR4vmWt2wwLZ87H0C1LGeUuHdsBiNc1d79zVDOFkaJntf7GUFa
	WARUJZ7fOs0CYrMJ6Eicf3OHGcQWAYrveLiMCaSBWeAIo8SuFW9ZQBxhgVuMEq/mLmUCqeIV
	cJC49+o6C4QtKHFy5hMgmwOoo0Ji6b1SCFNaYvk/DpAKTgFHiUP976FOVZLonTGXCcKulTi1
	5RbYLgmB+ZwSGxdsYYZIuEisWn2dFcIWlnh1fAs7hC0j8X/nfKiGyYwS+/99YIdwVjNKLGv8
	CjXWWqLlyhOoDkeJU4/b2EEukhDgk7jxVhAkzAxkTto2nRkizCvR0SYEUa0msfreG5YJjMqz
	kHw2C+GzWQifQZiaEut36aOIgkzXlli28DUzhG0rsW7de5YFjOyrGMVTS4tz01OLDfNSy/WK
	E3OLS/PS9ZLzczcxAlPZ6X/HP+1gnPvqo94hRiYOxkOMKkDNjzasvsAoxZKXn5eqJMI7ZaF+
	mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVAOT67Oiabt+
	HVw1aW3K5fvrntafuOq83Tv+46IHeo/0PGsvTLRl2KXUs2/tzlMTmipZFk139LrDdb/97aJc
	0aMx9qf/auvsVj079bHQPEVhg2eTXvQr1/d5PJ47w+/HD+MogccxMeyS1ttuOX2bFOsqcvt9
	3XPPEIbPW6fsYeJevOAGp3uw2rGlbFyVTudeyDj0f7K8zx+trOhQtlDxVNNK31OWRb73X88x
	FNudUJxoKZ0dMeEM6xv2F43tXNXamxh3hzKdvy/KmTTTp39HyUytWY9s/vlN2VnR9STrEb+A
	XX79fqXn4XY71S9dXDKDc52h/lapB+2K/j07fx72Fs4rnG/dN00z75fLOl/pDWdMlViKMxIN
	tZiLihMB8YB0+eADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7rTOA3TDHZOl7c4051rsWfvSRaL
	e2v+s1q8an7EZnFjwlNGi0MrrzA5sHnMbrjI4rF4z0smj02rOtk8Nn2axO7xYvNMRo/Pm+QC
	2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mlav
	P8dY8DS04s/TU4wNjF+9uhg5OSQETCQ+dz5g7WLk4hASWMoocfXdHEaIhIzExi9XWSFsYYk/
	17rYIIo+MkqcPfaIEcLZwijR3veBDaSKRUBV4vmt0ywgNpuAjsT5N3eYQWwRoPiOh8uYQBqY
	BY4wSuxa8ZYFxBEWuMUo8WruUiaQKl4BB4l7r66zQIzdwyhx9MMXNoiEoMTJmU/AxjILlEnc
	e9AA1MABZEtLLP/HARLmFHCUONT/ng3iViWJ3hlzmSDsWonPf58xTmAUnoVk0iwkk2YhTIII
	q0v8mXeJGUNYW2LZwtfMELatxLp171kWMLKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzq
	bcd+btnBuPLVR71DjEwcjIcYVYA6H21YfYFRiiUvPy9VSYR3ykL9NCHelMTKqtSi/Pii0pzU
	4kOMpsBwnMgsJZqcD0w3eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwc
	nFINTInB7LNDFz1mlVVuZl01Q2qLyOErNj0TX3PJz1PcFPrISl6H53/HcYFtJ8I3eW5Y5X90
	U5eoy6GvkhduP3W7XrEkbQPLOZHtCX8yPoe/1hL4t25x8q7HJyYF3Q/PjHsl8z/57OHEewn+
	j2c62gU2pf/a15o6L2NxmdjO5wtaDtcs2Gi0XCaubfqR5zfv1rQcFag4/fq38Ez3u4u6D4bu
	ubNcwH/T71czmhe/nTDPxPliopjP3S+cLDqti91KNi60cZG+OsX24tyWjLUx/9b++b37U8ua
	djNF5a6rbVtb5yk+erhQ0ymR8+F7+VOGX858c7+27jcja//s7Wx++ef3tmbeUD0ulb3K97jC
	xUbffXPblFiKMxINtZiLihMB3hI+oH8DAAA=
X-CMS-MailID: 20240430150910eucas1p125e6166525c2f1768b276c38b09a0e6c
X-Msg-Generator: CA
X-RootMTR: 20240421021112eucas1p2d8f8c557039ea1923f09668f9779ff18
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240421021112eucas1p2d8f8c557039ea1923f09668f9779ff18
References: <CGME20240421021112eucas1p2d8f8c557039ea1923f09668f9779ff18@eucas1p2.samsung.com>
	<202404211031.J6l2AfJk-lkp@intel.com>
	<20240430150302.rqply6lqrfh7uqov@joelS2.panther.com>

--oiroaqkce55dhyqr
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CC sysctl maintainers and linux-fsdevel=20

On Tue, Apr 30, 2024 at 05:03:02PM +0200, Joel Granados wrote:
> On Sun, Apr 21, 2024 at 10:10:26AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
=2Egit master
> > head:   a35e92ef04c07bd473404b9b73d489aea19a60a8
> > commit: 603cac6a968ab44e179e820fc0e2ca3ac2e1d829 [7116/7122] Merge bran=
ch 'sysctl-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sy=
sctl.git
> > config: riscv-randconfig-001-20231020 (https://download.01.org/0day-ci/=
archive/20240421/202404211031.J6l2AfJk-lkp@intel.com/config)
> > compiler: riscv64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240421/202404211031.J6l2AfJk-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202404211031.J6l2AfJk-l=
kp@intel.com/
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >    riscv64-linux-ld: section .data LMA [000000000099b000,0000000001424d=
e7] overlaps section .text LMA [0000000000104040,000000000213c543]
> >    riscv64-linux-ld: section .data..percpu LMA [00000000024e2000,000000=
00026b46e7] overlaps section .rodata LMA [000000000213c580,000000000292d0dd]
> >    riscv64-linux-ld: section .rodata VMA [ffffffff8213c580,ffffffff8292=
d0dd] overlaps section .data VMA [ffffffff82000000,ffffffff82a89de7]
> >    init/main.o: in function `rdinit_setup':
> > >> init/main.c:613:(.init.text+0x358): relocation truncated to fit: R_R=
ISCV_GPREL_I against symbol `__setup_start' defined in .init.rodata section=
 in .tmp_vmlinux.kallsyms1
> >    net/ipv4/ipconfig.o: in function `ic_dhcp_init_options':
> >    net/ipv4/ipconfig.c:682:(.init.text+0x9b4): relocation truncated to =
fit: R_RISCV_GPREL_I against `ic_bootp_cookie'
> >    net/sunrpc/auth_gss/gss_krb5_mech.o: in function `gss_krb5_prepare_e=
nctype_priority_list':
> > >> net/sunrpc/auth_gss/gss_krb5_mech.c:213:(.text.gss_krb5_prepare_enct=
ype_priority_list+0x9c): relocation truncated to fit: R_RISCV_GPREL_I again=
st `gss_krb5_enctypes.0'
> >    lib/maple_tree.o: in function `mas_leaf_max_gap':
> > >> lib/maple_tree.c:1512:(.text.mas_leaf_max_gap+0x2b8): relocation tru=
ncated to fit: R_RISCV_GPREL_I against `mt_pivots'
> >    lib/maple_tree.o: in function `ma_dead_node':
> > >> lib/maple_tree.c:560:(.text.mas_data_end+0x110): relocation truncate=
d to fit: R_RISCV_GPREL_I against `mt_pivots'
> >    lib/maple_tree.o: in function `mas_extend_spanning_null':
> > >> lib/maple_tree.c:3662:(.text.mas_extend_spanning_null+0x69c): reloca=
tion truncated to fit: R_RISCV_GPREL_I against `mt_pivots'
> >    lib/maple_tree.o: in function `mas_mab_cp':
> > >> lib/maple_tree.c:1943:(.text.mas_mab_cp+0x248): relocation truncated=
 to fit: R_RISCV_GPREL_I against `mt_pivots'
> >    lib/maple_tree.o: in function `mab_mas_cp':
> > >> lib/maple_tree.c:2000:(.text.mab_mas_cp+0x15c): relocation truncated=
 to fit: R_RISCV_GPREL_I against `mt_pivots'
> >    lib/maple_tree.o: in function `mas_reuse_node':
> > >> lib/maple_tree.c:3416:(.text.mas_reuse_node+0x17c): relocation trunc=
ated to fit: R_RISCV_GPREL_I against `mt_slots'
> >    lib/maple_tree.o: in function `mt_free_walk':
> > >> lib/maple_tree.c:5238:(.text.mt_free_walk+0x15c): relocation truncat=
ed to fit: R_RISCV_GPREL_I against `mt_slots'
> >    lib/maple_tree.o: in function `mtree_lookup_walk':
> >    lib/maple_tree.c:3700:(.text.mtree_lookup_walk+0x94): additional rel=
ocation overflows omitted from the output
> >=20
> I cross compiled this locally and I believe that the error is *NOT*
> introduced by our sysctl-next changes because I get the same 3 errors
> before and after:
> 1. .data overlaps .text
> 2. .data overlaps .rodata
> 3. .rodata overlaps .data
>=20
> The errors are the same type but not exactly the same. I believe that
> they change as code gets modified. So before the sysctl-next changes
> went in, the error was expressed somewhere else. This is consistent with
> the way that the bot shows the "new" errors; since they always change as
> code is changed, they will always detect a "new" error.
>=20
> Another commonality is that reason for reallocation: in my tests its
> always due to R_RISCV_GPREL_I.
>=20
> Here are my results (I modified them slightly for readability).
>=20
> # Before sysctl change:
>=20
>   ~/s/linux-next (29b0937 =E2=97=BC) =E2=9D=AF=E2=9D=AF=E2=9D=AF COMPILER=
_INSTALL_PATH=3D/home/joel/toolchains/0day_riscv COMPILER=3Dgcc-13.2.0 /hom=
e/joel/src/lkp-tests/kbuild/make.cross W=3D1 O=3Dbriscv ARCH=3Driscv SHELL=
=3D/bin/bash
>   ...
>   /home/joel/toolchains/0day_riscv/gcc-13.2.0-nolibc/riscv64-linux/bin/ri=
scv64-linux-ld: section .data LMA [000000000098c000,0000000001416fa7] overl=
aps section .text LMA [0000000000104040,000000000213c503]
>   /home/joel/toolchains/0day_riscv/gcc-13.2.0-nolibc/riscv64-linux/bin/ri=
scv64-linux-ld: section .data..percpu LMA [00000000024d5000,00000000026a76e=
7] overlaps section .rodata LMA [000000000213c540,000000000291e3dd]
>   /home/joel/toolchains/0day_riscv/gcc-13.2.0-nolibc/riscv64-linux/bin/ri=
scv64-linux-ld: section .rodata VMA [ffffffff8213c540,ffffffff8291e3dd] ove=
rlaps section .data VMA [ffffffff82000000,ffffffff82a8afa7]
>   mm/vmscan.o: in function `folio_nr_pages':
>   /home/joel/src/linux-next/briscv/../include/linux/mm.h:2078:(.text.page=
out+0x184): relocation truncated to fit: R_RISCV_GPREL_I against `__func__.=
9'
>   kernel/profile.o: in function `profile_setup':
>   /home/joel/src/linux-next/briscv/../kernel/profile.c:58:(.text.profile_=
setup+0x90): relocation truncated to fit: R_RISCV_GPREL_I against `sleepstr=
=2E2'
>   mm/show_mem.o: in function `show_free_areas':
>   /home/joel/src/linux-next/briscv/../mm/show_mem.c:381:(.text.show_free_=
areas+0x1f54): relocation truncated to fit: R_RISCV_GPREL_I against `types.=
0'
>   fs/fs_types.o: in function `fs_ftype_to_dtype':
>   /home/joel/src/linux-next/briscv/../fs/fs_types.c:38:(.text.fs_ftype_to=
_dtype+0x44): relocation truncated to fit: R_RISCV_GPREL_I against `fs_dtyp=
e_by_ftype'
>   fs/fs_types.o: in function `fs_umode_to_dtype':
>   /home/joel/src/linux-next/briscv/../fs/fs_types.c:103:(.text.fs_umode_t=
o_dtype+0x94): relocation truncated to fit: R_RISCV_GPREL_I against `fs_dty=
pe_by_ftype'
>   security/keys/keyctl.o: in function `keyctl_capabilities':
>   /home/joel/src/linux-next/briscv/../security/keys/keyctl.c:1855:(.text.=
keyctl_capabilities+0x40): relocation truncated to fit: R_RISCV_GPREL_I aga=
inst `keyrings_capabilities'
>   make[3]: *** [../scripts/Makefile.vmlinux:37: vmlinux] Error 1
>   make[3]: Target '__default' not remade because of errors.
>   make[2]: *** [/home/joel/src/linux-next/Makefile:1165: vmlinux] Error 2
>   make[2]: Target '__all' not remade because of errors.
>   make[1]: *** [/home/joel/src/linux-next/Makefile:240: __sub-make] Error=
 2
>   make[1]: Target '__all' not remade because of errors.
>   make[1]: Leaving directory '/home/joel/src/linux-next/briscv'
>   make: *** [Makefile:240: __sub-make] Error 2
>   make: Target '__all' not remade because of errors.
>=20
> # After sysctl change:
>=20
>   ~/s/linux-next (603cac6 =E2=97=BC) =E2=9D=AF=E2=9D=AF=E2=9D=AF COMPILER=
_INSTALL_PATH=3D/home/joel/toolchains/0day_riscv COMPILER=3Dgcc-13.2.0 /hom=
e/joel/src/lkp-tests/kbuild/make.cross W=3D1 O=3Dbriscv ARCH=3Driscv SHELL=
=3D/bin/bash
>   ...
>   /home/joel/toolchains/0day_riscv/gcc-13.2.0-nolibc/riscv64-linux/bin/ri=
scv64-linux-ld: section .data LMA [000000000098c000,0000000001415de7] overl=
aps section .text LMA [0000000000104000,000000000213c603]
>   /home/joel/toolchains/0day_riscv/gcc-13.2.0-nolibc/riscv64-linux/bin/ri=
scv64-linux-ld: section .data..percpu LMA [00000000024d3000,00000000026a56e=
7] overlaps section .rodata LMA [000000000213c640,000000000291e2fd]
>   /home/joel/toolchains/0day_riscv/gcc-13.2.0-nolibc/riscv64-linux/bin/ri=
scv64-linux-ld: section .rodata VMA [ffffffff8213c640,ffffffff8291e2fd] ove=
rlaps section .data VMA [ffffffff82000000,ffffffff82a89de7]
>   init/main.o: in function `.L0 ':
>   /home/joel/src/linux-next/briscv/../init/main.c:769:(.init.text+0x2388)=
: relocation truncated to fit: R_RISCV_GPREL_I against symbol `__stop___par=
am' defined in __param section in .tmp_vmlinux.kallsyms1
>   kernel/extable.o:(.init.text+0x2c): relocation truncated to fit: R_RISC=
V_GPREL_I against symbol `__start___ex_table' defined in __ex_table section=
 in .tmp_vmlinux.kallsyms1
>   kernel/extable.o:(.text.search_exception_tables+0x14): relocation trunc=
ated to fit: R_RISCV_GPREL_I against symbol `__start___ex_table' defined in=
 __ex_table section in .tmp_vmlinux.kallsyms1
>   kernel/params.o: in function `param_sysfs_builtin':
>   /home/joel/src/linux-next/briscv/../kernel/params.c:836:(.init.text+0x3=
54): relocation truncated to fit: R_RISCV_GPREL_I against symbol `__stop___=
param' defined in __param section in .tmp_vmlinux.kallsyms1
>   make[3]: *** [../scripts/Makefile.vmlinux:37: vmlinux] Error 1
>   make[3]: Target '__default' not remade because of errors.
>   make[2]: *** [/home/joel/src/linux-next/Makefile:1165: vmlinux] Error 2
>   make[2]: Target '__all' not remade because of errors.
>   make[1]: *** [/home/joel/src/linux-next/Makefile:240: __sub-make] Error=
 2
>   make[1]: Target '__all' not remade because of errors.
>   make[1]: Leaving directory '/home/joel/src/linux-next/briscv'
>   make: *** [Makefile:240: __sub-make] Error 2
>   make: Target '__all' not remade because of errors.
>=20
> If you see any flaw in this analysis, please let me know.
>=20
> Best
>=20
> --=20
>=20
> Joel Granados



--=20

Joel Granados

--oiroaqkce55dhyqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYxCZAACgkQupfNUreW
QU/P+Qv9HUMonzyxcM3hPs8upJ+b3u9NTf6Wo9Gys5NNZJF6keeOkKgM3pNSvxXV
tucACImqBygsV3dJivAx6/EeujdZIPBEbAISjYDWQvnW3o73A3CWqossLc1svEW5
C4QTbX9keNWkqBwyt+QUPJ5uStrArWRLXvxhpVSK3mSDNtRm+iEg80rznX9AvbsT
vmv0ijCx+7RDPjgIYIlfvh3r7w9qVIffc+TzDSSWnt/QAskc9shiPV2RthSINd0R
GLbX597GU/Qkwvzt6WU/ylqAESNBXVOcvTvLvkEU3Y31G8J5Ia6HRlhu/w9lI5Mf
l7dv9/IgfImJdhyrcR3MgMkdFfTttuZOECSVByS+dyTGyxZ28mYPZlvEKw6UiSFs
vSshFqs/9JpscDixUcAlZCoK+vAmsCzqgITztAB+rjCaNskR75inqhR0EJxRXrSL
BPgbJbdYe4EIZWReN+sAQPtiOWF0M9wt5v0mG+/rqdgA5FCPYty075wSwa9fhPYx
H4OrG2JB
=D34u
-----END PGP SIGNATURE-----

--oiroaqkce55dhyqr--

