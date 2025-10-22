Return-Path: <linux-fsdevel+bounces-65059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D96BFA6B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6158E3AE5E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1732F39D7;
	Wed, 22 Oct 2025 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hLYeRF9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D599221F26;
	Wed, 22 Oct 2025 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116528; cv=none; b=aGbF/ZPdOjAOcsgiw5f4NKKAFI3KbrnlRBYf24Ce1sp1gaqSnfXloJ1D7Jw2EJ8RchvAZbmaPERDbMo07Cc5GzOLOWTQ36IrisCcc1bG9A5A9v4N1hu6dUB+r/AoBcf3md5Av1FWBfdlO74j3XT8lSU2u67N8gOgBODZGfleZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116528; c=relaxed/simple;
	bh=m5moemwbfxGnLQM9kLTf22NBmKRkzKjT2BG3uZGegRg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Oin3JJf3834qIhI2fqSUJ92dVqmbgYpRzowMoziAqXP7lifuqA0x+j3wcErJrV6ckR//xpcUKw8z/qnNH9MtkBE1AhoVq1BWFe6fOFgdUWnBWoLVzKm1b8M8xrDRLGrkcr9K1bTSCazBZkZLT18IuIW1YwD/rxnQQgZgfrRRXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hLYeRF9L; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EHRP3uMAXDZCSqG6N+1vlxdAszjhwtbW5deaNWABMWQ=;
	b=hLYeRF9L/tbm9BwldRUCM0HeZZginJ4h9+WkMWqRPxsH4LOMDzdz4E90zWmQoRNClMEbzpw6P
	HhjKSYDkRwZ2uCj7ymzFT6szIKGDFnNRZM+ap2hGY40M4HwKRxDqZ/Ya2/Isgg0s0kqfxqwWzTv
	pfyvUnykgL7dyh/ykueDH9I=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cs0Ss0Xn4zmV66;
	Wed, 22 Oct 2025 15:01:33 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B80A18001B;
	Wed, 22 Oct 2025 15:01:57 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 15:01:57 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 15:01:49 +0800
Subject: Re: [PATCH v3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
To: Zi Yan <ziy@nvidia.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<nao.horiguchi@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <stable@vger.kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, <david@redhat.com>, <jane.chu@oracle.com>,
	<kernel@pankajraghav.com>,
	<syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
References: <20251017013630.139907-1-ziy@nvidia.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <73c5557a-bc84-e1aa-d5d0-ad0ae57b55bb@huawei.com>
Date: Wed, 22 Oct 2025 15:01:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251017013630.139907-1-ziy@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/17 9:36, Zi Yan wrote:
> Page cache folios from a file system that support large block size (LBS)
> can have minimal folio order greater than 0, thus a high order folio might
> not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
> folio in minimum folio order chunks") bumps the target order of
> split_huge_page*() to the minimum allowed order when splitting a LBS folio.
> This causes confusion for some split_huge_page*() callers like memory
> failure handling code, since they expect after-split folios all have
> order-0 when split succeeds but in reality get min_order_for_split() order
> folios and give warnings.
> 
> Fix it by failing a split if the folio cannot be split to the target order.
> Rename try_folio_split() to try_folio_split_to_order() to reflect the added
> new_order parameter. Remove its unused list parameter.
> 
> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
> [The test poisons LBS folios, which cannot be split to order-0 folios, and
> also tries to poison all memory. The non split LBS folios take more memory
> than the test anticipated, leading to OOM. The patch fixed the kernel
> warning and the test needs some change to avoid OOM.]
> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Thanks for your patch. LGTM.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

