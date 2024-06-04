Return-Path: <linux-fsdevel+bounces-20911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12988FAB3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D88DB23832
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2EA13EFE4;
	Tue,  4 Jun 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KiJcuOEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DF13E031
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483737; cv=none; b=T4YAnWmfNlQTF4L8Ccv8997U4W7UIniw0RWCCkLNbmtLR5VRdtz4c4+bXvTwBmVvfTNrG21dODBGMSa0+bed1P1BwIFJPw01aHQ9qsuMz9k5QhhXjakIrHWHsgDbHm1yPQNVL+KGHZ1A6lYUYhPEbrSoe1YVVlykg960zkdRHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483737; c=relaxed/simple;
	bh=O1UfMaKD/hmWFcGVX0dHXqkE0XTi/7iwjX0Urne5AX0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=t15M1mZO+12vvYjD3xi2D/GnGqa4AGCgyADy0G6vE/tdxUNAVFTYCQ3No/YDxp5nfYSDrspZLIHR06JwivKbmaNVokXFK6K1otyRhvyR8dSVqQbIrd1yDhWpKHxxDbfzSVaosYXhXhSJS5pXWsVOmadxbO46rR94oXtbK7UXVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KiJcuOEp; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240604064853euoutp0218b8800fa067f29f13dc34867afd2f62~VulsQ5yIe1626316263euoutp02J
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:48:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240604064853euoutp0218b8800fa067f29f13dc34867afd2f62~VulsQ5yIe1626316263euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717483733;
	bh=QbTrIPhFImjlKnd/ohqIcW3b/iR9Pfpr+J0VPVe1xtU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KiJcuOEp0bmxzmLWz26L/CKL9Uy1Jrkh2EThm1VuZfJKp/W5MYRnq8MC6Y4QqDQz4
	 S+gBnPR7KqdRUcFuAx1RehG0Ue2fsvKxjMnA62wYwIBPE8cyDwnzyjP4IHKZGYEdaw
	 9Vxmz12NHonqKK0YOlJz2FwJOYsBbPEknfqGyC5U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240604064852eucas1p1d00075de5770a5fa8593c734aef9db91~Vulr3Drz81683916839eucas1p1C;
	Tue,  4 Jun 2024 06:48:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F8.C4.09875.4D8BE566; Tue,  4
	Jun 2024 07:48:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240604064852eucas1p2db69f8d2d13b82887fbb3a4dd535c024~Vulra1_of1670216702eucas1p2K;
	Tue,  4 Jun 2024 06:48:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240604064852eusmtrp1071da7d58997076776fcc54baf4f28c8~VulrZuwRy1417014170eusmtrp1I;
	Tue,  4 Jun 2024 06:48:52 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-87-665eb8d42702
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.87.08810.4D8BE566; Tue,  4
	Jun 2024 07:48:52 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240604064852eusmtip1d292ba451e2cc73f72b5fe4a618458fc~VulrNK7321516115161eusmtip1R;
	Tue,  4 Jun 2024 06:48:52 +0000 (GMT)
Received: from localhost (106.210.248.71) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 4 Jun 2024 07:48:51 +0100
Date: Tue, 4 Jun 2024 08:48:47 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
	Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 3/8] sysctl: Remove check for sentinel element in
 ctl_table arrays
Message-ID: <20240604064847.4os2h42bj3cg6ptl@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604-jag-sysctl_remset-v1-3-2df7ecdba0bd@samsung.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSF8zoz7VAtmRa0N6AgdYuoKEpw4orGZaJiNMbdII0MSwQ0U4u7
	4o6tEqAgSpVUolbLEjMS4oq2xDaIYdEacWviGlQUShVxSbV0cPn33XfPefeel0diigoihEzL
	3Mxymep0lViK19i/NY11XklIHu/yjqJPNR3A6Tf2lxL6nj6Dbq7JJegbN+tx+sG1U2LaVfGL
	oFvz3iDabhpIdze0ozgpY8xuwZnqi49FjInXMrzliJjhuwokTEftQzHj4cMWS1ZLpyax6WlZ
	LDdueqI0lbfUiTd5pFu7PDlYNmogdSiABCoGeMtxiQ5JSQV1AUFpURESis8IblV1E0LhQbDv
	V4/oj8Ww14gLDTMCy7sq9Ff1pPasWCguI2gzvyB6LTg1DD7xd/12MTUGmtqfYb2iYKoQgfN5
	qX8IRt1GcMLl8quCqJVgtRr8LKPiQFdhxASWQ/3J13gvY76bTNe7fONIH4eC2euPFEDNgzNf
	jH27qsDa0oELvAsq7ff8UYE6HACFukpCaMyGvOzDmMBB8N5RLRF4EDQYjuKCweB7Dm9nn7sc
	wfm9X/pGTIEDztd9jplwOqdO1LsRUIHQ+lEuLBoIBTXFmHAsg5xDCkE9Aspd7XgeGlryX7SS
	/6KV/ItmQpgFKVmtJiOF1UzIZLdEadQZGm1mStT6jRk88n2oBq/j8xVkfu+OsiERiWwISEwV
	LMvdvSZZIUtSb9vOchvXcdp0VmNDoSSuUsqGJ4WzCipFvZndwLKbWO5PV0QGhGSLipWdr/Al
	nZfSTEvpujTP4MZIjyQ2CVIjrOvuFC6zL3iI5kdY7Q+S14Zt6dBONoSX6XpWrl44qYy7vqGt
	bH+WLObqKvdH5dvmOSXh7mnnh14Ywti+ypVUTv9jcSmDSiOseqs9/pFeHhSSoMdD5/ItH3aw
	gd9mO9OZ78Oejpwc614UzfFzTtcb3iUYssZNit41a3kzufO4jagcHq8vXkDcGB07NtFBjvnR
	r6dt2Yx25ytiYePTi2tES/fg536aHR0f3EXBYXeDqu6Y8w2OajLfCO7y2rfXqgcv6n7RvD8x
	XhYjP6sZ0Dg+knsWPOI5mft1yLHdqfcfH5zoWlHgNaHWQhWuSVVHR2KcRv0b5vVlPL8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7pXdsSlGcw/wW0x53wLi8XTY4/Y
	Lc5051pc2NbHarFn70kWi8u75rBZ3Fvzn9XixoSnjBbHFohZfDv9htGBy2N2w0UWjy0rbzJ5
	LNhU6rFpVSebx6ZPk9g93u+7yubxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWe
	obF5rJWRqZK+nU1Kak5mWWqRvl2CXsamVYfZCj5zVXz63MHcwHiao4uRk0NCwERicuNsli5G
	Lg4hgaWMEq8+PmaBSMhIbPxylRXCFpb4c62LDaLoI6PEqVtNUB2bGSXOPHsFVsUioCLxbtMp
	JhCbTUBH4vybO8wgRSICUxglXrxZwg7iMAscYJSYce8eWJWwQITEwYOTwWxeAQeJrjWzmSHG
	XmeU2PZ1BlRCUOLkzCdgRzEDjV2w+xPQIRxAtrTE8n9gT3AKuEss/DqbCeJWJYmDF99D/VAr
	8er+bsYJjMKzkEyahWTSLIRJCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG6bZjPzfv
	YJz36qPeIUYmDsZDjBIczEoivH110WlCvCmJlVWpRfnxRaU5qcWHGE2BgTGRWUo0OR+YJvJK
	4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiSmxraVvFr3flXfCSr
	zH26gLjZvjaTNV5LrppqPDy/5H/k8YNsQSWTnUTmLy1PivznfGAH8wNGG2b5PxN493l8Lgo9
	+9K0zGZx31UV6wchCoHrJ/2VEOTyerjs55k5C2IXXe892Ro9Z+NyppU3th2b4ij++4HYpDkz
	omNexexbeibkl6RIwXHOefdYlxR72J6crzzxdqXFld0TmXSbYzfyHV74K9vslIHJu8Cqz0Xz
	libnrRDv2i0t+OzUulPJGTeOXeEoNeB2S6+fXqF0Iz5tluWdSQ4vWIVcL7tYl/w/XtgitK/p
	+rqjYV5fZhz65tG/7qnZ11gHBpbfL7RLWCJapXpdN7Htj3T4tOzkcsbtSizFGYmGWsxFxYkA
	DqYi+FsDAAA=
X-CMS-MailID: 20240604064852eucas1p2db69f8d2d13b82887fbb3a4dd535c024
X-Msg-Generator: CA
X-RootMTR: 20240604063005eucas1p2a0ea8cbe2d925b1e63f0854f719d0b01
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240604063005eucas1p2a0ea8cbe2d925b1e63f0854f719d0b01
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
	<CGME20240604063005eucas1p2a0ea8cbe2d925b1e63f0854f719d0b01@eucas1p2.samsung.com>
	<20240604-jag-sysctl_remset-v1-3-2df7ecdba0bd@samsung.com>

On Tue, Jun 04, 2024 at 08:29:21AM +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> --- a/net/sysctl_net.c
> +++ b/net/sysctl_net.c
> @@ -127,7 +127,7 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
>  
>  	pr_debug("Registering net sysctl (net %p): %s\n", net, path);
>  	ent = table;
> -	for (size_t i = 0; i < table_size && ent->procname; ent++, i++) {
> +	for (size_t i = 0; i < table_size; ent++, i++) {
>  		unsigned long addr;
>  		const char *where;
>  
> @@ -165,17 +165,10 @@ struct ctl_table_header *register_net_sysctl_sz(struct net *net,
>  						struct ctl_table *table,
>  						size_t table_size)
>  {
> -	int count;
> -	struct ctl_table *entry;
> -
>  	if (!net_eq(net, &init_net))
>  		ensure_safe_net_sysctl(net, path, table, table_size);
>  
> -	entry = table;
> -	for (count = 0 ; count < table_size && entry->procname; entry++, count++)
> -		;
> -
> -	return __register_sysctl_table(&net->sysctls, path, table, count);
> +	return __register_sysctl_table(&net->sysctls, path, table, table_size);
>  }
>  EXPORT_SYMBOL_GPL(register_net_sysctl_sz);
>  

Given that this is a very small network related patch, I'm queueing this
in through the sysctl-next branch. Please let me know if you would
rather take it through the networking workflow.

Best

-- 

Joel Granados

