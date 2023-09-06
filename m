Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349B793F2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbjIFOpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjIFOpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:45:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26769172C;
        Wed,  6 Sep 2023 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694011511; x=1725547511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HKIKo8gJxS6xNqAxkMxzWOKQ5+W7pcHDwu58cyKSvBQ=;
  b=OOuPPinN4LxTy7L0QxtKdAySp8/EiQe3KsxeBqvNZ4pYOObCfFXJVc9B
   dZpxbTWTNjEh0PvN54sMULJmc6lXBdVHI5ZCSP7Y+sOT4KCxglAK2kGZF
   2HjQPUsmgsj/ZyUdu4sTIBAq5BqFSKE36RpUoHFrymA8gfaxlSTmq3sYP
   67uid6ayaMNcqgpTyvDH8+zPoXChcIS91y5fJPCZS9mK1d8Gw9+cqt2uv
   BA4bipRwXIQ5N+I/RKGea4iyuSLtJijMhobzHfNDLH0wH0CUguIIGn8M+
   nv+ZjiKqlkt3I/IecfWUxJPpwWkYlTuQN3CsWxEV2sAUFA9Kc+Ihd2CMM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357393634"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="357393634"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="770777884"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="770777884"
Received: from lmgabald-mobl2.amr.corp.intel.com (HELO [10.212.242.149]) ([10.212.242.149])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:45:09 -0700
Message-ID: <d0d30ad4-7837-b0c4-39f4-3e317e35a41b@intel.com>
Date:   Wed, 6 Sep 2023 07:45:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/8] arch/x86: Remove sentinel elem from ctl_table arrays
Content-Language: en-US
To:     j.granados@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
        willy@infradead.org, josh@joshtriplett.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org
References: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
 <20230906-jag-sysctl_remove_empty_elem_arch-v1-3-3935d4854248@samsung.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230906-jag-sysctl_remove_empty_elem_arch-v1-3-3935d4854248@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 03:03, Joel Granados via B4 Relay wrote:
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel element from sld_sysctl and itmt_kern_table.

There's a *LOT* of content to read for a reviewer to figure out what's
going on here between all the links.  I would have appreciated one more
sentence here, maybe:

	This is now safe because the sysctl registration code
	(register_sysctl()) implicitly uses ARRAY_SIZE() in addition
	to checking for a sentinel.

That needs to be more prominent _somewhere_.  Maybe here, or maybe in
the cover letter, but _somewhere_.

That said, feel free to add this to the two x86 patches:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86
