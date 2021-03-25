Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06C349AF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhCYU0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCYU0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:26:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B5C06174A;
        Thu, 25 Mar 2021 13:26:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 407901F4684B
Subject: Re: [PATCH v4 5/5] fs: unicode: Add utf8 module and a unicode layer
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
 <20210325000811.1379641-6-shreeya.patel@collabora.com>
 <YFznIVf/F68oEuC6@sol.localdomain>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <2db48ab8-1297-e044-dcec-6c8b8875fdb0@collabora.com>
Date:   Fri, 26 Mar 2021 01:56:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFznIVf/F68oEuC6@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 26/03/21 1:10 am, Eric Biggers wrote:
> On Thu, Mar 25, 2021 at 05:38:11AM +0530, Shreeya Patel wrote:
>> Also, indirect calls using function pointers are easily exploitable by
>> speculative execution attacks, hence use static_call() in unicode.h and
>> unicode-core.c files inorder to prevent these attacks by making direct
>> calls and also to improve the performance of function pointers.
> I don't think you need to worry about avoiding indirect calls to prevent
> speculative execution attacks.  That's what the mitigations like Retpoline are
> for.  Instead my concern was just that indirect calls are *slow*, especially
> when those mitigations are enabled.  Some of the casefolding operations are
> called a lot (e.g., repeatedly during path resolution), and it would be
> desirable to avoid adding more overhead there.
>
>> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
>> index 2c27b9a5cd6c..2961b0206b4d 100644
>> --- a/fs/unicode/Kconfig
>> +++ b/fs/unicode/Kconfig
>> @@ -8,7 +8,16 @@ config UNICODE
>>   	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>>   	  support.
>>   
>> +# UTF-8 encoding can be compiled as a module using UNICODE_UTF8 option.
>> +# Having UTF-8 encoding as a module will avoid carrying large
>> +# database table present in utf8data.h_shipped into the kernel
>> +# by being able to load it only when it is required by the filesystem.
>> +config UNICODE_UTF8
>> +	tristate "UTF-8 module"
>> +	depends on UNICODE
>> +	default m
>> +
> The help for UNICODE still says that it enables UTF-8 support.  But now there is
> a separate option that people will need to remember to enable.
>
> Please document each of these options properly.
>
> Perhaps EXT4_FS and F2FS_FS just should select UNICODE_UTF8 if UNICODE, so that
> UNICODE_UTF8 doesn't have to be a user-selectable symbol?


It is not a user-selectable symbol. It depends on UNICODE and if someone 
enables it,
by default UNICODE_UTF8 will be enabled as a module.


>> +DEFINE_STATIC_CALL(validate, unicode_validate_static_call);
>> +EXPORT_STATIC_CALL(validate);
> Global symbols can't have generic names like "validate".  Please add an
> appropriate prefix like "unicode_".
>
> Also, the thing called "unicode_validate_static_call" isn't actually a static
> call as the name suggests, but rather the default function used by the static
> call.  It should be called something like unicode_validate_default.
>
> Likewise for all the others.


Thanks for your reviews, I'll make the change suggested by you in v5.


>
> - Eric
>
