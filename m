Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B075F788A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 15:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJGNBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJGNBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:01:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F1D8EE9;
        Fri,  7 Oct 2022 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ww71LiFniQjR5k5o8LQpT64qpooOFLpcZ6GdALllUYo=; b=QhF6ALFmPBkkfK6dFkkN1oSJqI
        uszNgfRnVgnIbozx+cHW+7YAlwnmg4JY9ccZb6r6pv4elr/ccksmt3xqWLEkSx+Elil58cS7l3hfm
        qsj/bwmM3vrbZ3F3U6Jjo3U8EWQHPTCab+H5cbpieiGb0J7VBFdVXxhVhasLMHop8/OTpb4Iel8vP
        SQIDTuVq/oDsSFltZ4xjdisFnOPYks7Exn+pdebCExuQxfE4qy98LXWB47JBnYOmm3cIUw9O8oUbS
        RzZGAnWBo24EMKMiqdR8obYjiYOOuRriCmfNbf7WyPpe0+Upwk92te3qLusIkhSkVbIR30PdfYQMm
        oLZQCc5g==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogmxe-00D5Pa-8o; Fri, 07 Oct 2022 15:00:18 +0200
Message-ID: <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com>
Date:   Fri, 7 Oct 2022 10:00:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, linux-efi@vger.kernel.org
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-9-gpiccoli@igalia.com>
 <202210061614.8AA746094A@keescook>
 <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

First of all, thanks Ard for the historical explanation!


On 07/10/2022 06:11, Ard Biesheuvel wrote:
> [...]
>> I think it'd be great to make it configurable! Ard, do you have any
>> sense of what the max/min, etc, should be here?
>>
> 
> Given that dbx on an arbitrary EFI system with secure boot enabled is
> already almost 4k, that seems like a reasonable default. As for the
> upper bound, there is no way to know what weird firmware bugs you
> might tickle by choosing highly unusual values here.
> 
> If you need to store lots of data, you might want to look at [0] for
> some work done in the past on using capsule update for preserving data
> across a reboot. In the general case, this is not as useful, as the
> capsule is only delivered to the firmware after invoking the
> ResetSystem() EFI runtime service (as opposed to SetVariable() calls
> taking effect immediately). However, if you need to capture large
> amounts of data, and can tolerate the uncertainty involved in the
> capsule approach, it might be a reasonable option.
> 
> [0] https://lore.kernel.org/all/20200312011335.70750-1-qiuxu.zhuo@intel.com/

So, you mean 4K as the default? I can change, but I would try to not
mess with the current users, is there a case you can imagine something
like 4k would fail? Maybe 2K is safer?

As for the maximum, I've tested with many values, and when it's larger
than ~30000 for edk2/ovmf, it fails with EFI_OUT_OF_RESOURCES and
doesn't collect the log; other than that, no issues observed.

When set to ~24000, the interesting is that we have fewer big logs in
/sys/fs/pstore, so it's nice to see compared to the bunch of 1K files heheh

Anyway, let's agree on the default and then I can resubmit that, I'm
glad you both consider that it's a good idea =)

Thanks,


Guilherme
