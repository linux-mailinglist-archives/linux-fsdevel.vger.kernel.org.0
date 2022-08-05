Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3F58AEB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiHERMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 13:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiHERMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:12:45 -0400
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83513D56
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 10:12:43 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Lzsbt1l2KzMqKDR;
        Fri,  5 Aug 2022 19:12:42 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Lzsbs5rrZzln8Vs;
        Fri,  5 Aug 2022 19:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659719562;
        bh=ByfgOk0a145mOwBW4wWN/5/1GIUsi6+DCI0MKP3Cg1Y=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=j/Qcv/0GenZDzBu7Ueu55i+FkibDfgFYIat5DwKA0Vx2j8pKXhgJ1RLtcWH8Mcv3+
         IC8FMyEJHFMZmXuvGlqt+pAHl4/w3UmDZH00GsrtZOTh2g3GjXsRGIal6u6J5Suza7
         sDDoh1e3JwiNStRW/xkgotMHOj6NGwm2V3b7Xb3A=
Message-ID: <cf51d454-0b7d-ed21-3a7f-9b0e109a5e98@digikod.net>
Date:   Fri, 5 Aug 2022 19:12:41 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <dbb0cd04-72a8-b014-b442-a85075314464@digikod.net> <YsqihF0387fBeiVa@nuc>
 <b7ee2d01-2e33-bf9c-3b56-b649e2fde0fb@digikod.net> <YuvvXI5Y2azqiQyU@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 0/2] landlock: truncate(2) support
In-Reply-To: <YuvvXI5Y2azqiQyU@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 04/08/2022 18:10, Günther Noack wrote:
> On Fri, Jul 29, 2022 at 01:58:17PM +0200, Mickaël Salaün wrote:

[...]

>>>> While we may question whether a dedicated access right should be added for
>>>> the Landlock use case, two arguments are in favor of this approach:
>>>> - For compatibility reasons, the kernel must follow the semantic of a
>>>> specific Landlock ABI, otherwise it could break user space. We could still
>>>> backport this patch and merge it with the ABI 1 and treat it as a bug, but
>>>> the initial version of Landlock was meant to be an MVP, hence this lack of
>>>> access right.
>>>> - There is a specific access right for Capsicum (CAP_FTRUNCATE) that could
>>>> makes more sense in the future.
>>>>
>>>> Following the Capsicum semantic, I think it would be a good idea to also
>>>> check for the O_TRUNC open flag:
>>>> https://www.freebsd.org/cgi/man.cgi?query=rights
>>>
>>> open() with O_TRUNC was indeed a case I had not thought about - thanks
>>> for pointing it out.
>>>
>>> I started adding some tests for it, and found to my surprise that
>>> open() *is* already checking security_path_truncate() when it is
>>> truncating files. So there is a chance that we can get away without a
>>> special check for O_TRUNC in the security_file_open hook.
>>>
>>> The exact semantics might be slightly different to Capsicum though -
>>> in particular, the creat() call (= open with O_TRUNC|O_CREAT|O_WRONLY)
>>> will require the Landlock truncate right when it's overwriting an
>>> existing regular file, but it will not require the Landlock truncate
>>> right when it's creating a new file.
>>
>> Is the creat() check really different from what is done by Capsicum?
> 
> TBH, I'm not sure, it might also do the same thing. I don't have a
> FreeBSD machine at hand and am not familiar with Capsicum in detail.
> Let me know if you think we should go to the effort of ensuring the
> compatibility down to that level.

I'll take a look at the code, but it makes sense to implement it like 
you did.
