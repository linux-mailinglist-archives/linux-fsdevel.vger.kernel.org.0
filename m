Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2401179774F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjIGQYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbjIGQWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BD6194;
        Thu,  7 Sep 2023 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694103632; x=1725639632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QrIByt2sivOlThJJJuIm95tWasheU6Saudv9SUBPsTs=;
  b=WjvgFgQXWEPcAc2ETpIDyNS++ukCOrY1L3t9RubhePtbNagh8EdAE6lx
   GRRKzFHul8N+V+s3v+QVeRSSuLCoi5jA+HFi5cLDMOrHfQOYdlQb2i6V0
   frnCN+GVnMoZlg1/nZt95lP0EZaEQZOve2aY8ZM+BEjAsiO2kzEhTslLR
   uah6bcYkWm4PrCMSIkQZiRSQeboNz7uAquj5NOTcXlTgdynyo03Z2Yzaw
   ccWOyFoaGe3Yvp8+5tvUSXqBbQ7gBtO8+5Fc/Rr3Lo6uYUDPk/aUWmOgq
   l8f6sg9BEAcwYz+qFlvopB/k0ARsd7WpbDz7lS4BXc2muNhlxG9VCgAkr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="441379006"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="441379006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="856885283"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="856885283"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:46:55 -0700
Message-ID: <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
Date:   Thu, 7 Sep 2023 07:46:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
 <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
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

On 9/7/23 07:25, Kirill A. Shutemov wrote:
> On Thu, Sep 07, 2023 at 07:15:21AM -0700, Dave Hansen wrote:
>> On 9/6/23 00:39, Adrian Hunter wrote:
>>> Support for unaccepted memory was added recently, refer commit
>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>> a virtual machine may need to accept memory before it can be used.
>>>
>>> Do not map unaccepted memory because it can cause the guest to fail.
>> Doesn't /dev/mem already provide a billion ways for someone to shoot
>> themselves in the foot?  TDX seems to have added the 1,000,000,001st.
>> Is this really worth patching?
> Is it better to let TD die silently? I don't think so.

First, let's take a look at all of the distro kernels that folks will
run under TDX.  Do they have STRICT_DEVMEM set?

> config STRICT_DEVMEM
...
>           If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
>           file only allows userspace access to PCI space and the BIOS code and
>           data regions.  This is sufficient for dosemu and X and all common
>           users of /dev/mem.

Can a line of code in this patch even run in the face of IO_STRICT_DEVMEM=y?

I think basically everybody sets that option and has for over a decade.
If there are any distros out there _not_ setting this, we should
probably have a chat with them to find out more.

I suspect any practical use of this patch is limited to folks who:

1. Compile sensible security-related options out of their kernel
2. Go and reads random pages with /dev/mem in their "secure" VM

They get to hold the pieces, and they can and will get a notification
from their VMM that the VM did something nasty.

BTW, Ubuntu at least also sets HARDENED_USERCOPY which will *also*
enable STRICT_DEVMEM.  So someone would have to _really_ go to some
trouble to shoot themselves in the foot here.  If they're _that_
determined, it would be a shame to thwart their efforts with this patch.
