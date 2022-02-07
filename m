Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751E4AC8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 19:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiBGSy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 13:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiBGSvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:51:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3AC0401DA;
        Mon,  7 Feb 2022 10:51:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19927210FA;
        Mon,  7 Feb 2022 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644259899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOYjLS4N8vwfd3h4Lp9C/Ennm3oWf0c+XTehS9bJX24=;
        b=xD7Cr2cOpWyJFdqWLn+fwhofVahSVhXmdPo56idG5sEwFbYiClzqPVLWBWRcb1Mu2tmNuU
        eBlcaQcoZFvNCxqIn5ekPjrKgkKAvDwbsoby5+RH2Ym3YX23LrAYAMQLPTyjl3j3RNg7Ur
        5j0MxhHbXCsgoNKv88jfUOZwq7fbAWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644259899;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOYjLS4N8vwfd3h4Lp9C/Ennm3oWf0c+XTehS9bJX24=;
        b=XZ9d5JbQDs73N70sW61CO6zONLOYVpxPeUzOGcKXyNDBTFPsCbLl+dOc0vH286Yw3W8e+S
        55xDWRh3IpqtqrCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9974513C61;
        Mon,  7 Feb 2022 18:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZIAMJDpqAWI0QAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Feb 2022 18:51:38 +0000
Message-ID: <25166513-3074-f3b9-12cc-420ba74f153e@suse.cz>
Date:   Mon, 7 Feb 2022 19:51:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 02/12] mm/memfd: Introduce MFD_INACCESSIBLE flag
Content-Language: en-US
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
        ak@linux.intel.com, david@redhat.com,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-3-chao.p.peng@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220118132121.31388-3-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/18/22 14:21, Chao Peng wrote:
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

Shouldn't the amount of such memory allocations be restricted? E.g. similar
to secretmem_mmap() doing mlock_future_check().

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
> +	}
> +
>  	fd_install(fd, file);
>  	kfree(name);
>  	return fd;

