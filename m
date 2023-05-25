Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86127116FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 21:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbjEYTG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 15:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244035AbjEYTFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 15:05:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1386BB;
        Thu, 25 May 2023 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685040849; x=1716576849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I9uqk67X9bs3sYyrSKFArEnF17vc0xskgqqQ5rfNWro=;
  b=InJhDBtxi2J6JTpkhmNMySs/N0m5KSd8O9SBEwqH1nMQGcvOKeS9mGMM
   Le5eDrDrwk9rBArR+HSpM0eh0wTxSyv3CbXzsAYYIZGiEiMWI3jWd7a3d
   J+YyaqmcbXWO0Drgh61oNyuFzm1FnTlIWgM4VsGgoiY0CTPJhuxX5PcNK
   DhbWmHQ2o8I9cvAuqo5SV0CUV+uNuI/5tyyqatKZtfD5Q7pYt6eneLM8F
   mCmb5E6Uql5kySb3GAAxomb9vG3+rRVOpF7oBMp7rfcVTM+JFMPLw6cMh
   0zFWnIYCzW80aWy6QrQWjv82GYuG2XWUU3Ay/9GRZCYYDw7oGZjIJ6qlK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="351499792"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="351499792"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 11:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="794765493"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="794765493"
Received: from shuklaas-mobl1.amr.corp.intel.com (HELO [10.212.186.148]) ([10.212.186.148])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 11:52:59 -0700
Message-ID: <603f5357-3018-6c1b-2dc8-ec96aee9552c@intel.com>
Date:   Thu, 25 May 2023 11:52:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] signal: move show_unhandled_signals sysctl to its own
 file
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, bp@alien8.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230522210814.1919325-1-mcgrof@kernel.org>
 <20230522210814.1919325-3-mcgrof@kernel.org>
 <d0fe7a6f-8cd9-0b81-758a-f3b444e74bab@intel.com>
 <ZG29HWE9NWn56hTg@bombadil.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZG29HWE9NWn56hTg@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/23 00:30, Luis Chamberlain wrote:
>> It doesn't actually have anything to do with moving the
>> show_unhandled_signals sysctl, right?
> Well in my case it is making sure the sysctl variable used is declared
> as well.

But what does this have to do with _this_ patch?  This:

> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -12,6 +12,7 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <linux/ratelimit.h>
> +#include <linux/signal.h>

For instance.  You don't move things to another header or make *ANY*
change to the compilation of umip.c.  So why patch it?

It looks to me like a _fundamentally_ superfluous change.  That hunk
literally *can't* be related to the rest of the patch.

>> If that's the case, it would be nice to have this in its own patch.
> If its not really fixing any build bugs or functional bugs I don't see
> the need. But if you really want it, I can do it.
> 
> Let me know!

Yes, I really want it.

Please remove all the x86 bits from _this_ patch.  If x86 has a
separate, preexisting problem, please send that patch separately with a
separate changelog and justification.

We'll take a look.
