Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EA862844D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiKNPrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiKNPrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB912D33
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668440783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ia8pcKGDLql5r5FGlzWRSZ1nHmbuVDJ+PIdsdZ53JhI=;
        b=iiPlSSdFXMqlLG7hQcnjg5fiRmHUZOLyNNyLx8Z939zK1reXO0VFT3i+FxA/2e62PDQAYm
        YhpTWX165bHnFB+35tDYnlZjc8hb9ScekRTfOkXTK637zgX9IgDXTLN0A2Zdaf+pk8mp1b
        wny8lPS6d7SyF/axN7DWyEyXb+9OCoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-dLNEF1lePMKvmJO4AidJAQ-1; Mon, 14 Nov 2022 10:46:21 -0500
X-MC-Unique: dLNEF1lePMKvmJO4AidJAQ-1
Received: by mail-wm1-f72.google.com with SMTP id c1-20020a7bc001000000b003cfe40fca79so511823wmb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 07:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia8pcKGDLql5r5FGlzWRSZ1nHmbuVDJ+PIdsdZ53JhI=;
        b=mPlLCtKN5NWsHO5TPat42GS1fpqbG1Nyq7JxAj65qLbXvE6f1/4C+WAHwo6sMeaZQT
         fYpfeU2Pp+ZfKmwgp+YcQNUfjRUOIE4K/QAulam/XwKzVMEZIxPVeC2srmxRZc/L2FSJ
         hWJKxG6A8EVotZBeo0sJT/82VFHtYFGk4CKYvfNKYzZsYaUVnkdg8RZgrJ/lIcpBAJph
         8rrWFAL/1HCupIyCyH/9q5YvsYxEulMkTce99MnZLGHK+ja9bQoQpFSaIe5qHZMMSkiI
         Cxi8jQbMxbFKW3S2QYlNdOGtsdbX3RzGoQO3s9CkjMHa5Cxag+eE0MXqVRMlMNp33PJ1
         YubA==
X-Gm-Message-State: ANoB5pl2J2NpqeLw6LJDZr9G9mJRQGryCGQaBqLbndxbXD5ucVCxHsxf
        k8nIAj66wK1FkzBoupRiROSAfswL9wkj8NCPC7BJmpLurGWXCG1NAEq0u1AfIq5YX3OoPDr+SqH
        Y9axKPsip5IWbw1etvXcI//cRuw==
X-Received: by 2002:a5d:40c1:0:b0:22e:433a:46ba with SMTP id b1-20020a5d40c1000000b0022e433a46bamr8099938wrq.575.1668440780532;
        Mon, 14 Nov 2022 07:46:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4PNBwy8nTPC78ZKZ/DhAuvz42a+Loa0PqLvkYjbIuLMym1kLWnaraQbN6YaVSr6C1CNmRzgA==
X-Received: by 2002:a5d:40c1:0:b0:22e:433a:46ba with SMTP id b1-20020a5d40c1000000b0022e433a46bamr8099892wrq.575.1668440780199;
        Mon, 14 Nov 2022 07:46:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:d881:1fd5:bc95:5e2d? (p200300cbc703d300d8811fd5bc955e2d.dip0.t-ipconnect.de. [2003:cb:c703:d300:d881:1fd5:bc95:5e2d])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d554d000000b002366e3f1497sm10115912wrw.6.2022.11.14.07.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:46:19 -0800 (PST)
Message-ID: <a90ee936-67a9-340d-bf2c-2f331617b0da@redhat.com>
Date:   Mon, 14 Nov 2022 16:46:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
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
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <9c167d01-ef09-ec4e-b4a1-2fff62bf01fe@redhat.com>
 <6fdce544-8d4f-8b3c-9208-735769a9e624@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info about
 PTEs
In-Reply-To: <6fdce544-8d4f-8b3c-9208-735769a9e624@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The soft-dirtiness is stored in the PTE. VMA is marked dirty to store the
> dirtiness for reused regions. Clearing the soft-dirty status of whole
> process is straight forward. When we want to clear/monitor the
> soft-dirtiness of a part of the virtual memory, there is a lot of internal
> noise. We don't want the non-dirty pages to become dirty because of how the
> soft-dirty feature has been working. Soft-dirty feature wasn't being used
> the way we want to use now. While monitoring a part of memory, it is not
> acceptable to get non-dirty pages as dirty. Non-dirty pages become dirty
> when the two VMAs are merged without considering if they both are dirty or
> not (34228d473efe). To monitor changes over the memory, sometimes VMAs are
> split to clear the soft-dirty bit in the VMA flags. But sometimes kernel
> decide to merge them backup. It is so waste of resources.

Maybe you'd want a per-process option to not merge if the VM_SOFTDIRTY 
property differs. But that might be just one alternative for handling 
this case.

> 
> To keep things consistent, the default behavior of the IOCTL is to output
> even the extra non-dirty pages as dirty from the kernel noise. A optional
> PAGEMAP_NO_REUSED_REGIONS flag is added for those use cases which aren't
> tolerant of extra non-dirty pages. This flag can be considered as something
> which is by-passing the already present buggy implementation in the kernel.
> It is not buggy per say as the issue can be solved if we don't allow the
> two VMA which have different soft-dirty bits to get merged. But we are
> allowing that so that the total number of VMAs doesn't increase. This was
> acceptable at the time, but now with the use case of monitoring a part of
> memory for soft-dirty doesn't want this merging. So either we need to
> revert 34228d473efe and PAGEMAP_NO_REUSED_REGIONS flag will not be needed
> or we should allow PAGEMAP_NO_REUSED_REGIONS or similar mechanism to ignore
> the extra dirty pages which aren't dirty in reality.
> 
> When PAGEMAP_NO_REUSED_REGIONS flag is used, only the PTEs are checked to
> find if the pages are dirty. So re-used regions cannot be detected. This
> has the only side-effect of not checking the VMAs. So this is limitation of
> using this flag which should be acceptable in the current state of code.
> This limitation is okay for the users as they can clear the soft-dirty bit
> of the VMA before starting to monitor a range of memory for soft-dirtiness.
> 
> 
>> Please separate that part out from the other changes; I am still not
>> convinced that we want this and what the semantical implications are.
>>
>> Let's take a look at an example: can_change_pte_writable()
>>
>>      /* Do we need write faults for softdirty tracking? */
>>      if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
>>          return false;
>>
>> We care about PTE softdirty tracking, if it is enabled for the VMA.
>> Tracking is enabled if: vma_soft_dirty_enabled()
>>
>>      /*
>>       * Soft-dirty is kind of special: its tracking is enabled when
>>       * the vma flags not set.
>>       */
>>      return !(vma->vm_flags & VM_SOFTDIRTY);
>>
>> Consequently, if VM_SOFTDIRTY is set, we are not considering the soft_dirty
>> PTE bits accordingly.
> Sorry, I'm unable to completely grasp the meaning of the example. We have
> followed clear_refs_write() to write the soft-dirty bit clearing code in
> the current patch. Dirtiness of the VMA and the PTE may be set
> independently. Newer allocated memory has dirty bit set in the VMA. When
> something is written the memory, the soft dirty bit is set in the PTEs as
> well regardless if the soft dirty bit is set in the VMA or not.
> 

Let me try to find a simple explanation:

After clearing a SOFTDIRTY PTE flag inside an area with VM_SOFTDIRTY 
set, there are ways that PTE could get written to and it could become 
dirty, without the PTE becoming softdirty.

Essentially, inside a VMA with VM_SOFTDIRTY set, the PTE softdirty 
values might be stale: there might be entries that are softdirty even 
though the PTE is *not* marked softdirty.

These are, AFAIU, the current semantics, and I am not sure if we want 
user space to explicitly work around that.

>>
>>
>> I'd suggest moving forward without this controversial
>> PAGEMAP_NO_REUSED_REGIONS functionality for now, and preparing it as a
>> clear add-on we can discuss separately.Like I've described above, I've only added this flag to not get the
> non-dirty pages as dirty. Can there be some alternative to adding this
> flag? Please suggest.

Please split it out into a separate patch for now. We can discuss 
further what the semantics are and if there are better alternatives for 
that. In the meantime, you could move forward without 
PAGEMAP_NO_REUSED_REGIONS while we are discussing them further.

-- 
Thanks,

David / dhildenb

