Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9445718C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 16:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhKSPWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhKSPWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:22:47 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2BFC061748
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 07:19:45 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id j17so9778091qtx.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+oKCHlqOeL41R0XCrWbPi4i3qyXHn6RmL7MeAl4NL8=;
        b=lPGpGcid8QXwelr7zzSt5VTkDWstEKhmIVZjDI/gptTZ1XB8fRlCJsY82dS22YEbbI
         GADEuew95VumLWojAcQF6/3Rj7N9VtmARWHCGzMlbaVOuA5B2Iy8CEcEelQIeeRTPjCb
         /UriGVwYo5CnjPZCDlOVP8JIARNcJaTQUz01jDwgOeu3eE5FmpCC10B9LQ/D1G1T0tx4
         iQg2Eg0YoxH/lMrAwoMlca7V5PAbid3j8gMabaFjohga4jUqveMxv4mUiSKJmYsSXZJ9
         w9340v2YmW88xNRP0Sl+7ZXF9oISeC5mr2uPkE4vqO+Lek1l1/D1zTf+VnU59MujzXzD
         zgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+oKCHlqOeL41R0XCrWbPi4i3qyXHn6RmL7MeAl4NL8=;
        b=Ov+X/k3CGSC3VeJSlP7UBYyXn0wYfSln08ppiyUKV+zi289Lf/dojyHDiwyvr7Ytec
         qOlBwfeR+uHNyxnY7IT+fnsQYGw9xxvRYurYS3855smi7G4OqsQkNXSLD4orl01fPLGl
         5t66LYgBmP5tMcyX2o8ezVQb0UQ3qZwi2XslLnxNu9LOYOZusGjO3Oqff6kiSkBHqSBu
         APSXQwKS83nRmxSbDm1nEObJY4B5WbL3nP438OV1RFbVHMq56A20Fc0YSTK9qS5esoA0
         9vdRa8RoEjt0IVl12OUYb+zC/AS6lQ+90QWs63JCo6WEycepJlhJLNQf+33AhoMC6ey4
         h2fQ==
X-Gm-Message-State: AOAM533IG2YOYR1UgMtk8VQ3sCf1nEhb5lvUCr6e+H3SHDGTNZnQ6FJU
        fuFBJroh8BlNZG9fuXkW3mdNog==
X-Google-Smtp-Source: ABdhPJzBFCjiPUEhMyOCMWRnIUW5f5YGg2HohyzeoXo1q5KwzNya5wlMfrrS3JbWjHX+xZcOYu6I9Q==
X-Received: by 2002:a05:622a:1a93:: with SMTP id s19mr7169174qtc.291.1637335184307;
        Fri, 19 Nov 2021 07:19:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o126sm11039qke.11.2021.11.19.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 07:19:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mo5fz-00CHGM-Aq; Fri, 19 Nov 2021 11:19:43 -0400
Date:   Fri, 19 Nov 2021 11:19:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <20211119151943.GH876299@ziepe.ca>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119134739.20218-2-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 09:47:27PM +0800, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The new seal type provides semantics required for KVM guest private
> memory support. A file descriptor with the seal set is going to be used
> as source of guest memory in confidential computing environments such as
> Intel TDX and AMD SEV.
> 
> F_SEAL_GUEST can only be set on empty memfd. After the seal is set
> userspace cannot read, write or mmap the memfd.
> 
> Userspace is in charge of guest memory lifecycle: it can allocate the
> memory with falloc or punch hole to free memory from the guest.
> 
> The file descriptor passed down to KVM as guest memory backend. KVM
> register itself as the owner of the memfd via memfd_register_guest().
> 
> KVM provides callback that needed to be called on fallocate and punch
> hole.
> 
> memfd_register_guest() returns callbacks that need be used for
> requesting a new page from memfd.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>  include/linux/memfd.h      |  24 ++++++++
>  include/linux/shmem_fs.h   |   9 +++
>  include/uapi/linux/fcntl.h |   1 +
>  mm/memfd.c                 |  33 +++++++++-
>  mm/shmem.c                 | 123 ++++++++++++++++++++++++++++++++++++-
>  5 files changed, 186 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index 4f1600413f91..ff920ef28688 100644
> +++ b/include/linux/memfd.h
> @@ -4,13 +4,37 @@
>  
>  #include <linux/file.h>
>  
> +struct guest_ops {
> +	void (*invalidate_page_range)(struct inode *inode, void *owner,
> +				      pgoff_t start, pgoff_t end);
> +	void (*fallocate)(struct inode *inode, void *owner,
> +			  pgoff_t start, pgoff_t end);
> +};
> +
> +struct guest_mem_ops {
> +	unsigned long (*get_lock_pfn)(struct inode *inode, pgoff_t offset,
> +				      bool alloc, int *order);
> +	void (*put_unlock_pfn)(unsigned long pfn);
> +
> +};

Ignoring confidential compute for a moment

If qmeu can put all the guest memory in a memfd and not map it, then
I'd also like to see that the IOMMU can use this interface too so we
can have VFIO working in this configuration.

As designed the above looks useful to import a memfd to a VFIO
container but could you consider some more generic naming than calling
this 'guest' ?

Along the same lines, to support fast migration, we'd want to be able
to send these things to the RDMA subsytem as well so we can do data
xfer. Very similar to VFIO.

Also, shouldn't this be two patches? F_SEAL is not really related to
these acessors, is it?

> +extern inline int memfd_register_guest(struct inode *inode, void *owner,
> +				       const struct guest_ops *guest_ops,
> +				       const struct guest_mem_ops **guest_mem_ops);

Why does this take an inode and not a file *?

> +int shmem_register_guest(struct inode *inode, void *owner,
> +			 const struct guest_ops *guest_ops,
> +			 const struct guest_mem_ops **guest_mem_ops)
> +{
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	if (!owner)
> +		return -EINVAL;
> +
> +	if (info->guest_owner && info->guest_owner != owner)
> +		return -EPERM;

And this looks like it means only a single subsytem can use this API
at once, not so nice..

Jason
