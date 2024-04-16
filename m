Return-Path: <linux-fsdevel+bounces-17027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1D8A6720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A89B22FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8845885299;
	Tue, 16 Apr 2024 09:28:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50F5A10B
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259724; cv=none; b=MfMzWFEzOIEMWUMuHAV7EOxugf6Y2KI0KSKJbDolT+3S9e8uj0gW4cd54ndXK/QBK84C4p5694phcnx6Ha3JLpUHml4GcSZ5/jV5u0IzSU+0P0gjK7FOADufBpPq9K1SZJuynJP3KGj80e2bj8A42JOw/OU9IVjAFeJU6hMBrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259724; c=relaxed/simple;
	bh=Mhnyy89mf2LSCeNovK2qiuWwI/4FnRDukFDKEY9TxRI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o3uxhzIHmQx7ZmVJGStWgZ+kvoAgvLBHwaoT3mtteDDQuUOBYX+CvVnU95DSTEoJ2ll6xqOGfF1hKsgyWb5rkqgH+Qf6O08GSdxBMADZAjkeV9p9UgRKsKMYkJqSLY2Ghrn4UmsEqOMiUuW6eyLaGnk5ySljW5Br8Te98KQVUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VJdtT4R4NzXlJQ;
	Tue, 16 Apr 2024 17:25:21 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id D90CA18005D;
	Tue, 16 Apr 2024 17:28:38 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 17:28:38 +0800
Subject: Re: [PATCH v1 01/11] mm: migrate: simplify __buffer_migrate_folio()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Matthew Wilcox <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>, Benjamin
 LaHaise <bcrl@kvack.org>, <jglisse@redhat.com>, <linux-aio@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>, Jiaqi Yan
	<jiaqiyan@google.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-2-wangkefeng.wang@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <da49db15-c48e-c86f-1c85-9426330da02f@huawei.com>
Date: Tue, 16 Apr 2024 17:28:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240321032747.87694-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/3/21 11:27, Kefeng Wang wrote:
> Use filemap_migrate_folio() helper to simplify __buffer_migrate_folio().
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

