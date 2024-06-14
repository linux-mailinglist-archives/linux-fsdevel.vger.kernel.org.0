Return-Path: <linux-fsdevel+bounces-21711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35F908C36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7671F2820E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0C19ADBE;
	Fri, 14 Jun 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m81n540M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449B19ADA8
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370082; cv=none; b=YS+cc2mfNngjIVGBBg6ziK2No8tbaSeN4YZawlcSBlfgvx6nqtvaD+BD1ObeEjQOEHzvIH9Dke5x6Scrq1BL6gSNNdyINdWs8u0BxdTUonjFptnfJkN/HteovtkRHMe9d3fYqYINRFw3o0cEjvpr9P07E9HoeUFPX9F6XPBRqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370082; c=relaxed/simple;
	bh=hMvpZ9tbClbrtkjPDgxqeJECwCWJoQC4gPzaXkKI5VE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=W8vb1VRPYWe58ca+D61ECCnjBI2xMMp5yH80VZ76Nll10v/K3k3r4lRNjlB//RLypboPqeAxyA/pUSeZMBtnX1GW5IeYN5eZzjyB96SmXux6D4JjIBymFbZMDPbrztu7eKiIPH+Fx670K4tzfkWuxu26AqIEMrRAkVkx/LHZHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m81n540M; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240614130118euoutp02ef9ea254e3027406221941284c61170c~Y4HtVaCAa3084830848euoutp021
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 13:01:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240614130118euoutp02ef9ea254e3027406221941284c61170c~Y4HtVaCAa3084830848euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718370078;
	bh=Cu9Kth/VrhXwdZCe9UNE3CqQju5jHEgy4z5jh3by9oU=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=m81n540MYWTAA9ydrCEFZoh5sPrQ3Qz8hD/mLU7LAD8raEfX7M3BXmZ5BQNE8jawp
	 x2EX1wDs8vdMzyNoYeVjXPiiT7JPk4BUINRz0R01I94fu3ui6GGwxfaFoB2/j0Y0In
	 vTwvo8IV4g7FfBTbGoqs6zTLJdzoAtf3QzSOQiik=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240614130117eucas1p1c39ba449271398be15a5ea68c843d411~Y4Hs5JJlv2271122711eucas1p1P;
	Fri, 14 Jun 2024 13:01:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 57.7C.09875.D1F3C666; Fri, 14
	Jun 2024 14:01:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240614130117eucas1p2657abb565497200b6f1425771ae37129~Y4Hsgg1rh0312203122eucas1p2F;
	Fri, 14 Jun 2024 13:01:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240614130117eusmtrp11437275246ceae19229be6dbc6195987~Y4Hsfyw_q3250832508eusmtrp1L;
	Fri, 14 Jun 2024 13:01:17 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-9d-666c3f1dc2de
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B8.D7.09010.D1F3C666; Fri, 14
	Jun 2024 14:01:17 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240614130116eusmtip2e539933a9e2dd0d084995254c57ec5fa~Y4HsMU8NA1374913749eusmtip2N;
	Fri, 14 Jun 2024 13:01:16 +0000 (GMT)
Received: from localhost (106.210.248.168) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 14 Jun 2024 14:01:15 +0100
Date: Fri, 14 Jun 2024 15:01:10 +0200
From: Joel Granados <j.granados@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, "Kent
 Overstreet" <kent.overstreet@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
	<keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
	Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 8/8] sysctl: Warn on an empty procname element
Message-ID: <20240614130110.rovlk7be2ytkcm6x@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604-jag-sysctl_remset-v1-8-2df7ecdba0bd@samsung.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7qy9jlpBu0vlSzmrF/DZrFmSyOT
	xZzzLSwWT489Yrc4051rMfv5V2aLC9v6WC327D3JYnF51xw2i3tr/rNanD52gsXixoSnjBaX
	Dixgsji2QMzi2+k3jBbHew8wWUy+tIDNouWOqYOQx+yGiyweW1beZPLYOesuu8eCTaUem1do
	eWxa1cnmsenTJHaPEzN+s3gsbJjK7PF+31U2j8+b5AK4o7hsUlJzMstSi/TtErgyju48ylhw
	iKtiwoQpzA2Mezi6GDk4JARMJE4/AzK5OIQEVjBK3P68i6mLkRPI+cIoceGGM0TiM6PE17Yz
	YAmQhjn/mpggEssZJZbun8sOV7X04V1mCGcro8TLia0sIDtYBFQltk6QBulmE9CROP/mDliN
	iEAvq8T/LacZQRLCAk4SE7ZNB1vBK+Ag0bRpLSOELShxcuYTFhCbGah5we5PbCAzmQWkJZb/
	4wAJcwq4S/y/eIkN4jplieWnZzJD2LUSp7bcArtUQuASp8SqhkOsEAkXiVcLtjFC2MISr45v
	YYewZSROT+5hgWiYzCix/98HdghnNaPEssav0ACwlmi58gSqw1Fi8/R+VkhI8knceCsIcSif
	xKRt05khwrwSHW1CENVqEqvvvWGBCMtInPvEN4FRaRaSL2ch+XIWwpcLGJlXMYqnlhbnpqcW
	G+WllusVJ+YWl+al6yXn525iBKbC0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4Zy3MShPiTUms
	rEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQWgSTZeLglGpg2lj+um2ldGWZXL/o
	2ReTMhVb89hPVhx0CG7je14w84j+S871C/gOC5i+TttwX8p3BqPrjvnahmbv+udJyLLt/m95
	ooBj4hq/1/uzIi8mHLcpmWzFcirhe0F1N7vKd9PoyYtuB2V9iJP+8jfk1betk5Tkoti6GK4e
	nnRhT8sP0XmfQiMiyyskZuzeMZf7trOJ1IX7mZyOFd2zxHSvpbnd4N1X3+Zxxs+xaWcqu96t
	WZvUdrYUdD+5510np2i8PfjZ/XPO1r8jfkuuE4pZ/mXyqf1eNZtPun78IbZ0/bmbZSl3T2xp
	v2Tg2noo223PtAi7Q2vTv87yZDkvEOGfYCu2qkhJm39u3rIzIhx3f9/Zp8RSnJFoqMVcVJwI
	AKUgeSX0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7qy9jlpBl/WclnMWb+GzWLNlkYm
	iznnW1gsnh57xG5xpjvXYvbzr8wWF7b1sVrs2XuSxeLyrjlsFvfW/Ge1OH3sBIvFjQlPGS0u
	HVjAZHFsgZjFt9NvGC2O9x5gsph8aQGbRcsdUwchj9kNF1k8tqy8yeSxc9Zddo8Fm0o9Nq/Q
	8ti0qpPNY9OnSeweJ2b8ZvFY2DCV2eP9vqtsHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZ
	WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlHN15lLHgEFfFhAlTmBsY93B0MXJySAiY
	SMz518TUxcjFISSwlFHi44EFrBAJGYmNX65C2cISf651sUEUfWSU2Hy5gw0kISSwlVHiyD3L
	LkYODhYBVYmtE6RBwmwCOhLn39xhBqkXEehmlbi26DYjSEJYwEliwrbpTCA2r4CDRNOmtYwQ
	Q68zSlxt+MECkRCUODnzCZjNDDRpwe5PbCALmAWkJZb/A7uaU8Bd4v/FS2wQxylLLD89kxnC
	rpX4/PcZ4wRGoVlIJs1CMmkWwqQFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN/27Gf
	W3Ywrnz1Ue8QIxMH4yFGCQ5mJRHeWQuz0oR4UxIrq1KL8uOLSnNSiw8xmgK9P5FZSjQ5H5h8
	8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamNT+r56rsGbGjJeF
	On6TZnsEztogKpO/sPfl5yw/t9id3dNUK1Y9uFpg4f/EpNYn6PYciRPiksf/df4Td47LlpcU
	m1HjbVHbL23yUdJN5nTawzvLLxw/2n0xu0BOy5ElSSX2hKKzQuupTbqTZl9r/s9W16yn/ULz
	1NTaydznVWe8CGK8yl6Ra3Dv59RDqSoXgnwElbe7aPY/37G06N6rBZVd05d4nun6GRYkMGFR
	nb29SL1trHXyhVkCTEZnNR4+jXhudVLksOGWG8km7S90X3Uzbpa+rZ985Nwm4QWvEqa6HbWz
	uslzb34z4/TuvUbtPx2/PPTRnPTzrPtsydmyh7XvP9Q0kjjx9G6avkngNiWW4oxEQy3mouJE
	AF8X9TCGAwAA
X-CMS-MailID: 20240614130117eucas1p2657abb565497200b6f1425771ae37129
X-Msg-Generator: CA
X-RootMTR: 20240604063006eucas1p144c1d1a90606e5cd0c1852c6270ed3e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240604063006eucas1p144c1d1a90606e5cd0c1852c6270ed3e1
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
	<CGME20240604063006eucas1p144c1d1a90606e5cd0c1852c6270ed3e1@eucas1p1.samsung.com>
	<20240604-jag-sysctl_remset-v1-8-2df7ecdba0bd@samsung.com>

On Tue, Jun 04, 2024 at 08:29:26AM +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> Add a pr_err warning in case a ctl_table is registered with a sentinel
> element containing a NULL procname.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  fs/proc/proc_sysctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 806700b70dea..f65098de5fcb 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1119,6 +1119,8 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
>  	struct ctl_table *entry;
>  	int err = 0;
>  	list_for_each_table_entry(entry, header) {
> +		if (!entry->procname)
> +			err |= sysctl_err(path, entry, "procname is null");
>  		if ((entry->proc_handler == proc_dostring) ||
>  		    (entry->proc_handler == proc_dobool) ||
>  		    (entry->proc_handler == proc_dointvec) ||
> 
> -- 
> 2.43.0
> 
> 
To add to this check, I sent out a static analysis check to smatch in
such a way that a warning will be printed out if there is a ctl_table
element with a procname or prog_handler that are NULL. You can see it
here https://lore.kernel.org/all/20240614-master-v1-1-c652f5aa15fb@samsung.com/

Best
-- 

Joel Granados

