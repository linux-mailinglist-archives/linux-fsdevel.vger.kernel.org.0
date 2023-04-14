Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1996E2B80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDNVIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjDNVIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:08:13 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A45261
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 14:08:11 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h8-20020a170902f54800b001a1f5f00f3fso10189435plf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681506490; x=1684098490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7Jr+FjVXuQEnXDMlE3gznMa+dmQespZNtp7nLwMnLo=;
        b=Z5HvJTutAVSami8OKTwQ0L/Tb2qB7TzKRMxFI28D2AJ1QCpuyyvVHOIi9Fb3XHR9ej
         LUNfDfNV6JeVjW3E90abkAcvZRFvh1n+aONtio3M8f0noPTpRbjMmxowI+9sS4Xq8hOM
         Sf8ikJlSVrVt4ndDSkdOQC01mNz5LJQqb5MN5v49d2Xg9pi+/EcTwfMmakOAtcymdSPB
         3uhaOLkyYQ+M+WsF5l8y2hIZEq9pNWsbaA7iwUmYpJ328Zz4BxjSvHOlfXGK+mUVM1vi
         r2OSTO5kfzooBMyGZCEiZPK8V4lIN0PFu5BvTJM4WCQKYevPaAgKuJZuB8K2huoAWqrx
         vn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681506490; x=1684098490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7Jr+FjVXuQEnXDMlE3gznMa+dmQespZNtp7nLwMnLo=;
        b=jJn/G5rZGigc3UIixHIHIeTQ3uVNoiiJkYQgwqXKkSm4D5XJiQX/FeD0cB3JMlTK0M
         uPH1FonduzewUdzrRgnf4WF0hwsbFgXUI7hN0w7sIJnjuR+Mg+WYRsDOje6gU7MFOPEl
         WgMHsnbrIvJBERl+bDkb/9VrIHozJHP2lkr/maOm1hQd/F6gTQKvur1ti0qaSb0bTBWb
         PUADrPnQ3Dgmg1Lpx5eT8peHh2Bzs1Gri023nkuMtdelNwD0jcbS0vPo2ZwqYfBO3tZB
         r0CBQjLCmzn7SaB1EjPms3ghJ1eX4NymglNWJUtSEuUtkjG7UQGbJLhdJMd+r6BiQW46
         l8Vg==
X-Gm-Message-State: AAQBX9dvRlN7ieqAXh9cuhtkBA1S3BTyn6H7t6YbvtU3cDeVzcV56cNW
        8g8Hxf9Jn3ITvgo/EEOA8/kLfyb87po=
X-Google-Smtp-Source: AKy350bBbN9SHkQpgaNZinbD0G0RBAygFGxlP9+ytFbgc7OhIviX9khLc+w+xI6iW/tqbkBNGnqofgsbIU0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:58a:0:b0:513:57ce:d61c with SMTP id
 132-20020a63058a000000b0051357ced61cmr1120918pgf.7.1681506490508; Fri, 14 Apr
 2023 14:08:10 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:08:08 -0700
In-Reply-To: <20230328104108.GB2909606@chaop.bj.intel.com>
Mime-Version: 1.0
References: <20230128140030.GB700688@chaop.bj.intel.com> <diqz5ybc3xsr.fsf@ackerleytng-cloudtop.c.googlers.com>
 <20230308074026.GA2183207@chaop.bj.intel.com> <20230323004131.GA214881@ls.amr.corp.intel.com>
 <20230324021029.GA2774613@chaop.bj.intel.com> <6cf365a3-dddc-8b74-4d74-04666fbeb53d@intel.com>
 <20230328104108.GB2909606@chaop.bj.intel.com>
Message-ID: <ZDnAuGKrCO2wgjlG@google.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, pbonzini@redhat.com, corbet@lwn.net,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arnd@arndb.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, x86@kernel.org, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, mhocko@suse.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023, Chao Peng wrote:
> On Fri, Mar 24, 2023 at 10:29:25AM +0800, Xiaoyao Li wrote:
> > On 3/24/2023 10:10 AM, Chao Peng wrote:
> > > On Wed, Mar 22, 2023 at 05:41:31PM -0700, Isaku Yamahata wrote:
> > > > On Wed, Mar 08, 2023 at 03:40:26PM +0800,
> > > > Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > > > 
> > > > > On Wed, Mar 08, 2023 at 12:13:24AM +0000, Ackerley Tng wrote:
> > > > > > Chao Peng <chao.p.peng@linux.intel.com> writes:
> > > > > > 
> > > > > > > On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean Christopherson wrote:
> > > > > > > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > > > > +static bool kvm_check_rmem_offset_alignment(u64 offset, u64 gpa)
> > > > > > > +{
> > > > > > > +	if (!offset)
> > > > > > > +		return true;
> > > > > > > +	if (!gpa)
> > > > > > > +		return false;
> > > > > > > +
> > > > > > > +	return !!(count_trailing_zeros(offset) >= count_trailing_zeros(gpa));
> > > > 
> > > > This check doesn't work expected. For example, offset = 2GB, gpa=4GB
> > > > this check fails.
> > > 
> > > This case is expected to fail as Sean initially suggested[*]:
> > >    I would rather reject memslot if the gfn has lesser alignment than
> > >    the offset. I'm totally ok with this approach _if_ there's a use case.
> > >    Until such a use case presents itself, I would rather be conservative
> > >    from a uAPI perspective.
> > > 
> > > I understand that we put tighter restriction on this but if you see such
> > > restriction is really a big issue for real usage, instead of a
> > > theoretical problem, then we can loosen the check here. But at that time
> > > below code is kind of x86 specific and may need improve.
> > > 
> > > BTW, in latest code, I replaced count_trailing_zeros() with fls64():
> > >    return !!(fls64(offset) >= fls64(gpa));
> > 
> > wouldn't it be !!(ffs64(offset) <= ffs64(gpa)) ?
> 
> As the function document explains, here we want to return true when
> ALIGNMENT(offset) >= ALIGNMENT(gpa), so '>=' is what we need.
> 
> It's worthy clarifying that in Sean's original suggestion he actually
> mentioned the opposite. He said 'reject memslot if the gfn has lesser
> alignment than the offset', but I wonder this is his purpose, since
> if ALIGNMENT(offset) < ALIGNMENT(gpa), we wouldn't be possible to map
> the page as largepage. Consider we have below config:
> 
>   gpa=2M, offset=1M
> 
> In this case KVM tries to map gpa at 2M as 2M hugepage but the physical
> page at the offset(1M) in private_fd cannot provide the 2M page due to
> misalignment.
> 
> But as we discussed in the off-list thread, here we do find a real use
> case indicating this check is too strict. i.e. QEMU immediately fails
> when launch a guest > 2G memory. For this case QEMU splits guest memory
> space into two slots:
> 
>   Slot#1(ram_below_4G): gpa=0x0, offset=0x0, size=2G
>   Slot#2(ram_above_4G): gpa=4G,  offset=2G,  size=totalsize-2G
> 
> This strict alignment check fails for slot#2 because offset(2G) has less
> alignment than gpa(4G). To allow this, one solution can revert to my
> previous change in kvm_alloc_memslot_metadata() to disallow hugepage
> only when the offset/gpa are not aligned to related page size.
> 
> Sean, How do you think?

I agree, a pure alignment check is too restrictive, and not really what I intended
despite past me literally saying that's what I wanted :-)  I think I may have also
inverted the "less alignment" statement, but luckily I believe that ends up being
a moot point.

The goal is to avoid having to juggle scenarios where KVM wants to create a hugepage,
but restrictedmem can't provide one because of a misaligned file offset.  I think
the rule we want is that the offset must be aligned to the largest page size allowed
by the memslot _size_.  E.g. on x86, if the memslot size is >=1GiB then the offset
must be 1GiB or beter, ditto for >=2MiB and >=4KiB (ignoring that 4KiB is already a
requirement).

We could loosen that to say the largest size allowed by the memslot, but I don't
think that's worth the effort unless it's trivially easy to implement in code,
e.g. KVM could technically allow a 4KiB aligned offset if the memslot is 2MiB
sized but only 4KiB aligned on the GPA.  I doubt there's a real use case for such
a memslot, so I want to disallow that unless it's super easy to implement.
