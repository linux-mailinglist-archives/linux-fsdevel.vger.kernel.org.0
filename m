Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7A348539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 00:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhCXXUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 19:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhCXXU3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:20:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE88661A0F;
        Wed, 24 Mar 2021 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616628028;
        bh=DfPvVvnnPDOnWWAUCw/MMTu0BV/F1aFcs7Ds2Ng04gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mW4k3bZ+pK+Ysg7gscjEg94zbFO6h0wM0OI3WLRbjquYaGsdT9B6FGHJRwncMqk2o
         3AmNZ3T7z2vK3kNKvl8TLZ6peKzmZHK9JXI2g/lDl6mAWf9awteRaHy4z57jtli3B4
         Qg8KK7bbMeg+voQ1gLv3FOPPfzwy3S3GzuUFAHWY=
Date:   Wed, 24 Mar 2021 16:20:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix minor fault page leak
Message-Id: <20210324162027.cc723b545ff62b1ad6f5223e@linux-foundation.org>
In-Reply-To: <20210322204836.1650221-1-axelrasmussen@google.com>
References: <20210322204836.1650221-1-axelrasmussen@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Mar 2021 13:48:35 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> This fix is analogous to Peter Xu's fix for hugetlb [0]. If we don't
> put_page() after getting the page out of the page cache, we leak the
> reference.
> 
> The fix can be verified by checking /proc/meminfo and running the
> userfaultfd selftest in shmem mode. Without the fix, we see MemFree /
> MemAvailable steadily decreasing with each run of the test. With the
> fix, memory is correctly freed after the test program exits.
> 
> Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")

Confused.  The affected code:

> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1831,6 +1831,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  
>  	if (page && vma && userfaultfd_minor(vma)) {
>  		unlock_page(page);
> +		put_page(page);
>  		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
>  		return 0;
>  	}

Is added by Peter's "page && vma && userfaultfd_minor".  I assume that
"Fixes:" is incorrect?
