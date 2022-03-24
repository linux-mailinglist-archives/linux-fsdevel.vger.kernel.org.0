Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1353E4E61C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 11:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349522AbiCXKdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 06:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349626AbiCXKdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:33:07 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25EA1443
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Mar 2022 03:31:32 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KPM2p55BhzMqNND;
        Thu, 24 Mar 2022 11:31:30 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KPM2m27YJzljsTY;
        Thu, 24 Mar 2022 11:31:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648117890;
        bh=07InghFBQQsMZIwhzNxbiMPO0RvgGZQgEQaSuD90ZRQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wLPLtVakEdY3ntCVFa9PR0CP5WrSV7xM8w1zvacrOnr9A2aY8r+oZton40dAdqJjg
         ZSEJFmOmQTFYG9qt6Eg4a0KEcBChePGf7b0iCeCkzVrkLSpwSfCz7k0h/zYT5BHrBn
         stZ01j3MOm4b19vDHne2l6nYVK085p2lLPCxdBmA=
Message-ID: <f8f5ef29-4446-8f19-08a3-b9e080855405@digikod.net>
Date:   Thu, 24 Mar 2022 11:31:32 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 06/11] landlock: Add support for file reparenting with
 LANDLOCK_ACCESS_FS_REFER
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220221212522.320243-1-mic@digikod.net>
 <20220221212522.320243-7-mic@digikod.net>
 <CAHC9VhSFXN39EuVG5aVK0jtgCOmzM2FSCoVa2Xrs=oJQ4AkWMQ@mail.gmail.com>
 <588e0fec-6a45-db81-e411-ae488b29e533@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <588e0fec-6a45-db81-e411-ae488b29e533@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/03/2022 13:04, Mickaël Salaün wrote:
> 
> On 17/03/2022 02:26, Paul Moore wrote:

[...]

>>> @@ -269,16 +270,188 @@ static inline bool is_nouser_or_private(const 
>>> struct dentry *dentry)
>>>                           
>>> unlikely(IS_PRIVATE(d_backing_inode(dentry))));
>>>   }
>>>
>>> -static int check_access_path(const struct landlock_ruleset *const 
>>> domain,
>>> -               const struct path *const path,
>>> +static inline access_mask_t get_handled_accesses(
>>> +               const struct landlock_ruleset *const domain)
>>> +{
>>> +       access_mask_t access_dom = 0;
>>> +       unsigned long access_bit;
>>
>> Would it be better to declare @access_bit as an access_mask_t type?
>> You're not using any macros like for_each_set_bit() in this function
>> so I believe it should be safe.
> 
> Right, I'll change that.

Well, thinking about it again, access_bit is not an access mask but an 
index in such mask. access_mask_t gives enough space for such index but 
it is definitely not the right semantic. The best type should be size_t, 
but I prefer to stick to unsigned long (used for size_t anyway) for 
consistency with the other access_bit variable types. There is no need 
to use for_each_set_bit() here now but that could change, and I prefer 
to do my best to prevent future issues. ;)
Anyway, I guess the compiler can optimize such code.
