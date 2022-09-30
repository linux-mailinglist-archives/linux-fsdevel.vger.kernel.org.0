Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C214C5F0BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 14:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiI3Mjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 08:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiI3Mjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:39:45 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C95222B5;
        Fri, 30 Sep 2022 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lUTG+EmtFNfgk90oX9a54Dibc3TuSEy0wx0jrem7HIk=; b=aAxoS4eH2L4gINwLoHAstNk/hc
        S0K19BNpJ1Q7htbb+G1i2YTrI2omwApLIdsa5MbWbwEclQQMr8hdu6vWemIhUc+j9O92pKB1kI5zh
        aBushhVUs5AdhSWU8XmZLuzpkhNbGVVQuPcODDMsuxa5Qq9dFB8zQpsyiPUHHbKcnIbPMKmAPFLp/
        rUN/4j9jEGRdOeMNhENvcY1DT7ko3fOK0q6D+vQwbEh8ZU0x2MbRbtom3pOogd3Ktw+fu3HvPWQVB
        T5npz+RRzuQMY1jjjEyiWT6p5Iqid+De2GVqDHzGG9Xt6zLEauYJJj09tcVusbRljyhmDSih8X6vt
        2ksyIv6A==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oeFId-000RTf-Ab; Fri, 30 Sep 2022 14:39:27 +0200
Message-ID: <56d85c70-80f6-aa73-ab10-20474244c7d7@igalia.com>
Date:   Fri, 30 Sep 2022 09:39:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [REGRESSION][PATCH] Revert "pstore: migrate to crypto acomp
 interface"
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
References: <20220929215515.276486-1-gpiccoli@igalia.com>
 <202209291951.134BE2409@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202209291951.134BE2409@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/09/2022 00:29, Kees Cook wrote:
> [...]
> 
> Hi!
> 
> Thanks for looking at this. I wasn't able to reproduce the problem,
> initially. Booting with pstore.backend=ramoops pstore.compress=zstd and
> writing to /dev/pmsg0, after a reboot I'm able to read it back.
> 

Hi Kees, thanks a lot for your attention!
IIUC, compression applies to dmesg only, correct?


> [...] 
> What's your setup for this? I'm using emulated NVDIMM through qemu for
> a ramoops backend. But trying this with the EFI backend (booting
> undef EFI with pstore.backend=efi), I _do_ see the problem. That's
> weird... I suspect there's some back interaction with buffer size
> differences between ramoops and EFI & deflate and zstd.
> 
> And I can confirm EFI+zstd with the acomp change reverted fixes it.
> 

I'm using qemu but was able to use real HW (Steam Deck). In both cases,
kernel is not using the entire RAM ("mem=" parameter, for example) so we
can use a bit for ramoops. Also, both setups are UEFI, hence I can also
use efi_pstore.


> [...] 
> Hm, it's possible this was just sent directly to me? If that's true, I
> apologize for not re-posting it to lkml. I suspect I didn't notice at
> the time that it wasn't CCed to a list.

No need for apologies, thanks for the clarification! How about if we add
a mailing list in the pstore entry on MAINTAINERS file, since it's just
composed for you and 3 other people now? I mean, "officially" speaking,
it should be enough to send a patch for the 4 maintainers with no list
in CC, and that's bad for achieving purposes. What list should be the
best, fsdevel? Lkml?


> 
> No worries! Whatever the case, there's always -stable updates. :)

Heheh you're right! But for something like this (pstore/dmesg
compression broke for the most backends), I'd be glad if we could fix it
before the release.
Cheers,


Guilherme
