Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B4797B14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbjIGSCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbjIGSB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:01:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A16170C;
        Thu,  7 Sep 2023 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109700; x=1725645700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fFdJWlOfOQFNWE/wQ1sARfEDpEEqtJd3bE+CeaqxZ+s=;
  b=i67LFL18l3seX2OcweH4aewbX8SBcqeifMMiMOmveyMaA+lfEtrO0Cr7
   Y8ksE4t5DmkPaEIbemG1w95Kx1zOZl32L8oZJ2X73Miw0aMgnh7icdhv5
   XpmubasZvnDAZcAXyzeVlv7ijAJK5tcx3f0vMdr5i8GXzOGmNlu2XqyOJ
   uZ7QvIDPgJ1STBEY2wwuwdHNceJHqMlFy/2IeXKaQ0mNHn9xW9RtkBGq1
   OgzI58x3MjqOA/vQx48wvoeLYw53p5u1wCFyt+3rI5NaLztuzLj0V3IVm
   nvMrJgM771gQih1C1SHu5jYv1Zjpe3Xk8J+dMQM/2znYdX17n9VsK84/E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="443807581"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="443807581"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="988818775"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="988818775"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.181])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:44:11 -0700
Message-ID: <30d0cebb-13f9-572e-9baa-b7450fec9108@intel.com>
Date:   Thu, 7 Sep 2023 18:44:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
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
 <21bf2e44-3316-2372-44cb-1488f88650f5@intel.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <21bf2e44-3316-2372-44cb-1488f88650f5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/09/23 18:39, Dave Hansen wrote:
> On 9/6/23 00:39, Adrian Hunter wrote:
>> @@ -559,7 +567,8 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
>>  	 * pages without a reason.
>>  	 */
>>  	idx = srcu_read_lock(&vmcore_cb_srcu);
>> -	if (!list_empty(&vmcore_cb_list))
>> +	if (!list_empty(&vmcore_cb_list) ||
>> +	    range_contains_unaccepted_memory(paddr, paddr + size))
>>  		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
>>  	else
>>  		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);
> 
> The whole callback mechanism which fs/proc/vmcore.c::pfn_is_ram()
> implements seems to be in place to ensure that there aren't a billion
> different "ram" checks in here.
> 
> Is there a reason you can't register_vmcore_cb() a callback to check for
> unaccepted memory?

Someone asked for the change to be in arch-independent code... ;-)

