Return-Path: <linux-fsdevel+bounces-56061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131ECB12885
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 03:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BDF7B3A5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 01:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E121D5AC6;
	Sat, 26 Jul 2025 01:47:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD51172A;
	Sat, 26 Jul 2025 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753494450; cv=none; b=IVn5Rxxg9SY8iONjh2PVOvWuqGCtBfQ2/wucRo99amu7Rra/zCVqIvVL8oTgE/d6dowzVI92oZ/N8J4vCNYQeQ1to4DdVx8RaEAAw/+PW1DykIyHHjcwZhJZt8UjTDQoq5BwUvgBppDh8cu1r0YJernE9tLiAQSJnz+CuJN45wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753494450; c=relaxed/simple;
	bh=D4mv0bnJMpA06AEn9vrzc/D4M+IAH+zY69YwG874vbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JAdFtpknWF60wgQTj8eh8yyobFnhSkzvWPizYm+DKMBnZCANcLPvCm1ROYkY/uEZFb/VTWOjbN0EB6Ngd7lld6gZIsJ3jDltFIf05uGbZb10vaaEtISQS8CVEvHpkBCiDItp7zunTfTitW/D0zS9qGxjXhN2Al1P3oB3zwNJAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bpncD6rQtz2RVtT;
	Sat, 26 Jul 2025 09:45:00 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B5FE9140296;
	Sat, 26 Jul 2025 09:47:17 +0800 (CST)
Received: from [10.174.177.71] (10.174.177.71) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 09:47:16 +0800
Message-ID: <0213b23c-e746-4e05-b151-8b0f5bd3d7d2@huawei.com>
Date: Sat, 26 Jul 2025 09:47:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix crash on test_mb_mark_used kunit tests
Content-Language: en-GB
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Zhang Yi
	<yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux@roeck-us.net>, <yi.zhang@huawei.com>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
 <av5necgeitkiormvqsh75kvgq3arjwxxqxpqievulgz2rvi3dg@75hdi2ubarmr>
 <20250725131541.GA184259@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250725131541.GA184259@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 7/25/2025 9:15 PM, Theodore Ts'o wrote:
> On Fri, Jul 25, 2025 at 01:06:18PM +0200, Jan Kara wrote:
>>> This patch applies to the kernel that has only merged bbe11dd13a3f
>>> ("ext4: fix largest free orders lists corruption on mb_optimize_scan
>>> switch"), but not merged 458bfb991155 ("ext4: convert free groups order
>>> lists to xarrays").
>> Hum, I think it would be best to just squash this into bbe11dd13a3f and
>> then just rebase & squash the other unittest fixup to the final commit when
>> we have to rebase anyway. Because otherwise backports to stable kernel will
>> quickly become rather messy.
> What I ended up doing was to add a squashed combination of these two
> commits and dropped it in before the block allocation scalabiltity
> with the following commit description:
>
>      ext4: initialize superblock fields in the kballoc-test.c kunit tests
>      
>      Various changes in the "ext4: better scalability for ext4 block
>      allocation" patch series have resulted in kunit test failures, most
>      notably in the test_new_blocks_simple and the test_mb_mark_used tests.
>      The root cause of these failures is that various in-memory ext4 data
>      structures were not getting initialized, and while previous versions
>      of the functions exercised by the unit tests didn't use these
>      structure members, this was arguably a test bug.
>      
>      Since one of the patches in the block allocation scalability patches
>      is a fix which is has a cc:stable tag, this commit also has a
>      cc:stable tag.
>      
>      CC: stable@vger.kernel.org
>      Link: https://lore.kernel.org/r/20250714130327.1830534-1-libaokun1@huawei.com
>      Link: https://patch.msgid.link/20250725021550.3177573-1-yi.zhang@huaweicloud.com
>      Link: https://patch.msgid.link/20250725021654.3188798-1-yi.zhang@huaweicloud.com
>      Reported-by: Guenter Roeck <linux@roeck-us.net>
>      Closes: https://lore.kernel.org/linux-ext4/b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net/
>      Tested-by: Guenter Roeck <linux@roeck-us.net>
>      Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>      Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> Then in the commit "ext4: convert free groups order lists to xarrays"
> which removed list_head, I modified it to remove the linked list
> initialization from mballoc-test.c, since that's the commit which
> removed those structures.

This looks good to me. Thank you for helping to adapt this patch!

>
> In the future, we should try to make sure that when we modify data
> structures to add or remove struct elements, that we also make sure
> that kunit test should also be updated.  To that end, I've updated the
> kbuild script[1] in xfstests-bld repo so that "kbuild --test" will run
> the Kunit tests.  Hopefully reducing the friction for running tests
> will encourage more kunit tests to be created and so they will kept
> under regular maintenance.
>
> [1] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kbuild

Yeah, unit tests are a much more efficient way to catch problems compared
to full system tests. Running them regularly would be a great way to
quickly surface issues.

On top of that, I think it's worth revisiting our current code and cleaning
up some of the logic. Specifically, refactoring initialization functions to
align with the single-responsibility principle would enable reuse between
production and testing flows, and minimize strange edge cases we’ve been
seeing.


Cheers,
Baokun


