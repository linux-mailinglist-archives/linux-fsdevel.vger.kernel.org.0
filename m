Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50765346C25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhCWWTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbhCWWSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:18:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E020C061574;
        Tue, 23 Mar 2021 15:18:20 -0700 (PDT)
Received: from [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147] (unknown [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2208F1F454D0;
        Tue, 23 Mar 2021 22:18:14 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] fs: unicode: Add utf8 module and a unicode layer
To:     Eric Biggers <ebiggers@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, drosen@google.com, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
References: <20210323183201.812944-1-shreeya.patel@collabora.com>
 <20210323183201.812944-6-shreeya.patel@collabora.com>
 <87eeg5d4xb.fsf@collabora.com> <YFpPxCQiMLqctIuS@gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <dd7dae42-6024-8868-3e3e-f6d672274682@collabora.com>
Date:   Wed, 24 Mar 2021 03:48:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFpPxCQiMLqctIuS@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/03/21 1:59 am, Eric Biggers wrote:
> On Tue, Mar 23, 2021 at 03:51:44PM -0400, Gabriel Krisman Bertazi wrote:
>>> -int unicode_validate(const struct unicode_map *um, const struct qstr *str)
>>> -{
>>> -	const struct utf8data *data = utf8nfdi(um->version);
>>> -
>>> -	if (utf8nlen(data, str->name, str->len) < 0)
>>> -		return -1;
>>> -	return 0;
>>> -}
>>> +struct unicode_ops *utf8_ops;
>>> +EXPORT_SYMBOL(utf8_ops);
>>> +
>>> +int _utf8_validate(const struct unicode_map *um, const struct qstr *str)
>>> +{
>>> +	return 0;
>>> +}
>>> -EXPORT_SYMBOL(unicode_validate);
>> I think that any calls to the default static calls should return errors
>> instead of succeeding without doing anything.
>>
>> In fact, are the default calls really necessary?  If someone gets here,
>> there is a bug elsewhere, so WARN_ON and maybe -EIO.
>>
>> int unicode_validate_default_static_call(...)
>> {
>>     WARN_ON(1);
>>     return -EIO;
>> }
>>
>> Or just have a NULL default, as I mentioned below, if that is possible.
>>
> [...]
>>> +DEFINE_STATIC_CALL(utf8_validate, _utf8_validate);
>>> +DEFINE_STATIC_CALL(utf8_strncmp, _utf8_strncmp);
>>> +DEFINE_STATIC_CALL(utf8_strncasecmp, _utf8_strncasecmp);
>>> +DEFINE_STATIC_CALL(utf8_strncasecmp_folded, _utf8_strncasecmp_folded);
>>> +DEFINE_STATIC_CALL(utf8_normalize, _utf8_normalize);
>>> +DEFINE_STATIC_CALL(utf8_casefold, _utf8_casefold);
>>> +DEFINE_STATIC_CALL(utf8_casefold_hash, _utf8_casefold_hash);
>>> +DEFINE_STATIC_CALL(utf8_load, _utf8_load);
>>> +DEFINE_STATIC_CALL_NULL(utf8_unload, _utf8_unload);
>>> +EXPORT_STATIC_CALL(utf8_strncmp);
>>> +EXPORT_STATIC_CALL(utf8_strncasecmp);
>>> +EXPORT_STATIC_CALL(utf8_strncasecmp_folded);
>> I'm having a hard time understanding why some use
>> DEFINE_STATIC_CALL_NULL, while other use DEFINE_STATIC_CALL.  This new
>> static call API is new to me :).  None of this can be called if the
>> module is not loaded anyway, so perhaps the default function can just be
>> NULL, per the documentation of include/linux/static_call.h?
>>
>> Anyway, Aren't utf8_{validate,casefold,normalize} missing the
>> equivalent EXPORT_STATIC_CALL?
>>
> The static_call API is fairly new to me too.  But the intent of this patch seems
> to be that none of the utf8 functions are called without the utf8 module loaded.
> If they are called, it's a kernel bug.  So there are two options for what to do
> if it happens anyway:
>
>    1. call a "null" static call, which does nothing
>
> *or*
>
>    2. call a default function which does WARN_ON_ONCE() and returns an error if
>       possible.
>
> (or 3. don't use static calls and instead dereference a NULL utf8_ops like
> previous versions of this patch did.)
>
> It shouldn't really matter which of these approaches you take, but please be
> consistent and use the same one everywhere.
>
>> + void unicode_unregister(void)
>> + {
>> +         spin_lock(&utf8ops_lock);
>> +         utf8_ops = NULL;
>> +         spin_unlock(&utf8ops_lock);
>> + }
>> + EXPORT_SYMBOL(unicode_unregister);
> This should restore the static calls to their default values (either NULL or the
> default functions, depending on what you decide).
>
> Also, it's weird to still have the utf8_ops structure when using static calls.
> It seems it should be one way or the other: static calls *or* utf8_ops.
>
> The static calls could be exported, and the module could be responsible for
> updating them.  That would eliminate the need for utf8_ops.


Hmmm yes, I think we are just using utf8_ops for getting the owner details
which we can now remove and instead pass it as an argument while 
registering the module.
Will make this change in v4. Thanks


>
> - Eric
