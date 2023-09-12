Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE179C882
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjILHsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjILHsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:48:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5122E73;
        Tue, 12 Sep 2023 00:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694504879; x=1726040879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=myILytDdutAkJHoVsjGJrHjJI0XRaM5nA9tqDHz8FOQ=;
  b=BRsrZzgwiMKZTkvrgrCGhPincsWUsGdarkRTiUcBK2aExbWudOuW8yrc
   SWYr2RstRa/XyLcivhmZe30gUWfauyFIF6oUPWdyqoX71tzahL7eUdgd6
   iny/Rjssqlf3KO6RAZKvq2LCIxZV0kGtIjf0NyqxPDo+PpAjRvale1vyP
   64NDT+WQ4RNvAK/4aGY7vDlSYYbIcKyR74pbl/fQKPIbgBeXnKuLHBguU
   M6y7SjkXQCNxVkuvcZu0C9E9EzPGz/9IH3EVdRw1GoOOb0K1UGuXcGEAL
   GtT1RZ/jbsgqHmgyPZBBqRtwBuTUQmZSkZsWv/2rUXM0r0x55aWgfFRgT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444742371"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="444742371"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867283368"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="867283368"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.45.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:47:53 -0700
Message-ID: <1c736ca3-36e2-3225-2f98-e51149c468ef@intel.com>
Date:   Tue, 12 Sep 2023 10:47:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
 <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/09/23 10:19, David Hildenbrand wrote:
> On 11.09.23 13:21, Adrian Hunter wrote:
>> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
>> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
>> need to accept memory before it can be used.
>>
>> Do not let /proc/vmcore try to access unaccepted memory because it can
>> cause the guest to fail.
> 
> Oh, hold on. What are the actual side effects of this?
> 
> Once we're in the kdump kernel, any guest is already dead. So failing a guest doesn't apply, no?
> 
Unaccepted Memory is used by virtual machines.  In this case the guest
has kexec'ed to a dump-capture kernel, so the virtual machine is still
alive and running the dump-capture kernel.

