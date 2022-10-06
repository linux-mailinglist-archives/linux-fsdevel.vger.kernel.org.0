Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B3D5F6AB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiJFPfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiJFPfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:35:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F8A598A
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 08:35:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f193so2249852pgc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVH+mE8vTDt4ztWw0FuDerHaC6PXHO5VRvmOUup/utI=;
        b=BT6wFbdYtvryFMUPmG4baQJjXgZn2XpiWetEfLkz8x2RyoKztGe/UlFARXUiVD2Uyk
         zGpvUkPkTIRfx4JMN5hI2WK4Vgk1k8N885wJ1EBWwvMsuraG1ulQZ43ct2pF+3zIhJVX
         F1i8WjUx87St9iaud3AvDTYqXCqn3QgU8fn9TnOzEqb+U1DzCjFMpz9+e7NO4j+UhZ6F
         Xny2Sc+2/AmA/ruM4UQKTyH9J2g2UG6swWnfFrB5gYu1G4W/0wo2txos+zvpWVHb2gaF
         RAcl0gOYeTEgnMt3FEflaqus5BOqdgMjoCPePo0xlJLotiUsdEbJ+lpyHdUFudX5do3c
         80VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVH+mE8vTDt4ztWw0FuDerHaC6PXHO5VRvmOUup/utI=;
        b=lXCqx44/fhJzMp3RxquNtvVMoQXSMovJXb+/akhJbDHKqic9uhEAIEWfETKugGJw2e
         2unI68jnfuhySHHNH4v2lD15m06BjgmBkz+xhpdc4m+v48TDWwq55bOrOa9ZO0MMfP1T
         OvOPL2dqlvKclQLenuGs2TymJxD8siCoVv+vYaXKGC23bEuFXukz/xp6m74rOpp7pCUu
         hNRI69iUe7ohM26GNGwmB1WN7m8J/T+7Qhzdskrk33MJp+h83AH+teS/iXBirpL7zTe8
         moey6wlZ16YeWXV2sXDpB+t/nA0v3bu1D2yGNzNlks2iUAetpRZCuRT1P1im7EQ9QUpt
         dJlw==
X-Gm-Message-State: ACrzQf2oViWvxA4EQaMPIFWKIv0EYqiCFhBWgGocl3Po963Y+41aZeeC
        UOjmBBLfZSD/5XfUTAB+IAgC4w==
X-Google-Smtp-Source: AMsMyM4soRpBX+s7aYmfnDBJSa29oksK0grYg4InwOjmhMAH+pEZFdQxT/WmwSBMyChsZKzSIdtRww==
X-Received: by 2002:a05:6a00:1884:b0:562:6536:4844 with SMTP id x4-20020a056a00188400b0056265364844mr305684pfh.2.1665070506177;
        Thu, 06 Oct 2022 08:35:06 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001714e7608fdsm12311997plb.256.2022.10.06.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:35:03 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:34:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Message-ID: <Yz71ogila0mSHxxJ@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <Yz7s+JIexAHJm5dc@kernel.org>
 <Yz7vHXZmU3EpmI0j@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7vHXZmU3EpmI0j@kernel.org>
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

On Thu, Oct 06, 2022, Jarkko Sakkinen wrote:
> On Thu, Oct 06, 2022 at 05:58:03PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > > additional KVM memslot fields private_fd/private_offset to allow
> > > userspace to specify that guest private memory provided from the
> > > private_fd and guest_phys_addr mapped at the private_offset of the
> > > private_fd, spanning a range of memory_size.
> > > 
> > > The extended memslot can still have the userspace_addr(hva). When use, a
> > > single memslot can maintain both private memory through private
> > > fd(private_fd/private_offset) and shared memory through
> > > hva(userspace_addr). Whether the private or shared part is visible to
> > > guest is maintained by other KVM code.
> > 
> > What is anyway the appeal of private_offset field, instead of having just
> > 1:1 association between regions and files, i.e. one memfd per region?

Modifying memslots is slow, both in KVM and in QEMU (not sure about Google's VMM).
E.g. if a vCPU converts a single page, it will be forced to wait until all other
vCPUs drop SRCU, which can have severe latency spikes, e.g. if KVM is faulting in
memory.  KVM's memslot updates also hold a mutex for the entire duration of the
update, i.e. conversions on different vCPUs would be fully serialized, exacerbating
the SRCU problem.

KVM also has historical baggage where it "needs" to zap _all_ SPTEs when any
memslot is deleted.

Taking both a private_fd and a shared userspace address allows userspace to convert
between private and shared without having to manipulate memslots.

Paolo's original idea (was sent off-list):

  : The problem is that KVM_SET_USER_MEMORY_REGION and memslots in general
  : are designed around (S)RCU.  It is way too slow (in both QEMU and KVM)
  : to be called on every private<->shared conversion with 4K granularity,
  : and it tends naturally to have quadratic behavior (though, at least for
  : KVM, the in-progress "fast memslots" series would avoid that).
  : 
  : Since private PTEs are persistent, and userspace cannot access the memfd
  : in any other way, userspace could use fallocate() to map/unmap an
  : address range as private, and KVM can treat everything that userspace
  : hasn't mapped as shared.
  : 
  : This would be a new entry in struct guest_ops, called by fallocate(),
  : and the callback can take the mmu_lock for write to avoid racing with
  : page faults.  This doesn't add any more contention than
  : KVM_SET_USER_MEMORY_REGION, since the latter takes slots_lock.  If
  : there's something I'm missing then the mapping operation can use a
  : ioctl, while the unmapping can keep using FALLOC_FL_PUNCH_HOLE.
  : 
  : Then:
  : 
  : - for simplicity, mapping a private memslot fails if there are any
  : mappings (similar to the handling when F_SEAL_GUEST is set).
  : 
  : - for TDX, accessing a nonexistent private PTE will cause a userspace
  : exit for a shared->private conversion request.  For SNP, the guest will
  : do a page state change VMGEXIT to request an RMPUPDATE, which can cause
  : a userspace exit too; the consequent fallocate() on the private fd
  : invokes RMPUPDATE.
  : 
  : - trying to map a shared PTE where there's already a private PTE causes
  : a userspace exit for a private->shared conversion request.
  : kvm_faultin_pfn or handle_abnormal_pfn can query this in the private-fd
  : inode, which is essentially a single pagecache_get_page call.
  : 
  : - if userspace asks to map a private PTE where there's already a shared
  : PTE (which it can check because it has the mmu_lock taken for write),
  : KVM unmaps the shared PTE.

> > 
> > If this was the case, then an extended struct would not be needed in the
> > first place. A simple union inside the existing struct would do:
> > 
> >         union {
> >                 __u64 userspace_addr,
> >                 __u64 private_fd,
> >         };
> 
> Also, why is this mechanism just for fd's with MFD_INACCESSIBLE flag? I'd
> consider instead having KVM_MEM_FD flag. For generic KVM (if memfd does not
> have MFD_INACCESSIBLE set), KVM could just use the memory as it is using
> mapped memory. This would simplify user space code, as you can the use the
> same thing for both cases.

I explored this idea too[*].  Because we want to support specifying both the
private and shared backing stores in a single memslot, then we need two file
descriptors so that shared memory can also use fd-based memory.

[*] https://lore.kernel.org/all/YulTH7bL4MwT5v5K@google.com
