Return-Path: <linux-fsdevel+bounces-50918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D029AD101D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BE0161736
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C1C20C00C;
	Sat,  7 Jun 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d5eH7hOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A435957;
	Sat,  7 Jun 2025 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749331890; cv=none; b=uILABHe7F3QH4dipYrczYlbnLlXgFgoI3iQ9MgXVYYPMOAbHAY2vdphwlQgN3i/znnkSBl8rrlIbsKNNrF9xMC7CypjJ3Yo2sGTXZW+XX+Dm/2SCg8c8FYgtPnDhALFq9C2JjfzYdngtloH9XLnLn4y5PpaMs04RtWgESjuGJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749331890; c=relaxed/simple;
	bh=8aIyffKejPWFzUAjtn7mONxd6kcAwOjWhbvLV30cHpA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e/3oUEejHrOqXOvaxYrWY09b3wyKgrKyCRnFeCjg3OdJ7GM4FH0eBU6Mv3gt3O99qdhfh2f+h6J7u+Ieftg1A5YPF7lXbwuiZBbSqQrwKZ7pMxZZdSP23vyU5c6L2qdzK4ZKxeEJUOI181/lM21foERuO56rXixp5nGqaj5TkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d5eH7hOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61277C4CEE4;
	Sat,  7 Jun 2025 21:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749331889;
	bh=8aIyffKejPWFzUAjtn7mONxd6kcAwOjWhbvLV30cHpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d5eH7hOkXO+2GLIjd3Zsk5dRCih1mBAwA6gIAZWUaDp3jBv9zX+7ymfH6NeZmoK+1
	 rzLn9Cn058pWhtneEzEQleuRD3YGNqKkKXOdo7vNhvIqDZO/VqNuK1mHwEMpbBoLIs
	 xNNUz3saTvHrtJIg/s2GE5bOFhwpX3pfmVvRAA/Q=
Date: Sat, 7 Jun 2025 14:31:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wangfushuai <wangfushuai@baidu.com>
Cc: <david@redhat.com>, <andrii@kernel.org>, <osalvador@suse.de>,
 <Liam.Howlett@Oracle.com>, <christophe.leroy@csgroup.eu>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] fs/proc/task_mmu: add VM_SHADOW_STACK for arm64 when
 support GCS
Message-Id: <20250607143128.d3ae86e8ebf9dcab02870421@linux-foundation.org>
In-Reply-To: <20250607131525.76746-1-wangfushuai@baidu.com>
References: <20250607131525.76746-1-wangfushuai@baidu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Jun 2025 21:15:25 +0800 wangfushuai <wangfushuai@baidu.com> wrote:

> The recent commit adding VM_SHADOW_STACK for arm64 GCS did not update
> the /proc/[pid]/smaps display logic to show the "ss" flag for GCS pages.
> This patch adds the necessary condition to display "ss" flag.
> 
> ...
>
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -994,6 +994,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>  		[ilog2(VM_SHADOW_STACK)] = "ss",
>  #endif
> +#if defined(CONFIG_ARM64_GCS)
> +		[ilog2(VM_SHADOW_STACK)] = "ss",
> +#endif
>  #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
>  		[ilog2(VM_DROPPABLE)] = "dp",
>  #endif

It is possible to have CONFIG_ARM64_GCS=y when
CONFIG_ARCH_HAS_USER_SHADOW_STACK=n?  If so, is this a correct
combination?


Also, wouldn't it be nicer to code this as 

--- a/fs/proc/task_mmu.c~a
+++ a/fs/proc/task_mmu.c
@@ -991,7 +991,7 @@ static void show_smap_vma_flags(struct s
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
+#if defined(CONFIG_ARCH_HAS_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
_




