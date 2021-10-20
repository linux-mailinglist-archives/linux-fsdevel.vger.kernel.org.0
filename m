Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0B435018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhJTQ1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 12:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhJTQ1o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:27:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5849611F2;
        Wed, 20 Oct 2021 16:25:27 +0000 (UTC)
Date:   Wed, 20 Oct 2021 17:25:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 05/17] iov_iter: Introduce fault_in_iov_iter_writeable
Message-ID: <YXBC9LRwhgFCHqJA@arm.com>
References: <20211019134204.3382645-1-agruenba@redhat.com>
 <20211019134204.3382645-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019134204.3382645-6-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:41:52PM +0200, Andreas Gruenbacher wrote:
> diff --git a/mm/gup.c b/mm/gup.c
> index a7efb027d6cf..614b8536b3b6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1691,6 +1691,69 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
>  }
>  EXPORT_SYMBOL(fault_in_writeable);
>  
> +/*
> + * fault_in_safe_writeable - fault in an address range for writing
> + * @uaddr: start of address range
> + * @size: length of address range
> + *
> + * Faults in an address range using get_user_pages, i.e., without triggering
> + * hardware page faults.  This is primarily useful when we already know that
> + * some or all of the pages in the address range aren't in memory.
> + *
> + * Other than fault_in_writeable(), this function is non-destructive.
> + *
> + * Note that we don't pin or otherwise hold the pages referenced that we fault
> + * in.  There's no guarantee that they'll stay in memory for any duration of
> + * time.
> + *
> + * Returns the number of bytes not faulted in, like copy_to_user() and
> + * copy_from_user().
> + */
> +size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
> +{
> +	unsigned long start = (unsigned long)uaddr;
> +	unsigned long end, nstart, nend;
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = NULL;

For arm64 tagged addresses we need the diff below, otherwise the
subsequent find_vma() will fail:

diff --git a/mm/gup.c b/mm/gup.c
index f5f362cb4640..2c51e9748a6a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1713,7 +1713,7 @@ EXPORT_SYMBOL(fault_in_writeable);
  */
 size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
 {
-	unsigned long start = (unsigned long)uaddr;
+	unsigned long start = (unsigned long)untagged_addr(uaddr);
 	unsigned long end, nstart, nend;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;

-- 
Catalin
