Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264285F8590
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJHOOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 10:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJHOOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:14:43 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031DC115F;
        Sat,  8 Oct 2022 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v8wejr9QFqklPlsa3e4ecvwHkF8WHlPCHaLOlwoCR0E=; b=BJV3UFwWANjKm+Wrz80uzami7T
        w6NnMmJLSq97vEKPBoIZ5Zb+ZFhtmHRqhghcUD5LRpvcMqqfyIvRytKq8F0oeDDXXOUfYD95Yh+Xk
        eFsCtCBmvYY4XgMUitBgDceoUqHNk32SOS+Ycu6UiNJy8oVe5EMyVQpwirQSdLe3BRdUTcnSnmxGF
        lIYhmi7jRgkW9bocwg4E1WyvlhvElAZBs7HYeNtsPwTZqxNsiTrtkBKF4Rc0hm0AkKEss9Z//VI30
        LDTOSOoY9rx4EkPhtoSUwetbtn2PaNdGRdejHf6OOzIXy3HT+Rkv41adkPkgHECwC6CGNV2dQcKDn
        Ar5Quq+A==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ohAax-00EX1Z-N2; Sat, 08 Oct 2022 16:14:28 +0200
Message-ID: <11e03e8d-7711-330d-e0d4-808ef9acec3a@igalia.com>
Date:   Sat, 8 Oct 2022 11:14:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook>
 <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
 <202210071234.D289C8C@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210071234.D289C8C@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2022 16:37, Kees Cook wrote:
> On Fri, Oct 07, 2022 at 10:47:01AM +0200, Ard Biesheuvel wrote:
>> [...]
>> Isn't this the stuff we want to move into the crypto API?
> 
> It is, yes. Guilherme, for background:
> https://lore.kernel.org/linux-crypto/20180802215118.17752-1-keescook@chromium.org/
> 

Thanks a bunch Kees / Ard for pointing me that!

But I'm confused with regards to the state of this conversion: the
patches seem to be quite mature and work fine, but at the same time,
they focus in what Herbert consider a deprecated/old API, so they were
never merged right?

The proposal from Ard (to move to crypto scomp/acomp) allow to rework
the zbufsize worst case thing and wire it on such new API, correct? Do
you intend to do that Kees?

At the same time, I feel it is still valid to avoid these bunch of
implicit conversions on pstore, as this patch proposes - what do you all
think?

I could rework this one on top of Ard's acomp migration while we don't
have an official zbufsize API for on crypto scomp - and once we have,
it'd be just a matter of removing the zbufsize functions of pstore and
make use of the new API, which shouldn't be affected by this implicit
conversion fix.

Cheers,


Guilherme
