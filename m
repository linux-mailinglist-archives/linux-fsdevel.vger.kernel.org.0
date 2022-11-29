Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7216663BF31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 12:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiK2LkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 06:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiK2LkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:40:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D27167D5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 03:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669721951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRu/Hx0QeU09vI6dag4oeFynexJuKZWNYSe4MiEdyGs=;
        b=DY1pFbkUM1MIGvkYmEzktWFDEJKIDajUf044NWj1aFCx6VfR3SCLfpmRCKjsnEYsub5Awe
        QCfsxMM/j3ywnZurS9Qcb/sD9qqH41O+7AG53X/WBLMdI0vxZSJrISQFnIy14Yy+oxZprj
        M77lSprXFA5jMIqYUDPGM/sCTQWturo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-505-5bTVuSriMMmwmOGhYfF6CQ-1; Tue, 29 Nov 2022 06:39:10 -0500
X-MC-Unique: 5bTVuSriMMmwmOGhYfF6CQ-1
Received: by mail-wm1-f71.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so4620455wme.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 03:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRu/Hx0QeU09vI6dag4oeFynexJuKZWNYSe4MiEdyGs=;
        b=NgPgWIlMFxmtG5HZFljs+ogvCetLVaCPOXZdnUJLMAFBNY0uh8DDm2DKDccRUttW0y
         1xYdYz2xnfYBN3YVA+ve960GhdamC1lzongyKCd1SJaZuNlF2YJhKsh1nJ+oimRKJfFm
         kVz0ekFs+T9PdRiXoODUaRgAAoVLRur0DDxg5t1fgV6jcu0JKIORleZu4q7eM+QcXrP8
         DO5hjXCK+y3sizp5Up9751/lvrtiGxS2PnadYq4zplWaneK2zvUCPjQLTuKwAALO+M8T
         g2sWzk6up55onl6xmSQ+Lt14r5xTlfSrrsQPqkVEjsb0xMI2m0KVhwBZtvtmTLBwo76u
         f1dw==
X-Gm-Message-State: ANoB5pl1p8KfQb8x2QbV7ZlVsgqCm4xizDctiaJVt+Au/pee998tCg65
        iq55/sVKHVNWmUHVnxgLno0SyagRGmSfjdO29tBafu12rGl9aZNXLrdLFFKdB/nOXZnPcrddPlj
        7cXc3ITtMNW6BwEzR1kS4kkfMyA==
X-Received: by 2002:a7b:ca45:0:b0:3c4:bda1:7c57 with SMTP id m5-20020a7bca45000000b003c4bda17c57mr44926211wml.6.1669721948941;
        Tue, 29 Nov 2022 03:39:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6s03pDZ7+AzRjiuWChsKfmd6tu6WfpxK1aogO4cyP+8Olozy3bxlj+8EqBduo9KzTHvAm5sQ==
X-Received: by 2002:a7b:ca45:0:b0:3c4:bda1:7c57 with SMTP id m5-20020a7bca45000000b003c4bda17c57mr44926175wml.6.1669721948661;
        Tue, 29 Nov 2022 03:39:08 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6623.dip0.t-ipconnect.de. [91.12.102.35])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b003d069fc7372sm1471927wmb.1.2022.11.29.03.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 03:39:08 -0800 (PST)
Message-ID: <6d7f7775-5703-c27a-e57b-03aafb4de712@redhat.com>
Date:   Tue, 29 Nov 2022 12:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Roth <michael.roth@amd.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129000632.sz6pobh6p7teouiu@amd.com>
 <20221129112139.usp6dqhbih47qpjl@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129112139.usp6dqhbih47qpjl@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.11.22 12:21, Kirill A. Shutemov wrote:
> On Mon, Nov 28, 2022 at 06:06:32PM -0600, Michael Roth wrote:
>> On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>
>> <snip>
>>
>>> +static struct file *restrictedmem_file_create(struct file *memfd)
>>> +{
>>> +	struct restrictedmem_data *data;
>>> +	struct address_space *mapping;
>>> +	struct inode *inode;
>>> +	struct file *file;
>>> +
>>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>>> +	if (!data)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	data->memfd = memfd;
>>> +	mutex_init(&data->lock);
>>> +	INIT_LIST_HEAD(&data->notifiers);
>>> +
>>> +	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
>>> +	if (IS_ERR(inode)) {
>>> +		kfree(data);
>>> +		return ERR_CAST(inode);
>>> +	}
>>> +
>>> +	inode->i_mode |= S_IFREG;
>>> +	inode->i_op = &restrictedmem_iops;
>>> +	inode->i_mapping->private_data = data;
>>> +
>>> +	file = alloc_file_pseudo(inode, restrictedmem_mnt,
>>> +				 "restrictedmem", O_RDWR,
>>> +				 &restrictedmem_fops);
>>> +	if (IS_ERR(file)) {
>>> +		iput(inode);
>>> +		kfree(data);
>>> +		return ERR_CAST(file);
>>> +	}
>>> +
>>> +	file->f_flags |= O_LARGEFILE;
>>> +
>>> +	mapping = memfd->f_mapping;
>>> +	mapping_set_unevictable(mapping);
>>> +	mapping_set_gfp_mask(mapping,
>>> +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
>>
>> Is this supposed to prevent migration of pages being used for
>> restrictedmem/shmem backend?
> 
> Yes, my bad. I expected it to prevent migration, but it is not true.

Maybe add a comment that these pages are not movable and we don't want 
to place them into movable pageblocks (including CMA and ZONE_MOVABLE). 
That's the primary purpose of the GFP mask here.

-- 
Thanks,

David / dhildenb

