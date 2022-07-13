Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22F57383F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiGMOBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiGMOB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48F1B2E6BB
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657720865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KGqf/qeI+POrrn3TKUE5pxqC/C4LValvbrjKc6vdrc=;
        b=g/6oEjlQ10PkM5jQ/YdB/mEuYgVja8C/AvexVUI0JWLfuxG8xRGFKYBFwf//R3aDffDh8C
        Kw5lbUZWrybbZ0kNiRk95HE1t1S+ISnGPSSzUT2W3NY64Ss9ISi3TLSag3p9J0nzsiYNXb
        J/2UEcbUFYKylvAD8g614dAwlofGJH4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-r9EG3LqRNQ6-qdyk54BWTQ-1; Wed, 13 Jul 2022 10:01:03 -0400
X-MC-Unique: r9EG3LqRNQ6-qdyk54BWTQ-1
Received: by mail-ed1-f72.google.com with SMTP id w13-20020a05640234cd00b0043a991fb3f3so8426498edc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 07:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=9KGqf/qeI+POrrn3TKUE5pxqC/C4LValvbrjKc6vdrc=;
        b=vy1/nCBMcBZ3MuAZHNkzhn3buV4neJAAs/JDliyj057xchSv86qQbCTNbZHMHmY6qm
         JgSh/jxNJd8+RYSG7Vo+3wS11/WJ9J67twz3APhb5RczjghFLMSd4jR8M0liejF247hf
         QoJtXGPXPMy0IkowPqHXSPcJK2MfPqbEzYIS7mMZeusoANBXvZrzLsestywRUgoDt5u6
         i4UyFjNtWZSDtXJBAgarORklFUUZTPtkwZQO6G+f7iD4tKNEBTl67m3oMXVMhroM6LVi
         aZRpKyMdT1Q1EsmQIPKmopx2BqU6X3r805uzMTOIXqfGw5Be7UT0NpGJw+FxL+M6yG/D
         YCeQ==
X-Gm-Message-State: AJIora+V0OY5DWpWC5ZujCj0fWegLyR8XqLr6owFEm47yP8ChBMJHRWL
        pCxksXOpD5VpI0eT4m6cDkTF9MiRLDKIGXszORm2bUtp+ToqZPJT+nHBl3hFtAkOGmJJCxaX3Zd
        dTSyt/CAv6XfqKcISgPmQtwyAOQ==
X-Received: by 2002:a05:6402:194d:b0:43a:82da:b0f3 with SMTP id f13-20020a056402194d00b0043a82dab0f3mr5153376edz.104.1657720862046;
        Wed, 13 Jul 2022 07:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tfg+NQpq62PNkTi+9zGICpZjxIA1/V35s1b3D7GuzEpMEmnElvJd01BSGXkYV7V6mf4wtNGg==
X-Received: by 2002:a05:6402:194d:b0:43a:82da:b0f3 with SMTP id f13-20020a056402194d00b0043a82dab0f3mr5153326edz.104.1657720861765;
        Wed, 13 Jul 2022 07:01:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5800:5009:e8d0:d95e:544d? (p200300cbc70758005009e8d0d95e544d.dip0.t-ipconnect.de. [2003:cb:c707:5800:5009:e8d0:d95e:544d])
        by smtp.gmail.com with ESMTPSA id e2-20020a056402088200b0042dcbc3f302sm7975139edy.36.2022.07.13.07.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 07:01:01 -0700 (PDT)
Message-ID: <397f3cb2-1351-afcf-cd87-e8f9fb482059@redhat.com>
Date:   Wed, 13 Jul 2022 16:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     willy@infradead.org, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        21cnbao@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
 <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
 <357da99d-d096-a790-31d7-ee477e37c705@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
In-Reply-To: <357da99d-d096-a790-31d7-ee477e37c705@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.07.22 21:36, Khalid Aziz wrote:
> On 7/8/22 05:47, David Hildenbrand wrote:
>> On 02.07.22 06:24, Andrew Morton wrote:
>>> On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>
>>>> This patch series implements a mechanism in kernel to allow
>>>> userspace processes to opt into sharing PTEs. It adds a new
>>>> in-memory filesystem - msharefs.
>>>
>>> Dumb question: why do we need a new filesystem for this?  Is it not
>>> feasible to permit PTE sharing for mmaps of tmpfs/xfs/ext4/etc files?
>>>
>>
>> IIRC, the general opinion at LSF/MM was that this approach at hand is
>> makes people nervous and I at least am not convinced that we really want
>> to have this upstream.
> 
> Hi David,

Hi Khalid,

> 
> You are right that sharing page tables across processes feels scary, but at the same time threads already share PTEs and 
> this just extends that concept to processes.

They share a *mm* including a consistent virtual memory layout (VMA
list). Page table sharing is just a side product of that. You could even
call page tables just an implementation detail to produce that
consistent virtual memory layout -- described for that MM via a
different data structure.

> A number of people have commented on potential usefulness of this concept 
> and implementation.

... and a lot of people raised concerns. Yes, page table sharing to
reduce memory consumption/tlb misses/... is something reasonable to
have. But that doesn't require mshare, as hugetlb has proven.

The design might be useful for a handful of corner (!) cases, but as the
cover letter only talks about memory consumption of page tables, I'll
not care about those. Once these corner cases are explained and deemed
important, we might want to think of possible alternatives to explore
the solution space.

> There were concerns raised about being able to make this safe and reliable.
> I had agreed to send a 
> second version of the patch incorporating feedback from last review and LSF/MM, and that is what v2 patch is about. The 

Okay, most of the changes I saw are related to the user interface, not
to any of the actual dirty implementation-detail concerns. And the cover
letter is not really clear what's actually happening under the hood and
what the (IMHO) weird semantics of the design imply (as can be seen from
Andrews reply).

> suggestion to extend hugetlb PMD sharing was discussed briefly. Conclusion from that discussion and earlier discussion 
> on mailing list was hugetlb PMD sharing is built with special case code in too many places in the kernel and it is 
> better to replace it with something more general purpose than build even more on it. Mike can correct me if I got that 
> wrong.

Yes, I pushed for the removal of that yet-another-hugetlb-special-stuff,
and asked the honest question if we can just remove it and replace it by
something generic in the future. And as I learned, we most probably
cannot rip that out without affecting existing user space. Even
replacing it by mshare() would degrade existing user space.

So the natural thing to reduce page table consumption (again, what this
cover letter talks about) for user space (semi- ?)automatically for
MAP_SHARED files is to factor out what hugetlb has, and teach generic MM
code to cache and reuse page tables (PTE and PMD tables should be
sufficient) where suitable.

For reasonably aligned mappings and mapping sizes, it shouldn't be too
hard (I know, locking ...), to cache and reuse page tables attached to
files -- similar to what hugetlb does, just in a generic way. We might
want a mechanism to enable/disable this for specific processes and/or
VMAs, but these are minor details.

And that could come for free for existing user space, because page
tables, and how they are handled, would just be an implementation detail.


I'd be really interested into what the major roadblocks/downsides
file-based page table sharing has. Because I am not convinced that a
mechanism like mshare() -- that has to be explicitly implemented+used by
user space -- is required for that.

-- 
Thanks,

David / dhildenb

