Return-Path: <linux-fsdevel+bounces-36879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD039EA511
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 03:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8ED41886B6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373D148FE8;
	Tue, 10 Dec 2024 02:25:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B7233159;
	Tue, 10 Dec 2024 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797544; cv=none; b=gZ2tShAvM15Mo/QCwkQoAQWDVT94+PdiqLkTZCAv3rbLo/aaQ3BB7SACl/nLXQla/mKZPMd+NxbRx9JDitibbjNn34du+ZqZkzG31l5TRy7NmHWrVihDkpFBogirvmaZ5BAaw+HDsrWzbRSnD1sYVt9jQyXg+/Da3qfpOe8s9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797544; c=relaxed/simple;
	bh=U1ZIGWbN5GTBVBOSCn+zZFDwiwb3aTnpStLINUF9ZaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nVQEBA3tVktsGhaAnQQWHExPHL0hOQimJhx7KWF/821stLZk1QymRYVHHfmSMJEEg/XGvrNOn1Pmehmy5zD9p9D4KnIRY+tEXBukpJwClu00dD9H54C0mV8TpxS6Pt5noJgTK/AhvLOfMdb+v65QOWYU17VVFN0D8gZsHQoKG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y6jFb5bVNzhZX2;
	Tue, 10 Dec 2024 10:23:15 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id ECCD8180357;
	Tue, 10 Dec 2024 10:25:38 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 10:25:36 +0800
Message-ID: <b35ed617-0508-91f1-972b-801932320264@huawei.com>
Date: Tue, 10 Dec 2024 10:25:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/2] mm, rmap: handle anon_vma_fork() NULL check inline
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<akpm@linux-foundation.org>, <Liam.Howlett@oracle.com>,
	<lokeshgidra@google.com>, <lorenzo.stoakes@oracle.com>, <rppt@kernel.org>,
	<aarcange@redhat.com>, <Jason@zx2c4.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20241209132549.2878604-1-ruanjinjie@huawei.com>
 <20241209132549.2878604-3-ruanjinjie@huawei.com>
 <Z1byK9X59RHFJMHZ@casper.infradead.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Z1byK9X59RHFJMHZ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/12/9 21:35, Matthew Wilcox wrote:
> On Mon, Dec 09, 2024 at 09:25:49PM +0800, Jinjie Ruan wrote:
>> Check the anon_vma of pvma inline so we can avoid the function call
>> overhead if the anon_vma is NULL.
> 
> This really gets you 1% perf improvement?  On what hardware?

Yes，the total improvement of this two patches is about 1% on our
last-generation arm64 server platform.

During the test of Unixbench single-core process creation, the trace
result shows that the two functions are frequently invoked, and a large
number of check NULL and returned.

> 
> 

