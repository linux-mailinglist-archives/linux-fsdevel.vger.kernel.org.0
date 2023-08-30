Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFF78DBD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjH3Shw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbjH3Qo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713C1A2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 09:44:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e4d2b7d16so81993237b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413893; x=1694018693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7U5WETyc0Qx792+SyKBjLV43d3DHT0ObMpMrFVoeXw=;
        b=Vrqu6jdVSxGa28aE1migk5YVHh9PHn+K3BQigSsynTqZy+1FdBGBQl1nQH4In9WVRs
         KF+yQOaHMyhG/7vylvJ5xFxpXhxbdaWq++yLYUP/fN2VQ82tBRyWoQyVgRPj/MMHCpZe
         jO+0V9PUab495XMFnTawLOr1RRUfzotX6k9V6ER1+dm9TYtelUtxG92oglhZ+G48OHTA
         bw77cd5ga08rV8S2iervR+8tUMuXpINKvMhop7uskl+N/C/qylZpwCA4vMTQyd1AjsSG
         0geLp1xw/hWTZsN/r98ZAoO7y0K3ubKpSdpRpvOm2LmVQAtpWFwGs0HAi3r6ak9bzn/q
         y+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413893; x=1694018693;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7U5WETyc0Qx792+SyKBjLV43d3DHT0ObMpMrFVoeXw=;
        b=FU3HJwdPZkzgmgfu7SoG2AmcMcUMZQf9Gk99Z+KirF4KA6YCgdMhHwMhxO5+jS/GTw
         OEAbtEsmQegjJdp3H7qn8R9u86jh7Qhk/pASwPZszNdha2EV7z8OVT0ofiTTCyZgVAVu
         ATi104ao/5cPtinsTvNtDujI5vyqHvXued7FhYUoNwADO6yZUAI/FrjtyjPlQKHdds/y
         KFDzp86WzBsFOpKTYTKCVi/6LqbjlWyqUTJIWPnqVeQ+A5s0cxppA278gJxY9GHjP3Wu
         O2hplvPfGcWTK/0yOEqGNh/cU2y62veunu3D17mnnJsZvXRxhmEQfF3f97IhL1fxJtw8
         ioRQ==
X-Gm-Message-State: AOJu0YxsGR1WpIajfVLX+uVa0vssBUeADSznLsCHVD6cHUeWNWk2kGo/
        JJTVyQpVa2v8R1oBNzBVaHXln72NkaZZQ78a8g==
X-Google-Smtp-Source: AGHT+IHtp9pD/5ci3MqPyr+0sXpcwrOb70482adH4y9FFBhT1onMN4Y2Yo7VfYMaFeFIQUgnoauWykiqo7sAzbNhxQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a81:eb0b:0:b0:57a:793:7fb0 with SMTP
 id n11-20020a81eb0b000000b0057a07937fb0mr78438ywm.3.1693413893177; Wed, 30
 Aug 2023 09:44:53 -0700 (PDT)
Date:   Wed, 30 Aug 2023 16:44:51 +0000
In-Reply-To: <30ffe039-c9e2-b996-500d-5e11bf6ea789@linux.intel.com> (message
 from Binbin Wu on Wed, 30 Aug 2023 23:12:19 +0800)
Mime-Version: 1.0
Message-ID: <diqz5y4wfpj0.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     seanjc@google.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        oliver.upton@linux.dev, chenhuacai@kernel.org, mpe@ellerman.id.au,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Binbin Wu <binbin.wu@linux.intel.com> writes:

>> <snip>
>>
>> +static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>> +{
>> +	struct address_space *mapping = inode->i_mapping;
>> +	pgoff_t start, index, end;
>> +	int r;
>> +
>> +	/* Dedicated guest is immutable by default. */
>> +	if (offset + len > i_size_read(inode))
>> +		return -EINVAL;
>> +
>> +	filemap_invalidate_lock_shared(mapping);
>> +
>> +	start = offset >> PAGE_SHIFT;
>> +	end = (offset + len) >> PAGE_SHIFT;
>> +
>> +	r = 0;
>> +	for (index = start; index < end; ) {
>> +		struct folio *folio;
>> +
>> +		if (signal_pending(current)) {
>> +			r = -EINTR;
>> +			break;
>> +		}
>> +
>> +		folio = kvm_gmem_get_folio(inode, index);
>> +		if (!folio) {
>> +			r = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		index = folio_next_index(folio);
>> +
>> +		folio_unlock(folio);
>> +		folio_put(folio);
> May be a dumb question, why we get the folio and then put it immediately?
> Will it make the folio be released back to the page allocator?
>

I was wondering this too, but it is correct.

In filemap_grab_folio(), the refcount is incremented in three places:

+ When the folio is created in filemap_alloc_folio(), it is given a
  refcount of 1 in

    filemap_alloc_folio() -> folio_alloc() -> __folio_alloc_node() ->
    __folio_alloc() -> __alloc_pages() -> get_page_from_freelist() ->
    prep_new_page() -> post_alloc_hook() -> set_page_refcounted()

+ Then, in filemap_add_folio(), the refcount is incremented twice:

    + The first is from the filemap (1 refcount per page if this is a
      hugepage):

        filemap_add_folio() -> __filemap_add_folio() -> folio_ref_add()

    + The second is a refcount from the lru list

        filemap_add_folio() -> folio_add_lru() -> folio_get() ->
        folio_ref_inc()

In the other path, if the folio exists in the page cache (filemap), the
refcount is also incremented through

    filemap_grab_folio() -> __filemap_get_folio() -> filemap_get_entry()
    -> folio_try_get_rcu()

I believe all the branches in kvm_gmem_get_folio() are taking a refcount
on the folio while the kernel does some work on the folio like clearing
the folio in clear_highpage() or getting the next index, and then when
done, the kernel does folio_put().

This pattern is also used in shmem and hugetlb. :)

I'm not sure whose refcount the folio_put() in kvm_gmem_allocate() is
dropping though:

+ The refcount for the filemap depends on whether this is a hugepage or
  not, but folio_put() strictly drops a refcount of 1.
+ The refcount for the lru list is just 1, but doesn't the page still
  remain in the lru list?

>> +
>> +		/* 64-bit only, wrapping the index should be impossible. */
>> +		if (WARN_ON_ONCE(!index))
>> +			break;
>> +
>> +		cond_resched();
>> +	}
>> +
>> +	filemap_invalidate_unlock_shared(mapping);
>> +
>> +	return r;
>> +}
>> +
>>
>> <snip>
