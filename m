Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9E079B61D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbjIKU4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjIKKGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:06:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61338101;
        Mon, 11 Sep 2023 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426764; x=1725962764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lNlcOiZRhunRghkzUThcrr1D7ym3FdZ/wyvyoGKtnUY=;
  b=fCmvdokSaTW12ZMJxc9GZFuHMyIJPBtFCGZAqN7nHAbvGA7bIREBM4zZ
   JjZX68gFEKS3MOnuaWcbmpB9y2l1gnXYGwGSeNOLjW5m31xX0UjF2qIcV
   G6YrPHAlbR8NAqnpmwfdbeuPlCrTeYsuaVFpRZ7Vp4KwYbt2wEvxzk4GN
   KUPJHxhZvPdvQNX/CvKujQhCmXMtB/lPvj4NhVtq+qQN468sTJDoOWuG+
   DO4y4qk8PJUlz0McoCl/cUShZiDULS9Jc8a9DrVsH7C1gECn56UiDwpyV
   0ySpwEEOOvj7kzVAImo0r3FbZHWMk4QQbAfTAsuou2w4RJWWTSCldIayH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381843780"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="381843780"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="813308505"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="813308505"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:05:58 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ED55210940E; Mon, 11 Sep 2023 13:05:55 +0300 (+03)
Date:   Mon, 11 Sep 2023 13:05:55 +0300
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
Message-ID: <20230911100555.mjjnx3ujnjlaxgsy@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
 <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
 <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
 <20230911092712.2ps55mylf7elfqp6@box.shutemov.name>
 <476456e1-ac50-8e48-260d-5cbe5e8b085e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476456e1-ac50-8e48-260d-5cbe5e8b085e@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:50:31AM +0200, David Hildenbrand wrote:
> On 11.09.23 11:27, Kirill A. Shutemov wrote:
> > On Mon, Sep 11, 2023 at 10:42:51AM +0200, David Hildenbrand wrote:
> > > On 11.09.23 10:41, Kirill A. Shutemov wrote:
> > > > On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
> > > > > On 06.09.23 09:39, Adrian Hunter wrote:
> > > > > > Support for unaccepted memory was added recently, refer commit
> > > > > > dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> > > > > > a virtual machine may need to accept memory before it can be used.
> > > > > > 
> > > > > > Do not map unaccepted memory because it can cause the guest to fail.
> > > > > > 
> > > > > > For /proc/vmcore, which is read-only, this means a read or mmap of
> > > > > > unaccepted memory will return zeros.
> > > > > 
> > > > > Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
> > > > > to the information whether memory of the first kernel is unaccepted (IOW,
> > > > > not its memory, but the memory of the first kernel it is supposed to expose
> > > > > via /proc/vmcore)?
> > > > 
> > > > There are few patches in my queue to few related issue, but generally,
> > > > yes, the information is available to the target kernel via EFI
> > > > configuration table.
> > > 
> > > I assume that table provided by the first kernel, and not read directly from
> > > HW, correct?
> > 
> > The table is constructed by the EFI stub in the first kernel based on EFI
> > memory map.
> > 
> 
> Okay, should work then once that's done by the first kernel.
> 
> Maybe include this patch in your series?

Can do. But the other two patches are not related to kexec. Hm.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
