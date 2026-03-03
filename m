Return-Path: <linux-fsdevel+bounces-79237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGz0Jz3vpmkQagAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:25:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F421F1684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40C6630A54E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3763DEAD7;
	Tue,  3 Mar 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nAHolJpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C033F368
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547462; cv=none; b=Fl1oedzS4i81tqrNnMtAGRUMiqHJLNHeTxYIFMmasLrdrLsN6RN9yfzGdMB/P+iuS+vjxwitOdayQ1IPB5qI52qoKwutGsh+bmgMSrx0wXxPjKlpdN3rVcKPm1D2BtrdWmqGLhQLzoZE5mQRSbeaGTiHWFfPCotIw4f6jSW6/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547462; c=relaxed/simple;
	bh=KXtPR45XlwA5t9dJ3rfNgFxtzZ9y5nb7ehtXyJUvGRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=STRxgzvBAx2C1qiCz3/xk4DU2nuYAmWIrq5HvB0m2dfEnm0ZjjywtyDXmurktvNB1zaygwXE9KfJiC73EdiBXQwa4XFEuxnWwdWF6XgAZnYOo2uTDXaLf4B4Sw/mPb07QkmQuGEwBtV0FyLwMksiqghISatikUSXvMvTPcw/oQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nAHolJpm; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260303141732euoutp021c377a92bb840d861d168a3dc53b040e~ZWoQ9cE8H1205912059euoutp02u
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 14:17:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260303141732euoutp021c377a92bb840d861d168a3dc53b040e~ZWoQ9cE8H1205912059euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772547452;
	bh=yI63eG0TpyudB4EbuxKXYS2S0olMXbkfWRAVH8sYml4=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=nAHolJpmRCQ4gHFFWFKGXTt1mm4rLcsJZwxxRVqII9a8+aRkttC5F2e0ONfQcPxHw
	 3JVo+Gtcdd248Xf0fW4Swmdfb+xq06oSLF0CjoSYEG/BzpexuQVYcWOeNUqJmrX3w1
	 sIlwE2iFK4XGOA1aW7Y+5ZaIEhTK0qNMGjWb6dwo=
Received: from eucas1p1.samsung.com (unknown [203.254.199.20]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20260303141731eucas1p2e2776e83eaddf31d46a04572d08ecb6d~ZWoQeWN_70751407514eucas1p24;
	Tue,  3 Mar 2026 14:17:31 +0000 (GMT)
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260303141731eucas1p294a43af96c9468f35fc3b88ddda944b8~ZWoQMnWCl0751807518eucas1p20;
	Tue,  3 Mar 2026 14:17:31 +0000 (GMT)
Received: from CAMSPWEXC02.scsc.local (unknown [106.1.227.4]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260303141731eusmtip1a2108785e03078cd80aeba1cd79b3739~ZWoQEqtIM1956719567eusmtip1N;
	Tue,  3 Mar 2026 14:17:31 +0000 (GMT)
Received: from [106.210.248.154] (106.210.248.154) by CAMSPWEXC02.scsc.local
	(106.1.227.4) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 3 Mar
	2026 14:17:29 +0000
Message-ID: <6e86c417-c410-4deb-9b47-08e3d5d9be71@samsung.com>
Date: Tue, 3 Mar 2026 15:17:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/3] Decoupling large folios dependency on THP
To: Matthew Wilcox <willy@infradead.org>
CC: Suren Baghdasaryan <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Michal Hocko <mhocko@suse.com>, Lance Yang <lance.yang@linux.dev>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nico Pache
	<npache@redhat.com>, Zi Yan <ziy@nvidia.com>, Vlastimil Babka
	<vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe
	<axboe@kernel.dk>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<mcgrof@kernel.org>, <gost.dev@samsung.com>, <kernel@pankajraghav.com>,
	<tytso@mit.edu>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <aaEsOu0hgCUznzl3@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSPWEXC01.scsc.local (106.1.227.3) To
	CAMSPWEXC02.scsc.local (106.1.227.4)
X-CMS-MailID: 20260303141731eucas1p294a43af96c9468f35fc3b88ddda944b8
X-Msg-Generator: CA
X-RootMTR: 20260227053155eucas1p2b4b92cca44cefd084ae528fea27419d3
X-EPHeader: CA
cpgsPolicy: EUCPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260227053155eucas1p2b4b92cca44cefd084ae528fea27419d3
References: <20251206030858.1418814-1-p.raghav@samsung.com>
	<CGME20260227053155eucas1p2b4b92cca44cefd084ae528fea27419d3@eucas1p2.samsung.com>
	<aaEsOu0hgCUznzl3@casper.infradead.org>
X-Rspamd-Queue-Id: 39F421F1684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79237-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.raghav@samsung.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action



On 2/27/2026 6:31 AM, Matthew Wilcox wrote:
> On Sat, Dec 06, 2025 at 04:08:55AM +0100, Pankaj Raghav wrote:
>> There are multiple solutions to solve this problem and this is one of
>> them with minimal changes. I plan on discussing possible other solutions
>> at the talk.
> 
> Here's an argument.  The one remaining caller of add_to_page_cache_lru()
> is ramfs_nommu_expand_for_mapping().  Attached is a patch which
> eliminates it ... but it doesn't compile because folio_split() is
> undefined on nommu.
> 
> So either we need to reimplement all the good stuff that folio_split()
> does for us, or we need to make folio_split() available on nommu.
> 

I had a question, one conclusion I came to was: folio splitting depends on THP, 
so we either need to implement the split logic without THP dependency or just 
make sure we don't split a large folio at all when we use large folio (what I 
did in this RFC but not a great long term solution).

So even if we implement folio_split without any dependency on THP, do we need to 
re-implement or make folio_split available for nommu? I am also wondering how 
nommu code is related to removing large folios dependency on THP.

--
Pankaj



