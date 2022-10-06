Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF05F6A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiJFPHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJFPHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:07:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3B88DFB;
        Thu,  6 Oct 2022 08:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CA4CB820D6;
        Thu,  6 Oct 2022 15:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB2EC433D6;
        Thu,  6 Oct 2022 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665068832;
        bh=aOkXuECcbSjQISc+01I1tvXXXenJbSlH28e8M1BvI94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipL5LglSgB96d6J8L2HRVMl+jXPn9WaZCDeQ01bYQBl4fNvQ1dM3lsq4Q1rZT43/e
         04qttZa16SWURI2GfkK0oPR51suEX+KmL9EsCjFdWia96LnfzBWvtuqNVtpUW3BtJU
         vcNgsuDIFvSsLikBs88sxH/LdhpbfjE4y6loO4Mu7LZwOPT9sRBT/8sLT04H22RAal
         QWzkjxZVHXql+4CQTc3Zt3ML52Z7jwbzo3dBaWVQ7tNHxkNILSrzI4WPmGEaVVk6pI
         qS7RDP6QwQGatrjUNvs0hohnNuzTtFZ1Mq8tk9g2NPUW0j9qCUC4fQjJGqzWtnoJZi
         NyQ6cXDs2lPnw==
Date:   Thu, 6 Oct 2022 18:07:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
Message-ID: <Yz7vHXZmU3EpmI0j@kernel.org>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <Yz7s+JIexAHJm5dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7s+JIexAHJm5dc@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 05:58:03PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > additional KVM memslot fields private_fd/private_offset to allow
> > userspace to specify that guest private memory provided from the
> > private_fd and guest_phys_addr mapped at the private_offset of the
> > private_fd, spanning a range of memory_size.
> > 
> > The extended memslot can still have the userspace_addr(hva). When use, a
> > single memslot can maintain both private memory through private
> > fd(private_fd/private_offset) and shared memory through
> > hva(userspace_addr). Whether the private or shared part is visible to
> > guest is maintained by other KVM code.
> 
> What is anyway the appeal of private_offset field, instead of having just
> 1:1 association between regions and files, i.e. one memfd per region?
> 
> If this was the case, then an extended struct would not be needed in the
> first place. A simple union inside the existing struct would do:
> 
>         union {
>                 __u64 userspace_addr,
>                 __u64 private_fd,
>         };

Also, why is this mechanism just for fd's with MFD_INACCESSIBLE flag? I'd
consider instead having KVM_MEM_FD flag. For generic KVM (if memfd does not
have MFD_INACCESSIBLE set), KVM could just use the memory as it is using
mapped memory. This would simplify user space code, as you can the use the
same thing for both cases.

BR, Jarkko
