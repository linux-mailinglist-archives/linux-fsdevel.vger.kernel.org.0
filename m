Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DC4BEB62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 20:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiBUTyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 14:54:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiBUTyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:54:17 -0500
X-Greylist: delayed 266 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 11:53:54 PST
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5FE22535
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 11:53:54 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nMEgT-000rHd-Bl; Mon, 21 Feb 2022 20:49:21 +0100
Received: from p57ae5149.dip0.t-ipconnect.de ([87.174.81.73] helo=[192.168.178.35])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nMEgT-003cYB-4v; Mon, 21 Feb 2022 20:49:21 +0100
Message-ID: <94c3be49-0262-c613-e5f5-49b536985dde@physik.fu-berlin.de>
Date:   Mon, 21 Feb 2022 20:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     matoro_bugzilla_kernel@matoro.tk,
        Andrew Morton <akpm@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-ia64@vger.kernel.org,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info>
 <823f70be-7661-0195-7c97-65673dc7c12a@leemhuis.info>
 <03497313-A472-4152-BD28-41C35E4E824E@chromium.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <03497313-A472-4152-BD28-41C35E4E824E@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.174.81.73
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees!

On 2/21/22 08:42, Kees Cook wrote:
>>>> Reverting this commit resolves the issue up to and including git tip,
>>>> with no (visible) issues.
>>>>
>>>> Hardware:  HP Integrity rx2800 i2 Kernel config attached.
>>>
>>> Could somebody take a look into this? Or was this discussed somewhere
>>> else already? Or even fixed?
>>>
>>> Anyway, to get this tracked:
>>>
>>> #regzbot introduced: 5f501d555653f8968011a1e65ebb121c8b43c144
>>> #regzbot from: matoro <matoro_bugzilla_kernel@matoro.tk>
>>> #regzbot title: gcc segv at startup on ia64
>>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215601
> 
> Does this fix it?
> 
> https://www.ozlabs.org/~akpm/mmotm/broken-out/elf-fix-overflow-in-total-mapping-size-calculation.patch

I have applied this patch on top of 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6 and it doesn't
fix the problem for me. Reverting 5f501d555653f8968011a1e65ebb121c8b43c144, however, fixes
the problem.

FWIW, this problem doesn't just affect GCC but systemd keeps segfaulting with this change as well.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

