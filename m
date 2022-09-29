Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8145F0151
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 01:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiI2XW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 19:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI2XW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:22:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9A13D865
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 16:22:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2715495pjh.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SlBvqIbtpL0VufXgwK7uhVH38JuonCmEli0InnRVEwc=;
        b=WuAt0WRwYyROULHsLoKuJv2kXZVaCxvv5se5SYxucmOEgMFUNx2D57LgdDwCei2x1H
         BHZJk6cnqMJ9lpHSGjIAQZn0y8BmTQuG82WIZcNgoFeD7LG4pqgoDjfwNUvpxX0kJLxv
         Dw+WsZzJyUYdaQkT0re+VcE6b51zajqB6Pihs0d5Dm06lt/3y15zlDRlEVhaJYcITjqq
         kxupICcV/19shZioX2psCPJiZdpZ4ysq5/1T3jM0Xx0pSi+GIDFyiPzVO05s6m98CDTT
         tOo/5JDD8RVKU0DNuMgu6l56RXQ8C5tSDlMssCXWcmrz1Q8KJiW+10QJLFQH8nbm/WCu
         b7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SlBvqIbtpL0VufXgwK7uhVH38JuonCmEli0InnRVEwc=;
        b=2Lw7YBgm+XK511fc7i9o+gEoSVBiAUoW5Fm6fYZLJEhM6lunYokVKHbU3OXxIbuEs7
         /vhr3s2jBhfXO44FjBEfOc/UvzCyPxuoP94Ig//RKBOOrycbqOc8XyPDQh3kjj22lsby
         2GDHSwV7a8Ko+UpL/ZHq7nyf5+n+FRNwmMgG/BtAsSYlGWyKJYX/YPt6QMeVmSpnO7qJ
         rJXns2/vhNz2R9+TDLlmneOBH0K6tQs1mmD2hUi0vAfPoY7xXdfErnrwNH9wRMfF1Um4
         H9fnHwnZdkvj8w2cEQGOcjZTP1v1lQXbiCJ0/iaR8jrPi/9OPqU6h0Tq4YXJo1t3q2X1
         cq0g==
X-Gm-Message-State: ACrzQf1ITTyfaWYJAFhgQkwzD/nMKkBst1af+UIRcd2CVNudKcu1uvMV
        vUW2vNrXdoIwvEU7JjfaTkD3WA==
X-Google-Smtp-Source: AMsMyM75zZcPQQjlBQckiGdn+LExa+Ehm1TbE+ovPavYyibrIT8X85CNF5p+NDaTg0PkeD+6UnKilA==
X-Received: by 2002:a17:90b:1d81:b0:205:f381:7372 with SMTP id pf1-20020a17090b1d8100b00205f3817372mr11503541pjb.165.1664493743484;
        Thu, 29 Sep 2022 16:22:23 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a290b00b001f319e9b9e5sm4062149pjd.16.2022.09.29.16.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:22:22 -0700 (PDT)
Date:   Thu, 29 Sep 2022 23:22:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 2/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YzYoq/4AcWGS/noD@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <20220929224516.GA2260388@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929224516.GA2260388@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022, Isaku Yamahata wrote:
> On Thu, Sep 15, 2022 at 10:29:07PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > @@ -4645,14 +4672,20 @@ static long kvm_vm_ioctl(struct file *filp,
> >  		break;
> >  	}
> >  	case KVM_SET_USER_MEMORY_REGION: {
> > -		struct kvm_userspace_memory_region kvm_userspace_mem;
> > +		struct kvm_user_mem_region mem;
> > +		unsigned long size = sizeof(struct kvm_userspace_memory_region);
> > +
> > +		kvm_sanity_check_user_mem_region_alias();
> >  
> >  		r = -EFAULT;
> > -		if (copy_from_user(&kvm_userspace_mem, argp,
> > -						sizeof(kvm_userspace_mem)))
> > +		if (copy_from_user(&mem, argp, size);
> > +			goto out;
> > +
> > +		r = -EINVAL;
> > +		if (mem.flags & KVM_MEM_PRIVATE)
> >  			goto out;
> 
> Nit:  It's better to check if padding is zero.  Maybe rename it to reserved.
> 
> +               if (mem.pad1 || memchr_inv(mem.pad2, 0, sizeof(mem.pad2)))
> +                       goto out;

No need, KVM has more or less settled on using flags instead "reserving" bytes.
E.g. if/when another fancy feature comes along, we'll add another KVM_MEM_XYZ
and only consume the relevant fields when the flag is set.  Reserving bytes
doesn't work very well because it assumes that '0' is an invalid value, e.g. if
the future expansion is for a non-private file descriptor, then we'd need a new
flag even if KVM reserved bytes since fd=0 is valid.

The only reason to bother with pad2[14] at this time is to avoid having to define
yet another struct if/when the struct needs to expand again.  The struct definition
will still need to be changed, but at least we won't end up with struct
kvm_userspace_memory_region_really_extended.
