Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2BA7B6EDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjJCQql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJCQqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:46:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E083A1;
        Tue,  3 Oct 2023 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696351598; x=1727887598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WABA3N82zUWgofliPDkDARwavt+9zpHw4Esz4HwHYMg=;
  b=K/k8FxnbsqxEE5vVU/QJiIVBa4inmLKGwUThVbXSIZ7wv+LJuDrwlTWa
   GVlZ41AKWh0lX6za4KSJgSP70S/hEwwuB7c7XIRcVOTBx/Be1qhAHmuh6
   m8AU5HdKjFnofMSPVkn9Y9/3dddqrohDagPgilIb6gP119NR6af6Q2zDw
   lWbbFi19RljT721XRq8274vBeBG0LI1mXt/TrH3eegxqs5A11FQ0l9DGZ
   D+tEQNhuan4eruqMjebNDUIpsNH8Jk+sigWspumhXZR7yNWCnmPQ5L1Dd
   kh00SzcC2p6cyn7kU8lM8ESIXDKljYndy9a5nkQeA7cuy1b9PaEV8rJEv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380198863"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="380198863"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841423206"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841423206"
Received: from ddiaz-mobl4.amr.corp.intel.com (HELO [10.209.57.36]) ([10.209.57.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:46:37 -0700
Message-ID: <875f8a6f-c2b3-92f4-f067-b969a9fc1112@intel.com>
Date:   Tue, 3 Oct 2023 09:46:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 20/20] selftests: mm: make protection_keys test work on
 arm64
Content-Language: en-US
To:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-21-joey.gouly@arm.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230927140123.5283-21-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/23 07:01, Joey Gouly wrote:
> The encoding of the pkey register differs on arm64, than on x86/ppc. On those
> platforms, a bit in the register is used to disable permissions, for arm64, a
> bit enabled in the register indicates that the permission is allowed.
> 
> This drops two asserts of the form:
> 	 assert(read_pkey_reg() <= orig_pkey_reg);
> Because on arm64 this doesn't hold, due to the encoding.
> 
> The pkey must be reset to both access allow and write allow in the signal
> handler. pkey_access_allow() works currently for PowerPC as the
> PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE have overlapping bits set.
> 
> Access to the uc_mcontext is abstracted, as arm64 has a different structure.

This all looks sane enough.  Welcome to the pkey party! :)

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
