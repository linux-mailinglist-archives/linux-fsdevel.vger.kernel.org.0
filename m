Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF826E4B5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDQOVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDQOVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FD1B0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681741257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXXWTVEI1mMsVSpGycpPWe1J+aRrdeZCdqy7/mR/vH0=;
        b=Mbe9gMqv3KDIjrZYVgpGaok4s3fIhIVlR8W8qEkToGyFMP2DDwIU+vDkJBhAn0gn0jZJuZ
        lLtoPIRqbCFjGKpAhZjbjoEhqeffP/gLfx/CkdnsI6ZIC49TaIndxSMrDea4hGz4FiuoED
        f7wHMGfKJIBTn6kq4X9+1kEyyDa2R3c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-p22VNDBIPO6cDuI96qbguw-1; Mon, 17 Apr 2023 10:20:56 -0400
X-MC-Unique: p22VNDBIPO6cDuI96qbguw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f92bd71f32so314416f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 07:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681741255; x=1684333255;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXXWTVEI1mMsVSpGycpPWe1J+aRrdeZCdqy7/mR/vH0=;
        b=ZuIO6sAUKwA2aBYo2opQ7vPID6b5c3G24VDkUiBknui5EbaVd/3poUvnL4ezC/BLEN
         uM0hOTSTfoBZtfv0BuNMpMU8/tdBxFS8eyfv5H7aSB14gS+iezEt3sBGD1ZY1d58fA5S
         un+uERKZ7/Wx6vW7zjiAQsZOl0xa5GsaVU6cynreeNgrVSeu66ccJGAhMCTP1Uo5vbRQ
         PFSj7ij+klExPL+7bDCn3ud4b2eYzoXC2T96VDzju6AMSesUgth+B2HIjhOlgf+wAP9f
         nSUELGelMDzZtUvobwp+Xv1HAvCiSr/pWr+zlhWhu6nxNexYwe96trpfniTdxUChTjXJ
         1jrQ==
X-Gm-Message-State: AAQBX9cys1vNcQtr0bCZqRUSLvVfDxRT1ZOZmh4g8uCyKLqvvirfjW0e
        PlZMMBEp3aQfvScS3OBTLlm90jD1Of0rIEIwJg17i9DslEB5ubzALv7UQ8379eOH4qN/+Lk8IhV
        Orm7Jw1qnNJkvbx5nerHVAson5Q==
X-Received: by 2002:a5d:5248:0:b0:2f9:a75:b854 with SMTP id k8-20020a5d5248000000b002f90a75b854mr3792096wrc.59.1681741254928;
        Mon, 17 Apr 2023 07:20:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350boMM0zmEGTfFZFjlk6c0N1TW//CLM7LqCyngTtQr2+J07kOHHTQAknS4PxsNoOPWRVKQQvfg==
X-Received: by 2002:a5d:5248:0:b0:2f9:a75:b854 with SMTP id k8-20020a5d5248000000b002f90a75b854mr3792081wrc.59.1681741254560;
        Mon, 17 Apr 2023 07:20:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c00cd00b003edf2dc7ca3sm12016562wmm.34.2023.04.17.07.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:20:53 -0700 (PDT)
Message-ID: <b37d1876-0a74-aa52-7911-e6f78280caaa@redhat.com>
Date:   Mon, 17 Apr 2023 16:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>, Zi Yan <zi.yan@sent.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230403201839.4097845-1-zi.yan@sent.com>
 <20230404144727.e613116684dbd65a4b4745c1@linux-foundation.org>
 <49ee481e-452f-61c7-2da5-28de2cf3de2@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <49ee481e-452f-61c7-2da5-28de2cf3de2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.04.23 20:11, Hugh Dickins wrote:
> On Tue, 4 Apr 2023, Andrew Morton wrote:
>> On Mon,  3 Apr 2023 16:18:32 -0400 Zi Yan <zi.yan@sent.com> wrote:
>>
>>> File folio supports any order and people would like to support flexible orders
>>> for anonymous folio[1] too. Currently, split_huge_page() only splits a huge
>>> page to order-0 pages, but splitting to orders higher than 0 is also useful.
>>> This patchset adds support for splitting a huge page to any lower order pages
>>> and uses it during file folio truncate operations.
>>
>> This series (and its v1 & v2) don't appear to have much in the way of
>> detailed review.  As it's at v3 and has been fairly stable I'll queue
>> it up for some testing now, but I do ask that some reviewers go through
>> it please.
> 
> Andrew, please don't let this series drift into 6.4-rc1.
> 
> I've seen a bug or two (I'll point out in response to those patches),
> but overall I don't see what the justification for the series is: done
> because it could be done, it seems to me, but liable to add surprises.
> 
> The cover letter says "splitting to orders higher than 0 is also useful",
> but it's not clear why; and the infrastructure provided seems unsuited
> to the one use provided - I'll say more on that truncation patch.

I agree. Maybe this patch set is something we want to have in the future 
once actual consumers that can benefit are in place, such that we can 
show actual performance numbers with/without.

Until then, "365 insertions(+), 68 deletions(-)" certainly needs some 
reasonable motivation.

-- 
Thanks,

David / dhildenb

