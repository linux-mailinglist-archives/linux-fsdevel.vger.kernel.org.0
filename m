Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32593459EB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 09:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhKWI6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 03:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhKWI6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:58:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354FC061574;
        Tue, 23 Nov 2021 00:55:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so37601503wrr.8;
        Tue, 23 Nov 2021 00:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BqjTDota6qXyAvZTc5GkJOlaJlVWffG7A+eb5cGOB4I=;
        b=hFdqHn9RNEZSqmlr5iDLMvf0Vh/+AoriBzrucJDGFvvIJzpz2aAWz7zCwMcTOr+R34
         6j7hJ9fO5kHUgK7EB0/daaP7kC1zOgykiLKdxfc87gJDPQoyALSWcczHDm9U0BSYJokp
         AYs2XlP5glYCiNr0o9z00QBu/ifYKPDURHskwgpc+6Gn6RND+kHujM/yXBMtesmOY/qw
         xD+0iG3/gZa85Jdlli0QkI8k/btW15XtTW9xX1W3cJOR27cMXzr4GgO0atHXR5uypfHq
         HS1mH2y+lrz1qzuP7LB1a47LCmEbc+GawVY+0evta3MLP0+p9x32ab6JPgNFuPo2gcKI
         7omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BqjTDota6qXyAvZTc5GkJOlaJlVWffG7A+eb5cGOB4I=;
        b=6+djZ1F2uHQABLBHdPWOzINHxaf17aOX674rMs2BxDwUWiX8L36yQ04cEUJAINTbGv
         9vYOI/umsMsvsBq2ZiV6fOlvTSpptZ2IQIg+YHLwsbgiNinkSgUbP5SKB92dkFw7SNRU
         EmiR3z2fDkLFUSFF1zVQCrWY9jNSzk6D+22D5QPTy6ObdcK6qvQQIqF3qkiC8HiMg9n3
         /kXDH6hPwWaC4AfUBcsS+eripWLhgIw3hN6Rbtvd+DnVsYIkTUncnclA6r7vCVtgKLBD
         dEzmvHtcTTm+dX7xwGlKYOsyCK0Px3sxQMF0ejRQeew7SBXOlN4pKddFoEOu2sjc7NRm
         kr7w==
X-Gm-Message-State: AOAM533Qj13KmNfDEAG7cwyZrme864b9BYB33j0V7WIiOqcKgDAe43+E
        X+iB8xz5cMP1NkQ5/1bvvNQ=
X-Google-Smtp-Source: ABdhPJywg45Zdyiao5yHIoV/TWl9Lu4GeLuq7tkwSYZ5N0X3GzMOpvzt3xNpQ/xwFgF2+cvecBOasQ==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr5341362wrl.24.1637657703555;
        Tue, 23 Nov 2021 00:55:03 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id n1sm502199wmq.6.2021.11.23.00.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 00:55:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <5f6f43a1-bb4c-f498-2aba-4c93ab57fc98@gnu.org>
Date:   Tue, 23 Nov 2021 09:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
From:   Paolo Bonzini <bonzini@gnu.org>
In-Reply-To: <20211119134739.20218-2-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/21 14:47, Chao Peng wrote:
> +static void guest_invalidate_page(struct inode *inode,
> +				  struct page *page, pgoff_t start, pgoff_t end)
> +{
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	if (!info->guest_ops || !info->guest_ops->invalidate_page_range)
> +		return;
> +
> +	start = max(start, page->index);
> +	end = min(end, page->index + thp_nr_pages(page)) - 1;
> +
> +	info->guest_ops->invalidate_page_range(inode, info->guest_owner,
> +					       start, end);
> +}

The lack of protection makes the API quite awkward to use;
the usual way to do this is with refcount_inc_not_zero (aka 
kvm_get_kvm_safe).

Can you use the shmem_inode_info spinlock to protect against this?  If 
register/unregister take the spinlock, the invalidate and fallocate can 
take a reference under the same spinlock, like this:

	if (!info->guest_ops)
		return;

	spin_lock(&info->lock);
	ops = info->guest_ops;
	if (!ops) {
		spin_unlock(&info->lock);
		return;
	}

	/* Calls kvm_get_kvm_safe.  */
	r = ops->get_guest_owner(info->guest_owner);
	spin_unlock(&info->lock);
	if (r < 0)
		return;

	start = max(start, page->index);
	end = min(end, page->index + thp_nr_pages(page)) - 1;

	ops->invalidate_page_range(inode, info->guest_owner,
					       start, end);
	ops->put_guest_owner(info->guest_owner);

Considering that you have to take a mutex anyway in patch 13, and that 
the critical section here is very small, the extra indirect calls are 
cheaper than walking the vm_list; and it makes the API clearer.

Paolo
