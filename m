Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31075EA2E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiIZLQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 07:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiIZLPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7E642F9
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664188539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+ZbOYIFXSEJqplhVaiNThrZYYLuxY7C7urbtDbV/sM=;
        b=VXk+ea4x2AkI54yEzrRWyJog0cgrLgys3fny4SF5CScQR4wJF6rbiJ0rOIUMB0Sv9YBaFE
        23rA9Mw/gt79maz1ZzOz/tlxWS3XXlPYdoZ68oXpmhXxAyaAHWHZwFR55VLVJ55j6gSMO/
        0DbOJk/GPgdiOtki40fxST6+YF6BpHM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-kjJQn-TuNG6y4ag_FM5eYw-1; Mon, 26 Sep 2022 06:35:38 -0400
X-MC-Unique: kjJQn-TuNG6y4ag_FM5eYw-1
Received: by mail-wr1-f70.google.com with SMTP id i27-20020adfaadb000000b0022a48b6436dso1026889wrc.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 03:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=L+ZbOYIFXSEJqplhVaiNThrZYYLuxY7C7urbtDbV/sM=;
        b=feLZoxQEElqtsPfGcPpAKc0R9Zg81ByUT4a3RcWPBje+kMWsk/KV+j5Fq/+XSJUb+b
         fNckg0bw4lil4ifLb7F68S1294VqC0yVKa6PFS22ZJsmPhjO9ciAtO2zwsDeAJxUmX3y
         Qv82Qd1eb8NVjxthn6sXESYllSgiHH9E/zFrYNI8xcnh0ucx2YIiFDK6PJoXHJuhiWt5
         bGUSP2113ceLBXhOmn6Q38VQHtKhhBx/MwMEfL0f0roV99JCcH1WdkouSArOlrbpS6lh
         4qSH9MT+cAaCbJwv/jvGegjfqdMuQWBFoECJpd75VNH7mwv/YEez8fTIPPshFXysg8hG
         bdYg==
X-Gm-Message-State: ACrzQf2tjylK29RASjOvnl9567lU7CDLSd8pKp8LNBSzyl33XezXT3kv
        EDhN/mDQ7Z4PsTg4G8fUJwgu7/8/kJPNAM7LVAIoRAXUNZsc91torddFKifg7PrRG8xliZhpBFZ
        pUqzizFte3f65W8L05IurqSo15g==
X-Received: by 2002:a05:6000:1564:b0:226:dece:5630 with SMTP id 4-20020a056000156400b00226dece5630mr13540756wrz.294.1664188537478;
        Mon, 26 Sep 2022 03:35:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5u1Q2JTjA/FqGvI24o/KaCkInpRVUGg48R8VAI4FAuWRKXHrHhWxqHaWiVkWoqmb7Fe69iUg==
X-Received: by 2002:a05:6000:1564:b0:226:dece:5630 with SMTP id 4-20020a056000156400b00226dece5630mr13540729wrz.294.1664188537097;
        Mon, 26 Sep 2022 03:35:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id r64-20020a1c4443000000b003b4935f04a4sm13132198wma.5.2022.09.26.03.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:35:36 -0700 (PDT)
Message-ID: <f703e615-3b75-96a2-fb48-2fefd8a2069b@redhat.com>
Date:   Mon, 26 Sep 2022 12:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <20220923005808.vfltoecttoatgw5o@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220923005808.vfltoecttoatgw5o@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.09.22 02:58, Kirill A . Shutemov wrote:
> On Mon, Sep 19, 2022 at 11:12:46AM +0200, David Hildenbrand wrote:
>>> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
>>> index 6325d1d0e90f..9d066be3d7e8 100644
>>> --- a/include/uapi/linux/magic.h
>>> +++ b/include/uapi/linux/magic.h
>>> @@ -101,5 +101,6 @@
>>>    #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
>>>    #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>>>    #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>>> +#define INACCESSIBLE_MAGIC	0x494e4143	/* "INAC" */
>>
>>
>> [...]
>>
>>> +
>>> +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
>>> +			 int *order)
>>> +{
>>> +	struct inaccessible_data *data = file->f_mapping->private_data;
>>> +	struct file *memfd = data->memfd;
>>> +	struct page *page;
>>> +	int ret;
>>> +
>>> +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	*pfn = page_to_pfn_t(page);
>>> +	*order = thp_order(compound_head(page));
>>> +	SetPageUptodate(page);
>>> +	unlock_page(page);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(inaccessible_get_pfn);
>>> +
>>> +void inaccessible_put_pfn(struct file *file, pfn_t pfn)
>>> +{
>>> +	struct page *page = pfn_t_to_page(pfn);
>>> +
>>> +	if (WARN_ON_ONCE(!page))
>>> +		return;
>>> +
>>> +	put_page(page);
>>> +}
>>> +EXPORT_SYMBOL_GPL(inaccessible_put_pfn);
>>
>> Sorry, I missed your reply regarding get/put interface.
>>
>> https://lore.kernel.org/linux-mm/20220810092532.GD862421@chaop.bj.intel.com/
>>
>> "We have a design assumption that somedays this can even support non-page
>> based backing stores."
>>
>> As long as there is no such user in sight (especially how to get the memfd
>> from even allocating such memory which will require bigger changes), I
>> prefer to keep it simple here and work on pages/folios. No need to
>> over-complicate it for now.
> 
> Sean, Paolo , what is your take on this? Do you have conrete use case of
> pageless backend for the mechanism in sight? Maybe DAX?

The problem I'm having with this is how to actually get such memory into 
the memory backend (that triggers notifiers) and what the semantics are 
at all with memory that is not managed by the buddy.

memfd with fixed PFNs doesn't make too much sense.

When using DAX, what happens with the shared <->private conversion? 
Which "type" is supposed to use dax, which not?

In other word, I'm missing too many details on the bigger picture of how 
this would work at all to see why it makes sense right now to prepare 
for that.

-- 
Thanks,

David / dhildenb

