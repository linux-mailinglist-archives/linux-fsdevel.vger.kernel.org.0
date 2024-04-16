Return-Path: <linux-fsdevel+bounces-17037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFCD8A6A68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 14:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5304E1F218F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8112A179;
	Tue, 16 Apr 2024 12:13:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CE85644
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269621; cv=none; b=NYH09OdqG1/dJrk8gR9VKTqM6gcqzNov5xB01dA8J9JIaeRvHC3MjciUVNRD8zkBLCRH4n5sPoO8PLsjvvWEKBgjzba0ob9oaqKbhhQ7Mk695KL4omzjMeY5Ze3lVhoWNIupkV/QU1ojY3aWn+FUvB9WD2qXHwf9msJWOW1FRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269621; c=relaxed/simple;
	bh=gSE3iybu0Vtyog2ehoK9gyhaBHuSKfOxdvLC22F7c5A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rZsVYCUV364x+AevxihJUpWeeNb1LDZfIFtTL2h6SUeaTSVfm+voBoDWZGXqxDGAFgArMSx2T7oiHTyFDf41RHsGXFg8Wm2Nk6cNralMew8m4QMv7ekajRzZSVx64CpFuKxsKcuTkOrKvpwR4npSZemFvSSKFytRLCKv34zIyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJjbT2FZ1z17MlX;
	Tue, 16 Apr 2024 20:12:37 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BCC91A0172;
	Tue, 16 Apr 2024 20:13:35 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 20:13:34 +0800
Subject: Re: [PATCH v1 02/11] mm: migrate_device: use more folio in
 __migrate_device_pages()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Matthew Wilcox <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>, Benjamin
 LaHaise <bcrl@kvack.org>, <jglisse@redhat.com>, <linux-aio@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>, Jiaqi Yan
	<jiaqiyan@google.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-3-wangkefeng.wang@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d8c4fbe8-e41e-4a6f-e0b3-c1f97d3ee39d@huawei.com>
Date: Tue, 16 Apr 2024 20:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240321032747.87694-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/3/21 11:27, Kefeng Wang wrote:
> Use newfolio/folio for migrate_folio_extra()/migrate_folio() to
> save four compound_head() calls.
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

