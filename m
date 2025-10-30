Return-Path: <linux-fsdevel+bounces-66463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F067C1FF51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C58619C2CC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFAF29E0FD;
	Thu, 30 Oct 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ctW0uKYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A796213E9F;
	Thu, 30 Oct 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826562; cv=none; b=i0XhAoW475cFy2An1wcNdrqdF5FzZCH+X0N2GgRtPeNhPPNDifayo/JKjr+exy0cut1VtN0ytTi83AUI5ySjHaOfmoR/a1cLH9cbIgJdh3qQd2NyT3z+tqwYE6Y9jjVPqXpdhqmGFVc9BuDA5oDEZyn242uW7CIzkM3VCp76s3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826562; c=relaxed/simple;
	bh=zp6c2XfNy5SC1yAUUZ0Req/w9TZEp9325StaP9wUIq4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f9gBd5Wk/qmpWYuQXKuZP6OAE7LqoRnMcDedrdJk9aze1l6t6uk+2B3aFR+xkB3MEmOMg6NntzR8ibN2Jxg1Ll1wBDqAiqTY+sFrUjHW7fbczyYehdS8O5wrrhush1B+YTOupD7CXI74sY8kVyMHZdCfgBU8os0Q/FS8Jwnp4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ctW0uKYu; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=d+Vx3YdOyQTAap4dvbQCFkBJA4MCaz3tkdmY5eMqs/s=;
	b=ctW0uKYuEuqNTH08N25rcLPgjFdJdMsoFJvYYo0HhwMP8I1f7fEbBU6t6ajFd3ShcW6FG4YJa
	cBDMN4cbf6SKbwlzuEVgw0peCcGnxfxGxQxhy6go8XXJwoU2RiuGYkRjfDuaRI3w1XtTV6QhQ0U
	M/kjoMtnJ7vQpce2ZNeiXlc=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cy32G5kMbzcZyk;
	Thu, 30 Oct 2025 20:14:30 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AD703140144;
	Thu, 30 Oct 2025 20:15:56 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 20:15:56 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 20:15:55 +0800
Subject: Re: [PATCH v4 2/3] mm/memory-failure: improve large block size folio
 handling.
To: Zi Yan <ziy@nvidia.com>
CC: <kernel@pankajraghav.com>, <akpm@linux-foundation.org>,
	<mcgrof@kernel.org>, <nao.horiguchi@gmail.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, "Yang
 Shi" <shy828301@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <david@redhat.com>,
	<jane.chu@oracle.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-3-ziy@nvidia.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <68910328-ba58-0554-c961-6a4087c72354@huawei.com>
Date: Thu, 30 Oct 2025 20:15:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251030014020.475659-3-ziy@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/30 9:40, Zi Yan wrote:
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
> 
> For soft offline, do not split the large folio if its min_order_for_folio()
> is not 0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
> 
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.


