Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7586573C52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGMSD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiGMSDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A35EC13F58
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657735433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qq4rbqh9j9QqFNAu6orBc1kOpVtgKyUJMzBlJDFOspE=;
        b=P0cKUIH5Vnd1Z1GIqWy5vKjx7Uu2O1XHvDRl0pqCcMQTJEuHfITGnjWXdrbZEgJuTmPc8U
        VYyqYPkzUhCCDjxYwQFUQ8pk28iVfVIJt5QK9BUFT6SZg+Xpjg/kAewlD5HEqyN7mEOqFT
        HEOe5/0kG+cPZ1PEVe8jglVAVyTD4so=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-_0vzs7iSPq2Kq5Pj63Fcvw-1; Wed, 13 Jul 2022 14:03:52 -0400
X-MC-Unique: _0vzs7iSPq2Kq5Pj63Fcvw-1
Received: by mail-wm1-f72.google.com with SMTP id 23-20020a05600c229700b003a2eda0c59cso1174336wmf.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 11:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qq4rbqh9j9QqFNAu6orBc1kOpVtgKyUJMzBlJDFOspE=;
        b=EZFj2lAeyoUWZwLpp93/VhJBPfVVlVQEqgvFsYsJlTzHlPv7ddoyj6p2y+7VL/n6k8
         FVe8gPdx3Fu4I3O72c6OxrZ7FufZGEamx6fIn5xa6HGNBGJU2a90P3IaNXC+ZB9OPk/F
         fEMmbGwus9wTiLF9pCBAXFC7Alp2+bIAFCehjheDksgtHM4cDE8uAHAWzqAYalad5QoH
         I8YyCZW1nlp00wCUbY9hrdGKHMsGRCpfd34ha615lDEHfdbV514C492mmQ/HZstxZaBi
         ZNg2/5phHIM1Lt02NHxHTCbirFT9iB4T8pB5ZTU9QAZtqBXJv+z8ocPqo7KfMYYurUxd
         1OfQ==
X-Gm-Message-State: AJIora+CgRiwhhH9dBafqXMyE6SQb8i0+HFBplBF3bDXF/SNhzHxyI0Y
        ZLRvGxRqBz0vSF0B5CaacZF+AUvJbzS+4Bzje389Dk0qmjN4QDeERi+edcQbP/WZvzH32SJyKoI
        V5FZOA3e1RYreVLNmD8x4TkN/2w==
X-Received: by 2002:a5d:638e:0:b0:21d:68bc:17c8 with SMTP id p14-20020a5d638e000000b0021d68bc17c8mr4515511wru.467.1657735431035;
        Wed, 13 Jul 2022 11:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uWxDrVrEZx/YPI60k7+IxR4NpRPIkwimgG3BIPzBmrjO/IHk6FPykEeu5eTFieuTO477OAQA==
X-Received: by 2002:a5d:638e:0:b0:21d:68bc:17c8 with SMTP id p14-20020a5d638e000000b0021d68bc17c8mr4515473wru.467.1657735430779;
        Wed, 13 Jul 2022 11:03:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5800:5009:e8d0:d95e:544d? (p200300cbc70758005009e8d0d95e544d.dip0.t-ipconnect.de. [2003:cb:c707:5800:5009:e8d0:d95e:544d])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0021d888e1132sm11593492wru.43.2022.07.13.11.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 11:03:50 -0700 (PDT)
Message-ID: <e3574f08-74fc-cf63-3c4f-3d90ae68ba49@redhat.com>
Date:   Wed, 13 Jul 2022 20:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, keescook@chromium.org,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, longpeng2@huawei.com, luto@kernel.org,
        markhemm@googlemail.com, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de, surenb@google.com,
        tst@schoebel-theuer.de, yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
 <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
 <357da99d-d096-a790-31d7-ee477e37c705@oracle.com>
 <397f3cb2-1351-afcf-cd87-e8f9fb482059@redhat.com> <Ys8HrW+52EwQbeh8@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ys8HrW+52EwQbeh8@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.07.22 19:58, Mike Kravetz wrote:
> On 07/13/22 16:00, David Hildenbrand wrote:
>> On 08.07.22 21:36, Khalid Aziz wrote:
>>> On 7/8/22 05:47, David Hildenbrand wrote:
>>>> On 02.07.22 06:24, Andrew Morton wrote:
>>>>> On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>>> suggestion to extend hugetlb PMD sharing was discussed briefly. Conclusion from that discussion and earlier discussion 
>>> on mailing list was hugetlb PMD sharing is built with special case code in too many places in the kernel and it is 
>>> better to replace it with something more general purpose than build even more on it. Mike can correct me if I got that 
>>> wrong.
>>
>> Yes, I pushed for the removal of that yet-another-hugetlb-special-stuff,
>> and asked the honest question if we can just remove it and replace it by
>> something generic in the future. And as I learned, we most probably
>> cannot rip that out without affecting existing user space. Even
>> replacing it by mshare() would degrade existing user space.
>>
>> So the natural thing to reduce page table consumption (again, what this
>> cover letter talks about) for user space (semi- ?)automatically for
>> MAP_SHARED files is to factor out what hugetlb has, and teach generic MM
>> code to cache and reuse page tables (PTE and PMD tables should be
>> sufficient) where suitable.
>>
>> For reasonably aligned mappings and mapping sizes, it shouldn't be too
>> hard (I know, locking ...), to cache and reuse page tables attached to
>> files -- similar to what hugetlb does, just in a generic way. We might
>> want a mechanism to enable/disable this for specific processes and/or
>> VMAs, but these are minor details.
>>
>> And that could come for free for existing user space, because page
>> tables, and how they are handled, would just be an implementation detail.
>>
>>
>> I'd be really interested into what the major roadblocks/downsides
>> file-based page table sharing has. Because I am not convinced that a
>> mechanism like mshare() -- that has to be explicitly implemented+used by
>> user space -- is required for that.
> 
> Perhaps this is an 'opportunity' for me to write up in detail how
> hugetlb pmd sharing works.  As you know, I have been struggling with
> keeping that working AND safe AND performant. 

Yes, and I have your locking-related changes in my inbox marked as "to
be reviewed" :D Sheding some light on that would be highly appreciated,
especially, how hugetlb-specific it currently is and for which reason.

-- 
Thanks,

David / dhildenb

