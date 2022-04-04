Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8334F17CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377716AbiDDPD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355038AbiDDPDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:03:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8002F037
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 08:01:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g22so11470073edz.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Apr 2022 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i+zr5M68aloOJzDo2BfmM/AByzuuaBC8sU7HTQ424Ng=;
        b=P1lRqzuiE1i5AQgVXMAadjQxuZaNvOCmKCWVC7NoAosWtxg6O6uGhV1Fs5d9UThrZ1
         zNrRtXos2DqCwVW5VD+GKbPk1i42rM9aiUb9yc0F+sIK7PRpivdnddQGLO7YoWG7oZmw
         1x+zSzZfSodiP6Ntsi6OzrVuazT7b0XFcTsGnlR/cfyiEBMAvlIIi+by8VcRPuSXfbaq
         jvnXsXf/ijVmNTh2jlG406awsf8vRVsNEmYxTWAk77H/Jd0WSG835ZDrosun+PmVeAme
         A2bgEVeBBvzo/mxIlfxdxxqbrAD3YyIIefiix/stRu7ICwOCzguPsSvKzSzjE2W+YgM+
         7sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i+zr5M68aloOJzDo2BfmM/AByzuuaBC8sU7HTQ424Ng=;
        b=65buMDq2dZGiWb/pJvA/N3XZYIaMVdhNH+fu8bWIq5eYDbZVAClUEVcCL0J0YCK630
         0rWwO2TAmLaFLUlOqjEP6PCmk3m19YKSUgbt3yd2enJZwxCmHdKzvHEZPwSeI5wxFygT
         gJ9GoDhfPXKxahoe2pcShMIYdpDB80kYpiX0nzJIHthW2icKb7kmYl/YPqErP+KSadEd
         gbhMr6trH+14HH4wXL9UTRFuVz4X1utK6DxLM4PchVEY/Iof3wLh2V9ZRMZ862VVmr4g
         a9APa/hwd7aDUjhTaNG5zhggYvapFnkse+3Kd89/ptRwGG/9OnjFwtjsosxmTTyd48IE
         hmCQ==
X-Gm-Message-State: AOAM530ZKv35cocXsFiozEtrxG8z37fo4nNcZDGpcN8I+X2mEsjYnt4h
        jKLn/6DNUOPT49OucLIdku41Nw==
X-Google-Smtp-Source: ABdhPJwdjQe3XZ1e4GuiLZkjz2XSDy8kccxsDVifb45M/0aMy9MY01MBSRkMjNi/1qqoMOzRLXd9XA==
X-Received: by 2002:aa7:cdc9:0:b0:419:197e:14d9 with SMTP id h9-20020aa7cdc9000000b00419197e14d9mr498264edw.375.1649084485024;
        Mon, 04 Apr 2022 08:01:25 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm5690519eda.2.2022.04.04.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:01:24 -0700 (PDT)
Date:   Mon, 4 Apr 2022 15:01:21 +0000
From:   Quentin Perret <qperret@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Steven Price <steven.price@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
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
Message-ID: <YksIQYdG41v3KWkr@google.com>
References: <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 01 Apr 2022 at 12:56:50 (-0700), Andy Lutomirski wrote:
> On Fri, Apr 1, 2022, at 7:59 AM, Quentin Perret wrote:
> > On Thursday 31 Mar 2022 at 09:04:56 (-0700), Andy Lutomirski wrote:
> 
> 
> > To answer your original question about memory 'conversion', the key
> > thing is that the pKVM hypervisor controls the stage-2 page-tables for
> > everyone in the system, all guests as well as the host. As such, a page
> > 'conversion' is nothing more than a permission change in the relevant
> > page-tables.
> >
> 
> So I can see two different ways to approach this.
> 
> One is that you split the whole address space in half and, just like SEV and TDX, allocate one bit to indicate the shared/private status of a page.  This makes it work a lot like SEV and TDX.
>
> The other is to have shared and private pages be distinguished only by their hypercall history and the (protected) page tables.  This saves some address space and some page table allocations, but it opens some cans of worms too.  In particular, the guest and the hypervisor need to coordinate, in a way that the guest can trust, to ensure that the guest's idea of which pages are private match the host's.  This model seems a bit harder to support nicely with the private memory fd model, but not necessarily impossible.

Right. Perhaps one thing I should clarify as well: pKVM (as opposed to
TDX) has only _one_ page-table per guest, and it is controllex by the
hypervisor only. So the hypervisor needs to be involved for both shared
and private mappings. As such, shared pages have relatively similar
constraints when it comes to host mm stuff --  we can't migrate shared
pages or swap them out without getting the hypervisor involved.

> Also, what are you trying to accomplish by having the host userspace mmap private pages?

What I would really like to have is non-destructive in-place conversions
of pages. mmap-ing the pages that have been shared back felt like a good
fit for the private=>shared conversion, but in fact I'm not all that
opinionated about the API as long as the behaviour and the performance
are there. Happy to look into alternatives.

FWIW, there are a couple of reasons why I'd like to have in-place
conversions:

 - one goal of pKVM is to migrate some things away from the Arm
   Trustzone environment (e.g. DRM and the likes) and into protected VMs
   instead. This will give Linux a fighting chance to defend itself
   against these things -- they currently have access to _all_ memory.
   And transitioning pages between Linux and Trustzone (donations and
   shares) is fast and non-destructive, so we really do not want pKVM to
   regress by requiring the hypervisor to memcpy things;

 - it can be very useful for protected VMs to do shared=>private
   conversions. Think of a VM receiving some data from the host in a
   shared buffer, and then it wants to operate on that buffer without
   risking to leak confidential informations in a transient state. In
   that case the most logical thing to do is to convert the buffer back
   to private, do whatever needs to be done on that buffer (decrypting a
   frame, ...), and then share it back with the host to consume it;

 - similar to the previous point, a protected VM might want to
   temporarily turn a buffer private to avoid ToCToU issues;

 - once we're able to do device assignment to protected VMs, this might
   allow DMA-ing to a private buffer, and make it shared later w/o
   bouncing.

And there is probably more.

IIUC, the private fd proposal as it stands requires shared and private
pages to come from entirely distinct places. So it's not entirely clear
to me how any of the above could be supported without having the
hypervisor memcpy the data during conversions, which I really don't want
to do for performance reasons.

> Is the idea that multiple guest could share the same page until such time as one of them tries to write to it?

That would certainly be possible to implement in the pKVM
environment with the right tracking, so I think it is worth considering
as a future goal.

Thanks,
Quentin
