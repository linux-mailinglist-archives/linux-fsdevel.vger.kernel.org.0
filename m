Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB566E4E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjAQR1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 12:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjAQRZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:25:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA28731E3C
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 09:25:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 7-20020a17090a098700b002298931e366so4882714pjo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPCKpcym2RW5d35rmFIPP7PcNPID9DHF3zaB9zUqfc0=;
        b=fcIljTThBG4xJap5TcGlXLzzw36TVvznNFdH4K5cV1wgP0TBEN+a0DD1GCYhRROsCO
         QvjnEf/w+v2arlNJbI9HWsv3aQkGE66ZYpTq2jVV7H8jTKB+jcivNkBG1DLGh2COfKTX
         pweZYAuWKUG+YbRSPiUyMiUsIhMoDelNa4TCm0Xonr0YcRslVr+wkYXPREIFWc5njYN5
         hleDjpP/fD2PR+Pk217/hDlyN417xQoAuBfDpMCd7cMkK5+rXFZvrG6QdKzfXmWAaGuZ
         MtZaFsL+TjIMHfkIcKjhxx6/QR2rCC95vb8NVwOqOTD6jTRuiCKfm4a07+k8PrsQ0gnu
         +dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPCKpcym2RW5d35rmFIPP7PcNPID9DHF3zaB9zUqfc0=;
        b=kOMiMqJw3SpsCokRyYL95WFIRd+HcwXHENUw4bJeJ7F4g43XvjPtKacpfdxC+plBRB
         PBf1p3jqW+RkbhQNWCLIvwPbRYvjC+dSSESlDJgNKvNIyyPv1cBz9g2FmOjb1S5cWSCz
         oopb95LU5ufmzl5UaD0hi0Ix5cFe5JGfrh+ZBM/R1aTvrfGVmVb7p+WRnfnc7Ipmbwml
         Zz63zqREw0SAWbmXohUUysv+q5GFw9RSIc4lWJbjvXTS4tLjc0MfZS0FuSyMTq7vkk7a
         /tkM1/8D4bXC0GU2xrxythnSEBr1k0YHyQ7DbKEgQlGrod1rmSUfF7Q0Lmcbbewr+XUJ
         LJbg==
X-Gm-Message-State: AFqh2koz+tP2ahd2x8G2yrHvUK8D6uqeeGxjJiylNs64qLO80KmaPE66
        FwFY0Ql0MZGhMJSmXDx0TEqvbQ==
X-Google-Smtp-Source: AMrXdXvUnfK+nwEzio3X173A3OOI+axnR8EWU2P/trlYbT/Eyg2+Qv0Pg0jRmQ5K8mkAb8pmdGJXpw==
X-Received: by 2002:a05:6a20:8f02:b0:b8:c646:b0e2 with SMTP id b2-20020a056a208f0200b000b8c646b0e2mr385151pzk.3.1673976320986;
        Tue, 17 Jan 2023 09:25:20 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a390300b0022960d00017sm4505994pjb.22.2023.01.17.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:25:20 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:25:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Message-ID: <Y8bZ/J98V5i3wG/v@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <c25f1f8c-f7c0-6a96-cd67-260df47f79a9@linux.intel.com>
 <20230117133015.GE273037@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117133015.GE273037@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023, Chao Peng wrote:
> On Tue, Jan 17, 2023 at 11:21:10AM +0800, Binbin Wu wrote:
> > 
> > On 12/2/2022 2:13 PM, Chao Peng wrote:
> > > In confidential computing usages, whether a page is private or shared is
> > > necessary information for KVM to perform operations like page fault
> > > handling, page zapping etc. There are other potential use cases for
> > > per-page memory attributes, e.g. to make memory read-only (or no-exec,
> > > or exec-only, etc.) without having to modify memslots.
> > > 
> > > Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> > > userspace to operate on the per-page memory attributes.
> > >    - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
> > >      a guest memory range.
> > >    - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
> > >      memory attributes.
> > > 
> > > KVM internally uses xarray to store the per-page memory attributes.
> > > 
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com/
> > > ---
> > >   Documentation/virt/kvm/api.rst | 63 ++++++++++++++++++++++++++++
> > >   arch/x86/kvm/Kconfig           |  1 +
> > >   include/linux/kvm_host.h       |  3 ++
> > >   include/uapi/linux/kvm.h       | 17 ++++++++
> > 
> > Should the changes introduced in this file also need to be added in
> > tools/include/uapi/linux/kvm.h ?
> 
> Yes I think.

I'm not sure how Paolo or others feel, but my preference is to never update KVM's
uapi headers in tools/ in KVM's tree.  Nothing KVM-related in tools/ actually
relies on the headers being copied into tools/, e.g. KVM selftests pulls KVM's
headers from the .../usr/include/ directory that's populated by `make headers_install`.

Perf's tooling is what actually "needs" the headers to be copied into tools/, so
my preference is to let the tools/perf maintainers deal with the headache of keeping
everything up-to-date.

> But I'm hesitate to include in this patch or not. I see many commits sync
> kernel kvm.h to tools's copy. Looks that is done periodically and with a
> 'pull' model.
