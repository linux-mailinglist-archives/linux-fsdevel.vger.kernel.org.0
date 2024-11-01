Return-Path: <linux-fsdevel+bounces-33398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED39B88E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D932B212DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04607E59A;
	Fri,  1 Nov 2024 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mOA7IDOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF621A28C;
	Fri,  1 Nov 2024 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425956; cv=none; b=hvtTlCgXugV7Kp8KN202QcYxXzxPUjM/CyR/0gSN+vFsiOVWPui0kIJmxrBFNJrgYLTmZFc40YNc0KQeq2MUkiZT6mBUYoqEWrUX9glrTc4iHJ9S15dSi3pn+qyarY30RVfDF/nRo4Eni0oFvbWpqLqjPfp2ycXHMtpU94Oxcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425956; c=relaxed/simple;
	bh=rUYhonZQ44s7AHpyKlo7hmLgeKtjiBsbCXsQs2AM87c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZnqFNsxf96VDEUeuimFakYG5alv2/laAMSbgya4z+x8lRojZAXtE6PqLdOdW6GtJB/URaCSQeKXUwssux7mvu0rNOujyNeyvQrV7mTmgpam8fpitEZsZXt+OosJ8b+G6uqhz5d23bOAgdViie8jLlx8u9BF/xlkeC/5U9VgJ0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mOA7IDOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A363EC4CEC3;
	Fri,  1 Nov 2024 01:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730425955;
	bh=rUYhonZQ44s7AHpyKlo7hmLgeKtjiBsbCXsQs2AM87c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mOA7IDOAhyGZXr2y5DJ0+z5H3EkStEeP+24bScIxzAUIsj7m8vmKF4Yr3wrnwFgXI
	 r+aW2Rs2YEa434G8cFDlj+sOmGj7fCzxMDqFpBr50XQLGkLCH6QYq51/8UwUuHNkbK
	 8t+H+zbZNSs3LeRcOWcbAoHK7clISQT7cj1+EA4o=
Date: Thu, 31 Oct 2024 18:52:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Xi <xiqi2@huawei.com>
Cc: <bobo.shaobowang@huawei.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
 <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/proc: Fix compile warning about variable
 'vmcore_mmap_ops'
Message-Id: <20241031185235.8bb482766ab10d2ab19fd3f6@linux-foundation.org>
In-Reply-To: <20241031072746.12897-1-xiqi2@huawei.com>
References: <20241031072746.12897-1-xiqi2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 15:27:46 +0800 Qi Xi <xiqi2@huawei.com> wrote:

> When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
> is defined but not used:
> 
> >> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
>      458 | static const struct vm_operations_struct vmcore_mmap_ops = {
> 
> Fix this by declaring it __maybe_unused.
> 

It's better to move the definition inside #ifdef CONFIG_MMU, perhaps this:

--- a/fs/proc/vmcore.c~a
+++ a/fs/proc/vmcore.c
@@ -457,10 +457,6 @@ static vm_fault_t mmap_vmcore_fault(stru
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
-	.fault = mmap_vmcore_fault,
-};
-
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
  * @size: size of buffer
@@ -488,6 +484,11 @@ static inline char *vmcore_alloc_buf(siz
  * virtually contiguous user-space in ELF layout.
  */
 #ifdef CONFIG_MMU
+
+static const struct vm_operations_struct vmcore_mmap_ops = {
+	.fault = mmap_vmcore_fault,
+};
+
 /*
  * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
  * reported as not being ram with the zero page.
_


Please check and test that and send it back at us a a v2 patch?

