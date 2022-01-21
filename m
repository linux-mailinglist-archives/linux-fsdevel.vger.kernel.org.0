Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E70C496252
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381684AbiAUPvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 10:51:04 -0500
Received: from foss.arm.com ([217.140.110.172]:55548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351414AbiAUPvC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:51:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5BE101E;
        Fri, 21 Jan 2022 07:51:00 -0800 (PST)
Received: from [10.57.39.88] (unknown [10.57.39.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B59213F73D;
        Fri, 21 Jan 2022 07:50:56 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v4 02/12] mm/memfd: Introduce MFD_INACCESSIBLE flag
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-3-chao.p.peng@linux.intel.com>
Message-ID: <8f1eba03-e5e9-e9fc-084d-0ef683093d65@arm.com>
Date:   Fri, 21 Jan 2022 15:50:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220118132121.31388-3-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/01/2022 13:21, Chao Peng wrote:
> Introduce a new memfd_create() flag indicating the content of the
> created memfd is inaccessible from userspace. It does this by force
> setting F_SEAL_INACCESSIBLE seal when the file is created. It also set
> F_SEAL_SEAL to prevent future sealing, which means, it can not coexist
> with MFD_ALLOW_SEALING.
> 
> The pages backed by such memfd will be used as guest private memory in
> confidential computing environments such as Intel TDX/AMD SEV. Since
> page migration/swapping is not yet supported for such usages so these
> pages are currently marked as UNMOVABLE and UNEVICTABLE which makes
> them behave like long-term pinned pages.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/uapi/linux/memfd.h |  1 +
>  mm/memfd.c                 | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 7a8a26751c23..48750474b904 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -8,6 +8,7 @@
>  #define MFD_CLOEXEC		0x0001U
>  #define MFD_ALLOW_SEALING	0x0002U
>  #define MFD_HUGETLB		0x0004U
> +#define MFD_INACCESSIBLE	0x0008U
>  
>  /*
>   * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 9f80f162791a..26998d96dc11 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -245,16 +245,19 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
>  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>  
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> +		       MFD_INACCESSIBLE)
>  
>  SYSCALL_DEFINE2(memfd_create,
>  		const char __user *, uname,
>  		unsigned int, flags)
>  {
> +	struct address_space *mapping;
>  	unsigned int *file_seals;
>  	struct file *file;
>  	int fd, error;
>  	char *name;
> +	gfp_t gfp;
>  	long len;
>  
>  	if (!(flags & MFD_HUGETLB)) {
> @@ -267,6 +270,10 @@ SYSCALL_DEFINE2(memfd_create,
>  			return -EINVAL;
>  	}
>  
> +	/* Disallow sealing when MFD_INACCESSIBLE is set. */
> +	if (flags & MFD_INACCESSIBLE && flags & MFD_ALLOW_SEALING)
> +		return -EINVAL;
> +
>  	/* length includes terminating zero */
>  	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
>  	if (len <= 0)
> @@ -315,6 +322,17 @@ SYSCALL_DEFINE2(memfd_create,
>  		*file_seals &= ~F_SEAL_SEAL;
>  	}
>  
> +	if (flags & MFD_INACCESSIBLE) {
> +		mapping = file_inode(file)->i_mapping;
> +		gfp = mapping_gfp_mask(mapping);
> +		gfp &= ~__GFP_MOVABLE;
> +		mapping_set_gfp_mask(mapping, gfp);
> +		mapping_set_unevictable(mapping);
> +
> +		file_seals = memfd_file_seals_ptr(file);
> +		*file_seals &= F_SEAL_SEAL | F_SEAL_INACCESSIBLE;

This looks backwards - the flags should be set on *file_seals, but here
you are unsetting all other flags.

Steve

> +	}
> +
>  	fd_install(fd, file);
>  	kfree(name);
>  	return fd;
> 

