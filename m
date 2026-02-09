Return-Path: <linux-fsdevel+bounces-76702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H0YIOLUiWmECAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:36:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572110EB95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A7723004D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3936A02B;
	Mon,  9 Feb 2026 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HgvFsm/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E9352C5D;
	Mon,  9 Feb 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638502; cv=none; b=u5vkfifLUFMcd0mqGjKrVnF0YyHgiBK5VPrJn1UCAnjoJDXJqD/ojZnauvVwzgyb4vWFetqN1Q2cLeu/Md9dYs3Hd/9NAXGqukjSby7Kf4a8BKWUP7t0gHBMbMoNZgcuqmYHdBMCx1XcGnO0oH6GaItgooYPbdvb86xVtYcTDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638502; c=relaxed/simple;
	bh=LJOVPEY3H5xF6UGDzXtfFnV/LL+zLRcBDoDb+TkAptw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z1DXmor/LxLLQDmo/xq07VhPsfVaja6XYmwS3eqGOmE0QtQC55Q5UbYPtF6nFVIQCNsNTfsARmuMdIqkdbkzRo33xuoKrMGyLWdfnnUaVrXsi6dW7QeEsKtjqVGOGlvGElK8GtMfpvC3W0AvHtrZsY6Zc0N9fJAnE4E+xWH/BXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HgvFsm/O; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aVJWYN5hT//tauzZC63sk90Og7RFtOObfGnbaqSG+J8=;
	b=HgvFsm/O5g3Y9YB2RfP6Mz2JabvrM3IzLzLrLnyrTV56cNRQv176lP0NpjI/mcxJlpGKlcLfK
	vcCyPP/bWOp+HrFwDDgLpyVBRya0CEHBsBSxo43LQh5aIcvEcDlVWWDFTIVvp02VSWzT4KTZSqc
	2XO8ugKS2BfADEs4da/8lfY=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f8jq35wJvz1K97n;
	Mon,  9 Feb 2026 19:57:03 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AD60240563;
	Mon,  9 Feb 2026 20:01:38 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Feb 2026 20:01:38 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Feb 2026 20:01:37 +0800
Subject: Re: [PATCH v3 2/3] selftests/mm: test userspace MFR for HugeTLB
 hugepage
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <nao.horiguchi@gmail.com>, <tony.luck@intel.com>,
	<wangkefeng.wang@huawei.com>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <rientjes@google.com>,
	<duenwen@google.com>, <jthoughton@google.com>, <jgg@nvidia.com>,
	<ankita@nvidia.com>, <peterx@redhat.com>, <sidhartha.kumar@oracle.com>,
	<ziy@nvidia.com>, <david@redhat.com>, <dave.hansen@linux.intel.com>,
	<muchun.song@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<william.roche@oracle.com>, <harry.yoo@oracle.com>, <jane.chu@oracle.com>
References: <20260203192352.2674184-1-jiaqiyan@google.com>
 <20260203192352.2674184-3-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <26a7803a-bf20-c60b-459d-2c8f82f2f4f6@huawei.com>
Date: Mon, 9 Feb 2026 20:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260203192352.2674184-3-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76702-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9572110EB95
X-Rspamd-Action: no action

On 2026/2/4 3:23, Jiaqi Yan wrote:
> Test the userspace memory failure recovery (MFR) policy for HugeTLB:
> 
> 1. Create a memfd backed by HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.
> 
> 2. Allocate and map 4 hugepages to the process.
> 
> 3. Create sub-threads to MADV_HWPOISON inner addresses of the 1st hugepage.
> 
> 4. Check if the process gets correct SIGBUS for each poisoned raw page.
> 
> 5. Check if all memory are still accessible and content valid.
> 
> 6. Check if the poisoned hugepage is dealt with after memfd released.
> 
> Two configurables in the test:
> 
> - hugepage_size: size of the hugepage, 1G or 2M.
> 
> - nr_hwp_pages: number of pages within the 1st hugepage to MADV_HWPOISON.
> 
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

It's not required but could this testcase be written into the tools/testing/selftests/mm/memory-failure.c [1]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=cf2929c618fec0a22702b3abd0778bbdde6e458e

Thanks.
.

