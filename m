Return-Path: <linux-fsdevel+bounces-68798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F278C66733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6811D2973E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49FD33290F;
	Mon, 17 Nov 2025 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FyEeWQ8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D3313526;
	Mon, 17 Nov 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419417; cv=none; b=dnRuYeOr7IJfxmSw8Jy7F0Y2Dz10R9+Mv0wdltBeCTPSLk263mF7oxlqRmkiScwLZGMx54kJdea6SbQrY3RZ6+zo6whFJw+/j/EbbaybrHdyS/hsfixH9gIu11rzkU++2vGLTqX4p68njdy/HrlciYZdrfe0o393c+F0q32siKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419417; c=relaxed/simple;
	bh=fvcx/Gt9WjAEJUY/t8KcGE1aZ2anNZHWj8y8rDypI98=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fey3hA7Bxpx073u7ov+1L0cHFcsC3FrNHktxJqdmSdkIX0qE6bNhaeeRWpSogXxVh1kj25kOeECAgfB7gxkO/irnOV/MVPX2Vk1xqSahar6rbX+rjogQtpb+JiPVBdoE+grTxEOBnGQwYt7T86YcngiWjIJO6vFawyjLCSl+2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FyEeWQ8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24759C4CEFB;
	Mon, 17 Nov 2025 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763419416;
	bh=fvcx/Gt9WjAEJUY/t8KcGE1aZ2anNZHWj8y8rDypI98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FyEeWQ8iSZBK+XnCJYC79Ys+cl+vTmK23FjMTSIBT8qxfqwAdGJWPQrUDKKb25F3X
	 9LOCFYq7rd7q0KO1765OIQTvs/NItDf3p96v++AKHzUHor95T0Ma5HfgoXwMW2St7d
	 Ck8Z+BeQg9aiz6mwKaoXhpAMMmJ5dCexanDIw1M8=
Date: Mon, 17 Nov 2025 14:43:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Andrei
 Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 3/8] mm: implement sticky VMA flags
Message-Id: <20251117144332.d338e8368d59c3ab665db986@linux-foundation.org>
In-Reply-To: <cf58c518-05d0-494f-8fe4-571879834031@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
	<1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
	<cf58c518-05d0-494f-8fe4-571879834031@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 20:02:03 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Sorry to be a pain here, and can respin if it's easier, but can we update the
> text of the comments below? As in discussion with Liam off-list we agreed that
> the current wording is rather unclear and we can do a lot better.
> 
> I provide the improved version inline below:

np,

 include/linux/mm.h               |    7 +++----
 tools/testing/vma/vma_internal.h |    7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

--- a/include/linux/mm.h~mm-implement-sticky-vma-flags-fix-2
+++ a/include/linux/mm.h
@@ -549,10 +549,9 @@ extern unsigned int kobjsize(const void
  *                pressure on the memory system forcing the kernel to generate
  *                new VMAs when old one could be extended instead.
  *
- *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
- *                which should propagate to all VMAs, but the other does not,
- *                the merge should still proceed with the merge logic applying
- *                sticky flags to the final VMA.
+ *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
+ *                'sticky'. If any sticky flags exist in either VMA, we simply
+ *                set all of them on the merged VMA.
  */
 #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
 
--- a/tools/testing/vma/vma_internal.h~mm-implement-sticky-vma-flags-fix-2
+++ a/tools/testing/vma/vma_internal.h
@@ -139,10 +139,9 @@ extern unsigned long dac_mmap_min_addr;
  *                pressure on the memory system forcing the kernel to generate
  *                new VMAs when old one could be extended instead.
  *
- *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
- *                which should propagate to all VMAs, but the other does not,
- *                the merge should still proceed with the merge logic applying
- *                sticky flags to the final VMA.
+ *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
+ *                'sticky'. If any sticky flags exist in either VMA, we simply
+ *                set all of them on the merged VMA.
  */
 #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
 
_


