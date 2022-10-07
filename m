Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5628B5F8135
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 01:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJGXaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 19:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJGXab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:30:31 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99138457;
        Fri,  7 Oct 2022 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=njY685+fJIJ0trGWiIPdJ5ci69EWL4zwHN8ZL610bNQ=; b=ZbrymY6KpDp9rFwIMAqNCk6Tbz
        tD4iuaVs8CgXQd2F3fSM+wbJXjhEXMXLtpuEH9U/P7XUUU56OXYiYPFQTKhEQKkltg1CV768B+G8+
        lcI7eaC3u8UTOxhgyqG24FukxzS43EhPGc0eucaad4k2X8niWpfSaHGkUCCSbpPa35xSnt1oXQtcQ
        tU11w/8A7KMmildtewgBc65VesBKlbD4uMgUUt+hSvtuZ9efCSZGtQKo+Cvvat1jFiwD3m6zCEy/7
        OoP28xh7KQdPP3VeCGfJTHKlPVszby///DT+YllmNpNIKjt/jTMMz3ButxJarf4Akvx3Xl4Rb0r+9
        ugKUw0Dw==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogwnM-00DmvH-Mk; Sat, 08 Oct 2022 01:30:20 +0200
Message-ID: <cc5945c8-3aa6-980d-902f-ac72f1f3902c@igalia.com>
Date:   Fri, 7 Oct 2022 20:29:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-efi@vger.kernel.org
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-9-gpiccoli@igalia.com>
 <202210061614.8AA746094A@keescook>
 <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
 <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com>
 <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
 <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com>
 <202210071230.63CF832@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210071230.63CF832@keescook>
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

On 07/10/2022 16:32, Kees Cook wrote:
> [...]
> Given OVMF showing this as a max, it doesn't seem right to also make
> this a minimum? Perhaps choose a different minimum to be enforced.

Hi Kees! Through my tests, I've noticed low values tend to cause issues
(didn't go further in the investigation), IIRC even 512 caused problems
on "deflate" (worked in the others).

I'll try again 512 to see how it goes, but I'm not so sure what would be
the use of such low values, it does truncate a lot and "pollute" the
pstore fs with many small files. But I can go with any value you/Ard
think is appropriate (given it works with all compression algorithms
heh) - currently the minimum of 1024 is enforced in the patch.

> 
> Also, can you update the commit log with Ard's archeology on
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize ?
> 

Sure, of course!
Cheers,


Guilherme
