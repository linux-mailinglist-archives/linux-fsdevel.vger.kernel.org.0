Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96236341E6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSNe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCSNet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:34:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D9FC06174A;
        Fri, 19 Mar 2021 06:34:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 20C6B1F46912
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, drosen@google.com, ebiggers@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com
Subject: Re: [PATCH v2 4/4] fs: unicode: Add utf8 module and a unicode layer
Organization: Collabora
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
        <20210318133305.316564-5-shreeya.patel@collabora.com>
        <87sg4si6b4.fsf@collabora.com>
        <fcd0f413-0ae9-db25-0e0d-8d48e24f3ce6@collabora.com>
Date:   Fri, 19 Mar 2021 09:34:44 -0400
In-Reply-To: <fcd0f413-0ae9-db25-0e0d-8d48e24f3ce6@collabora.com> (Shreeya
        Patel's message of "Fri, 19 Mar 2021 15:56:59 +0530")
Message-ID: <877dm3i7wr.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> On 19/03/21 1:27 am, Gabriel Krisman Bertazi wrote:

>> Maybe, the if leg should be:
>>
>> if (!utf8_ops || !try_module_get(utf8_ops->owner)
>>     return ERR_PTR(-ENODEV)
>>
>> But this is still racy, since you are not protecting utf8_ops before
>> acquiring the reference.  If you race with module removal here, a
>> NULL ptr dereference can still occur.  See below.
>
>
> If module is removed before reaching this step, then unicode_unregister
> function would make utf8_ops NULL. So the first condition of if will be true
> and it will return error so how can we have a NULL ptr dereference
> then?

Hi Shreeya,

As we discussed offline, it can happen if the module is deregistered
after checking utf8_ops and before doing the try_module_get.

>>>   }
>>> -EXPORT_SYMBOL(unicode_normalize);
>>> +EXPORT_SYMBOL(unicode_load);
>>>   -static int unicode_parse_version(const char *version, unsigned int
>>> *maj,
>>> -				 unsigned int *min, unsigned int *rev)
>>> +void unicode_unload(struct unicode_map *um)
>>>   {
>>> -	substring_t args[3];
>>> -	char version_string[12];
>>> -	static const struct match_token token[] = {
>>> -		{1, "%d.%d.%d"},
>>> -		{0, NULL}
>>> -	};
>>> -
>>> -	strscpy(version_string, version, sizeof(version_string));
>>> -
>>> -	if (match_token(version_string, token, args) != 1)
>>> -		return -EINVAL;
>>> +	if (utf8_ops)
>>> +		module_put(utf8_ops->owner);
>>>
>> How can we have a unicode_map to free if utf8_ops is NULL?  that seems
>> to be an invalid use of API, which suggests a bug elsewhere
>> in the kernel.  maybe this should read like this:
>>
>> void unicode_unload(struct unicode_map *um)
>> {
>>    if (WARN_ON(!utf8_ops))
>>      return;
>>
>>    module_put(utf8_ops->owner);
>>    kfree(um);
>> }
>
>
> The reason for adding the check if(utf8_ops) is that some of the filesystem
> calls the unicode_unload function even before calling the unicode_load
> function.
> if we try to decrement the reference without even having the
> reference. ( i.e. not loading the module )
> it would result in kernel panic.
> fs/ext4/super.c
> fs/f2fs/super.c
> Both the above files call the unicode_unload function if CONFIG_UNICODE
> is enabled.
> Not sure if this is an odd behavior or expected.

Those seem to be error paths, where the mount fails before we get a
chance to load the unicode map.  I suggest we fix the callers to avoid
calling the unicode API unnecessarily.

-- 
Gabriel Krisman Bertazi
