Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CC7976A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbjIGQOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjIGQNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:13:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C993E0;
        Thu,  7 Sep 2023 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694101470; x=1725637470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nvAw9m6A6x9DDVOWLkP+zkRHDGaDC+Y39YscRQTquf0=;
  b=UTFIkH+tBGzunZkC8ebiv+ch3kc0iaS4HDTDh8WI0p+olmr3dkE+Ylr1
   v+DV1w9z50tYXBx0Ms7khq7QUxUDXQow9urn7RqjXnBMyuZKno+uMAHlM
   Q+ZxEjzXnPtMcCz+ZApeqkjVEwDWa3evo49IrRfqEvCbygPwBzIHTpDDu
   YJruhYodPyhN5O3szqhvGGMYIzupAAqVOKgSckq1Xk69C2kVZQhBC+c94
   97Uba10+nDOiJo83t+vlev2IeRb1eM1a5riCLnHMYvo2gI1glFFIqEFow
   Yl0SOJLKYnhKkR1F30TXAH6RqKhlGcm/Fu0fMOyyHuH6SmssqpWXB3xIB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="463769143"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="463769143"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735563105"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735563105"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:43:07 -0700
Message-ID: <523020c5-87fe-6aa3-4c30-c0ca94d36f8f@intel.com>
Date:   Thu, 7 Sep 2023 08:43:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] proc/kcore: Do not map unaccepted memory
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
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
 <20230906073902.4229-3-adrian.hunter@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230906073902.4229-3-adrian.hunter@intel.com>
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

On 9/6/23 00:39, Adrian Hunter wrote:
> Do not map unaccepted memory because it can cause the guest to fail.
> 
> For /proc/kcore, which is read-only and does not support mmap, this means a
> read of unaccepted memory will return zeros.

I'm confused by this changelog and subject.

What is getting "mapped" here if mmap() isn't in play?
