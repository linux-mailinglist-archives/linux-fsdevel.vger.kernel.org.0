Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834FF673D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjASPZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 10:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjASPZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:25:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C2D81014
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 07:25:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so1418391pjg.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 07:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3x+gqjTmgbestDAk4Awmq54vOdmydIW5Pid7KApIj0=;
        b=mBCVF1D4CCb5Ux/a0sTklFD5Mi8L9pIXDGbMCkJlimD4PHSACap2p25+kVgwBgrsIq
         EvdnQ1DJdyozyD6i/NGQ9LHUxMYOj57ZDAvsSBtrXrWSIG9rE81ZQPLMflUW9tlr3kaQ
         W5HhRhzDrOZXVo2eJJX+pBBPi5F1VgqXmlz+Dn+5py/XCqnPsdSKBwTESeGVpPIz964i
         Y7hB+IGNBYCrP1QuYyMwMmClI1OOCW3cnNMzXyQEA2j3fMpJV5G+s3nKt4FHhRG/KAkL
         4FVfZGb2GwNGLwVQhykEPhQCdeJbS7eHn+w6UX0yqcdlwsdurSpSSE/duLw9iP7/BBnl
         1UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3x+gqjTmgbestDAk4Awmq54vOdmydIW5Pid7KApIj0=;
        b=7oSdlJ/frpsvDmHg5SYrBXWyE1O9qThZkZfdmT8rv0/IEvB2cIP2xIfdN5yoTQZ2M0
         jVSTeI5cltZRB2auMydncROvEFCzEsJNISy6S1Ohye0tZRdlDntUHGBaBB7cqAa9PD7/
         kwCMpQskDmZZ0pR2ZbNnGQuPpbpnDqdOucQRDx8vjBo9+IFE1v71wwNjwzEXqRKEWd3N
         7G+Rvmfag5OFuy1R3ZkqPSEF67zwsMo8FuamE7Jh5zKMJ2nHo/sSj5p6gdgtzRB5TkxE
         U9R4CVQi3w3NFXwjiqZpdAN07bM9TnPw/Pg0Od4dMta1OBMMpy5xkM9boB1TD951mMwT
         q/qw==
X-Gm-Message-State: AFqh2kqpjVQYXXrpO4t9AntceYKe41YGiGlgPouasl3aEd5TiW3geKKS
        8wvJOolS+BAehSjbQddzxGMENg==
X-Google-Smtp-Source: AMrXdXuFbwGpoS/BOsR3GLdQjSETsa46BfhBRwIB416u+GXbq71Q0+uUKVzOwXl/a9TU4tZ66S2N/Q==
X-Received: by 2002:a05:6a20:ce43:b0:b8:c3c0:e7f7 with SMTP id id3-20020a056a20ce4300b000b8c3c0e7f7mr1187627pzb.1.1674141912349;
        Thu, 19 Jan 2023 07:25:12 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001945339354asm5530181plg.197.2023.01.19.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:25:11 -0800 (PST)
Date:   Thu, 19 Jan 2023 15:25:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <Y8lg1G2lRIrI/hld@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119111308.GC2976263@ls.amr.corp.intel.com>
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

On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> On Sat, Jan 14, 2023 at 12:37:59AM +0000,
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > This patch series implements KVM guest private memory for confidential
> > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > TDX-protected guest memory, machine check can happen which can further
> > > crash the running host system, this is terrible for multi-tenant
> > > configurations. The host accesses include those from KVM userspace like
> > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > via a fd-based approach, but it can never access the guest memory
> > > content.
> > > 
> > > The patch series touches both core mm and KVM code. I appreciate
> > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > reviews are always welcome.
> > >   - 01: mm change, target for mm tree
> > >   - 02-09: KVM change, target for KVM tree
> > 
> > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > is available here:
> > 
> >   git@github.com:sean-jc/linux.git x86/upm_base_support
> > 
> > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > a WIP.
> > 
> > As for next steps, can you (handwaving all of the TDX folks) take a look at what
> > I pushed and see if there's anything horrifically broken, and that it still works
> > for TDX?
> > 
> > Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> > (and I mean that).
> > 
> > On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> > (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> > merging so that the criteria for merging are clear, and so that if the list is large
> > (haven't thought much yet), the work of writing and running tests can be distributed.
> > 
> > Regarding downstream dependencies, before this lands, I want to pull in all the
> > TDX and SNP series and see how everything fits together.  Specifically, I want to
> > make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> > don't miss an opportunity to make things simpler.  The patches in the SNP series to
> > add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> > details.  Nothing remotely major, but something that needs attention since it'll
> > be uAPI.
> 
> Although I'm still debuging with TDX KVM, I needed the following.
> kvm_faultin_pfn() is called without mmu_lock held.  the race to change
> private/shared is handled by mmu_seq.  Maybe dedicated function only for
> kvm_faultin_pfn().

Gah, you're not on the other thread where this was discussed[*].  Simply deleting
the lockdep assertion is safe, for guest types that rely on the attributes to
define shared vs. private, KVM rechecks the attributes under the protection of
mmu_seq.

I'll get a fixed version pushed out today.

[*] https://lore.kernel.org/all/Y8gpl+LwSuSgBFks@google.com
