Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3456C79BEB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjIKU4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjIKIl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:41:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C965125;
        Mon, 11 Sep 2023 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694421715; x=1725957715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uhPe1H2Fp1YDVYHUdP69YCF2k7+nQbNT9DvyyBH2lmY=;
  b=kI09s6e/ZM3koHQI3MdzBIHixUNhvXWXRUC7IicLTa4fT9L24sPAbQN1
   Mz9UMheeobLrGzIl0gS7OmXVy8+vl8e4Mzwewz33KjL3DN3HMUWEPCsVn
   qq4OcF0HtlKDz5HIC3wmQqtvywfmLg1KSg0D5ZqC53VKoBSdK3n1+pHw7
   aQImioOATVhNbwcCTxuQpg62kZT+O4idojkeI7Dj+/Xsks5NnakUYzof2
   id3FFgVOQLRkQBDLOhiakbuBCThWA6svuRFzlulMTl97IX5pPINgbCnHH
   Cwzdhxc85+mP2f5OdPFBwIzk6tkGx8IJ/h5FxXr4e6caYPoDbvncRByvH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="442024370"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="442024370"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858242359"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="858242359"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:41:50 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1DF6310940E; Mon, 11 Sep 2023 11:41:48 +0300 (+03)
Date:   Mon, 11 Sep 2023 11:41:48 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Message-ID: <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
> On 06.09.23 09:39, Adrian Hunter wrote:
> > Support for unaccepted memory was added recently, refer commit
> > dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> > a virtual machine may need to accept memory before it can be used.
> > 
> > Do not map unaccepted memory because it can cause the guest to fail.
> > 
> > For /proc/vmcore, which is read-only, this means a read or mmap of
> > unaccepted memory will return zeros.
> 
> Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
> to the information whether memory of the first kernel is unaccepted (IOW,
> not its memory, but the memory of the first kernel it is supposed to expose
> via /proc/vmcore)?

There are few patches in my queue to few related issue, but generally,
yes, the information is available to the target kernel via EFI
configuration table.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
