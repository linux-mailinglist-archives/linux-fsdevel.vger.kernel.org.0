Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF86E6FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 01:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjDRXko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 19:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjDRXk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:40:28 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666BD14445
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 16:38:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a698bd6046so13354015ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681861114; x=1684453114;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZZcbhEIXep3CsDuGt1XX4NDaxpUgfaEfLEdZFPghSQ=;
        b=hm9bDIHJQIeAjh+0Wi4XwWxk5FEWf9SU2iifaVaFm2SHEQi+MfvRomA6hNFQPypblO
         ajskHfJ21yXbKIgYGAkYYUqP0Ygv5283TmzvvXkvGPLvNGcY8IspXO87zRQLxoMgm7+A
         44LeeK44/TjVVWr4ejNfVV1NjMwkMAjVBZwnQccmKfvNgc/rCXeLfUDkrNJrLDo+aM/k
         5pFpnDDsiw5EE9Dzm//Lga2qY9q3z+kEsegm3Xv/EsUZ8FyYGeSCyJOZ49dURNwlnL2q
         Y5lq2y1JVNHacWD2DjdNMHYSACvPNhgvLrByCLzQkYOtXAP0CIMW0LotNLXFCHIJamQv
         WJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681861114; x=1684453114;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZZcbhEIXep3CsDuGt1XX4NDaxpUgfaEfLEdZFPghSQ=;
        b=ddbbZ/F3qqeGLlR4JzILUuCetuF+NruKJtC44+XPwY6dHlX0+me1ufWEvLCA8yUP7J
         x4vu9F5DJwAiBNBsMpKbjohypiuM3F8aiPRdeAPBSTRKxg8TUuljclKLoSawrHxdMrNK
         W9MXqoEAY7uoJWFCFS9ZXrn7dVLEc2ugWur5YXT/HVmfzTqVLCp0b51xEEAWw7jBOCi8
         Gci44mI8Hy5kx/uC0e8JTm/ukqizlj0EcQmDd5u+Y7z2K/PGaNzofyxTI50K0v9OT2py
         w6BZce1cInVDpIcIKB1jNWMiWRsBINLtPEHDBew6x5BGmIElJRtDCTVmCXu6fJKPrqBV
         u4fA==
X-Gm-Message-State: AAQBX9ddcY75eYDKw81CvUuP8BYzwI6Ly407AHWJ6zjdGw6zrMymfV9k
        1u1uT2o78hYgfpfyzJ9pErZnSpm0DhoatD70cw==
X-Google-Smtp-Source: AKy350Y4yrZy3jVvN3wQp7+RZBqQNJ9wdfC4ADrLjc4RYHgu0a5KoOvNA6U3D5YLtIMfO6ES8yW87Yjz2s2FcMbRug==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:41c5:b0:19a:7bd4:5b0d with
 SMTP id u5-20020a17090341c500b0019a7bd45b0dmr1394106ple.8.1681861113900; Tue,
 18 Apr 2023 16:38:33 -0700 (PDT)
Date:   Tue, 18 Apr 2023 23:38:32 +0000
In-Reply-To: <ZDnAuGKrCO2wgjlG@google.com> (message from Sean Christopherson
 on Fri, 14 Apr 2023 14:08:08 -0700)
Mime-Version: 1.0
Message-ID: <diqz354w92x3.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     chao.p.peng@linux.intel.com, xiaoyao.li@intel.com,
        isaku.yamahata@gmail.com, kvm@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Mar 28, 2023, Chao Peng wrote:
>> On Fri, Mar 24, 2023 at 10:29:25AM +0800, Xiaoyao Li wrote:
>> > On 3/24/2023 10:10 AM, Chao Peng wrote:
>> > > On Wed, Mar 22, 2023 at 05:41:31PM -0700, Isaku Yamahata wrote:
>> > > > On Wed, Mar 08, 2023 at 03:40:26PM +0800,
>> > > > Chao Peng <chao.p.peng@linux.intel.com> wrote:
>> > > >
>> > > > > On Wed, Mar 08, 2023 at 12:13:24AM +0000, Ackerley Tng wrote:
>> > > > > > Chao Peng <chao.p.peng@linux.intel.com> writes:
>> > > > > >
>> > > > > > > On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean  
>> Christopherson wrote:
>> > > > > > > > On Fri, Dec 02, 2022, Chao Peng wrote:
>> > > > > > > +static bool kvm_check_rmem_offset_alignment(u64 offset, u64  
>> gpa)
>> > > > > > > +{
>> > > > > > > +	if (!offset)
>> > > > > > > +		return true;
>> > > > > > > +	if (!gpa)
>> > > > > > > +		return false;
>> > > > > > > +
>> > > > > > > +	return !!(count_trailing_zeros(offset) >=  
>> count_trailing_zeros(gpa));
>> > > >
>> > > > This check doesn't work expected. For example, offset = 2GB,  
>> gpa=4GB
>> > > > this check fails.
>> > >
>> > > This case is expected to fail as Sean initially suggested[*]:
>> > >    I would rather reject memslot if the gfn has lesser alignment than
>> > >    the offset. I'm totally ok with this approach _if_ there's a use  
>> case.
>> > >    Until such a use case presents itself, I would rather be  
>> conservative
>> > >    from a uAPI perspective.
>> > >
>> > > I understand that we put tighter restriction on this but if you see  
>> such
>> > > restriction is really a big issue for real usage, instead of a
>> > > theoretical problem, then we can loosen the check here. But at that  
>> time
>> > > below code is kind of x86 specific and may need improve.
>> > >
>> > > BTW, in latest code, I replaced count_trailing_zeros() with fls64():
>> > >    return !!(fls64(offset) >= fls64(gpa));
>> >
>> > wouldn't it be !!(ffs64(offset) <= ffs64(gpa)) ?

>> As the function document explains, here we want to return true when
>> ALIGNMENT(offset) >= ALIGNMENT(gpa), so '>=' is what we need.

>> It's worthy clarifying that in Sean's original suggestion he actually
>> mentioned the opposite. He said 'reject memslot if the gfn has lesser
>> alignment than the offset', but I wonder this is his purpose, since
>> if ALIGNMENT(offset) < ALIGNMENT(gpa), we wouldn't be possible to map
>> the page as largepage. Consider we have below config:

>>    gpa=2M, offset=1M

>> In this case KVM tries to map gpa at 2M as 2M hugepage but the physical
>> page at the offset(1M) in private_fd cannot provide the 2M page due to
>> misalignment.

>> But as we discussed in the off-list thread, here we do find a real use
>> case indicating this check is too strict. i.e. QEMU immediately fails
>> when launch a guest > 2G memory. For this case QEMU splits guest memory
>> space into two slots:

>>    Slot#1(ram_below_4G): gpa=0x0, offset=0x0, size=2G
>>    Slot#2(ram_above_4G): gpa=4G,  offset=2G,  size=totalsize-2G

>> This strict alignment check fails for slot#2 because offset(2G) has less
>> alignment than gpa(4G). To allow this, one solution can revert to my
>> previous change in kvm_alloc_memslot_metadata() to disallow hugepage
>> only when the offset/gpa are not aligned to related page size.

>> Sean, How do you think?

> I agree, a pure alignment check is too restrictive, and not really what I  
> intended
> despite past me literally saying that's what I wanted :-)  I think I may  
> have also
> inverted the "less alignment" statement, but luckily I believe that ends  
> up being
> a moot point.

> The goal is to avoid having to juggle scenarios where KVM wants to create  
> a hugepage,
> but restrictedmem can't provide one because of a misaligned file offset.   
> I think
> the rule we want is that the offset must be aligned to the largest page  
> size allowed
> by the memslot _size_.  E.g. on x86, if the memslot size is >=1GiB then  
> the offset
> must be 1GiB or beter, ditto for >=2MiB and >=4KiB (ignoring that 4KiB is  
> already a
> requirement).

> We could loosen that to say the largest size allowed by the memslot, but  
> I don't
> think that's worth the effort unless it's trivially easy to implement in  
> code,
> e.g. KVM could technically allow a 4KiB aligned offset if the memslot is  
> 2MiB
> sized but only 4KiB aligned on the GPA.  I doubt there's a real use case  
> for such
> a memslot, so I want to disallow that unless it's super easy to implement.

Checking my understanding here about why we need this alignment check:

When KVM requests a page from restrictedmem, KVM will provide an offset
into the file in terms of 4K pages.

When shmem is configured to use hugepages, shmem_get_folio() will round
the requested offset down to the nearest hugepage-aligned boundary in
shmem_alloc_hugefolio().

Example of problematic configuration provided to
KVM_SET_USER_MEMORY_REGION2:

+ shmem configured to use 1GB pages
+ restrictedmem_offset provided to KVM_SET_USER_MEMORY_REGION2: 0x4000
+ memory_size provided in KVM_SET_USER_MEMORY_REGION2: 1GB
+ KVM requests offset (pgoff_t) 0x8, which translates to offset 0x8000

restrictedmem_get_page() and shmem_get_folio() returns the page for
offset 0x0 in the file, since rounding down 0x8000 to the nearest 1GB is
0x0. This is allocating outside the range that KVM is supposed to use,
since the parameters provided in KVM_SET_USER_MEMORY_REGION2 is only
supposed to be offset 0x4000 to (0x4000 + 1GB = 0x40004000) in the file.

IIUC shmem will actually just round down (0x4000 rounded down to nearest
1GB will be 0x0) and allocate without checking bounds, so if offset 0x0
to 0x4000 in the file were supposed to be used by something else, there
might be issues.

Hence, this alignment check ensures that rounding down of any offsets
provided by KVM (based on page size configured in the backing file
provided) to restrictedmem_get_page() must not go below the offset
provided to KVM_SET_USER_MEMORY_REGION2.

Enforcing alignment of restrictedmem_offset based on the currently-set
page size in the backing file (i.e. shmem) may not be effective, since
the size of the pages in the backing file can be adjusted to a larger
size after KVM_SET_USER_MEMORY_REGION2 succeeds. With that, we may still
end up allocating outside the range that KVM was provided with.

Hence, to be safe, we should check alignment to the max page size across
all backing filesystems, so the constraint is

     rounding down restrictedmem_offset to
     min(max page size across all backing filesystems,
         max page size that fits in memory_size) == restrictedmem_offset

which is the same check as

     restrictedmem_offset must be aligned to min(max page size across all
     backing filesystems, max page size that fits in memory_size)

which can safely reduce to

     restrictedmem_offset must be aligned to max page size that fits in
     memory_size

since "max page size that fits in memory_size" is probably <= to "max
page size across all backing filesystems", and if it's larger, it'll
just be a tighter constraint.

If the above understanding is correct:

+ We must enforce this in the KVM_SET_USER_MEMORY_REGION2 handler, since
   IIUC shmem will just round down and allocate without checking bounds.

     + I think this is okay because holes in the restrictedmem file (in
       terms of offset) made to accommodate this constraint don't cost us
       anything anyway(?) Are they just arbitrary offsets in a file? In
       our case, this file is usually a new and empty file.

     + In the case of migration of a restrictedmem file between two KVM
       VMs, this constraint would cause a problem is if the largest
       possible page size on the destination machine is larger than that
       of the source machine. In that case, we might have to move the
       data in the file to a different offset (a separate problem).

+ On this note, it seems like there is no check for when the range is
   smaller than the allocated page? Like if the range provided is 4KB in
   size, but shmem is then configured to use a 1GB page, will we end up
   allocating past the end of the range?
