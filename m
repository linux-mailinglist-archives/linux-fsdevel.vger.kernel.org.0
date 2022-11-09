Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFD622889
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 11:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKIKfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 05:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIKfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49BA19C15
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 02:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667990088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3J441/GDgv6cN9YzwYIw/Qlxf96gs8QTcgGQhe6EZYE=;
        b=SLHXDNu6OP/hwicW+P/ENpnWFs+Mz+dcKNKk/uRn4/tzJyoK1XvhbYks2GephIYj8hNXq6
        +LHEhuT+cBeAPGOeVMjvzy/x+nPxb1IBM7YtKTdn180hhZc/4MdYc7rL21uLmuoSX6v9HE
        BsxFlN9aSuaVnnyONcmPpu3Qk+MGYz4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-197-p_n73j2ZOvuUDKdiv1BSrQ-1; Wed, 09 Nov 2022 05:34:47 -0500
X-MC-Unique: p_n73j2ZOvuUDKdiv1BSrQ-1
Received: by mail-wm1-f69.google.com with SMTP id p14-20020a05600c204e00b003cf4cce4da5so421594wmg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 02:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3J441/GDgv6cN9YzwYIw/Qlxf96gs8QTcgGQhe6EZYE=;
        b=I0OLbG3lL3UQjos8VESfHllLFpa0O8k/aE+ocpOULiQPXouCD8R8XOTnCg3yaORbio
         ZMRSC0NfiCr1FpKO6QvT3+jylKc2xxLDhPzpaIZnnvuu5eyDtxM1XhkZVA3Z0/TjSEox
         6pk+ida8lJaYrwEc7HvGckAkEpxn1nSgbXiiCcJZFFX6XBBWA+25pgmFcWSiaMMIycrJ
         1A+n+8XhWymSdNt6pvWz15oJhuOq6GRV/hiyu7LkGxGKGB2uSoHt8Mau90R/R1xtOKaR
         YQ4q41Mj6+2Q3lwReVRuKBurNMkhOyr38mEAsW8gOJWcV3jhffGI6B/bu3SVyR+xI357
         H3Bg==
X-Gm-Message-State: ACrzQf1x3GsruW+HDZOKzYCda8dVYYlS0kteTphquTAcsxy71kA0J8F1
        +UaKIvaJfcVCbexiqoMKrJyS1YByCHe5N6QP0fU32KR4ng8nUJK3Gh3FOpHJ2+GTWIMJKLVtL6l
        WyD9EcFjegenpjZ9yMqdgCdZrZQ==
X-Received: by 2002:a1c:f214:0:b0:3be:4e7c:1717 with SMTP id s20-20020a1cf214000000b003be4e7c1717mr40707885wmc.171.1667990086103;
        Wed, 09 Nov 2022 02:34:46 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5KUj/gYNJcSIhtdNPjm0EteMyf5apuMBhpsiXhBbhX54nb3tAFmta3JZlLl0rVB/VwRx9Lrw==
X-Received: by 2002:a1c:f214:0:b0:3be:4e7c:1717 with SMTP id s20-20020a1cf214000000b003be4e7c1717mr40707846wmc.171.1667990085742;
        Wed, 09 Nov 2022 02:34:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:b000:3b0e:74a3:bc8:9937? (p200300cbc704b0003b0e74a30bc89937.dip0.t-ipconnect.de. [2003:cb:c704:b000:3b0e:74a3:bc8:9937])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003c6f426467fsm1194121wmq.40.2022.11.09.02.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 02:34:45 -0800 (PST)
Message-ID: <9c167d01-ef09-ec4e-b4a1-2fff62bf01fe@redhat.com>
Date:   Wed, 9 Nov 2022 11:34:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info about
 PTEs
In-Reply-To: <20221109102303.851281-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.11.22 11:23, Muhammad Usama Anjum wrote:
> Changes in v6:
> - Updated the interface and made cosmetic changes
> 
> Original Cover Letter in v5:
> Hello,
> 
> This patch series implements IOCTL on the pagemap procfs file to get the
> information about the page table entries (PTEs). The following operations
> are supported in this ioctl:
> - Get the information if the pages are soft-dirty, file mapped, present
>    or swapped.
> - Clear the soft-dirty PTE bit of the pages.
> - Get and clear the soft-dirty PTE bit of the pages atomically.
> 
> Soft-dirty PTE bit of the memory pages can be read by using the pagemap
> procfs file. The soft-dirty PTE bit for the whole memory range of the
> process can be cleared by writing to the clear_refs file. There are other
> methods to mimic this information entirely in userspace with poor
> performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping
> Some benchmarks can be seen here[1]. This series adds features that weren't
> present earlier:
> - There is no atomic get soft-dirty PTE bit status and clear operation
>    possible.
> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
> 
> Historically, soft-dirty PTE bit tracking has been used in the CRIU
> project. The procfs interface is enough for finding the soft-dirty bit
> status and clearing the soft-dirty bit of all the pages of a process.
> We have the use case where we need to track the soft-dirty PTE bit for
> only specific pages on demand. We need this tracking and clear mechanism
> of a region of memory while the process is running to emulate the
> getWriteWatch() syscall of Windows. This syscall is used by games to
> keep track of dirty pages to process only the dirty pages.
> 
> The information related to pages if the page is file mapped, present and
> swapped is required for the CRIU project[2][3]. The addition of the
> required mask, any mask, excluded mask and return masks are also required
> for the CRIU project[2].
> 
> The IOCTL returns the addresses of the pages which match the specific masks.
> The page addresses are returned in struct page_region in a compact form.
> The max_pages is needed to support a use case where user only wants to get
> a specific number of pages. So there is no need to find all the pages of
> interest in the range when max_pages is specified. The IOCTL returns when
> the maximum number of the pages are found. The max_pages is optional. If
> max_pages is specified, it must be equal or greater than the vec_size.
> This restriction is needed to handle worse case when one page_region only
> contains info of one page and it cannot be compacted. This is needed to
> emulate the Windows getWriteWatch() syscall.
> 
> Some non-dirty pages get marked as dirty because of the kernel's
> internal activity (such as VMA merging as soft-dirty bit difference isn't
> considered while deciding to merge VMAs). The dirty bit of the pages is
> stored in the VMA flags and in the per page flags. If any of these two bits
> are set, the page is considered to be soft dirty. Suppose you have cleared
> the soft dirty bit of half of VMA which will be done by splitting the VMA
> and clearing soft dirty bit flag in the half VMA and the pages in it. Now
> kernel may decide to merge the VMAs again. So the half VMA becomes dirty
> again. This splitting/merging costs performance. The application receives
> a lot of pages which aren't dirty in reality but marked as dirty.
> Performance is lost again here. Also sometimes user doesn't want the newly
> allocated memory to be marked as dirty. PAGEMAP_NO_REUSED_REGIONS flag
> solves both the problems. It is used to not depend on the soft dirty flag
> in the VMA flags. So VMA splitting and merging doesn't happen. It only
> depends on the soft dirty bit of the individual pages. Thus by using this
> flag, there may be a scenerio such that the new memory regions which are
> just created, doesn't look dirty when seen with the IOCTL, but look dirty
> when seen from procfs. This seems okay as the user of this flag know the
> implication of using it.

Please separate that part out from the other changes; I am still not 
convinced that we want this and what the semantical implications are.

Let's take a look at an example: can_change_pte_writable()

	/* Do we need write faults for softdirty tracking? */
	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
		return false;

We care about PTE softdirty tracking, if it is enabled for the VMA. 
Tracking is enabled if: vma_soft_dirty_enabled()

	/*
	 * Soft-dirty is kind of special: its tracking is enabled when
	 * the vma flags not set.
	 */
	return !(vma->vm_flags & VM_SOFTDIRTY);

Consequently, if VM_SOFTDIRTY is set, we are not considering the 
soft_dirty PTE bits accordingly.


I'd suggest moving forward without this controversial 
PAGEMAP_NO_REUSED_REGIONS functionality for now, and preparing it as a 
clear add-on we can discuss separately.

-- 
Thanks,

David / dhildenb

