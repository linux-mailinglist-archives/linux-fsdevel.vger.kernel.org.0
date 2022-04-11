Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5653E4FC457
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbiDKStd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiDKStc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:49:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8BE1FCDB;
        Mon, 11 Apr 2022 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649702838; x=1681238838;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=BlRY1ucylwTHwi1CNLdV5Rmu+hVaqB1rWV9jwjmzSX0=;
  b=P4Xo9NxwM93wYkwdmYF5ClJ2wcrKxV3yaAeBTtGumzZuDMHyQJqdQJdP
   qsV0bS1nJYOKp1CU7byxOr6Y4Ichl7YMutLkSrGv09YFQOjFG/K34M0v8
   g4C5/hW5PdrwPmxTwW3zj5yU1ugZX6uUa/6+bddgXpvGOpheDNO6dqH/6
   DBfZUMcB3uGBlD/7dERT9fxFXqal5WHDjDYXpYbIZvtzwDbgmPR3VOIhk
   xJfrNCq2mdaG+7OZE8zwRxvAdKVVRSiEC/OMLaQWOpwG7b0aYLooLCpIn
   LISDZfuQJTAmhqQv0e4ApksQGXWkuKKEd4O8JSWYOEt6lKoBjxHg/I43q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322633693"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="322633693"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 11:47:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572338003"
Received: from minhjohn-mobl.amr.corp.intel.com (HELO [10.212.44.201]) ([10.212.44.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 11:47:15 -0700
Message-ID: <d473d25a-8119-3f17-7c56-c1686b0fe17c@intel.com>
Date:   Mon, 11 Apr 2022 11:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org
Cc:     aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1649370874.git.khalid.aziz@oracle.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/11/22 09:05, Khalid Aziz wrote:
> PTEs are shared at pgdir level and hence it imposes following
> requirements on the address and size given to the mshare():
> 
> - Starting address must be aligned to pgdir size (512GB on x86_64).
>   This alignment value can be looked up in /proc/sys/vm//mshare_size
> - Size must be a multiple of pgdir size
> - Any mappings created in this address range at any time become
>   shared automatically
> - Shared address range can have unmapped addresses in it. Any access
>   to unmapped address will result in SIGBUS
> 
> Mappings within this address range behave as if they were shared
> between threads, so a write to a MAP_PRIVATE mapping will create a
> page which is shared between all the sharers. The first process that
> declares an address range mshare'd can continue to map objects in
> the shared area. All other processes that want mshare'd access to
> this memory area can do so by calling mshare(). After this call, the
> address range given by mshare becomes a shared range in its address
> space. Anonymous mappings will be shared and not COWed.

What does this mean in practice?
