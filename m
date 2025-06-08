Return-Path: <linux-fsdevel+bounces-50926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F1AD1178
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7517A55E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE71FBEB9;
	Sun,  8 Jun 2025 07:37:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE321D9A54;
	Sun,  8 Jun 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368234; cv=none; b=YloJzPJAwO4psOu6jfoDxAohK8gD1dKX5AX5Qqct9BV38psyYSI8pDbZBdaoJw6iLC6lvb80YwNdzFrpIBteQzpJN7VMjnhR2mMOu1sY+1t4PblXp4mGo3ArW1jnNHhj3tAWAP8WzaBR/E0uh9qdPGh7rm3FKWsXCO8MLA4yUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368234; c=relaxed/simple;
	bh=jnTo92m2IlMApVTpukuZMOlOy0IQg59i7fceuedhtNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br6MpyBH8A1fbJc2PSrIWIu8Ps4sGEZ49Qwy0GjOtaSx69LpdG9Vm81u2/CE74RL4+aywt0t5yR62RUM6tqEtJNgZun9oRBGZ5LjlZy9zDGudp6MWCssLEl+0GMLmv6ksa3KCDy9o3OQF5HOYk0v7z1JhePDC9QOmO2Y/T2YWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <akpm@linux-foundation.org>
CC: <Liam.Howlett@Oracle.com>, <andrii@kernel.org>, <broonie@kernel.org>,
	<catalin.marinas@arm.com>, <christophe.leroy@csgroup.eu>, <david@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<osalvador@suse.de>, <wangfushuai@baidu.com>
Subject: Re: [PATCH v2] fs/proc/task_mmu: add VM_SHADOW_STACK for arm64 when support GCS
Date: Sun, 8 Jun 2025 15:35:17 +0800
Message-ID: <20250608073517.98789-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250607143128.d3ae86e8ebf9dcab02870421@linux-foundation.org>
References: <20250607143128.d3ae86e8ebf9dcab02870421@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

>> The recent commit adding VM_SHADOW_STACK for arm64 GCS did not update
>> the /proc/[pid]/smaps display logic to show the "ss" flag for GCS pages.
>> This patch adds the necessary condition to display "ss" flag.
>> 
>> ...
>>
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -994,6 +994,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>>  #ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>>  		[ilog2(VM_SHADOW_STACK)] = "ss",
>>  #endif
>> +#if defined(CONFIG_ARM64_GCS)
>> +		[ilog2(VM_SHADOW_STACK)] = "ss",
>> +#endif
>>  #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
>>  		[ilog2(VM_DROPPABLE)] = "dp",
>>  #endif
> 
> It is possible to have CONFIG_ARM64_GCS=y when
> CONFIG_ARCH_HAS_USER_SHADOW_STACK=n?  If so, is this a correct
> combination?
Hi, Morton
After revisiting the code logic, I realized that if CONFIG_ARM64_GCS is enabled,
CONFIG_ARCH_HAS_USER_SHADOW_STACK will always be enabled as well. Therefore,
it seems unnecessary to add separate VM_SHADOW_STACK support specifically for
CONFIG_ARM64_GCS at this stage.

I will make sure to review future patches more carefully to avoid such oversights.

Regards,
Wang
> 
> 
> Also, wouldn't it be nicer to code this as 
> 
> --- a/fs/proc/task_mmu.c~a
> +++ a/fs/proc/task_mmu.c
> @@ -991,7 +991,7 @@ static void show_smap_vma_flags(struct s
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> -#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> +#if defined(CONFIG_ARCH_HAS_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
>  		[ilog2(VM_SHADOW_STACK)] = "ss",
>  #endif
>  #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
> _
> --

