Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D0F79B717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbjIKUya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjIKJ1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:27:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381FCA;
        Mon, 11 Sep 2023 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694424439; x=1725960439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P1rWfsyWf1hT8IBhrbyQRWuhyIqsGBEwhKPFJUoIoGM=;
  b=FNvGj8uFx9t7i4bxR9sWmLQuirGta2Q6Czdrn1r+DJYrVCSm8l/ETcoN
   UCmob8OkpmfJUYMXXEV2n9VupxNcP0yWmQAGZYsGBeAYiIBkOP5/mQPQm
   UDYU8fkpRcIHy3gRxNkq5cbIVFZ5jdGouW2p4s8AP9HVeQRITswGziqEy
   aPNYHlafhXIL8NF/2sKlx2igSt18qvfHqUIeaq1HcYnuuIs5tGVKdKVs4
   lYjPqQ5BMM07xENal8bhgfUoL9XxCT9lkdnD52pmTotlZvQBv6uZiPYgh
   fli9XRMh0WD2CAZbqMSCacZKlt23/dGyfp0AZxDVdGwvUbF698qvCORpO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="380736512"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="380736512"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="990032592"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="990032592"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:27:15 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 53E5810940E; Mon, 11 Sep 2023 12:27:12 +0300 (+03)
Date:   Mon, 11 Sep 2023 12:27:12 +0300
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
Message-ID: <20230911092712.2ps55mylf7elfqp6@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
 <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
 <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:42:51AM +0200, David Hildenbrand wrote:
> On 11.09.23 10:41, Kirill A. Shutemov wrote:
> > On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
> > > On 06.09.23 09:39, Adrian Hunter wrote:
> > > > Support for unaccepted memory was added recently, refer commit
> > > > dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> > > > a virtual machine may need to accept memory before it can be used.
> > > > 
> > > > Do not map unaccepted memory because it can cause the guest to fail.
> > > > 
> > > > For /proc/vmcore, which is read-only, this means a read or mmap of
> > > > unaccepted memory will return zeros.
> > > 
> > > Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
> > > to the information whether memory of the first kernel is unaccepted (IOW,
> > > not its memory, but the memory of the first kernel it is supposed to expose
> > > via /proc/vmcore)?
> > 
> > There are few patches in my queue to few related issue, but generally,
> > yes, the information is available to the target kernel via EFI
> > configuration table.
> 
> I assume that table provided by the first kernel, and not read directly from
> HW, correct?

The table is constructed by the EFI stub in the first kernel based on EFI
memory map.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
