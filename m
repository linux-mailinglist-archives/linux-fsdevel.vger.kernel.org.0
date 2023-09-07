Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DF79748D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjIGPjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbjIGPaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE0E45;
        Thu,  7 Sep 2023 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100594; x=1725636594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLkgQjdozZeu2blgME5D5x7Y7mxXeqbdwxTIXoD6yOY=;
  b=HuSt7vXerTav1SVECOWGjx1WQRHwY9vXDokWeDddzmvx+oHdvYunDkfq
   06De1hnvJOtDkeogmC3UpNLeVWXQ93UgNxkprqjUftfwgYuFMSGQWKTF4
   oszRYEK00qtQC1tW1B6TZuHbH87dC8NqEBV0y1+jspLMJO1kODwQMHs4H
   kk269B8v6woEI4yNRzx0zDC6DDYZVhCJ74eHVF5FWtj0KNTJn42FPaczt
   G3qZ47kzD4KOY+5fUr3fm0DIa/OR1nwtFqmP6SLqCqP8gtAhGG0oxcsvG
   69RT9msT9uZo8zA6QuVsb/18Faa1jFIyBuWCvqzpifYrg4/34s3k4j4VV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357679642"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="357679642"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735520927"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735520927"
Received: from oshragax-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.215.248])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:25:14 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7882D104860; Thu,  7 Sep 2023 17:25:10 +0300 (+03)
Date:   Thu, 7 Sep 2023 17:25:10 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Message-ID: <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 07:15:21AM -0700, Dave Hansen wrote:
> On 9/6/23 00:39, Adrian Hunter wrote:
> > Support for unaccepted memory was added recently, refer commit
> > dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> > a virtual machine may need to accept memory before it can be used.
> > 
> > Do not map unaccepted memory because it can cause the guest to fail.
> 
> Doesn't /dev/mem already provide a billion ways for someone to shoot
> themselves in the foot?  TDX seems to have added the 1,000,000,001st.
> Is this really worth patching?

Is it better to let TD die silently? I don't think so.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
