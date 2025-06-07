Return-Path: <linux-fsdevel+bounces-50907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A5AD0D93
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91D93A4E87
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFECA223DF0;
	Sat,  7 Jun 2025 13:10:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDACA5A;
	Sat,  7 Jun 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301834; cv=none; b=eVIm6B9YwUekJWrqot4CjfUuzLJmjfnFxCjYbJ5Wb0iaNwAlM+8Xo3BerCRcNSnjBtsF4Q+TzXeLuxPJxjpxMZcG10p5sDfwO4jJv8ktNU8pDnAWgDMZ4TMCl3KIoyQF2k2hfb/SnsE6D0yaYbjbGx4nUeSAAxMv7h+zd29ghqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301834; c=relaxed/simple;
	bh=WOYQ6xWwJEuJwlVoF7FZKQNdjh/wOaLF4xZxjrOdDT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfdil4QgDp+6KALE37O3peghWS16XTUj/CFBf6HwAfuJbqcoXAYA+8u6YpwPIQP1dGC4cM2dtE7oJPZ31bsSJz9tQ7U6bnWLzGM3MrhcD04IKIhPpHxwMjSv8bMMy+ZlVgqtYvM5TbrP8tnwtwfYzEYEJHF820OlAjLt9TBFVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <wangfushuai@baidu.com>
CC: <Liam.Howlett@Oracle.com>, <akpm@linux-foundation.org>,
	<andrii@kernel.org>, <christophe.leroy@csgroup.eu>, <david@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<osalvador@suse.de>
Subject: Re: [PATCH] fs/proc/task_mmu: add VM_SHADOW_STACK for arm64 when support GCS
Date: Sat, 7 Jun 2025 21:08:38 +0800
Message-ID: <20250607130838.76035-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250607060741.69902-1-wangfushuai@baidu.com>
References: <20250607060741.69902-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

> The recent commit adding VM_SHADOW_STACK for arm64 GCS did not update
> the /proc/[pid]/smaps display logic to show the "ss" flag for GCS pages.
> This patch adds the necessary condition to display "ss" flag.
>  
> Fixes: ae80e1629aea ("mm: Define VM_SHADOW_STACK for arm64 when we support GCS")
> Signed-off-by: wangfushuai <wangfushuai@baidu.com>
> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 27972c0749e7..c4c942cc6e72 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -991,7 +991,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> -#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK || defined(CONFIG_ARM64_GCS)
>  		[ilog2(VM_SHADOW_STACK)] = "ss",
>  #endif
>  #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
> -- 
Hi Maintainers,

Please disregard this patch. I accidentally uploaded the wrong version of the code.
I will send the corrected patch shortly. Apologies for the confusion.

Thanks,

