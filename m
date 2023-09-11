Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB779A54C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 10:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjIKIE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 04:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIKIE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C67BB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694419421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrV+UHvgaplY9/k+vBVt5n0teGN9bGsHMMAwUGo1dQ4=;
        b=FbL5rWxUq3SEePjUP3/v6nbZYfKhML0eBZwCJi6aO8N3k+eJwFemmmL6nqeOxAuqBknPQe
        n/zgk5OaMK+wZwxCFLRmxt3SDPORNVlTKOI+nX9A+bztFuiEIiVjmBEUz5pVovcgPRRLVF
        HuWefuSN77EJEdikENSrA5VzLRJRe+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-YKEKIX-vPq6P47ir3pglog-1; Mon, 11 Sep 2023 04:03:39 -0400
X-MC-Unique: YKEKIX-vPq6P47ir3pglog-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so31026945e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 01:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419418; x=1695024218;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrV+UHvgaplY9/k+vBVt5n0teGN9bGsHMMAwUGo1dQ4=;
        b=raUYVG6ouVMw4OGKerE43i/QGROCMIMl3SoIBQb9uPm5tHT+YiKwQm9R5OWoZGwK3B
         e2shGr9VRGSexypTSn0shJZPBbZ2UQORJjHS/0/qnsoQqny9H6jGqcTmakX9CLYampkx
         D0BCnKy11PvTUEXpycIx4uqe/BH7YfPFYLBKmzU0I5c5O88uY0kDFdAJf+7PQe+3iGOT
         DUXoDc/SRdiA4/xwSgiUEBjvr6wa8O7y7oBDx7WdZNLUzc0NTiW5MVNPfAe5WUT7bdC5
         JpdJ6mBcFTtBvRUc2yZIlbB5L0pV66QAmuQ8Eo6gRjfTSKKA2Jzyp1Dx4UNG3sZo4eii
         E/qg==
X-Gm-Message-State: AOJu0YxlhqLGhXU9bQt2v3jyUA8gcIbwLcDoti93MgS1iioat/hJwy5d
        /rNV+6TP19pfylP44q+x+MA6mekNyuZ2ff/DmmMdJPzSsxhkoM5XdbZsjGi89SCXEq+1uAxQvt3
        OqEuo9MIpTiRFtkGsFAHn9yHm8Qb8sz5NcA==
X-Received: by 2002:a7b:cbd7:0:b0:403:bb3:28bf with SMTP id n23-20020a7bcbd7000000b004030bb328bfmr2323545wmi.23.1694419418732;
        Mon, 11 Sep 2023 01:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7EvIVVm6lIu/W9CgMSy8CEDYEwYaFhdi1B8VWOvJfeNjozxmbl+32f4PcpqOmD3Ruy38Uwg==
X-Received: by 2002:a7b:cbd7:0:b0:403:bb3:28bf with SMTP id n23-20020a7bcbd7000000b004030bb328bfmr2323518wmi.23.1694419418297;
        Mon, 11 Sep 2023 01:03:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id r23-20020a05600c321700b00402b9d611d9sm5118569wmp.0.2023.09.11.01.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:03:37 -0700 (PDT)
Message-ID: <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
Date:   Mon, 11 Sep 2023 10:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
In-Reply-To: <20230906073902.4229-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.09.23 09:39, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> a virtual machine may need to accept memory before it can be used.
> 
> Do not map unaccepted memory because it can cause the guest to fail.
> 
> For /proc/vmcore, which is read-only, this means a read or mmap of
> unaccepted memory will return zeros.

Does a second (kdump) kernel that exposes /proc/vmcore reliably get 
access to the information whether memory of the first kernel is 
unaccepted (IOW, not its memory, but the memory of the first kernel it 
is supposed to expose via /proc/vmcore)?

I recall there might be other kdump-related issues for TDX and friends 
to solve. Especially, which information the second kernel gets provided 
by the first kernel.

So can this patch even be tested reasonably (IOW, get into a kdump 
kernel in an environment where the first kernel has unaccepted memory, 
and verify that unaccepted memory is handled accordingly? ... while 
kdump doing anything reasonable in such an environment at all?)

-- 
Cheers,

David / dhildenb

