Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391E25A1D51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 01:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiHYXni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 19:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbiHYXnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:43:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA455B8F1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 16:43:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo6479950pjd.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CrkUDi4mYcC3qOEbpgTO1y4xAYzFYl9qfJxBFAO1WQU=;
        b=oH89fuC7/OCch4BVe3RICsoOXGZYywI31GBVdOyyzkOO7DEQwz0A3bC8XVXdtvCwd1
         6++QpYTFdw9m4hHnWiKtTIpB7Hi5ELfJeZuqNN9uFKSo7WfdJ9G1Mhm4JK6AV2WHzXjJ
         VbNzkpdmEXJLIC2dBL9fBoXXr3+4Uapf2ay+q5o5OiTRLYNgKYonwB+ySRb6B5oDeL1+
         dAGtJD3OxzwN4u/yHADk0FqkEVYKITXRoFTnTIyXKBO0WL66kWEVFTEfNMRKnT8HVrqd
         r0phSuI2WdqgmUZxadQTwthKDt4ZrV+UeAwXIY6ktT0Ll4TYsN0WDJRL1/UrY3DGWEjg
         ExLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CrkUDi4mYcC3qOEbpgTO1y4xAYzFYl9qfJxBFAO1WQU=;
        b=YOFt13imVvzaDQ4pg1m+uxXTk2rzyKJDkMcspwYCk19gaUdpygOZ9ytRWT+svlAtCI
         lNqgrdzhbm7AdIB0n4GWzRBpsVCY1R010pzM3BVmxh0otxAQw22owmVtHLB/rzn07Pue
         ItpibtdrLw5ZxlltUHnNQiTK8RbZS4qI0iYYxDZ0q2FktH5vwk8KBJe2kO77etXkF4Z6
         3o5zy2HegB6N2Nf7a1BxNPSsIpajxmWWy9jaECHYHhUjehiUDvHDI2+ikU76egO94gn4
         uAfOBhIbZQU6gs28kPciMTSQMGZ80cRy3gbjN+IQ5/h2ZckLBLmnwueT+H7moj0SQ+Dl
         nDsg==
X-Gm-Message-State: ACgBeo2BPHp+S5HG3mNYobZemrv96DVMU+1x4MP8VxK8B+hmalNsPutb
        wXAS1+lCmpqizM4b4bMXwbSfUg==
X-Google-Smtp-Source: AA6agR7uDYeONp1wM5VEYWT/Ep3xp8EiV6yvT/4U8QUXuA4MqoQg5QOZ3aLyR1Qey0199Sw+p/pMAg==
X-Received: by 2002:a17:90b:2390:b0:1fa:c680:1f63 with SMTP id mr16-20020a17090b239000b001fac6801f63mr1464578pjb.16.1661471012094;
        Thu, 25 Aug 2022 16:43:32 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78e89000000b005379fb50ff0sm216131pfr.50.2022.08.25.16.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 16:43:31 -0700 (PDT)
Date:   Thu, 25 Aug 2022 23:43:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Mike Rapoport <rppt@kernel.org>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Message-ID: <YwgJH0TRZO4ie4z8@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
 <YqzyjZnflCMPo8b/@google.com>
 <20220819004018.mgdvxhl6dj3ujl3f@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819004018.mgdvxhl6dj3ujl3f@box.shutemov.name>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022, Kirill A. Shutemov wrote:
> On Fri, Jun 17, 2022 at 09:30:53PM +0000, Sean Christopherson wrote:
> > > @@ -4088,7 +4144,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> > >  		read_unlock(&vcpu->kvm->mmu_lock);
> > >  	else
> > >  		write_unlock(&vcpu->kvm->mmu_lock);
> > > -	kvm_release_pfn_clean(fault->pfn);
> > > +
> > > +	if (fault->is_private)
> > > +		kvm_private_mem_put_pfn(fault->slot, fault->pfn);
> > 
> > Why does the shmem path lock the page, and then unlock it here?
> 
> Lock is require to avoid race with truncate / punch hole. Like if truncate
> happens after get_pfn(), but before it gets into SEPT we are screwed.

Getting the PFN into the SPTE doesn't provide protection in and of itself.  The
protection against truncation and whatnot comes from KVM getting a notification
and either retrying the fault (notification acquires mmu_lock before
direct_page_fault()), or blocking the notification (truncate / punch hole) until
after KVM installs the SPTE.  I.e. KVM just needs to ensure it doesn't install a
SPTE _after_ getting notified.

If the API is similar to gup(), i.e. only elevates the refcount but doesn't lock
the page, then there's no need for a separate kvm_private_mem_put_pfn(), and in
fact no need for ->put_unlock_pfn() because can KVM do set_page_dirty() and
put_page() directly as needed using all of KVM's existing mechanisms.
