Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3C546D3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350364AbiFJT1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 15:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347427AbiFJT1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:27:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA35E1455AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 12:27:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so294294pjq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PkrZb935FOMK/VTbtX8totq42RNXT0VkqR/O4EKP5jw=;
        b=kmpQnW9pQgc6jCgIv4PLRkvKW49ZsJ+smOOvRhdRKVJdJ9Zkgk/YtNmm2SoA/O56aA
         yjFKkHRfbiMSOg+r0ZuEHtWF+14lgCCm5q+DXC3bejs09+0NaISJZNgBhtVPM9hZrici
         3midqgBOk1EJAH+oLhfyYrDiwbBDxS42gWbD3T1HxBtTqZj5rJQ1Vj5t+t/6Y/yDFzkR
         TRp+d8eLox2jVwYtlenr13zA6kmJWThb1Qn1BG5USAR/NIbWIM5rxoKgalwJT2rnYHA0
         Li6tjfWy3x6EaebIJ1bWYlnHEdXiiKan7s8y/yDhYNyNGVMe9Qq5RglipqFtGNp66N0C
         fy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PkrZb935FOMK/VTbtX8totq42RNXT0VkqR/O4EKP5jw=;
        b=Zyobdm7+2XfTkHbFUy+hOTaxi/1seWo/+ywQVrGvu3jTvjEW4ppCduTn3q0qCP/se3
         19BExsxAq3HfjtZzEBtxS+aF3gcnUrKbbUTOZw2buK2NxmMhU58/c55ltG7TUEY/qMQO
         LsZmkR+btpW1IGNxTYMZx1Hn3VwBJ685HI++xrp17KTzJ9KL0e2oTaHLFYabJ1+ORx/s
         qMH/MJL91iZsS5E4o4DuR+y2CuVxwsuuf9dJDfaJMNfIKLmB2S2vBV3VfNU6YAUu3aOd
         BndSmnnyU4TPz+tDUVP5033HI5ndULVz9a9NbrZqq9PYSN2uG1LNbOnrg8Dh+/HrY8Uv
         ocyQ==
X-Gm-Message-State: AOAM5324gehbl9hUUwHxjcURsehYzvPTZNNBbJhOPyWkrxM6/B8hPPGj
        GalbVfXko6okgeL1quCadtJIqw==
X-Google-Smtp-Source: ABdhPJzu4+uiwCvV1vrvW1wojSNf5k+tJhEK5603Gry9wHXsc+/ZSsj5mtg+D4HxhdsWZ9rjzRno9w==
X-Received: by 2002:a17:902:be12:b0:167:6cbd:f113 with SMTP id r18-20020a170902be1200b001676cbdf113mr32389883pls.69.1654889259182;
        Fri, 10 Jun 2022 12:27:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 187-20020a6215c4000000b0051b32c2a5a7sm19853799pfv.138.2022.06.10.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:27:38 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:27:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YqObJ4v2k7W+O2j9@google.com>
References: <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
 <3b99f157-0f30-4b30-8399-dd659250ab8d@www.fastmail.com>
 <20220425134051.GA175928@chaop.bj.intel.com>
 <27616b2f-1eff-42ff-91e0-047f531639ea@www.fastmail.com>
 <YmcFAJEJmmtYa+82@google.com>
 <CALCETrU_BdaYcPgVcjj4o9zFPyvU9oyjCCtjKTbSSgeL0aZaGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrU_BdaYcPgVcjj4o9zFPyvU9oyjCCtjKTbSSgeL0aZaGQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022, Andy Lutomirski wrote:
> On Mon, Apr 25, 2022 at 1:31 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Apr 25, 2022, Andy Lutomirski wrote:
> > >
> > >
> > > On Mon, Apr 25, 2022, at 6:40 AM, Chao Peng wrote:
> > > > On Sun, Apr 24, 2022 at 09:59:37AM -0700, Andy Lutomirski wrote:
> > > >>
> > >
> > > >>
> > > >> 2. Bind the memfile to a VM (or at least to a VM technology).  Now it's in
> > > >> the initial state appropriate for that VM.
> > > >>
> > > >> For TDX, this completely bypasses the cases where the data is prepopulated
> > > >> and TDX can't handle it cleanly.
> >
> > I believe TDX can handle this cleanly, TDH.MEM.PAGE.ADD doesn't require that the
> > source and destination have different HPAs.  There's just no pressing need to
> > support such behavior because userspace is highly motivated to keep the initial
> > image small for performance reasons, i.e. burning a few extra pages while building
> > the guest is a non-issue.
> 
> Following up on this, rather belatedly.  After re-reading the docs,
> TDX can populate guest memory using TDH.MEM.PAGE.ADD, but see Intel®
> TDX Module Base Spec v1.5, section 2.3, step D.4 substeps 1 and 2
> here:
> 
> https://www.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-module-1.5-base-spec-348549001.pdf
> 
> For each TD page:
> 
> 1. The host VMM specifies a TDR as a parameter and calls the
> TDH.MEM.PAGE.ADD function. It copies the contents from the TD
> image page into the target TD page which is encrypted with the TD
> ephemeral key. TDH.MEM.PAGE.ADD also extends the TD
> measurement with the page GPA.
> 
> 2. The host VMM extends the TD measurement with the contents of
> the new page by calling the TDH.MR.EXTEND function on each 256-
> byte chunk of the new TD page.
> 
> So this is a bit like SGX.  There is a specific series of operations
> that have to be done in precisely the right order to reproduce the
> intended TD measurement.  Otherwise the guest will boot and run until
> it tries to get a report and then it will have a hard time getting
> anyone to believe its report.
> 
> So I don't think the host kernel can get away with host userspace just
> providing pre-populated memory.  Userspace needs to tell the host
> kernel exactly what sequence of adds, extends, etc to perform and in
> what order, and the host kernel needs to do precisely what userspace
> asks it to do.  "Here's the contents of memory" doesn't cut it unless
> the tooling that builds the guest image matches the exact semantics
> that the host kernel provides.

For TDX, yes, a KVM ioctl() is mandatory for all intents and purposes since adding
non-zero memory into the guest requires a SEAMCALL.  My "idea", which I'm not sure
would actually work, is more than a bit contrived, and which I don't think is remotely
critical to support, is to let userspace fill the guest private memory directly
and then use the private page for both the source and the target to TDH.MEM.PAGE.ADD.

That would avoid having to double allocate memory for the initial guest image.  But
like I said, contrived and low priority.
