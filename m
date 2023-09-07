Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1EF797829
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjIGQmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242104AbjIGQl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:41:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B24696;
        Thu,  7 Sep 2023 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102852; x=1725638852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XrtgQdDTZL5BjJSbu5lQThCpM5CmzSeBRvH2o+zR2m0=;
  b=mk60zAzQScQrXQJIKsqyb+wqhd/eLKjMk6oFEKjIdvQs2myScrEASEmX
   jLZu5cuRYt7tOmLqH1DfCPxTBIDGlMYnPDoDIuEt1bBgtv775ALVWdV0g
   18OZ6vOsZRa8rJf3+cmjJMKlhEpQR2vnDPZpEV8EnesUNg9RHyXM2h5NU
   ABroCfDwHlostRzn8GfUOy5Tn8goPVSq2Ctki/rEjy0oxIDO6A6H5bcSi
   yZ09OBQeRPQJ08JmbPMMWfpjRGhPaCYlXV6LEBH1Mk9Ku2WUOJqNeHVaw
   3XWx4C14OoEv+A4hyC1HIjEE1F6zylDTllwrFiz6wsE0xEuWP6tPZUV4j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380029834"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="380029834"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="718649065"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="718649065"
Received: from rbhaumik-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.38])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:06:17 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0691D1042C5; Thu,  7 Sep 2023 13:06:15 +0300 (+03)
Date:   Thu, 7 Sep 2023 13:06:14 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20230907100614.35mxxo63xwkz7ohw@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906073902.4229-4-adrian.hunter@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:39:02AM +0300, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> a virtual machine may need to accept memory before it can be used.
> 
> Do not map unaccepted memory because it can cause the guest to fail.
> 
> For /dev/mem, this means a read of unaccepted memory will return zeros,
> a write to unaccepted memory will be ignored, but an mmap of unaccepted
> memory will return an error.

I am unsure who currently uses /dev/mem. The change to the mmap path has the
potential to cause issues as it is a new behavior. However, it appears to
be a common practice as we also fail to mmap if PAT is set on a page in
the rang. I suppose it is acceptable.

Another option is to accept the memory on mmap, but it seems excessive at
this point.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
