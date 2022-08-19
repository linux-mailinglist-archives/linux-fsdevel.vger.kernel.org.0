Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C25991A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 02:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiHSAUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 20:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiHSAUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:20:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90345CE30D
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 17:20:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bf22so3158817pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=pEgXnTJKFJrTL3CTka16XSJbg6kxwB4cnfOI/Ofjlz4=;
        b=jQOCWpbvee03T0P8xijjOYN3zJfdX6BqWq3GiUDY54GeiB2kYOpPOdypH/gNOYaODr
         ix4Q5zM5HRdkrH8VNhhYaqC4bGm3TWrsr3zotxk6UhP/oyxM/RNGcU3wIqmpKytWvU4a
         BTREDH/HNF59rmTBvSdbCesgF6GRyz5K9//B1DM9fRziLLn/FELyxzGGJ6BTGO4HJJrl
         o0UAtZhP3o05JqW/WffSD/W7KBey1RzgtF0ZEqIKFPy09PHnweIeH6czpkeJBsdR0KF6
         StCY9jf29Uto9xBg0n+/eHlcuPQ9Rk2xvxAOK7+9vgIk182YafaVSJIp8WTK07eIFh8d
         mv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pEgXnTJKFJrTL3CTka16XSJbg6kxwB4cnfOI/Ofjlz4=;
        b=tUOihVDTaXy81rFfZJ0AK0WOvOWgZ5sYbqKgTBR7uaMEcQfaHXhy9xvKuBVJUF/DyG
         QEEpT0DR6aCAmtjCud2PP5jwfgkAINHO/J/x1D7keFPWcNqH/0C3+w8T9xaiL9pLGnJC
         MXPz2KSsLwQFk9h1/57bXUf9jVOWJmFcA6w9EMnBoRSG1UTuXIq2dtB32Z8xOeob7kms
         iL1sqjq/UqybYa38KD6HunKV3tiIiIGdRKGnN+dqtCST3BpYI+yQ8F9AC25gwdRn3Dx6
         QD9uy0FcFWdl3KigbH1mJUkjt7sEGX51MS4s0//99Intq/OVDveaocsnYM0hRYx2MvOy
         pyEg==
X-Gm-Message-State: ACgBeo2srKp4gPMNDP3AnVu4eLCtGB0MJYNLOhwVCN9Mp2YaY0N0JuzI
        sRvqeu1nqJbk2MfwN3bcH0H+1Q==
X-Google-Smtp-Source: AA6agR7cPKIHabvzPHesQ7mysYM4f98Not26hLuTLYt6okFI7nMH1sNNM2K+QGI7RxRYoX8JypicJA==
X-Received: by 2002:a17:902:7208:b0:172:a9d6:527 with SMTP id ba8-20020a170902720800b00172a9d60527mr4900702plb.32.1660868432853;
        Thu, 18 Aug 2022 17:20:32 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b0016bedcced2fsm1984501pls.35.2022.08.18.17.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:20:32 -0700 (PDT)
Date:   Fri, 19 Aug 2022 00:20:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <Yv7XTON3MwuC1Q3U@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818132421.6xmjqduempmxnnu2@box>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022, Kirill A . Shutemov wrote:
> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > On Wed, 6 Jul 2022, Chao Peng wrote:
> > But since then, TDX in particular has forced an effort into preventing
> > (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
> > 
> > Are any of the shmem.c mods useful to existing users of shmem.c? No.
> > Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.

But QEMU and other VMMs are users of shmem and memfd.  The new features certainly
aren't useful for _all_ existing users, but I don't think it's fair to say that
they're not useful for _any_ existing users.

> > What use do you have for a filesystem here?  Almost none.
> > IIUC, what you want is an fd through which QEMU can allocate kernel
> > memory, selectively free that memory, and communicate fd+offset+length
> > to KVM.  And perhaps an interface to initialize a little of that memory
> > from a template (presumably copied from a real file on disk somewhere).
> > 
> > You don't need shmem.c or a filesystem for that!
> > 
> > If your memory could be swapped, that would be enough of a good reason
> > to make use of shmem.c: but it cannot be swapped; and although there
> > are some references in the mailthreads to it perhaps being swappable
> > in future, I get the impression that will not happen soon if ever.
> > 
> > If your memory could be migrated, that would be some reason to use
> > filesystem page cache (because page migration happens to understand
> > that type of memory): but it cannot be migrated.
> 
> Migration support is in pipeline. It is part of TDX 1.5 [1]. 

And this isn't intended for just TDX (or SNP, or pKVM).  We're not _that_ far off
from being able to use UPM for "regular" VMs as a way to provide defense-in-depth
without having to take on the overhead of confidential VMs.  At that point,
migration and probably even swap are on the table.

> And swapping theoretically possible, but I'm not aware of any plans as of
> now.

Ya, I highly doubt confidential VMs will ever bother with swap.

> > I'm afraid of the special demands you may make of memory allocation
> > later on - surprised that huge pages are not mentioned already;
> > gigantic contiguous extents? secretmem removed from direct map?
> 
> The design allows for extension to hugetlbfs if needed. Combination of
> MFD_INACCESSIBLE | MFD_HUGETLB should route this way. There should be zero
> implications for shmem. It is going to be separate struct memfile_backing_store.
> 
> I'm not sure secretmem is a fit here as we want to extend MFD_INACCESSIBLE
> to be movable if platform supports it and secretmem is not migratable by
> design (without direct mapping fragmentations).

But secretmem _could_ be a fit.  If a use case wants to unmap guest private memory
from both userspace and the kernel then KVM should absolutely be able to support
that, but at the same time I don't want to have to update KVM to enable secretmem
(and I definitely don't want KVM poking into the directmap itself).

MFD_INACCESSIBLE should only say "this memory can't be mapped into userspace",
any other properties should be completely separate, e.g. the inability to migrate
pages is effective a restriction from KVM (acting on behalf of TDX/SNP), it's not
a fundamental property of MFD_INACCESSIBLE.
