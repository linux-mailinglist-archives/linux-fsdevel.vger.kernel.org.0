Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6837C5F792C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJGNp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJGNp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:45:57 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22E9A50DD;
        Fri,  7 Oct 2022 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4t8LTL1d8XMZzDzaw81RwyytmuMEaVVPGbZaheRn9Ho=; b=RVb8x+mL5ZCRv3Q5mRuFYd5J0x
        LrUBERT5kEMJXsXHtO2lPv91kufd+4grujBRTLcbbUeTT+bntpLecUcEHRhnO6JM1jCA3PZlVk0Dd
        ls4L2caoU/ETLF47SU3jeguF0Dgw5PwGV1HG0r6GBVkU4+J3NncVW2OqUWIQaxxWDbyeh06t5ObQ4
        GRj3g8qpD1NumzNcCclIJkLln1OTz5aih3GedKg/ADw37VQ0qcz5VP7yNYsnkg2tLOOajCHCfXy8k
        7gc57Uokd4krD0nEdg2D0cWdJXfjPMcm64ZaiOzoPGCGhRihCJ6z422UU8hmBXwi5p4Y9BiONvmn9
        1AaPyw+w==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ognfh-00D9Dx-4v; Fri, 07 Oct 2022 15:45:49 +0200
Message-ID: <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com>
Date:   Fri, 7 Oct 2022 10:45:33 -0300
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
 <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com>
 <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
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

On 07/10/2022 10:19, Ard Biesheuvel wrote:
> [...]
> 
> OVMF has
> 
> OvmfPkg/OvmfPkgX64.dsc:
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
> OvmfPkg/OvmfPkgX64.dsc:
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x8400
> 
> where the first one is without secure boot and the second with secure boot.
> 
> Interestingly, the default is
> 
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x400
> 
> so this is probably where this 1k number comes from. So perhaps it is
> better to leave it at 1k after all :-(
> 

Oh darn...

So, let's stick with 1024 then? If so, no need for re-submitting right?
Thanks again,


Guilherme
