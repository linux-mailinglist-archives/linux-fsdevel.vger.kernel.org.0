Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D340797AF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbjIGR6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbjIGR6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B81FEA;
        Thu,  7 Sep 2023 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109481; x=1725645481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vslREB8ROsaiDtOyMM59OVIoUOD6oP12DWv5XlYD9Hw=;
  b=M0VE7YQC25Ks1mypgyD1WmpSak9G4ioignoFyuOs812B9QYxp/3V88OY
   Tfg3XWyI8cYHTm1ThqcMDPK6TBsskx5tFJA3BVFzMNh1qUra8SCEDbjwF
   NnaRJ2JK8a2reDgLVf0ZoLKQc0QvvMvCvDFfMjvP8zQVWER8XLH5wdp6v
   b9KO0a2e1YIwi98vk33qghlDyR4wsePcEVjxi6gXFR86BTiWylcHag7Uj
   qOpCPKImmSVO1McYlww5DL/8CljYfsMz8t1Z5nGAwTYFH/cJ7L0zJmohR
   fTeSYDY2gCnnfLPfDG39zphSm5nxHniNHSL2RLzsj7b8hZaW5JD7vHDNz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367538843"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="367538843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691725586"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="691725586"
Received: from rbhaumik-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.38])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:07:49 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C66861042C5; Thu,  7 Sep 2023 13:07:46 +0300 (+03)
Date:   Thu, 7 Sep 2023 13:07:46 +0300
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
Subject: Re: [PATCH 0/3] Do not map unaccepted memory
Message-ID: <20230907100746.42ujuj7brawxw322@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906073902.4229-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:38:59AM +0300, Adrian Hunter wrote:
> Hi
> 
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> a virtual machine may need to accept memory before it can be used.
> 
> Plug a few gaps where RAM is exposed without checking if it is
> unaccepted memory.

Thanks for catching this. Looks good to me.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
