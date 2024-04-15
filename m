Return-Path: <linux-fsdevel+bounces-16901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E78A47A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 07:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CCA1C214BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 05:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC35234;
	Mon, 15 Apr 2024 05:41:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32538441F
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159682; cv=none; b=h1jo8nCdxXOsY99P8CGuml+Qrd8ceHiYMeSNS9qzFwjkW40+auAJfGYClvNFIhHUNvQ09dbV/P8AdtLexkc5W/U6Cclf0XH313Bpkgn3xn5BgW7Wno+zqlNOG8Ys3iQO3NSqJ/u+gLyAArqCt28bVQZBP9nn1jc8gUAxVDPe10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159682; c=relaxed/simple;
	bh=qj33x8qZLDuIpFBVPdwGca68ljZI2ZjO7ou69dwumdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SjfiX/xzT0fpDDL9+X4zRcbPOYGs/Xv7W+8YAT6MDZ5yAM4BNJdvpKEZvqIcpRBD0aXMRdgoIq6A2Tbs3R5TzOZE/DS9aXNLZOvZZ7IKv+sEABIxKanIWc+9g6hlYBx25MRTuKogkyo+ZDuHktsN/oXO7PiV4YcRXiZnOWZKTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VHwx84t5Wz1wrwq;
	Mon, 15 Apr 2024 13:40:12 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DA11140154;
	Mon, 15 Apr 2024 13:41:10 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 13:41:09 +0800
Message-ID: <73ad9d2b-01d3-4af7-bbb4-0063079f8070@huawei.com>
Date: Mon, 15 Apr 2024 13:41:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mm: batch mm counter updating in
 filemap_map_pages()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20240412064751.119015-1-wangkefeng.wang@huawei.com>
 <20240412161217.c7dc1af77babe5004bd3e71d@linux-foundation.org>
 <ZhnaW0CzJZb_rrTl@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZhnaW0CzJZb_rrTl@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/13 9:05, Matthew Wilcox wrote:
> On Fri, Apr 12, 2024 at 04:12:17PM -0700, Andrew Morton wrote:
>> On Fri, 12 Apr 2024 14:47:49 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>>> Let's batch mm counter updating to accelerate filemap_map_pages().
>>
>> Are any performance testing results available?
> 
> Patch 2/2 says 12% improvement

Yes, lat_pagefault with 512M file from lmbench, thanks.

