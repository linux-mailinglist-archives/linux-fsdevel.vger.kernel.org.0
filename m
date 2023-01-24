Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C4678D67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 02:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjAXB17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 20:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjAXB15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:27:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7D312F26
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 17:27:55 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c26so10205722pfp.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 17:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8F6hRIomZ2nfgoOl9vt+Mda6mTJjuiQ/nB/OzAXwDSI=;
        b=H0wzig6HSgCdkJfbnchvpXtWngdQg2CyHZkhgdpFw+HuZ2/LaO4BJx1ZZJ+RRoILq8
         GuT7pIND31DaoY+FiJSBILYhipQMPqJ7CZUOuz7x71s515bfTFYymuOqj76dpZGGPe0R
         roYrZDSWF8NxOve8Pxp7cvCd6BZ0axXo2A8t3B8iw98G/r8Tkcv0kcruglI/OT22oEey
         j/0uWp0hdocKI/BmP7HVj2M7QFhthg3W7d8Q1vm0Us4lX+kWe4jn02BGZ4yej5UdNIiy
         ekteTmqXj33t26Jyf+JF3RUpU48Qj5o/y07idXkF5Ho4kjJsXeyVErd+MUZWegqHYXVp
         q16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F6hRIomZ2nfgoOl9vt+Mda6mTJjuiQ/nB/OzAXwDSI=;
        b=MEtyrf/XIVvwnjU21E3berEotmo7rPbzLaT8JRTu8aY5lSBzfRYTaHYHB5th5WDc6i
         uVNE8wxBjhXgS+ob/U0G1ux6ShshWfK6bheCiqYggLR//oyZXjfwLXvo8ibY7wwmbzI4
         M0QVBW4h7xKsW/2mRg6OZbKy1xsTX72xQe1Q6EtDznETBhL4wDK0/Qih1mgH/Sgb8JFt
         5eTA2bOKQJXzpoXAZPsTvi1Mpw9Ug01p5QShkkbK+6wfa/p3DJDuw34btZ0MByLQ0LdT
         PCk6VYbp4/PAE3MYE9NJX6JRKTxBBn69IpVCF+W2iEXqkTyJ/7u08uzPbbSLKfCjVclS
         zxKA==
X-Gm-Message-State: AO0yUKWpUb+biwXuCI7NuKC2gvbjPt6s3EPo2PyLrCsoVJKmuE2FLafK
        It4GQstZcqbrjC1EZtABwVMPyw==
X-Google-Smtp-Source: AK7set8oWHW5as5U3Q0r97O5m1dlnRFyFLOsa36pUh2yIP/6nFcX7lH+DqOSXyUNOJ1I4yEcn6HIvg==
X-Received: by 2002:a05:6a00:b55:b0:576:9252:d06 with SMTP id p21-20020a056a000b5500b0057692520d06mr19319pfo.0.1674523674434;
        Mon, 23 Jan 2023 17:27:54 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a28-20020aa78e9c000000b00582bdaab584sm238831pfr.81.2023.01.23.17.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:27:53 -0800 (PST)
Date:   Tue, 24 Jan 2023 01:27:50 +0000
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
Message-ID: <Y880FiYF7YCtsw/i@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com>
 <20230119223704.GD2976263@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119223704.GD2976263@ls.amr.corp.intel.com>
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

On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> On Thu, Jan 19, 2023 at 03:25:08PM +0000,
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> > > On Sat, Jan 14, 2023 at 12:37:59AM +0000,
> > > Sean Christopherson <seanjc@google.com> wrote:
> > > 
> > > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > > This patch series implements KVM guest private memory for confidential
> > > > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > > > TDX-protected guest memory, machine check can happen which can further
> > > > > crash the running host system, this is terrible for multi-tenant
> > > > > configurations. The host accesses include those from KVM userspace like
> > > > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > > > via a fd-based approach, but it can never access the guest memory
> > > > > content.
> > > > > 
> > > > > The patch series touches both core mm and KVM code. I appreciate
> > > > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > > > reviews are always welcome.
> > > > >   - 01: mm change, target for mm tree
> > > > >   - 02-09: KVM change, target for KVM tree
> > > > 
> > > > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > > > is available here:
> > > > 
> > > >   git@github.com:sean-jc/linux.git x86/upm_base_support
> > > > 
> > > > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > > > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > > > a WIP.
> > > > 
> > > > As for next steps, can you (handwaving all of the TDX folks) take a look at what
> > > > I pushed and see if there's anything horrifically broken, and that it still works
> > > > for TDX?
> > > > 
> > > > Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> > > > (and I mean that).
> > > > 
> > > > On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> > > > (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> > > > merging so that the criteria for merging are clear, and so that if the list is large
> > > > (haven't thought much yet), the work of writing and running tests can be distributed.
> > > > 
> > > > Regarding downstream dependencies, before this lands, I want to pull in all the
> > > > TDX and SNP series and see how everything fits together.  Specifically, I want to
> > > > make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> > > > don't miss an opportunity to make things simpler.  The patches in the SNP series to
> > > > add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> > > > details.  Nothing remotely major, but something that needs attention since it'll
> > > > be uAPI.
> > > 
> > > Although I'm still debuging with TDX KVM, I needed the following.
> > > kvm_faultin_pfn() is called without mmu_lock held.  the race to change
> > > private/shared is handled by mmu_seq.  Maybe dedicated function only for
> > > kvm_faultin_pfn().
> > 
> > Gah, you're not on the other thread where this was discussed[*].  Simply deleting
> > the lockdep assertion is safe, for guest types that rely on the attributes to
> > define shared vs. private, KVM rechecks the attributes under the protection of
> > mmu_seq.
> > 
> > I'll get a fixed version pushed out today.
> > 
> > [*] https://lore.kernel.org/all/Y8gpl+LwSuSgBFks@google.com
> 
> Now I have tdx kvm working. I've uploaded at the followings.
> It's rebased to v6.2-rc3.
>         git@github.com:yamahata/linux.git tdx/upm
>         git@github.com:yamahata/qemu.git tdx/upm

And I finally got a working, building version updated and pushed out (again to):

  git@github.com:sean-jc/linux.git x86/upm_base_support

Took longer than expected to get the memslot restrictions sussed out.  I'm done
working on the code for now, my plan is to come back to it+TDX+SNP in 2-3 weeks
to resolves any remaining todos (that no one else tackles) and to do the whole
"merge the world" excersise.

> kvm_mmu_do_page_fault() needs the following change.
> kvm_mem_is_private() queries mem_attr_array.  kvm_faultin_pfn() also uses
> kvm_mem_is_private(). So the shared-private check in kvm_faultin_pfn() doesn't
> make sense. This change would belong to TDX KVM patches, though.

Yeah, SNP needs similar treatment.  Sorting that out is high up on the todo list.
