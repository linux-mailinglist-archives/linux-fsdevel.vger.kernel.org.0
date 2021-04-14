Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF135F307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhDNL5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 07:57:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44504 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhDNL5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:57:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 6212B1F4226E
Subject: Re: [PATCH v7 4/4] fs: unicode: Add utf8 module and a unicode layer
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, drosen@google.com, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com, ebiggers@google.com
References: <20210407144845.53266-1-shreeya.patel@collabora.com>
 <20210407144845.53266-5-shreeya.patel@collabora.com>
 <875z0wvbhj.fsf@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <df4cff9b-86b3-0d6c-e757-46659a93910c@collabora.com>
Date:   Wed, 14 Apr 2021 17:26:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <875z0wvbhj.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 09/04/21 12:40 am, Gabriel Krisman Bertazi wrote:
> Shreeya Patel <shreeya.patel@collabora.com> writes:
>
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions.
>> It is not necessary to load this large table in the kernel if no
>> filesystem is using it, hence make UTF-8 encoding loadable by converting
>> it into a module.
>>
>> Modify the file called unicode-core which will act as a layer for
>> unicode subsystem. It will load the UTF-8 module and access it's functions
>> whenever any filesystem that needs unicode is mounted.
>> Currently, only UTF-8 encoding is supported but if any other encodings
>> are supported in future then the layer file would be responsible for
>> loading the desired encoding module.
>>
>> Also, indirect calls using function pointers are slow, use static calls to
>> avoid overhead caused in case of repeated indirect calls. Static calls
>> improves the performance by directly calling the functions as opposed to
>> indirect calls.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>> Changes in v7
>>    - Update the help text in Kconfig
>>    - Handle the unicode_load_static_call function failure by decrementing
>>      the reference.
>>    - Correct the code for handling built-in utf8 option as well.
>>    - Correct the synchronization for accessing utf8mod.
>>    - Make changes to unicode_unload() for handling the situation where
>>      utf8mod != NULL and um == NULL.
>>
>> Changes in v6
>>    - Add spinlock to protect utf8mod and avoid NULL pointer
>>      dereference.
>>    - Change the static call function names for being consistent with
>>      kernel coding style.
>>    - Merge the unicode_load_module function with unicode_load as it is
>>      not really needed to have a separate function.
>>    - Use try_then_module_get instead of module_get to avoid loading the
>>      module even when it is already loaded.
>>    - Improve the commit message.
>>
>> Changes in v5
>>    - Rename global variables and default static call functions for better
>>      understanding
>>    - Make only config UNICODE_UTF8 visible and config UNICODE to be always
>>      enabled provided UNICODE_UTF8 is enabled.
>>    - Improve the documentation for Kconfig
>>    - Improve the commit message.
>>   
>> Changes in v4
>>    - Return error from the static calls instead of doing nothing and
>>      succeeding even without loading the module.
>>    - Remove the complete usage of utf8_ops and use static calls at all
>>      places.
>>    - Restore the static calls to default values when module is unloaded.
>>    - Decrement the reference of module after calling the unload function.
>>    - Remove spinlock as there will be no race conditions after removing
>>      utf8_ops.
>>
>> Changes in v3
>>    - Add a patch which checks if utf8 is loaded before calling utf8_unload()
>>      in ext4 and f2fs filesystems
>>    - Return error if strscpy() returns value < 0
>>    - Correct the conditions to prevent NULL pointer dereference while
>>      accessing functions via utf8_ops variable.
>>    - Add spinlock to avoid race conditions.
>>    - Use static_call() for preventing speculative execution attacks.
>>
>> Changes in v2
>>    - Remove the duplicate file from the last patch.
>>    - Make the wrapper functions inline.
>>    - Remove msleep and use try_module_get() and module_put()
>>      for ensuring that module is loaded correctly and also
>>      doesn't get unloaded while in use.
>>    - Resolve the warning reported by kernel test robot.
>>    - Resolve all the checkpatch.pl warnings.
>>
>>   fs/unicode/Kconfig        |  26 +++-
>>   fs/unicode/Makefile       |   5 +-
>>   fs/unicode/unicode-core.c | 297 ++++++++++++++------------------------
>>   fs/unicode/unicode-utf8.c | 264 +++++++++++++++++++++++++++++++++
>>   include/linux/unicode.h   |  96 ++++++++++--
>>   5 files changed, 483 insertions(+), 205 deletions(-)
>>   create mode 100644 fs/unicode/unicode-utf8.c
>>
>> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
>> index 2c27b9a5cd6c..0c69800a2a37 100644
>> --- a/fs/unicode/Kconfig
>> +++ b/fs/unicode/Kconfig
>> @@ -2,13 +2,31 @@
>>   #
>>   # UTF-8 normalization
>>   #
>> +# CONFIG_UNICODE will be automatically enabled if CONFIG_UNICODE_UTF8
>> +# is enabled. This config option adds the unicode subsystem layer which loads
>> +# the UTF-8 module whenever any filesystem needs it.
>>   config UNICODE
>> -	bool "UTF-8 normalization and casefolding support"
>> +	bool
>> +
>> +config UNICODE_UTF8
>> +	tristate "UTF-8 module"
> "UTF-8 module" is the text that will appear in menuconfig and other
> configuration utilities.  This string not very helpful to describe what
> this code is about or why it is different from NLS_utf8.  People come to
> this option looking for the case-insensitive feature in ext4, so I'd
> prefer to keep the mention to 'casefolding'. or even improve the
> original a bit to say:
>
> tristate: "UTF-8 support for native Case-Insensitive filesystems"
>
> Other than these and what Eric mentioned, the code looks good to me.


Thanks Gabriel and Eric for your reviews.


>    I
> gave this series a try and it seems to work fine.
>
> It does raise a new warning, though
>
> /home/krisman/src/linux/fs/unicode/unicode-core.c: In function ‘unicode_load’:
> /home/krisman/src/linux/include/linux/kmod.h:28:8: warning: the omitted middle operand in ‘?:’ will always be ‘true’, suggest explicit middle operand [-Wparentheses]
>     28 |  ((x) ?: (__request_module(true, mod), (x)))
>        |        ^
> /home/krisman/src/linux/fs/unicode/unicode-core.c:123:7: note: in expansion of macro ‘try_then_request_module’
>    123 |  if (!try_then_request_module(utf8mod_get(), "utf8")) {
>
> But in this specific case, i think gcc is just being silly. What would
> be the right way to avoid it?


There are two possible things that we can do here to suppress the warning

1. Disable the warning using pragma with something like this :-

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wparentheses"
     if(!try_then_request_module(utf8mod_get(), "utf8"))
#pragma GCC diagnostic pop


2. Add the following in fs/unicode/Makefile

KBUILD_CFLAGS += $(call cc-disable-warning, parentheses)
But this would disable the warning for the complete unicode subsystem 
which doesn't seem to be right.
It would also disable some other crucial warning generated by Wparantheses.

What do you think about the first option? I am not sure if this is the 
right way to fix this.


