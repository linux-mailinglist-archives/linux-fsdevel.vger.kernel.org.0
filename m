Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77667397EF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 04:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFBCZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 22:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhFBCYl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:24:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C78E61008;
        Wed,  2 Jun 2021 02:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622600578;
        bh=4+yLy4p99WqcuQe2+GKoMtnbQHolk38VvFSqueJl5PU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zVJyKrG2rWXB0c0ILxAig2g02HhkupS08S9YYUFJwhsoOwK6dNcpSZAHebVgu5zA/
         SP/a9+40z4KAho+ozQDZNICPodGMS33gMlt6vUdv5pxS2A28yQGWBe2yWY8lj2uczo
         l0btlGYYEaI09TzIUrQWAccv2zH0/gJ2ovDfVBbI=
Date:   Tue, 1 Jun 2021 19:22:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     adobriyan@gmail.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2] fs/proc/kcore.c: add mmap interface
Message-Id: <20210601192257.65a514606382f0a972f918c3@linux-foundation.org>
In-Reply-To: <20210601082241.13378-1-zhoufeng.zf@bytedance.com>
References: <20210601082241.13378-1-zhoufeng.zf@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  1 Jun 2021 16:22:41 +0800 Feng zhou <zhoufeng.zf@bytedance.com> wrote:

> From: ZHOUFENG <zhoufeng.zf@bytedance.com>
> 
> When we do the kernel monitor, use the DRGN
> (https://github.com/osandov/drgn) access to kernel data structures,
> found that the system calls a lot. DRGN is implemented by reading
> /proc/kcore. After looking at the kcore code, it is found that kcore
> does not implement mmap, resulting in frequent context switching
> triggered by read. Therefore, we want to add mmap interface to optimize
> performance. Since vmalloc and module areas will change with allocation
> and release, consistency cannot be guaranteed, so mmap interface only
> maps KCORE_TEXT and KCORE_RAM.
> 
> ...
>
> +static int mmap_kcore(struct file *file, struct vm_area_struct *vma)
> +{
> +	size_t size = vma->vm_end - vma->vm_start;
> +	u64 start, pfn;
> +	int nphdr;
> +	size_t data_offset;
> +	size_t phdrs_len, notes_len;
> +	struct kcore_list *m = NULL;
> +	int ret = 0;
> +
> +	down_read(&kclist_lock);
> +
> +	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
> +
> +	start = kc_offset_to_vaddr(((u64)vma->vm_pgoff << PAGE_SHIFT) -
> +		((data_offset >> PAGE_SHIFT) << PAGE_SHIFT));
> +
> +	list_for_each_entry(m, &kclist_head, list) {
> +		if (start >= m->addr && size <= m->size)
> +			break;
> +	}
> +
> +	if (&m->list == &kclist_head) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (vma->vm_flags & (VM_WRITE | VM_EXEC)) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
> +	vma->vm_flags |= VM_MIXEDMAP;
> +	vma->vm_ops = &kcore_mmap_ops;
> +
> +	if (kern_addr_valid(start)) {
> +		if (m->type == KCORE_RAM || m->type == KCORE_REMAP)

KCORE_REMAP was removed by
https://lkml.kernel.org/r/20210526093041.8800-2-david@redhat.com

I did this:

--- a/fs/proc/kcore.c~fs-proc-kcorec-add-mmap-interface-fix
+++ a/fs/proc/kcore.c
@@ -660,7 +660,7 @@ static int mmap_kcore(struct file *file,
 	vma->vm_ops = &kcore_mmap_ops;
 
 	if (kern_addr_valid(start)) {
-		if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
+		if (m->type == KCORE_RAM)
 			pfn = __pa(start) >> PAGE_SHIFT;
 		else if (m->type == KCORE_TEXT)
 			pfn = __pa_symbol(start) >> PAGE_SHIFT;

