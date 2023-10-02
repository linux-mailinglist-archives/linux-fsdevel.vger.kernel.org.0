Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7097B4CD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjJBHue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjJBHud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08CFC4
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696232983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3pNKxFBUrDFcUW5mxBwAPe/18s1s98AEQ79l0wt2AA=;
        b=Qm9tqKZYABYPRb7sor+tDQnl6L/WGtTQSAzPudhaNhph4w8/WYZ+IFnU2VpsdXnreye4oF
        pCJcAafjCtfUjiwklDp/EFuDg9arhxBC2k29qzqU/ueuOfKb0JiHc9NcUuwvJct5Wspr9D
        q66yzEX3PVybY3+1o6rC7327pUlciG8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-RXA6G4BUPS-ONG-Q6SYtAQ-1; Mon, 02 Oct 2023 03:49:42 -0400
X-MC-Unique: RXA6G4BUPS-ONG-Q6SYtAQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32480c0ad52so3614655f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 00:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232981; x=1696837781;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3pNKxFBUrDFcUW5mxBwAPe/18s1s98AEQ79l0wt2AA=;
        b=u74i+1Bx75AJrGWFeQZ21mYkXx08/g2cOHLzFC8GKYT5gV4PIuhwUg8NuXQjOpOrvF
         tZOp7FzQu6KfuvS3+ngqLuqkKfRccF+Q6uldX6Um4Hsk1+SBRp41Jbjeb3gShnAyv7OY
         PKmN7GuaHV+5aeXLWIXDz+rlysFKN3Bq8sWE9bac91TADL2haQu4/qqQA2rNwyC3Vp8S
         f2umxXF6eOPDAqwUYEs5S8b5Ar4DxIDpwKQgWpma+c9/6FT/4cd2bAbSytBHneuBhPdq
         YTpowkpOTs1bfI1CGhul0xYb8/8yJ752qyXJElFtb0560KerqSIzAs1Ao+qPQGzVAMML
         6ODA==
X-Gm-Message-State: AOJu0YwpPBBPKVTswdxjZZNflxIZ7Wu6GEqIRkaKfx97TV82/EF9vxg/
        KGnU/3elCNrDcK6aMVotWheK2eG+2ZyOCjBLXpU8nerDODHy8h2KDz0EAi/XxU6N1m3kdTv641q
        ObkUsSykf17hQsC/DzLQ2mrEIuw==
X-Received: by 2002:adf:cd0a:0:b0:31f:f982:5395 with SMTP id w10-20020adfcd0a000000b0031ff9825395mr10301912wrm.35.1696232981320;
        Mon, 02 Oct 2023 00:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLBiLwKVSTk/G8HcTeWj03aHPuB2YTlSJwfNO0ffMI/phA6rHC95xmGQ2ps9Gau1Kj+UL4rw==
X-Received: by 2002:adf:cd0a:0:b0:31f:f982:5395 with SMTP id w10-20020adfcd0a000000b0031ff9825395mr10301886wrm.35.1696232980873;
        Mon, 02 Oct 2023 00:49:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id s5-20020adf9785000000b003232380ffd7sm19386758wrb.102.2023.10.02.00.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:49:40 -0700 (PDT)
Message-ID: <56c63536-3947-49b3-d271-6092e50474ec@redhat.com>
Date:   Mon, 2 Oct 2023 09:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
 <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com> <ZRXNVGI73SfX1lu4@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZRXNVGI73SfX1lu4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.09.23 21:00, Peter Xu wrote:
> On Thu, Sep 28, 2023 at 07:15:13PM +0200, David Hildenbrand wrote:
>> There are some interesting questions to ask here:
>>
>> 1) What happens if the old VMA has VM_SOFTDIRTY set but the new one not? You
>> most probably have to mark the PTE softdirty and not make it writable.
> 
> I don't know whether anyone would care about soft-dirty used with uffd
> remap, but if to think about it..
> 
> Logically if the dst vma has !SOFTDIRTY (means, soft-dirty tracking
> enabled), then IIUC the right thing to do is to assume this page is
> modified, hence mark softdirty and perhaps proceed with other checks (where
> write bit can be set if all check pass)?

I think so, yes.

> 
> Because from a soft-dirty monitor POV on dst_vma I see this REMAP the same
> as writting data onto the missing page and got a page fault
> (e.g. UFFDIO_COPY); we just avoided the allocation and copy.
> 
> The src vma seems also fine in this regard: soft-dirty should ignore holes
> always anyway (e.g. DONTNEED on a page should report !soft-dirty later even
> if tracking).

Sounds good to me.

> 
>>
>> 2) VM_UFFD_WP requires similar care I assume? Peter might know.
> 
> UFFD_WP shouldn't be affected, iiuc.
> 
> Let's first discuss dst vma side.
> 
> WP_UNPOPULATED made it slightly complicated but not so much.  The core
> should be that REMAP only installs pages if it's exactly pte_none():
> 
> +       if (!pte_none(orig_dst_pte)) {
> +               err = -EEXIST;
> +               goto out;
> +       }
> 
> Then it already covers things like pte markers, and any marker currently
> will fail the REMAP ioctl already.  May not be always wanted, but no risk
> of losing wp notifications.  If that'll be a valid use case we can work it
> out.

Agreed.

> 
> On src vma, REMAP ioctl should behave the same as DONTNEED.  Now we drop
> the src pte along with the uffd-wp bit even if set, which is the correct
> behavior from that regard.
> 
> Again, I don't know whether anyone cares on any of those, though..

If it's easy to handle, we should just handle it or instead spell it out 
why we believe we can break other features. Seems to be very easy to handle.

-- 
Cheers,

David / dhildenb

