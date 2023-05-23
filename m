Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2BD70DF01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbjEWOQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbjEWOQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:16:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAF2DD;
        Tue, 23 May 2023 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684851417; x=1716387417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mBoWANnbxeB4+cdZjE5tIosRxB0kPFN8XlkOEXTIKhY=;
  b=GWZOBMBliMfopBECd8MXhq+O21efXn/GgSCdk8XVPmHMbX5jq8dRMwNf
   qSzywzA0qKC6HDt1YfUwZqxWmcEIO4w0Oe+0RRY0FibPIjuNDZiPyEQhS
   N9Yq1wwuRley6iayazMNm2GbDZTFVPuKI7yLf+vmKbtZV32AuJcLgqffH
   rPPcYgrS8+3xgOVXY1c2toSe3hMF/dl8L2uptaB/O7EwfLTgo2ekjKBWU
   V1xwcWhfLIrs+unvgEVroRfELeoBScCyKVXTwC0sp/ysg9V29vWVFAcs9
   mJX32Ed4hxORJFUHjZOsA8gkBTjdwVWbFmlum0IMY1YLsTP2Xbkel5mri
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350758443"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="350758443"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="734761410"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="734761410"
Received: from kroconn-mobl2.amr.corp.intel.com (HELO [10.251.1.84]) ([10.251.1.84])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:16:56 -0700
Message-ID: <d0fe7a6f-8cd9-0b81-758a-f3b444e74bab@intel.com>
Date:   Tue, 23 May 2023 07:16:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] signal: move show_unhandled_signals sysctl to its own
 file
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, keescook@chromium.org,
        yzaikin@google.com, ebiederm@xmission.com, arnd@arndb.de,
        bp@alien8.de, James.Bottomley@HansenPartnership.com, deller@gmx.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Cc:     j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230522210814.1919325-1-mcgrof@kernel.org>
 <20230522210814.1919325-3-mcgrof@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230522210814.1919325-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/23 14:08, Luis Chamberlain wrote:
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -12,6 +12,7 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <linux/ratelimit.h>
> +#include <linux/signal.h>

Oh, so this is actually fixing a bug: umip.c uses
'show_unhandled_signals' but it doesn't explicitly include
linux/signal.h where 'show_unhandled_signals' is declared.

It doesn't actually have anything to do with moving the
show_unhandled_signals sysctl, right?

If that's the case, it would be nice to have this in its own patch.
