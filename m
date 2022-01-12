Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBA48BEC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 08:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351089AbiALHDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 02:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiALHDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:03:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B3AC06173F;
        Tue, 11 Jan 2022 23:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=B7oR5l7h0xuDP9JkX9UDFLPOyakW7jPGUaFIedqZLKM=; b=ALPDjET2IPPnr29smamizRIwBR
        MWLZ7saJYUtW5+15kJkTnMhfYXVh2fhKAmh8368gqR/G/8+oY/51j4QzGpE/TGxslgvC/OUVfTa8b
        sme1cQBHlG6P8ik1cH9uNbueJLsd9FPAzKfUcnavdIo4pz1dnM24GG28AuWihddIdcBe19XTlspV5
        78GlkHzWt/PlrvrJt+TjNyHj/9RjB0wezmSZrrSGnJWKvstGg0Ur5Ao9YojceyFghaVF/vnZ1Q9Ap
        oWib4BV6bYLujt7cMleA2MACmgN2iT1JKL7M4r4DRZatw2l9p5KGGm8WFmQRK+ul7OVkZqg5nYrLq
        ku3LD3lQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Xfe-000kn9-PH; Wed, 12 Jan 2022 07:03:47 +0000
Message-ID: <da39d895-61fc-5ca2-64e0-e31e20e98245@infradead.org>
Date:   Tue, 11 Jan 2022 23:03:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] firmware_loader: simplfy builtin or module check
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <20220112023416.215644-1-mcgrof@kernel.org>
 <3e721c69-afa9-6634-2e52-e9a9c2a89372@infradead.org>
 <CAK7LNARiDFpphJrhk5q00d5sSPWAQ2mMLu8Z2YP0Xwk=3WGt3w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNARiDFpphJrhk5q00d5sSPWAQ2mMLu8Z2YP0Xwk=3WGt3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/11/22 22:56, Masahiro Yamada wrote:
> On Wed, Jan 12, 2022 at 3:37 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 1/11/22 18:34, Luis Chamberlain wrote:
>>> The existing check is outdated and confuses developers. Use the
>>> already existing IS_ENABLED() defined on kconfig.h which makes
>>> the intention much clearer.
>>>
>>> Reported-by: Borislav Petkov <bp@alien8.de>
>>> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> Thanks.
>>
>>> ---
>>>  include/linux/firmware.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
>>> index 3b057dfc8284..fa3493dbe84a 100644
>>> --- a/include/linux/firmware.h
>>> +++ b/include/linux/firmware.h
>>> @@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
>>>  }
>>>  #endif
>>>
>>> -#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
>>
>> The "defined(MODULE)" part wasn't needed here. :)
> 
> 
> 
> It _is_ needed.
> 
> This seems to be equivalent to IS_REACHABLE(CONFIG_FW_LOADER),
> not IS_ENABLE(CONFIG_FW_LOADER).
> 

Hm, /me confused.

How can CONFIG_FW_LOADER_MODULE be =y when MODULE is not defined?

> 
> 
>>
>>> +#if IS_ENABLED(CONFIG_FW_LOADER)
>>>  int request_firmware(const struct firmware **fw, const char *name,
>>>                    struct device *device);
>>>  int firmware_request_nowarn(const struct firmware **fw, const char *name,
>>
>> --
>> ~Randy
> 
> 
> 

-- 
~Randy
