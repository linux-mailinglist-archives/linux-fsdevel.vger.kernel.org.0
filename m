Return-Path: <linux-fsdevel+bounces-27434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7068196183A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014111F2413D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED01D3654;
	Tue, 27 Aug 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OVIXCCbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C561D3652
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788258; cv=none; b=mhbeJwrLirssgDG6yLDrEKoOJaT9JwiqI2xw/6C2LWUFhvJVzPef1XXr26D/yjePAnoC83d8pxpiqMTT1VW8sBeDBTR0NydLy7EfFFM+3hl4vihXttC3vHoM/7U4lOAWX/+t1799OVH6n1TQjc1TGB3mFXgZoVoqVvaystsrvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788258; c=relaxed/simple;
	bh=EvQO0uA0BhzYO2XF9beZx3IvAZ/PpNwJRfaNYRsSpnc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=E9uSpl4vTdkyjH4Lyl9qxu2XJ4Ypq3sIupLSq8dei+4+p3lrqg2u2fPV7fyFMnlHy7+RSEsW7heYjbMaQHEYyS1l2JdBx1Yk2ZDOHQzjBzzGFwcGMYIblNvDaAujOT68PkUhyl0sjBJC1qaq7KSsMJqI01deAEsVUxpB3XNONy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OVIXCCbb; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240827195049euoutp01c4429ea737ba6aea1310e16f12617872~vrcZNJbpw3066230662euoutp01e
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 19:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240827195049euoutp01c4429ea737ba6aea1310e16f12617872~vrcZNJbpw3066230662euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724788249;
	bh=RbgxCt4c9LLN/5M2xpsNkhslAjeybQo+iNmMUSkrSXQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OVIXCCbbY2QKGTL0bxxHN85fHfoEpsx9Xi8mmzReq/PCrRUy9SwRofdw3g9D/bo6f
	 tYXjAkr1THnbBg4MUqbgecqZh71SjXejJwVxZrg23IWofVWaznJ4U7jhjOjGqmMzJS
	 YyCzYX3AhkZelypdOrqjflu3avV9dLsw194p9eqs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240827195049eucas1p2b511dfa65dee588f9136300cc2bbd755~vrcY2ZM2G0652606526eucas1p2O;
	Tue, 27 Aug 2024 19:50:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 7A.B4.09875.81E2EC66; Tue, 27
	Aug 2024 20:50:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240827195048eucas1p126c94ff638c5b766f66205ad9bfc4ec3~vrcYk6Eiw1412914129eucas1p14;
	Tue, 27 Aug 2024 19:50:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240827195048eusmtrp17fb10a10fd0e3efd0b225827498103bc~vrcYkbYoj0185601856eusmtrp1i;
	Tue, 27 Aug 2024 19:50:48 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-db-66ce2e188d1a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.D1.08810.81E2EC66; Tue, 27
	Aug 2024 20:50:48 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240827195048eusmtip14a4f942ed8a0d53e7219cbdbdb6cb322~vrcYZkOff0744707447eusmtip1F;
	Tue, 27 Aug 2024 19:50:48 +0000 (GMT)
Received: from localhost (106.210.248.81) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 27 Aug 2024 20:50:47 +0100
Date: Tue, 27 Aug 2024 16:27:49 +0200
From: Joel Granados <j.granados@samsung.com>
To: Xingyu Li <xli399@ucr.edu>
CC: <mcgrof@kernel.org>, <kees@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: BUG: general protection fault in put_links
Message-ID: <20240827142749.ibj4fjdp6n7wvz2p@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALAgD-4n=bgzbLyyw1Q3C=2aa=wh8FimDgS30ud_ay53hDgYBQ@mail.gmail.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87qSeufSDLZ5WKx7e57VYs/ekywW
	l3fNYbO4MeEpo8WLCTvZHFg9Nq3qZPOYNfsqk8fnTXIBzFFcNimpOZllqUX6dglcGWdnfGcs
	uMJcsejGBvYGxtdMXYwcHBICJhLfZ2V3MXJxCAmsYJRYuH0LC4TzhVGiZe0dKOczo8T99vlA
	DidYx6m1KxkhEssZJe70bGOGq7pwYzGUs4VR4umxTjaQFhYBVYklP7eBtbMJ6Eicf3OHGcQW
	EZCTmHr7LCuIzSyQK7Gv9S5YvbCAucTDk4vBbF4BB4mdl++wQtiCEidnPmGBqNeRWLD7ExvI
	E8wC0hLL/3GAhDkFAiX2HbvBCnGpksTbji4mCLtW4tSWW0wgt0kIHOGQmD31J1SRi8Sd/8uh
	ioQlXh3fwg5hy0icntzDAtEwmVFi/78P7BDOakaJZY1foTqsJVquPGGHBKWjxI9fKRAmn8SN
	t4IQd/JJTNo2nRkizCvR0SYE0agmsfreG5YJjMqzkHw2C8lnsxA+W8DIvIpRPLW0ODc9tdgo
	L7Vcrzgxt7g0L10vOT93EyMwhZz+d/zLDsblrz7qHWJk4mA8xCjBwawkwnvi+Nk0Id6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBiapNQ6qbtPPNNwIt/2v
	tMZ8l1vA/3otmQtfMppmii7a8obb/Z/vx6sF/eWbgm43bZ8pfNDxF/fq9qI9cU9e3/KL9Hr3
	1LlPMEcoS8Yip6fFTV/ebPrLyL3BHYvnfTd8pLNZ4saqxQYG0T+S0jm8LkWfNWfM5PpSfyH1
	xwuHuuzNtS6PlkW8nCOeurmu7o76C55zffu+MD851Z5anNd08Fv2sbs5a79p/0/7xvNKpeWh
	3FvLKd+5UsWmvzDl2vDj48bbZndv77XV+Rgt6SdlaR38jlXn6inlWoPOhQFfrnXHeWlZX39x
	yOPp2vDFD25f3FHHr/7OzEVfL/W201359Y/EPDZt5Tq7Lc+zRGHe3qdKLMUZiYZazEXFiQCy
	rmwTkAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7oSeufSDH4/07VY9/Y8q8WevSdZ
	LC7vmsNmcWPCU0aLFxN2sjmwemxa1cnmMWv2VSaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLOzvjOWHCFuWLRjQ3sDYyvmboYOTkk
	BEwkTq1dydjFyMUhJLCUUeL4mblsEAkZiY1frrJC2MISf651sUEUfWSUOPvzCyuEs4VRYvPK
	WYwgVSwCqhJLfm5jAbHZBHQkzr+5wwxiiwjISUy9fRZsErNArsS+1rtgG4QFzCUenlwMZvMK
	OEjsvHwHaugSRomlq+4xQyQEJU7OfMIC0awjsWD3J6AGDiBbWmL5Pw6QMKdAoMS+YzegLlWS
	eNvRBfVarcTnv88YJzAKz0IyaRaSSbMQJi1gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kR
	GE3bjv3cvINx3quPeocYmTgYDzFKcDArifCeOH42TYg3JbGyKrUoP76oNCe1+BCjKTAoJjJL
	iSbnA+M5ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBSfP05xgZ
	6yMJt5fxKHnc3PC+3/VRTjSH6Q+1fe7C9zb9EJU16TX68McrWOe70tELM3JsnKL07aQNqgRY
	JT+1fbbf8YP/8OSunD0NDvHO/KbCq+ftfLxQvX/KnJTtbd15unfmlWYXRtvvfuewvc56w/ks
	d1WxV67yve3+9qoTes4+EmO0/VDHw7p++xWO8JrLGjFvDpb1b8wQsn8s1SAv+vtw4epHh+Ze
	jnrKw+MgyJm4+5G7Rt7HLXUP9onsrg5USjOePK/evWJmt3Wwy/zGNbIrNc+vmqDAcJiFJePk
	L8+1PaUGXbtulHUorhOMji0RKksM8f3h8vEfJ3Phzdpiq4BW3gUnjq2PFC9rmKHEUpyRaKjF
	XFScCAAtJEnqLwMAAA==
X-CMS-MailID: 20240827195048eucas1p126c94ff638c5b766f66205ad9bfc4ec3
X-Msg-Generator: CA
X-RootMTR: 20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4
References: <CGME20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4@eucas1p2.samsung.com>
	<CALAgD-4n=bgzbLyyw1Q3C=2aa=wh8FimDgS30ud_ay53hDgYBQ@mail.gmail.com>

On Sat, Aug 24, 2024 at 10:04:54PM -0700, Xingyu Li wrote:
> Hi,
> 
> We found a bug in Linux 6.10. It is probably a null pointer reference bug.
> The reason is probably that before line 123 of
> fs/proc/proc_sysctl.c(entry = &head->ctl_table[ctl_node -
> head->node];), there is no null pointer check for `head`.
> The bug report is as follow:

Thx for the report. How did you trigger it. Do you have code that
triggers it?

Best

-- 

Joel Granados

