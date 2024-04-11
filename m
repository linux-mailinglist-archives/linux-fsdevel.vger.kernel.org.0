Return-Path: <linux-fsdevel+bounces-16687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB958A16C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01DCB282DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55F14E2DE;
	Thu, 11 Apr 2024 14:08:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753714D70F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844532; cv=none; b=Vdwx+GbxS1uyFPcQELPwCXQ/qBEnDMt6QccvLgSbqNkTEX79Y4ILGm3rFjCHJohxKzgckkKWx2BmxbYJsqgHEcZ7tSuiY34QvjA1tn3DqMx1rqPt/N/3w67op2RpyYm4hS9dS6+8zv5a6mXYNEfzXDx6td7cUQnK/9cr/EwyDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844532; c=relaxed/simple;
	bh=4g1DZDj5L/f65b/g+rh80PmI29xw5F/EYeVUqZj8gJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H31dOByUE1BGNIW1No9L4cyoJHYp7uMCEXj+2X0+O5VEaQeqyL6g6mvaW01M1QPeK2FDdWRqvpi7A1kVLNoMkECx7aDBOgSMXgx2ZTu3Gzxuex28hN684Pi89MhyZvh4ze3IsceAlBOTTKrTg3QXLHx2ksYoexIfWJmj3d/vrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFhLP0qQ8z2NW5y;
	Thu, 11 Apr 2024 22:05:49 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D06C41A0172;
	Thu, 11 Apr 2024 22:08:41 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 22:08:41 +0800
Message-ID: <9166e288-30cc-49a4-b29e-c3350a7efde7@huawei.com>
Date: Thu, 11 Apr 2024 22:08:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: move mm counter updating out of set_pte_range()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240411130950.73512-1-wangkefeng.wang@huawei.com>
 <20240411130950.73512-2-wangkefeng.wang@huawei.com>
 <ZhfdNL4kbAtsWzBI@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZhfdNL4kbAtsWzBI@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/11 20:53, Matthew Wilcox wrote:
> On Thu, Apr 11, 2024 at 09:09:49PM +0800, Kefeng Wang wrote:
>> In order to support batch mm counter updating in filemap_map_pages(),
>> make set_pte_range() return the type of MM_COUNTERS and move mm counter
>> updating out of set_pte_range().
> 
> I don't like this.  You're making set_pte_range() harder to use.
> It's also rather overengineered; if you're calling set_pte_range()
> from filemap.c, you already know the folios are MM_FILEPAGES.

or MM_SHMEMS,  and another caller finish_fault(), which already check
vmf->flags and vma->vm_flags, we could use it to distinguish anon or 
file, I will try this way, thanks.

> 
> 

