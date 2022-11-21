Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2516A6328C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKUP5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 10:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiKUP47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0019ACB9C7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669046161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Brr1q29tF36QPcdWuuy4BDao5Edh5KDPJSgJgZKXZRA=;
        b=QPRXXIZtCGb+LmVkHdcZ+otuJpx8jAlnwY8NmPQIsEvtsnO8shhCUfPkf2CwCPBt+F1npV
        hI6AloUXGeVDmRuWfKyt88DwU3kZazN4+atJtHgf7H4OszgSCdpTy2tvc0FyB7iQcykL5M
        84N293XeV2vGBo7RVdj21K+nwT5d214=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-4g1oR978MFOX49bS-yU6fA-1; Mon, 21 Nov 2022 10:56:00 -0500
X-MC-Unique: 4g1oR978MFOX49bS-yU6fA-1
Received: by mail-wm1-f72.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso9498035wms.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 07:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:organization:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Brr1q29tF36QPcdWuuy4BDao5Edh5KDPJSgJgZKXZRA=;
        b=fTe6/uiEvUqgMt4eE+nxh46JDRHDxYkw2AoGMV6HwwILR0T30W1wcAHjAMy45Jvyjl
         5wYklZ+LSbxt5RosncrfiKOuPjTMvuDxy3+HAaUNJb/wFAfKZ9eM1bxMoyGwgXNcjVHd
         bf0y58pI2yjIk5OOs9Sr7b2jJlQ5TidV0txSBVolzkfyQyNxbO3LUwKatB7O5i3Iqnyr
         2L4etrwPtXIln7py3/ABGiZ1v9ag3cQnc0rmwpPPoL5amM8pQ+7TnLGctDoI4MVVkTBi
         0Qg8eMedoroufUlLyQ+Apiakt1155QdsNYaCn0L9Cpfz4N9at+KwGf++fXudfMnGjze3
         f0OA==
X-Gm-Message-State: ANoB5pni64jLKL0UYBebgUrK2sa7XS1hBMPuNhhuFr4Jigh+xaICghfA
        WCngQeIBo8M8zBlEPSmGlDfVmH2yyhFFvL4I6YoymC0DGFfmBMX9QzANYOntS3Tg5xznHS44KfK
        4pMhN3kKuOxS5pHbZZkS2o+RWPg==
X-Received: by 2002:adf:f48f:0:b0:236:715c:aaa6 with SMTP id l15-20020adff48f000000b00236715caaa6mr5020238wro.25.1669046158759;
        Mon, 21 Nov 2022 07:55:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Y8r12BiCMimD8lA0MdgHcMmvrdEVyQpzLWwry7IXgLsmfJELV/YezpWTosx6Pwu2JeAx35g==
X-Received: by 2002:adf:f48f:0:b0:236:715c:aaa6 with SMTP id l15-20020adff48f000000b00236715caaa6mr5020212wro.25.1669046158309;
        Mon, 21 Nov 2022 07:55:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:dc00:2571:c3c2:c6ea:84ef? (p200300cbc702dc002571c3c2c6ea84ef.dip0.t-ipconnect.de. [2003:cb:c702:dc00:2571:c3c2:c6ea:84ef])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003cf4eac8e80sm18773096wmq.23.2022.11.21.07.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 07:55:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------X26NNqKh6qmB3gIBG6DEU1Rl"
Message-ID: <bfcae708-db21-04b4-0bbe-712badd03071@redhat.com>
Date:   Mon, 21 Nov 2022 16:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info about
 PTEs
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
 <a90ee936-67a9-340d-bf2c-2f331617b0da@redhat.com>
 <254130e7-7fb1-6cf1-e8fa-5bc2d4450431@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <254130e7-7fb1-6cf1-e8fa-5bc2d4450431@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------X26NNqKh6qmB3gIBG6DEU1Rl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.11.22 16:00, Muhammad Usama Anjum wrote:
> Hello,
> 
> Thank you for replying.
> 
> On 11/14/22 8:46 PM, David Hildenbrand wrote:
>>> The soft-dirtiness is stored in the PTE. VMA is marked dirty to store the
>>> dirtiness for reused regions. Clearing the soft-dirty status of whole
>>> process is straight forward. When we want to clear/monitor the
>>> soft-dirtiness of a part of the virtual memory, there is a lot of internal
>>> noise. We don't want the non-dirty pages to become dirty because of how the
>>> soft-dirty feature has been working. Soft-dirty feature wasn't being used
>>> the way we want to use now. While monitoring a part of memory, it is not
>>> acceptable to get non-dirty pages as dirty. Non-dirty pages become dirty
>>> when the two VMAs are merged without considering if they both are dirty or
>>> not (34228d473efe). To monitor changes over the memory, sometimes VMAs are
>>> split to clear the soft-dirty bit in the VMA flags. But sometimes kernel
>>> decide to merge them backup. It is so waste of resources.
>>
>> Maybe you'd want a per-process option to not merge if the VM_SOFTDIRTY
>> property differs. But that might be just one alternative for handling this
>> case.
>>
>>>
>>> To keep things consistent, the default behavior of the IOCTL is to output
>>> even the extra non-dirty pages as dirty from the kernel noise. A optional
>>> PAGEMAP_NO_REUSED_REGIONS flag is added for those use cases which aren't
>>> tolerant of extra non-dirty pages. This flag can be considered as something
>>> which is by-passing the already present buggy implementation in the kernel.
>>> It is not buggy per say as the issue can be solved if we don't allow the
>>> two VMA which have different soft-dirty bits to get merged. But we are
>>> allowing that so that the total number of VMAs doesn't increase. This was
>>> acceptable at the time, but now with the use case of monitoring a part of
>>> memory for soft-dirty doesn't want this merging. So either we need to
>>> revert 34228d473efe and PAGEMAP_NO_REUSED_REGIONS flag will not be needed
>>> or we should allow PAGEMAP_NO_REUSED_REGIONS or similar mechanism to ignore
>>> the extra dirty pages which aren't dirty in reality.
>>>
>>> When PAGEMAP_NO_REUSED_REGIONS flag is used, only the PTEs are checked to
>>> find if the pages are dirty. So re-used regions cannot be detected. This
>>> has the only side-effect of not checking the VMAs. So this is limitation of
>>> using this flag which should be acceptable in the current state of code.
>>> This limitation is okay for the users as they can clear the soft-dirty bit
>>> of the VMA before starting to monitor a range of memory for soft-dirtiness.
>>>
>>>
>>>> Please separate that part out from the other changes; I am still not
>>>> convinced that we want this and what the semantical implications are.
>>>>
>>>> Let's take a look at an example: can_change_pte_writable()
>>>>
>>>>       /* Do we need write faults for softdirty tracking? */
>>>>       if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
>>>>           return false;
>>>>
>>>> We care about PTE softdirty tracking, if it is enabled for the VMA.
>>>> Tracking is enabled if: vma_soft_dirty_enabled()
>>>>
>>>>       /*
>>>>        * Soft-dirty is kind of special: its tracking is enabled when
>>>>        * the vma flags not set.
>>>>        */
>>>>       return !(vma->vm_flags & VM_SOFTDIRTY);
>>>>
>>>> Consequently, if VM_SOFTDIRTY is set, we are not considering the soft_dirty
>>>> PTE bits accordingly.
>>> Sorry, I'm unable to completely grasp the meaning of the example. We have
>>> followed clear_refs_write() to write the soft-dirty bit clearing code in
>>> the current patch. Dirtiness of the VMA and the PTE may be set
>>> independently. Newer allocated memory has dirty bit set in the VMA. When
>>> something is written the memory, the soft dirty bit is set in the PTEs as
>>> well regardless if the soft dirty bit is set in the VMA or not.
>>>
>>
>> Let me try to find a simple explanation:
>>
>> After clearing a SOFTDIRTY PTE flag inside an area with VM_SOFTDIRTY set,
>> there are ways that PTE could get written to and it could become dirty,
>> without the PTE becoming softdirty.
>>
>> Essentially, inside a VMA with VM_SOFTDIRTY set, the PTE softdirty values
>> might be stale: there might be entries that are softdirty even though the
>> PTE is *not* marked softdirty.
> Can someone please share the example to reproduce this? In all of my
> testing, even if I ignore VM_SOFTDIRTY and only base my decision of
> soft-dirtiness on individual pages, it always passes.

Quick reproducer (the first and easiest one that triggered :) )
attached.

With no kernel changes, it works as expected.

# ./softdirty_mprotect


With the following kernel change to simulate what you propose it fails:

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d22687d2e81e..f2c682bf7f64 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1457,8 +1457,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
                 flags |= PM_FILE;
         if (page && !migration && page_mapcount(page) == 1)
                 flags |= PM_MMAP_EXCLUSIVE;
-       if (vma->vm_flags & VM_SOFTDIRTY)
-               flags |= PM_SOFT_DIRTY;
+       //if (vma->vm_flags & VM_SOFTDIRTY)
+       //      flags |= PM_SOFT_DIRTY;
  
         return make_pme(frame, flags);
  }


# ./softdirty_mprotect
Page #1 should be softdirty

-- 
Thanks,

David / dhildenb

--------------X26NNqKh6qmB3gIBG6DEU1Rl
Content-Type: text/x-csrc; charset=UTF-8; name="softdirty_mprotect.c"
Content-Disposition: attachment; filename="softdirty_mprotect.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8
c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgoK
c3RhdGljIHNpemVfdCBwYWdlc2l6ZTsKc3RhdGljIGludCBwYWdlbWFwX2ZkOwoKc3RhdGlj
IHZvaWQgY2xlYXJfc29mdGRpcnR5KHZvaWQpCnsKCWludCBmZCA9IG9wZW4oIi9wcm9jL3Nl
bGYvY2xlYXJfcmVmcyIsIE9fV1JPTkxZKTsKCWNvbnN0IGNoYXIgKmN0cmwgPSAiNCI7Cglp
bnQgcmV0OwoKCWlmIChmZCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIm9wZW4oKSBmYWls
ZWRcbiIpOwoJCWV4aXQoMSk7Cgl9CglyZXQgPSB3cml0ZShmZCwgY3RybCwgc3RybGVuKGN0
cmwpKTsKCWNsb3NlKGZkKTsKCWlmIChyZXQgIT0gc3RybGVuKGN0cmwpKSB7CgkJZnByaW50
ZihzdGRlcnIsICJ3cml0ZSgpIGZhaWxlZFxuIik7CgkJZXhpdCgxKTsKCX0KfQoKc3RhdGlj
IHVpbnQ2NF90IHBhZ2VtYXBfZ2V0X2VudHJ5KGludCBmZCwgY2hhciAqc3RhcnQpCnsKCWNv
bnN0IHVuc2lnbmVkIGxvbmcgcGZuID0gKHVuc2lnbmVkIGxvbmcpc3RhcnQgLyBwYWdlc2l6
ZTsKCXVpbnQ2NF90IGVudHJ5OwoJaW50IHJldDsKCglyZXQgPSBwcmVhZChmZCwgJmVudHJ5
LCBzaXplb2YoZW50cnkpLCBwZm4gKiBzaXplb2YoZW50cnkpKTsKCWlmIChyZXQgIT0gc2l6
ZW9mKGVudHJ5KSkgewoJCWZwcmludGYoc3RkZXJyLCAicHJlYWQoKSBmYWlsZWRcbiIpOwoJ
CWV4aXQoMSk7Cgl9CgoJcmV0dXJuIGVudHJ5Owp9CgpzdGF0aWMgYm9vbCBwYWdlbWFwX2lz
X3NvZnRkaXJ0eShpbnQgZmQsIGNoYXIgKnN0YXJ0KQp7Cgl1aW50NjRfdCBlbnRyeSA9IHBh
Z2VtYXBfZ2V0X2VudHJ5KGZkLCBzdGFydCk7CgoJcmV0dXJuIGVudHJ5ICYgMHgwMDgwMDAw
MDAwMDAwMDAwdWxsOwp9Cgp2b2lkIG1haW4odm9pZCkKewoJY2hhciAqbWVtLCAqbWVtMjsK
CglwYWdlc2l6ZSA9IGdldHBhZ2VzaXplKCk7CglwYWdlbWFwX2ZkID0gb3BlbigiL3Byb2Mv
c2VsZi9wYWdlbWFwIiwgT19SRE9OTFkpOwoJaWYgKHBhZ2VtYXBfZmQgPCAwKSB7CgkJZnBy
aW50ZihzdGRlcnIsICJvcGVuKCkgZmFpbGVkXG4iKTsKCQlleGl0KDEpOwoJfQoKCS8qIE1h
cCAyIHBhZ2VzLiAqLwoJbWVtID0gbW1hcCgwLCAyICogcGFnZXNpemUsIFBST1RfUkVBRHxQ
Uk9UX1dSSVRFLAoJCSAgIE1BUF9QUklWQVRFfE1BUF9BTk9OLCAtMSwgMCk7CglpZiAobWVt
ID09IE1BUF9GQUlMRUQpIHsKCQlmcHJpbnRmKHN0ZGVyciwgIm1tYXAoKSBmYWlsZWRcbiIp
OwoJCWV4aXQoMSk7Cgl9CgoJLyogUG9wdWxhdGUgYm90aCBwYWdlcy4gKi8KCW1lbXNldCht
ZW0sIDEsIDIgKiBwYWdlc2l6ZSk7CgoJaWYgKCFwYWdlbWFwX2lzX3NvZnRkaXJ0eShwYWdl
bWFwX2ZkLCBtZW0pKQoJCWZwcmludGYoc3RkZXJyLCAiUGFnZSAjMSBzaG91bGQgYmUgc29m
dGRpcnR5XG4iKTsKCWlmICghcGFnZW1hcF9pc19zb2Z0ZGlydHkocGFnZW1hcF9mZCwgbWVt
ICsgcGFnZXNpemUpKQoJCWZwcmludGYoc3RkZXJyLCAiUGFnZSAjMiBzaG91bGQgYmUgc29m
dGRpcnR5XG4iKTsKCgkvKgoJICogU3RhcnQgc29mdGRpcnR5IHRyYWNraW5nLiBDbGVhciBW
TV9TT0ZURElSVFkgYW5kIGNsZWFyIHRoZSBzb2Z0ZGlydHkKCSAqIFBURSBiaXQuCgkgKi8K
CWNsZWFyX3NvZnRkaXJ0eSgpOwoKCWlmIChwYWdlbWFwX2lzX3NvZnRkaXJ0eShwYWdlbWFw
X2ZkLCBtZW0pKQoJCWZwcmludGYoc3RkZXJyLCAiUGFnZSAjMSBzaG91bGQgbm90IGJlIHNv
ZnRkaXJ0eVxuIik7CglpZiAocGFnZW1hcF9pc19zb2Z0ZGlydHkocGFnZW1hcF9mZCwgbWVt
ICsgcGFnZXNpemUpKQoJCWZwcmludGYoc3RkZXJyLCAiUGFnZSAjMiBzaG91bGQgbm90IGJl
IHNvZnRkaXJ0eVxuIik7CgoJLyoKCSAqIFJlbWFwIHRoZSBzZWNvbmQgcGFnZS4gVGhlIFZN
QSBnZXRzIFZNX1NPRlRESVJUWSBzZXQuIEJvdGggVk1BcwoJICogZ2V0IG1lcmdlZCBzdWNo
IHRoYXQgdGhlIHJlc3VsdGluZyBWTUEgaGFzIFZNX1NPRlRESVJUWSBzZXQuCgkgKi8KCW1l
bTIgPSBtbWFwKG1lbSArIHBhZ2VzaXplLCBwYWdlc2l6ZSwgUFJPVF9SRUFEfFBST1RfV1JJ
VEUsCgkJICAgIE1BUF9QUklWQVRFfE1BUF9BTk9OfE1BUF9GSVhFRCwgLTEsIDApOwoJaWYg
KG1lbTIgPT0gTUFQX0ZBSUxFRCkgewoJCWZwcmludGYoc3RkZXJyLCAibW1hcCgpIGZhaWxl
ZFxuIik7CgkJZXhpdCgxKTsKCX0KCgkvKiBQcm90ZWN0ICsgdW5wcm90ZWN0LiAqLwoJbXBy
b3RlY3QobWVtLCAyICogcGFnZXNpemUsIFBST1RfUkVBRCk7CgltcHJvdGVjdChtZW0sIDIg
KiBwYWdlc2l6ZSwgUFJPVF9SRUFEfFBST1RfV1JJVEUpOwoKCS8qIE1vZGlmeSBib3RoIHBh
Z2VzLiAqLwoJbWVtc2V0KG1lbSwgMiwgMiAqIHBhZ2VzaXplKTsKCglpZiAoIXBhZ2VtYXBf
aXNfc29mdGRpcnR5KHBhZ2VtYXBfZmQsIG1lbSkpCgkJZnByaW50ZihzdGRlcnIsICJQYWdl
ICMxIHNob3VsZCBiZSBzb2Z0ZGlydHlcbiIpOwoJaWYgKCFwYWdlbWFwX2lzX3NvZnRkaXJ0
eShwYWdlbWFwX2ZkLCBtZW0gKyBwYWdlc2l6ZSkpCgkJZnByaW50ZihzdGRlcnIsICJQYWdl
ICMyIHNob3VsZCBiZSBzb2Z0ZGlydHlcbiIpOwp9Cg==

--------------X26NNqKh6qmB3gIBG6DEU1Rl--

