Return-Path: <linux-fsdevel+bounces-18643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A98BAE5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183F01F23F15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BD154441;
	Fri,  3 May 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z5932pvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C69848A;
	Fri,  3 May 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744897; cv=none; b=IcXYtE8ZwQEEO99pR7NBdxB9whyEFgkgwSRB0P+1Jy+AucxTRW2T2j7Jep8Vvlhjn3evz50eoiadRIQTWwhicTN/H6OocCtUbGAVL8iiAsVLpcz8ugnVbMNv+oYDecJuEHoi7evhSFbfbqPbZAcEEzQDxKi9yXpYioOaUSDilgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744897; c=relaxed/simple;
	bh=iaX0h6rUKtEhomCK3iBaJv7Kjhb6ygyIqcNzXjc4WxY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=RhuAMg1rwJu9UAl8+PQftvscZE9ltdCociFK8TyL2CfsG/I9dMyCNfb0/1v+jI8ZaLT4LNy9frn3jK4E5mlGb8p4iTdy+EGcXCBFs9ZKpnT8+gqdGHqNZ+6nxBDwMo8LEsuox8e9U0Q1zd1MiZrdwjSAhv9FtcZ3bqEg0ivtfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z5932pvT; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240503140132euoutp0181343546e5919e019c0df37dbb1fe655~L-2UArv9S0326003260euoutp01k;
	Fri,  3 May 2024 14:01:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240503140132euoutp0181343546e5919e019c0df37dbb1fe655~L-2UArv9S0326003260euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714744892;
	bh=fN2OM5c9IQl+wGQ6BdWAi4qNn8eiNM4NK2U3kSSVYh8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Z5932pvTjtVXtbpxYzokxHb5gDq5YwFbXUCDh8abNzP3bzWtZdJ9riO0kFlj1C9jD
	 YQTHO2V6fROzPvg/TrSyQISYSgHVy5C9bsTZtOqCYR8hO1c2QjLnyaxKpxRkEEg5WL
	 SG86Ex35w5cZFnJbAL6lcS1ansXOwpsQbB+toNns=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240503140132eucas1p1e42f1f00a4c0c3011b066e745425d5c2~L-2TwfATi2217122171eucas1p1P;
	Fri,  3 May 2024 14:01:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 50.AD.09624.B3EE4366; Fri,  3
	May 2024 15:01:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240503140131eucas1p1bcd327f6b7fbeb36ea4d5234c1578b6d~L-2TI7jft2217922179eucas1p1K;
	Fri,  3 May 2024 14:01:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240503140131eusmtrp2270f5d74c935b0dc330652edf1d86082~L-2THyMR91693116931eusmtrp2b;
	Fri,  3 May 2024 14:01:31 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-9a-6634ee3bd91b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C8.AF.09010.B3EE4366; Fri,  3
	May 2024 15:01:31 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240503140131eusmtip1aa1216dbf0260fa1cd446614d8f742a4~L-2SySDmb1504015040eusmtip14;
	Fri,  3 May 2024 14:01:31 +0000 (GMT)
Received: from localhost (106.210.248.112) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 3 May 2024 15:01:29 +0100
Date: Fri, 3 May 2024 14:56:07 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: David Ahern <dsahern@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Joerg Reuter
	<jreuter@yaina.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef
	Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
	Aleksandrov <razor@blackwall.org>, "Alexander Aring" <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Wenjia Zhang
	<wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe"
	<alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
	<guwen@linux.alibaba.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-hams@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <bridge@lists.linux.dev>,
	<linux-wpan@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-sctp@vger.kernel.org>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify
 ctl_table_header::ctl_table_arg
Message-ID: <20240503125607.yekwvbtged2fmdbw@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="yvyg4rr3uiq245na"
Content-Disposition: inline
In-Reply-To: <20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfTBcVxjG59x7995FN72W4VS0zfjsSLONNJMeqRrSJL3VdqTaTicyaaPc
	IFi6S5BoRyIaVmK2aIz1kSUtgizRHWsJ0o1Q36RiMOjQqI5gxfdHQq0r08z0v9/7Ps8z533+
	OHxcmEVZ8YPEEaxE7BtiQxoTlY0rHXtcp/ef3tskRbq4d9DIHRkPVd5IxtAz7WUcZXdeIpCq
	OgFDY42jFCq5OEggzfgSiZInrFFPwQyJVlJMUKYsHkNtyaGoqzKFh+7UNhOoVzOEoT+qs0kk
	z4vH0ZjyMQ8NphUQaG35bwyNlukxtFrUxEMdVzdwpFAV46hPPgbQvct1PNRWdpFCjUoLJFe1
	EGixdRKgjMmHOGqZ38DQXPYbKK1IjaGapGUK/bU0TqILbZWUuyMz3dEMmNzS80xWXDfBrK44
	Meqb/RijVQxRTOVde0ZZEclUFCeRjHbEhZHn3wXMP79mAmZq7XeMuRo/TTL6uockU5HwM++Y
	mY+xqz8bEnSWlbzldso4sEJ3iwpvTwXR+rERPA5ciZEBIz6k98PZ3E6eDBjzhXQRgIM9DRg3
	zAOYXarjGVxCeg5A3fiJ54na9laSMxUCOHX9T5wbNk3q3tltRQ3gaFYBaYgQtB1UtGsoA5P0
	m7BzchA3sDntCm8uzlGGAE5vGMOnA8OEQTCjP4dziwVbbwtod3j72gLOsSlszny05cHpaDhT
	U7vp4W/yTli4zjesjWgvuJieSnGn2sIGTc42fwdb1ANb3SBdYwL7SrUEJxyGPRu/AY7N4EST
	ejtgDTe017cDaQDWr89Q3FACYMGFBYxzvQsv9TyiDFdA2gPW53hzuAP2TZlyd+6AqZUZOLcW
	wMQfhFzQAZYMTxJyYKt4oZnihWaK/5pxaxHs+ymd/N96NyzIe4xz/B5UqfSEElDFwJKNlIYG
	sFJnMRslkvqGSiPFASK/sNAKsPlnWtebZqtAzsQTkQ5gfKADdpvh0fKSLmBFiMPErI25YHfa
	26eFAn/fmHOsJOxrSWQIK9WBnXzCxlJg7/86K6QDfCPYYJYNZyXPVYxvZBWHeTZ6HovSzxz8
	xtshYdVi+v19jjJ9ddUvfvbRs0FxPWuftc2IPqjCxqxL5yxPRU04533ZcKDG6trJCJdir+Uk
	TJuiEvWJnRP3fFJy60z+R68+FZ700Xaf7/dc8LCfOZjfLLnvVpsUHPJ9F+o/nhQ713fmi7Mf
	Hn3lgbDeT7nX2SI2x6FQcx9Lvy0zOmQRvu7abNly+MlKuXvds11hKQO1P/IAsAUandc5XrTg
	NXFM4aGW7CAn8/ojZscfvCwv5+Vauhzu3ueXOG48f0OTYtLFumX0lpkq3Y4Glqcd4PPHXkLK
	e97DrrvUX/mMNsrXOzI/ldp9G9a9FB3rMRQ8n3ql5eMTjlE2hDTQ19kJl0h9/wX9Kj9xrgQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTbUxTVxzGd+69vS2wklpwO2HoTIeZE2gpr6cOCB8wuWYmI87sA4ywRi6g
	0pb0hcDIJoMRbBuRl02lMi0MEFBbYKWMigRhA6Gg4AabE5yygYSXIoFRCgIr1GUm+/ac5/n/
	nnNycg4L51pIH9ZJqZKWS8XpPNKdsG72jge+bwtNCXpg3oW6ciPQ03YNA5m/02Joo60QRxX3
	vyKQwVKAocmeCSa6njdGoNZndhJpZ3zRL7XPSeQo8kDlmnwMDWglaMhcxEDtt/sINNo6jqGf
	LRUkKq7Mx9GkfpaBxspqCbS+OoWhCeMChtbqehno3rktHOkMDTj6rXgSoO7CDgYaMOYxUY/+
	DVRs6CfQinUOoItzIzjqX97C0FLFAVRWZ8LQLfUqE/1pf0aiLwfMzJh3Kdu9PkBduZFDXc4d
	Jqg1x0HKVP8Qo9p040zK3Lmf0jerqOYGNUm1PRVRxVWdgJr+vhxQ8+t3Mepcvo2kFjpGSKq5
	oJoR5xXPj5TLVEp6X5pMoYziJQhRMF8oQvzgUBFfGBKReCg4jCeIjkym009m0nJB9Kf8tBdX
	NogMaynIqq6+S+QCTbYGuLEgJxTeHrSSGuDO4nJqACx4qAeuwBc2LY8wXNoLvhjVvBxaBFA7
	f47pWpgAbFwbw7enCI4f1A22Mrc1yQmA9+dcvjcnEtavLO0AOGfDHepLZojtwItzHC6t1O5s
	webEwKYLf+Ou1ioA25+YMFewC/aV/7UD4JxMeKFm3AmwnPoteG2TtW27cT6EK1+XMl1HfQf+
	2PrtS/05XNqYAsXAS/dKk+6VJt1/TS47ALa1jJH/s/1hbeUs7tJR0GBYIPSA2QC8aZVCkipR
	BPMVYolCJU3ln5BJmoHz4Zp7HKYfQP3MIr8LYCzQBfyc5ETj9SHgQ0hlUprnzfYvC0nhspPF
	2Z/RclmSXJVOK7pAmPMaS3Cf3Sdkzl8gVSYJw4PChKHhoqAwUXgI7032kYyzYi4nVaykT9N0
	Bi3/l8NYbj65GErYE+VX0ZE4mZvt47g52xiX+hNkSqc7avzeDlCLe873Vi6K1nv2Hj6tZr92
	9dGAsUSszvbL+SBnX3yv0bfMbtnsEmQd3R3geWC+JMXgWS0oO5zQ4JHo/8V5/zva6Epj4YNH
	2mPDVtWqxGb85tZFWacg+8nj5ayzizml/aeGR17/teATT7czMxF3npcyC2O3rHbhxjIP5gz1
	X81qmlrpjnPM27qPJp/py+P+4TFqupQZGWS55li3t8i9Gj8KTigaFMRXhsRWDUmn4+utNy8T
	7MdJQXP6Ppua+3sgZe/QeIqOFdmUAtlxmeXGnpi9h0QxNQ3vTccGXopv2d9+6mO34ToeoUgT
	Cw/icoX4H/dVO6ZNBAAA
X-CMS-MailID: 20240503140131eucas1p1bcd327f6b7fbeb36ea4d5234c1578b6d
X-Msg-Generator: CA
X-RootMTR: 20240418094054eucas1p21587abc8e1707712481b198d9c138d94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240418094054eucas1p21587abc8e1707712481b198d9c138d94
References: <CGME20240418094054eucas1p21587abc8e1707712481b198d9c138d94@eucas1p2.samsung.com>
	<20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net>

--yvyg4rr3uiq245na
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:40:08AM +0200, Thomas Wei=DFschuh wrote:
> To be able to constify instances of struct ctl_tables it is necessary to
> remove ways through which non-const versions are exposed from the
> sysctl core.
> One of these is the ctl_table_arg member of struct ctl_table_header.
>=20
> Constify this reference as a prerequisite for the full constification of
> struct ctl_table instances.
> No functional change.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Add link to original monolithic series
> - Send to all maintainers again
> - Link to v1: https://lore.kernel.org/r/20240322-sysctl-const-table-arg-v=
1-1-88436d34961b@weissschuh.net
> ---
> This is a standalone version of PATCH 11 from my original const-sysctl
> series at
> https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weis=
sschuh.net/
>=20
> It is based upon the branch constfy of
> https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/
>=20
> This patch is meant to be applied through the sysctl tree.
>=20
> It was implemented by manually searching for "ctl_table_arg"
> throughout the tree and inspecing each found site.
>=20
> If somebody comes up with a cocciscript for this, I'll be happy to use
> that.
> ---
>  drivers/net/vrf.c                       | 2 +-
>  include/linux/sysctl.h                  | 2 +-
>  ipc/ipc_sysctl.c                        | 2 +-
>  ipc/mq_sysctl.c                         | 2 +-
>  kernel/ucount.c                         | 2 +-
>  net/ax25/sysctl_net_ax25.c              | 2 +-
>  net/bridge/br_netfilter_hooks.c         | 2 +-
>  net/core/sysctl_net_core.c              | 2 +-
>  net/ieee802154/6lowpan/reassembly.c     | 2 +-
>  net/ipv4/devinet.c                      | 2 +-
>  net/ipv4/ip_fragment.c                  | 2 +-
>  net/ipv4/route.c                        | 2 +-
>  net/ipv4/sysctl_net_ipv4.c              | 2 +-
>  net/ipv4/xfrm4_policy.c                 | 2 +-
>  net/ipv6/addrconf.c                     | 2 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
>  net/ipv6/reassembly.c                   | 2 +-
>  net/ipv6/sysctl_net_ipv6.c              | 6 +++---
>  net/ipv6/xfrm6_policy.c                 | 2 +-
>  net/mpls/af_mpls.c                      | 4 ++--
>  net/mptcp/ctrl.c                        | 2 +-
>  net/netfilter/nf_conntrack_standalone.c | 2 +-
>  net/netfilter/nf_log.c                  | 2 +-
>  net/sctp/sysctl.c                       | 2 +-
>  net/smc/smc_sysctl.c                    | 2 +-
>  net/unix/sysctl_net_unix.c              | 2 +-
>  net/xfrm/xfrm_sysctl.c                  | 2 +-
>  27 files changed, 30 insertions(+), 30 deletions(-)
I see that Kees has reviewed this, but most of it falls in the network
subsystem. At this point I see three options:

1. I queue it all up in the sysctl changes going into 6.11 and it make
   its way to mainline that way.
2. Since its mostly network, it can all go through that path
3. We split this up into netwokring and non-networking changes and each
   takes its separate path.

I would like to hear from the network folks on these options.

Best
>=20
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index bb95ce43cd97..66f8542f3b18 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -1971,7 +1971,7 @@ static int vrf_netns_init_sysctl(struct net *net, s=
truct netns_vrf *nn_vrf)
>  static void vrf_netns_exit_sysctl(struct net *net)
>  {
>  	struct netns_vrf *nn_vrf =3D net_generic(net, vrf_net_id);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D nn_vrf->ctl_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(nn_vrf->ctl_hdr);
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 47bd28ffa88f..09db2f2e6488 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -171,7 +171,7 @@ struct ctl_table_header {
>  		struct rcu_head rcu;
>  	};
>  	struct completion *unregistering;
> -	struct ctl_table *ctl_table_arg;
> +	const struct ctl_table *ctl_table_arg;
>  	struct ctl_table_root *root;
>  	struct ctl_table_set *set;
>  	struct ctl_dir *parent;
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 19b2a67aef40..113452038303 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -305,7 +305,7 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
> =20
>  void retire_ipc_sysctls(struct ipc_namespace *ns)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
> =20
>  	tbl =3D ns->ipc_sysctls->ctl_table_arg;
>  	unregister_sysctl_table(ns->ipc_sysctls);
> diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
> index 43c0825da9e8..068e7d5aa42b 100644
> --- a/ipc/mq_sysctl.c
> +++ b/ipc/mq_sysctl.c
> @@ -159,7 +159,7 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
> =20
>  void retire_mq_sysctls(struct ipc_namespace *ns)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
> =20
>  	tbl =3D ns->mq_sysctls->ctl_table_arg;
>  	unregister_sysctl_table(ns->mq_sysctls);
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 90300840256b..366a2c1971f5 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -119,7 +119,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
>  void retire_userns_sysctls(struct user_namespace *ns)
>  {
>  #ifdef CONFIG_SYSCTL
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
> =20
>  	tbl =3D ns->sysctls->ctl_table_arg;
>  	unregister_sysctl_table(ns->sysctls);
> diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
> index db66e11e7fe8..e0128dc9def3 100644
> --- a/net/ax25/sysctl_net_ax25.c
> +++ b/net/ax25/sysctl_net_ax25.c
> @@ -171,7 +171,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
>  void ax25_unregister_dev_sysctl(ax25_dev *ax25_dev)
>  {
>  	struct ctl_table_header *header =3D ax25_dev->sysheader;
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	if (header) {
>  		ax25_dev->sysheader =3D NULL;
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_ho=
oks.c
> index 35e10c5a766d..a09118c56c7d 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -1268,7 +1268,7 @@ static int br_netfilter_sysctl_init_net(struct net =
*net)
>  static void br_netfilter_sysctl_exit_net(struct net *net,
>  					 struct brnf_net *brnet)
>  {
> -	struct ctl_table *table =3D brnet->ctl_hdr->ctl_table_arg;
> +	const struct ctl_table *table =3D brnet->ctl_hdr->ctl_table_arg;
> =20
>  	unregister_net_sysctl_table(brnet->ctl_hdr);
>  	if (!net_eq(net, &init_net))
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 6973dda3abda..903ab4a51c17 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -743,7 +743,7 @@ static __net_init int sysctl_core_net_init(struct net=
 *net)
> =20
>  static __net_exit void sysctl_core_net_exit(struct net *net)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
> =20
>  	tbl =3D net->core.sysctl_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->core.sysctl_hdr);
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan=
/reassembly.c
> index 6dd960ec558c..2a983cf450da 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -399,7 +399,7 @@ static int __net_init lowpan_frags_ns_sysctl_register=
(struct net *net)
> =20
>  static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  	struct netns_ieee802154_lowpan *ieee802154_lowpan =3D
>  		net_ieee802154_lowpan(net);
> =20
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 7a437f0d4190..7592f242336b 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2749,7 +2749,7 @@ static __net_init int devinet_init_net(struct net *=
net)
>  static __net_exit void devinet_exit_net(struct net *net)
>  {
>  #ifdef CONFIG_SYSCTL
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
> =20
>  	tbl =3D net->ipv4.forw_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv4.forw_hdr);
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index a4941f53b523..6b9285fd6f06 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -632,7 +632,7 @@ static int __net_init ip4_frags_ns_ctl_register(struc=
t net *net)
> =20
>  static void __net_exit ip4_frags_ns_ctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D net->ipv4.frags_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv4.frags_hdr);
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index c8f76f56dc16..af30b5942ba4 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -3590,7 +3590,7 @@ static __net_init int sysctl_route_net_init(struct =
net *net)
> =20
>  static __net_exit void sysctl_route_net_exit(struct net *net)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
> =20
>  	tbl =3D net->ipv4.route_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv4.route_hdr);
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 7e4f16a7dcc1..ce5d19978a26 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1554,7 +1554,7 @@ static __net_init int ipv4_sysctl_init_net(struct n=
et *net)
> =20
>  static __net_exit void ipv4_sysctl_exit_net(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	kfree(net->ipv4.sysctl_local_reserved_ports);
>  	table =3D net->ipv4.ipv4_hdr->ctl_table_arg;
> diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
> index c33bca2c3841..1dda59e0aeab 100644
> --- a/net/ipv4/xfrm4_policy.c
> +++ b/net/ipv4/xfrm4_policy.c
> @@ -186,7 +186,7 @@ static __net_init int xfrm4_net_sysctl_init(struct ne=
t *net)
> =20
>  static __net_exit void xfrm4_net_sysctl_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	if (!net->ipv4.xfrm4_hdr)
>  		return;
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 247bd4d8ee45..9c34a351f115 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7235,7 +7235,7 @@ static int __addrconf_sysctl_register(struct net *n=
et, char *dev_name,
>  static void __addrconf_sysctl_unregister(struct net *net,
>  					 struct ipv6_devconf *p, int ifindex)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	if (!p->sysctl_header)
>  		return;
> diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter=
/nf_conntrack_reasm.c
> index 1a51a44571c3..98809f846229 100644
> --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> @@ -105,7 +105,7 @@ static int nf_ct_frag6_sysctl_register(struct net *ne=
t)
>  static void __net_exit nf_ct_frags6_sysctl_unregister(struct net *net)
>  {
>  	struct nft_ct_frag6_pernet *nf_frag =3D nf_frag_pernet(net);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D nf_frag->nf_frag_frags_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(nf_frag->nf_frag_frags_hdr);
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index acb4f119e11f..ee95cdcc8747 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -487,7 +487,7 @@ static int __net_init ip6_frags_ns_sysctl_register(st=
ruct net *net)
> =20
>  static void __net_exit ip6_frags_ns_sysctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D net->ipv6.sysctl.frags_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv6.sysctl.frags_hdr);
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 888676163e90..75de55f907b0 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -313,9 +313,9 @@ static int __net_init ipv6_sysctl_net_init(struct net=
 *net)
> =20
>  static void __net_exit ipv6_sysctl_net_exit(struct net *net)
>  {
> -	struct ctl_table *ipv6_table;
> -	struct ctl_table *ipv6_route_table;
> -	struct ctl_table *ipv6_icmp_table;
> +	const struct ctl_table *ipv6_table;
> +	const struct ctl_table *ipv6_route_table;
> +	const struct ctl_table *ipv6_icmp_table;
> =20
>  	ipv6_table =3D net->ipv6.sysctl.hdr->ctl_table_arg;
>  	ipv6_route_table =3D net->ipv6.sysctl.route_hdr->ctl_table_arg;
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index 42fb6996b077..4891012b692f 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -218,7 +218,7 @@ static int __net_init xfrm6_net_sysctl_init(struct ne=
t *net)
> =20
>  static void __net_exit xfrm6_net_sysctl_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	if (!net->ipv6.sysctl.xfrm6_hdr)
>  		return;
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 6dab883a08dd..973881b8faa3 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -1438,7 +1438,7 @@ static void mpls_dev_sysctl_unregister(struct net_d=
evice *dev,
>  				       struct mpls_dev *mdev)
>  {
>  	struct net *net =3D dev_net(dev);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	if (!mdev->sysctl)
>  		return;
> @@ -2706,7 +2706,7 @@ static void mpls_net_exit(struct net *net)
>  {
>  	struct mpls_route __rcu **platform_label;
>  	size_t platform_labels;
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  	unsigned int index;
> =20
>  	table =3D net->mpls.ctl->ctl_table_arg;
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 13fe0748dde8..8d661156ab8c 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -198,7 +198,7 @@ static int mptcp_pernet_new_table(struct net *net, st=
ruct mptcp_pernet *pernet)
> =20
>  static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
>  {
> -	struct ctl_table *table =3D pernet->ctl_table_hdr->ctl_table_arg;
> +	const struct ctl_table *table =3D pernet->ctl_table_hdr->ctl_table_arg;
> =20
>  	unregister_net_sysctl_table(pernet->ctl_table_hdr);
> =20
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_c=
onntrack_standalone.c
> index 0ee98ce5b816..bb9dea676ec1 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -1122,7 +1122,7 @@ static int nf_conntrack_standalone_init_sysctl(stru=
ct net *net)
>  static void nf_conntrack_standalone_fini_sysctl(struct net *net)
>  {
>  	struct nf_conntrack_net *cnet =3D nf_ct_pernet(net);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D cnet->sysctl_header->ctl_table_arg;
>  	unregister_net_sysctl_table(cnet->sysctl_header);
> diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
> index 370f8231385c..efedd2f13ac7 100644
> --- a/net/netfilter/nf_log.c
> +++ b/net/netfilter/nf_log.c
> @@ -514,7 +514,7 @@ static int netfilter_log_sysctl_init(struct net *net)
> =20
>  static void netfilter_log_sysctl_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D net->nf.nf_log_dir_header->ctl_table_arg;
>  	unregister_net_sysctl_table(net->nf.nf_log_dir_header);
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index f65d6f92afcb..25bdf17c7262 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -624,7 +624,7 @@ int sctp_sysctl_net_register(struct net *net)
> =20
>  void sctp_sysctl_net_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D net->sctp.sysctl_header->ctl_table_arg;
>  	unregister_net_sysctl_table(net->sctp.sysctl_header);
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index a5946d1b9d60..4e8baa2e7ea4 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -133,7 +133,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
> =20
>  void __net_exit smc_sysctl_net_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D net->smc.smc_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->smc.smc_hdr);
> diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
> index 3e84b31c355a..44996af61999 100644
> --- a/net/unix/sysctl_net_unix.c
> +++ b/net/unix/sysctl_net_unix.c
> @@ -52,7 +52,7 @@ int __net_init unix_sysctl_register(struct net *net)
> =20
>  void unix_sysctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D net->unx.ctl->ctl_table_arg;
>  	unregister_net_sysctl_table(net->unx.ctl);
> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
> index 7fdeafc838a7..e972930c292b 100644
> --- a/net/xfrm/xfrm_sysctl.c
> +++ b/net/xfrm/xfrm_sysctl.c
> @@ -76,7 +76,7 @@ int __net_init xfrm_sysctl_init(struct net *net)
> =20
>  void __net_exit xfrm_sysctl_fini(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
> =20
>  	table =3D net->xfrm.sysctl_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->xfrm.sysctl_hdr);
>=20
> ---
> base-commit: 48a8b5270db856be233021e47a5f1dc02d47ed0d
> change-id: 20231226-sysctl-const-table-arg-2c828e0264dc
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--yvyg4rr3uiq245na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY03uYACgkQupfNUreW
QU9rpgv+LMI/CY9LR0XCel701LS2lPn/3XQ45JHWHEBRDWutMm9vatsXnVvIoaQp
9goOKPta5+HEqSbY3yPtQLzpQyR56jKQYeYpNGp9Cfeax6NQLDnzIebDsVtYFO6Q
rRYIEIWSinsOcnragmvhjk3i5POVFR0BkhR2h7kig0ps2C3EAXVcYjZ+Tse8KvTS
h8POZkuw5j04FTBGJNdmdeZM2XImsc5muslm+sU9QZjAiAczczkhSRud47b9Xz5b
hAduA6g1J4b5VkAtt4LnbDY7UlGH6MQco/54UqxdNyQ7AC1no78/HQHPbXKrej5Z
reqjeUk48au8/N9NtORWbLJ8gCy++uWoAmh8PosLsLSG0y0fyT0b8wAJMMei7S/q
0g+AGkRsSXE9g1c+6ypDz1N+UVf6rkIUmI7BpM3Z+zik2mDab7vB1sLnE2t29FZm
obFCgW99jWJCmt8yS8AsaIR2F/YHukwRixT96vg1W43VPUGiMV132N91jPnS9ZR1
YhKtxJoy
=GSEF
-----END PGP SIGNATURE-----

--yvyg4rr3uiq245na--

