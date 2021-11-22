Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD5459009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 15:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhKVOTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 09:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhKVOTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:19:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C8EC061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 06:16:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c32so81555395lfv.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 06:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+4zN2N2GD5InVPRag20OPT/f7vJcEHsDBTk4URQjTY=;
        b=i660LRu/4c8k5hZyBAeiN7vx0DBSwtD8jpUkhNkSzxlWCRi0bijMvkNpekOr7ODcqf
         UC0FELTodvWUnOuZjym86GSTh/2Zk2G58nuT2v5lRYn46uzum5yI7DHmlQ4HhO1Nm7T/
         aQH9kqwRvEP2U9SXB4mugfIDYeVG8Q83mR0ziru1aeYKVDvndcWcO2dGj6xLJFbVDXKn
         nChK1SZIjg7CvjRVK6vC6dXSOLsBwzmizr4u7jHyKx6OVdI3BWNtfNkiZu97/IcU80/r
         He6oR52eZ+2bEqk/XkG670vHL3LQAnjJvaBUqzPuTmX2lMgEKeEbNFXL0x2jxrgBfVWC
         MnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+4zN2N2GD5InVPRag20OPT/f7vJcEHsDBTk4URQjTY=;
        b=idvMCpQ4MBaFjh+W1LaoborFDzk7xB1+zTsywR7HrXk9oDp2a6m2xrVMQ7bn0D38BW
         geSB3GTt9NOlk8DA904X6cPLUd6xfuoqYAv6GGmMtP+UFkxKlLWUjsnLqEDm2GvAeUQs
         kJ+TqNEB+VT+vrkl1Q5bff7BZ7exaaMtNlUVN0Ju1JCrNRlhL5L9mGG6k69PTgoSWhGF
         zQyDxvvhqxvKTtHLzJtgy8j1SqTTl54UtlAYphvav94y6XF0w3DvDKcswkJ5QYNn3s0d
         5spg3zRv88r0y22hKeGAdDoEWRAlEDW6jA8YVKTGnZw371ncfj3UCwlNxMKjU+WL0RrC
         PLeQ==
X-Gm-Message-State: AOAM530izc+XAigt3zAP+aFiNDHR8E71ScicGdl1LIJ4tk6kcZ4Uo9Gq
        Vv7LzeXNf/OugAksX2dVpfU0Pw==
X-Google-Smtp-Source: ABdhPJwA2Y8gfA+st0HYZ/WwMV2AWc6rzJCATTeuU95BmoAecu1lVYYz4BBqsxxXP2KWDyyXt38ykg==
X-Received: by 2002:a2e:8189:: with SMTP id e9mr52166761ljg.333.1637590602046;
        Mon, 22 Nov 2021 06:16:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q24sm979041lfp.103.2021.11.22.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:16:41 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 83FF5103610; Mon, 22 Nov 2021 17:16:47 +0300 (+03)
Date:   Mon, 22 Nov 2021 17:16:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Wanpeng Li <wanpengli@tencent.com>,
        jun.nakajima@intel.com, david@redhat.com,
        "J . Bruce Fields" <bfields@fieldses.org>, dave.hansen@intel.com,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>, susie.li@intel.com,
        Jeff Layton <jlayton@kernel.org>, john.ji@intel.com,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC v2 PATCH 13/13] KVM: Enable memfd based page
 invalidation/fallocate
Message-ID: <20211122141647.3pcsywilrzcoqvbf@box.shutemov.name>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-14-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119134739.20218-14-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 09:47:39PM +0800, Chao Peng wrote:
> Since the memory backing store does not get notified when VM is
> destroyed so need check if VM is still live in these callbacks.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  virt/kvm/memfd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/virt/kvm/memfd.c b/virt/kvm/memfd.c
> index bd930dcb455f..bcfdc685ce22 100644
> --- a/virt/kvm/memfd.c
> +++ b/virt/kvm/memfd.c
> @@ -12,16 +12,38 @@
>  #include <linux/memfd.h>
>  const static struct guest_mem_ops *memfd_ops;
>  
> +static bool vm_is_dead(struct kvm *vm)
> +{
> +	struct kvm *kvm;
> +
> +	list_for_each_entry(kvm, &vm_list, vm_list) {
> +		if (kvm == vm)
> +			return false;
> +	}

I don't think this is enough. The struct kvm can be freed and re-allocated
from the slab and this function will give false-negetive.

Maybe the kvm has to be tagged with a sequential id that incremented every
allocation. This id can be checked here.

> +
> +	return true;
> +}

-- 
 Kirill A. Shutemov
