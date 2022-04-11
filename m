Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75614FBFDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347632AbiDKPLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiDKPLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:11:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329FB2AE12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 08:08:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq30so14430644lfb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SZ3/Vx+1Q7uH45Ete1zY0f2BZJWVMOSE6BEs5zWCYbs=;
        b=7DIUdDw1bDVY/1pX9CrYKqoUnxn4Af2165TByD3u5HZ0iXmIdkyeDLerqJVS4ILYb2
         sr8EaHNWEoVQlow3SdmLYTkP5xN8dgvPftKQlE2GzWppJ9Nm1Jc8ZkbxJeZp/XQcv+bm
         CkITSbBdcYbYkEIbRjUo+wMmeMYCl/ckl8Eyh5jpmDByZr90ijXMmjL2GuwmjJqoSc6X
         41HpTTObRQn2DziTHtTZKAPeR3G4oO4JnMRiHaWm+nxgPN2SgqBjtuDslRAMsgbobCqJ
         zrEUAd863LfUu4IdojsoK+HRzJ1QfBeJabFS3cJ9rTqFAAPFDxSzIUbnYMV1zoLxx+KI
         BBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SZ3/Vx+1Q7uH45Ete1zY0f2BZJWVMOSE6BEs5zWCYbs=;
        b=1U7aCrn+UlhVkqO3F7ePYMdr4pYiO4443NLr5JFDzcz2jXzTeH8ZW4pg85RuvK7jct
         5lQqyYZbeM0jFIm9LRU9QqmalVOWOXOC51ZWIIjwwZ4km+pvGfkNrB2U+Gk4e5SLnUWV
         0ylwHFmdMAM897lTyAqcG4zz+vfAYkXYCjWSa/GfVA0jyDUrFspDaViHeCYu2NW6OAwh
         zmVnnndd1DNOaHkkCo45eN96WZAzV5S4i/8zdVICuG/rjKGYORFUGlbUF156fH9A+T0J
         WEq287MkYUjaTPHwZNjybpKodOL+7YC7mjZjI57SwZTcegeZVp2Wjqo6saROVQm3obb5
         YAIQ==
X-Gm-Message-State: AOAM532FQGADmt1Aio5sqPVlYRuCUgK6QrsP19cL7h37KT7RtEODBRDt
        7XW6vF+xwHD9emUNYjA2ybjI0g==
X-Google-Smtp-Source: ABdhPJwVzRe0aqmUWVOSiTlNptfcMMnBCa3LaWdYU4CM/MHAyK3juuV+XEpH4cZF1tu2LetUDByrEw==
X-Received: by 2002:a05:6512:3f29:b0:450:ac79:77dd with SMTP id y41-20020a0565123f2900b00450ac7977ddmr21705662lfa.301.1649689731304;
        Mon, 11 Apr 2022 08:08:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t2-20020a05651c204200b0024b4bc5d324sm1197193ljo.79.2022.04.11.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:08:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 41CC4103CE0; Mon, 11 Apr 2022 18:10:23 +0300 (+03)
Date:   Mon, 11 Apr 2022 18:10:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 01/13] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <20220411151023.4nx34pxyg5amj44m@box.shutemov.name>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-2-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-2-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:08:59PM +0800, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Introduce a new memfd_create() flag indicating the content of the
> created memfd is inaccessible from userspace through ordinary MMU
> access (e.g., read/write/mmap). However, the file content can be
> accessed via a different mechanism (e.g. KVM MMU) indirectly.
> 
> It provides semantics required for KVM guest private memory support
> that a file descriptor with this flag set is going to be used as the
> source of guest memory in confidential computing environments such
> as Intel TDX/AMD SEV but may not be accessible from host userspace.
> 
> Since page migration/swapping is not yet supported for such usages
> so these pages are currently marked as UNMOVABLE and UNEVICTABLE
> which makes them behave like long-term pinned pages.
> 
> The flag can not coexist with MFD_ALLOW_SEALING, future sealing is
> also impossible for a memfd created with this flag.
> 
> At this time only shmem implements this flag.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/shmem_fs.h   |  7 +++++
>  include/uapi/linux/memfd.h |  1 +
>  mm/memfd.c                 | 26 +++++++++++++++--
>  mm/shmem.c                 | 57 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index e65b80ed09e7..2dde843f28ef 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -12,6 +12,9 @@
>  
>  /* inode in-kernel data */
>  
> +/* shmem extended flags */
> +#define SHM_F_INACCESSIBLE	0x0001  /* prevent ordinary MMU access (e.g. read/write/mmap) to file content */
> +
>  struct shmem_inode_info {
>  	spinlock_t		lock;
>  	unsigned int		seals;		/* shmem seals */
> @@ -24,6 +27,7 @@ struct shmem_inode_info {
>  	struct shared_policy	policy;		/* NUMA memory alloc policy */
>  	struct simple_xattrs	xattrs;		/* list of xattrs */
>  	atomic_t		stop_eviction;	/* hold when working on inode */
> +	unsigned int		xflags;		/* shmem extended flags */
>  	struct inode		vfs_inode;
>  };
>  

AFAICS, only two bits of 'flags' are used. And that's very strange that
VM_ flags are used for the purpose. My guess that someone was lazy to
introduce new constants for this.

I think we should fix this: introduce SHM_F_LOCKED and SHM_F_NORESERVE
alongside with SHM_F_INACCESSIBLE and stuff them all into info->flags.
It also makes shmem_file_setup_xflags() go away.

-- 
 Kirill A. Shutemov
