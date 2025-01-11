Return-Path: <linux-fsdevel+bounces-38923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E98CA09F9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 01:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BA3188EF57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B6B67A;
	Sat, 11 Jan 2025 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="s1g/Bwlt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E24689;
	Sat, 11 Jan 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556334; cv=none; b=tEVATLBbAtXJwGQsNo/0zjw1naDS24LHykn1zTbBQlL3siXEDF5TgBDhLQ2Umm8UtBMfUPgDec3cSwD87FnHuPNwFwWrhxgeK4ixMKWbqXjBJJklLMipzm40NtP4B95WI0AHC4xH9iyz6SWwEIny9Vq1fl5gEOIyoZ5ucycI18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556334; c=relaxed/simple;
	bh=TbVcNLHS+ntm0ELp6PZq+CJ4y3znHfMLmaJiBqo2fYw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KJlm8ceTqonPFqEgNv4j6m7wJ1OY+KlF02s/wxJCKmAlutRyfL78Dbtu7YPSuqO1DrtOLE5s5dp7sgzUdYhN8FQ38qrhw1vQ5oD7FXh9TOJKH6IFDkaWoqplXXnCtP3nItggqmfSQMEp3ydV6/a8Lib8jzo+kzDb0Fe3nNH656o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=s1g/Bwlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95035C4CED6;
	Sat, 11 Jan 2025 00:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736556333;
	bh=TbVcNLHS+ntm0ELp6PZq+CJ4y3znHfMLmaJiBqo2fYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s1g/BwltNKLo89VJZN8Z/mYNiOyQawI3ikdv8bqdTtJF8Ow+1GIb3/RiH+LHsapzG
	 Vqc3723rtA9/XXPiO+Zw1ev+MVzTx8+crxOQy2UyIkHqaG8kYXP/K3/r6hMKr6zzGY
	 eoD6OzNZDytdmNqXRQfDG5ZqRDYZJRvJ1Ki77Uxc=
Date: Fri, 10 Jan 2025 16:45:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: <xu.xin16@zte.com.cn>
Cc: <david@redhat.com>, <linux-kernel@vger.kernel.org>,
 <wang.yaxin@zte.com.cn>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH v5] ksm: add ksm involvement information for each
 process
Message-Id: <20250110164533.996d4ec5b82f58198cd36b74@linux-foundation.org>
In-Reply-To: <20250110174034304QOb8eDoqtFkp3_t8mqnqc@zte.com.cn>
References: <20250110174034304QOb8eDoqtFkp3_t8mqnqc@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 17:40:34 +0800 (CST) <xu.xin16@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
> KSM_mergeable and KSM_merge_any. It helps administrators to
> better know the system's KSM behavior at process level.
> 
> ksm_merge_any: yes/no
> 	whether the process'mm is added by prctl() into the candidate list
> 	of KSM or not, and fully enabled at process level.
> 
> ksm_mergeable: yes/no
>     whether any VMAs of the process'mm are currently applicable to KSM.
> 
> Purpose
> =======
> These two items are just to improve the observability of KSM at process
> level, so that users can know if a certain process has enable KSM.
> 
> For example, if without these two items, when we look at
> /proc/<pid>/ksm_stat and there's no merging pages found, We are not sure
> whether it is because KSM was not enabled or because KSM did not
> successfully merge any pages.
> 
> Althrough "mg" in /proc/<pid>/smaps indicate VM_MERGEABLE, it's opaque
> and not very obvious for non professionals.

Thanks, seems useful enough to me.

> +  3.14  /proc/<pid/ksm_stat - Information about the process' ksm status.

hm, I added this as a separate thing:


From: Andrew Morton <akpm@linux-foundation.org>
Subject: Documentation/filesystems/proc.rst: fix possessive form of "process"
Date: Fri Jan 10 04:38:41 PM PST 2025

The possessive form of "process" is "process's".  Fix up various
misdirected attempts at this.  Also reflow some paragraphs.

Cc: David Hildenbrand <david@redhat.com>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/filesystems/proc.rst |   36 +++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

--- a/Documentation/filesystems/proc.rst~documentation-filesystems-procrst-fix-possessive-form-of-process
+++ a/Documentation/filesystems/proc.rst
@@ -48,7 +48,7 @@ fixes/update part 1.1  Stefani Seibold <
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
   3.13  /proc/<pid>/fd - List of symlinks to open files
-  3.14  /proc/<pid/ksm_stat - Information about the process' ksm status.
+  3.14  /proc/<pid/ksm_stat - Information about the process's ksm status.
 
   4	Configuring procfs
   4.1	Mount options
@@ -485,14 +485,15 @@ Memory Area, or VMA) there is a series o
     THPeligible:           0
     VmFlags: rd ex mr mw me dw
 
-The first of these lines shows the same information as is displayed for the
-mapping in /proc/PID/maps.  Following lines show the size of the mapping
-(size); the size of each page allocated when backing a VMA (KernelPageSize),
-which is usually the same as the size in the page table entries; the page size
-used by the MMU when backing a VMA (in most cases, the same as KernelPageSize);
-the amount of the mapping that is currently resident in RAM (RSS); the
-process' proportional share of this mapping (PSS); and the number of clean and
-dirty shared and private pages in the mapping.
+The first of these lines shows the same information as is displayed for
+the mapping in /proc/PID/maps.  Following lines show the size of the
+mapping (size); the size of each page allocated when backing a VMA
+(KernelPageSize), which is usually the same as the size in the page table
+entries; the page size used by the MMU when backing a VMA (in most cases,
+the same as KernelPageSize); the amount of the mapping that is currently
+resident in RAM (RSS); the process's proportional share of this mapping
+(PSS); and the number of clean and dirty shared and private pages in the
+mapping.
 
 The "proportional set size" (PSS) of a process is the count of pages it has
 in memory, where each page is divided by the number of processes sharing it.
@@ -2233,8 +2234,8 @@ The number of open files for the process
 of stat() output for /proc/<pid>/fd for fast access.
 -------------------------------------------------------
 
-3.14 /proc/<pid/ksm_stat - Information about the process' ksm status
---------------------------------------------------------------------
+3.14 /proc/<pid/ksm_stat - Information about the process's ksm status
+---------------------------------------------------------------------
 When CONFIG_KSM is enabled, each process has this file which displays
 the information of ksm merging status.
 
@@ -2288,15 +2289,18 @@ memory consumed.
 ksm_merge_any
 ^^^^^^^^^^^^^
 
-It specifies whether the process'mm is added by prctl() into the candidate list
-of KSM or not, and KSM scanning is fully enabled at process level.
+It specifies whether the process's mm is added by prctl() into the
+candidate list of KSM or not, and KSM scanning is fully enabled at process
+level.
 
 ksm_mergeable
 ^^^^^^^^^^^^^
 
-It specifies whether any VMAs of the process'mm are currently applicable to KSM.
+It specifies whether any VMAs of the process's mm are currently applicable
+to KSM.
 
-More information about KSM can be found at Documentation/admin-guide/mm/ksm.rst.
+More information about KSM can be found at
+Documentation/admin-guide/mm/ksm.rst.
 
 
 Chapter 4: Configuring procfs
@@ -2327,7 +2331,7 @@ arguments are now protected against loca
 hidepid=invisible or hidepid=2 means hidepid=1 plus all /proc/<pid>/ will be
 fully invisible to other users.  It doesn't mean that it hides a fact whether a
 process with a specific pid value exists (it can be learned by other means, e.g.
-by "kill -0 $PID"), but it hides process' uid and gid, which may be learned by
+by "kill -0 $PID"), but it hides process's uid and gid, which may be learned by
 stat()'ing /proc/<pid>/ otherwise.  It greatly complicates an intruder's task of
 gathering information about running processes, whether some daemon runs with
 elevated privileges, whether other user runs some sensitive program, whether
_


