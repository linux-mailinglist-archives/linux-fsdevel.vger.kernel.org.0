Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EC4CEE99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 00:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiCFXmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 18:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiCFXmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:42:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519743969B;
        Sun,  6 Mar 2022 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646610121; x=1678146121;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ms8fEHLgOxSSRVUWFcxRUAylSAFNrqV0pk+t2bhqEvo=;
  b=H9A6S1Xz2shq/6CtvJYfHnx3hv7W+VYWttrBVbzWPk8bJ3LPPwwk9xl1
   MgRwgakynUElW9RTDoQzFLBXTIWhQNYdUalJK7zepP7zVmdyPz9eddEpO
   lKaKaSZLfx+CbBXUllWa5AVvZm4etTxfp5Su6UQnT/m8022vEmYy0glcp
   LFU1AWAdSOy7Cu71fDW+R3PbS4kHYSPh8vgLblL99v/qgMGcH67NyAT9u
   YTxygB4rObiQx52hz/jEeZjeZA2wbA11pNkTZsf9JNctBJndU3XBjCHrl
   3tA+mqlxLtMnyUl9fDRNQo+TIYIw45kR1Ck9cLCN9HtPGaTmgmYHQvfB7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234876372"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="234876372"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:42:00 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="552917258"
Received: from nraghura-mobl2.amr.corp.intel.com (HELO [10.209.12.153]) ([10.209.12.153])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:42:00 -0800
Message-ID: <c3083144-bfc1-3260-164c-e59b2d110df8@intel.com>
Date:   Sun, 6 Mar 2022 15:41:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, jaharkes@cs.cmu.edu,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        codalist@telemann.coda.cs.cmu.edu, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20220306032655.97863-1-jarkko@kernel.org>
 <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC v2] mm: Add f_ops->populate()
In-Reply-To: <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/22 15:24, Andrew Morton wrote:
> On Sun,  6 Mar 2022 05:26:55 +0200 Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
>> Sometimes you might want to use MAP_POPULATE to ask a device driver to
>> initialize the device memory in some specific manner. SGX driver can use
>> this to request more memory by issuing ENCLS[EAUG] x86 opcode for each
>> page in the address range.
> Why is this useful?  Please fully describe the benefit to kernel users.
> Convince us that the benefit justifies the code churn, maintenance
> cost and larger kernel footprint.

In short: page faults stink.  The core kernel has lots of ways of
avoiding page faults like madvise(MADV_WILLNEED) or mmap(MAP_POPULATE).
 But, those only work on normal RAM that the core mm manages.

SGX is weird.  SGX memory is managed outside the core mm.  It doesn't
have a 'struct page' and get_user_pages() doesn't work on it.  Its VMAs
are marked with VM_IO.  So, none of the existing methods for avoiding
page faults work on SGX memory.

This essentially helps extend existing "normal RAM" kernel ABIs to work
for avoiding faults for SGX too.  SGX users want to enjoy all of the
benefits of a delayed allocation policy (better resource use,
overcommit, NUMA affinity) but without the cost of millions of faults.

That said, this isn't how I would have implemented it.  I probably would
have hooked in to populate_vma_page_range() or its callers.
