Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B909770769
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHDSBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjHDSBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107AE46BD
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691172031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plknfH3SDQ/AujyL8eWFqeOy7h7VD7A1dUfZFnOOKDM=;
        b=WleMOlCiA9fEGrBu8XtpTlTUrdZVCU7GibyEzku5Npwg2zxSgIaKX9qHsS3dmDkeY2poBy
        8spRhZcFBzRUmCzzJu9x/PhPZucCFquFIjhQXUNvW/Ead5gaXG/y2OwUAH4S6xphz3RnfO
        BQltXk9GLdQfpNE/AMYrFPyyLk65SCI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-XRJK_870O5uouZCooGGLMA-1; Fri, 04 Aug 2023 14:00:29 -0400
X-MC-Unique: XRJK_870O5uouZCooGGLMA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso1182561f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 11:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691172028; x=1691776828;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plknfH3SDQ/AujyL8eWFqeOy7h7VD7A1dUfZFnOOKDM=;
        b=k6E7ghunTx3J1IsRhPHoTSRPkXUpq6OsYyK44qpbS0TDfmvbSbEdufo+e6xFq1IUd1
         uYiI24LiU3QVs0YDKs0OCEAAbz8zyemAu5jtpFoXGMh04KMi629G4zvHV5cfxpRgc00/
         0MuFyPqgSEl3evYimX6W99XaaUtnNzhUr0ldC3HlExmT9TC6ZI2XSLdYDh4LwJovdbeR
         kZ58LvITS8vCsS5S/MqJwIqElxbKBRBmJjeSSe8uJepB2iNoNlhligJroUnXN6oqvVYl
         WFiHDOTHjxla8c8ZYpY7bc5DAQWcvZbSVVZ0NENqFObWvk/B0/8GLfZ/OF9A76AC4jEF
         ZJtg==
X-Gm-Message-State: AOJu0YyVIL8o3fXJ6yARdGZj+CwfmwSnxiqjx65tt3UH/pwoGpvzpJyV
        66akMee1LOL14keloahZL9o+pVwiIamGV35HBKTQDJSQnXXd6Pd548twKny96BJmJKrkSLxZ0VQ
        HPkC3aKgF8IPOMJgbpWsPDEwMEA==
X-Received: by 2002:adf:e90b:0:b0:314:49e4:b0c4 with SMTP id f11-20020adfe90b000000b0031449e4b0c4mr1906970wrm.70.1691172028376;
        Fri, 04 Aug 2023 11:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxHfzUz1EPw43upa/7C1PthJlkuVCBp6Z+blRveCGIYkYDQyDnvZ5j7WD7RCluzgxUr1F+kA==
X-Received: by 2002:adf:e90b:0:b0:314:49e4:b0c4 with SMTP id f11-20020adfe90b000000b0031449e4b0c4mr1906951wrm.70.1691172027948;
        Fri, 04 Aug 2023 11:00:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806? (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de. [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000008f00b0031417b0d338sm3082057wrx.87.2023.08.04.11.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 11:00:27 -0700 (PDT)
Message-ID: <dff76f35-8564-1908-2a17-1479c53e56cf@redhat.com>
Date:   Fri, 4 Aug 2023 20:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 7/7] selftest/mm: ksm_functional_tests: Add PROT_NONE
 test
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230803143208.383663-1-david@redhat.com>
 <20230803143208.383663-8-david@redhat.com> <ZMv6wG7PqehMp6vT@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMv6wG7PqehMp6vT@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.08.23 21:06, Peter Xu wrote:
> On Thu, Aug 03, 2023 at 04:32:08PM +0200, David Hildenbrand wrote:
>> Let's test whether merging and unmerging in PROT_NONE areas works as
>> expected.
>>
>> Pass a page protection to mmap_and_merge_range(), which will trigger
>> an mprotect() after writing to the pages, but before enabling merging.
>>
>> Make sure that unsharing works as expected, by performing a ptrace write
>> (using /proc/self/mem) and by setting MADV_UNMERGEABLE.
>>
>> Note that this implicitly tests that ptrace writes in an inaccessible
>> (PROT_NONE) mapping work as expected.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> [...]
> 
>> +static void test_prot_none(void)
>> +{
>> +	const unsigned int size = 2 * MiB;
>> +	char *map;
>> +	int i;
>> +
>> +	ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +	map = mmap_and_merge_range(0x11, size, PROT_NONE, false);
>> +	if (map == MAP_FAILED)
>> +		goto unmap;
>> +
>> +	/* Store a unique value in each page on one half using ptrace */
>> +	for (i = 0; i < size / 2; i += pagesize) {
>> +		lseek(mem_fd, (uintptr_t) map + i, SEEK_SET);
>> +		if (write(mem_fd, &i, sizeof(size)) != sizeof(size)) {
> 
> sizeof(i)?  May not matter a huge lot, though..

Oh, indeed, thanks!

> 
>> +			ksft_test_result_fail("ptrace write failed\n");
>> +			goto unmap;
>> +		}
>> +	}
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 

Thanks!

-- 
Cheers,

David / dhildenb

