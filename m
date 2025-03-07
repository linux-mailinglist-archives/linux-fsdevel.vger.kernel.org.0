Return-Path: <linux-fsdevel+bounces-43413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83162A56285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B783B28D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D951B4233;
	Fri,  7 Mar 2025 08:24:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD8186607;
	Fri,  7 Mar 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335842; cv=none; b=BSZoc8uFJ1d+V5ykcWXqdj7WhbcUb3OXNZ5Y/CEygorp4iz3z23DNbef9fzr50eBMhr0Ux8/l95mnHaG5Zl5Mof74tA/xpNnIABLR5zrHMBPhURDlHecYvn//TGecNax07/XYgQeuE6v+H+OzMGTIJTS/0blasdi2vuL4mvyfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335842; c=relaxed/simple;
	bh=s3l2q/Nnz6wU5N/cVTEMEy94ENTsGRsCboHxSTZ9wZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I0YIejasmA2aYzXg3CutEKnK52KHGQx3sibOqxssHtoc7hPdwx4IpXTbcM6awKtD4UzXimhV4puOTCCK6YmuMiWuBBbwFhkegkAtnRWK2ga3pzQtz+Gz5QaGULdbUrrkM5El4BEMbsZ+ndJ8MVE3CGhXGl+5RAwkCV087M5fYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z8JjY6Tn9z9wQH;
	Fri,  7 Mar 2025 16:04:49 +0800 (CST)
Received: from kwepemo200002.china.huawei.com (unknown [7.202.195.209])
	by mail.maildlp.com (Postfix) with ESMTPS id B08E21800EB;
	Fri,  7 Mar 2025 16:07:58 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 kwepemo200002.china.huawei.com (7.202.195.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 16:07:57 +0800
Message-ID: <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
Date: Fri, 7 Mar 2025 16:07:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
To: <jimsiak@cslab.ece.ntua.gr>, <peterx@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <20250307072133.3522652-1-tujinjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo200002.china.huawei.com (7.202.195.209)

cc Peter Xu

在 2025/3/7 15:21, Jinjiang Tu 写道:
> Hi,
>
> I encountered the same issue too. In my scenario, GUP is called by mlockall()
> syscall.
>
> Is there a solution to fix it?
>
> Thanks.
>

