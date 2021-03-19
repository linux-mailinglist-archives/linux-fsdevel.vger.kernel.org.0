Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4ED3419ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 11:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCSK1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCSK1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:27:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3CC06174A;
        Fri, 19 Mar 2021 03:27:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 06C741F466D1
Subject: Re: [PATCH v2 4/4] fs: unicode: Add utf8 module and a unicode layer
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, drosen@google.com, ebiggers@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
 <20210318133305.316564-5-shreeya.patel@collabora.com>
 <87sg4si6b4.fsf@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <fcd0f413-0ae9-db25-0e0d-8d48e24f3ce6@collabora.com>
Date:   Fri, 19 Mar 2021 15:56:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87sg4si6b4.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/21 1:27 am, Gabriel Krisman Bertazi wrote:
> Shreeya,
>
Hi Gabriel,

Thanks for your detailed review. Please find my comments inline.
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions.
>> It is not necessary to carry this large table in the kernel hence make
>>
> Thanks for the v2.  This is looking much better!  I have a few comments
> inline.
>
> I also have a question about how this patchset was tested.  Did you run
> the normalization test (UNICODE_NORMALIZATION_SELFTEST)?  What about
> actual filesystems?


Yes I did run the normalization test by loading the utf8-selftest.ko module.
modprobe utf8-selftest


For actual filesystem check I followed the blog post written by you.
https://www.collabora.com/news-and-blog/blog/2020/08/27/using-the-linux-kernel-case-insensitive-feature-in-ext4/
So the basic steps that were followed are as follows :-
1. mkfs -t ext4 -O casefold image.img
2. mount image.img /mnt ( This step would load the module )
3. cd /mnt
4. mkdir CI_dir
5. touch CI_dir/hello_world ( this step would call the inline functions )
6. ls CI_dir/HELLO_WORLD (HELLO_WORLD file should be found if our 
case-insensitive fs is working as expected.)


>
> Minor nit:
>
> "It is not necessary to load this large table in the kernel in the
> kernel if no file system is using it"
>
>> UTF-8 encoding loadable by converting it into a module.
>> Also, modify the file called unicode-core which will act as a layer for
>> unicode subsystem. It will load the UTF-8 module and access it's functions
>> whenever any filesystem that needs unicode is mounted.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>>
>> Changes in v2
>>    - Remove the duplicate file utf8-core.c
>>    - Make the wrapper functions inline.
>>    - Remove msleep and use try_module_get() and module_put()
>>      for ensuring that module is loaded correctly and also
>>      doesn't get unloaded while in use.
>>   fs/unicode/Kconfig        |  11 +-
>>   fs/unicode/Makefile       |   5 +-
>>   fs/unicode/unicode-core.c | 229 +++++------------------------------
>>   fs/unicode/utf8mod.c      | 246 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/unicode.h   |  73 ++++++++---
>>   5 files changed, 346 insertions(+), 218 deletions(-)
>>   create mode 100644 fs/unicode/utf8mod.c
>>
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
>>   config UNICODE_NORMALIZATION_SELFTEST
>>   	tristate "Test UTF-8 normalization support"
>> -	depends on UNICODE
>> +	depends on UNICODE_UTF8
>>   	default n
>> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
>> index fbf9a629ed0d..9dbb04194b32 100644
>> --- a/fs/unicode/Makefile
>> +++ b/fs/unicode/Makefile
>> @@ -1,11 +1,14 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>>   obj-$(CONFIG_UNICODE) += unicode.o
>> +obj-$(CONFIG_UNICODE_UTF8) += utf8.o
>>   obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
>>   
>> -unicode-y := utf8-norm.o unicode-core.o
>> +unicode-y := unicode-core.o
>> +utf8-y := utf8mod.o utf8-norm.o
>>   
>>   $(obj)/utf8-norm.o: $(obj)/utf8data.h
>> +$(obj)/utf8mod.o: $(obj)/utf8-norm.o
>>   
>>   # In the normal build, the checked-in utf8data.h is just shipped.
>>   #
>> diff --git a/fs/unicode/unicode-core.c b/fs/unicode/unicode-core.c
>> index 287a8a48836c..945984a3fe9e 100644
>> --- a/fs/unicode/unicode-core.c
>> +++ b/fs/unicode/unicode-core.c
>> @@ -1,235 +1,60 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>> -#include <linux/string.h>
>>   #include <linux/slab.h>
>> -#include <linux/parser.h>
>>   #include <linux/errno.h>
>>   #include <linux/unicode.h>
>> -#include <linux/stringhash.h>
>>   
>> -#include "utf8n.h"
>>   
>> -int unicode_validate(const struct unicode_map *um, const struct qstr *str)
>> -{
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -
>> -	if (utf8nlen(data, str->name, str->len) < 0)
>> -		return -1;
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(unicode_validate);
>> -
>> -int unicode_strncmp(const struct unicode_map *um,
>> -		    const struct qstr *s1, const struct qstr *s2)
>> -{
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -	struct utf8cursor cur1, cur2;
>> -	int c1, c2;
>> -
>> -	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
>> -		return -EINVAL;
>> -
>> -	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
>> -		return -EINVAL;
>> -
>> -	do {
>> -		c1 = utf8byte(&cur1);
>> -		c2 = utf8byte(&cur2);
>> -
>> -		if (c1 < 0 || c2 < 0)
>> -			return -EINVAL;
>> -		if (c1 != c2)
>> -			return 1;
>> -	} while (c1);
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(unicode_strncmp);
>> -
>> -int unicode_strncasecmp(const struct unicode_map *um,
>> -			const struct qstr *s1, const struct qstr *s2)
>> -{
>> -	const struct utf8data *data = utf8nfdicf(um->version);
>> -	struct utf8cursor cur1, cur2;
>> -	int c1, c2;
>> +struct unicode_ops *utf8_ops;
>> +EXPORT_SYMBOL(utf8_ops);
>>   
>> -	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
>> -		return -EINVAL;
>> -
>> -	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
>> -		return -EINVAL;
>> -
>> -	do {
>> -		c1 = utf8byte(&cur1);
>> -		c2 = utf8byte(&cur2);
>> -
>> -		if (c1 < 0 || c2 < 0)
>> -			return -EINVAL;
>> -		if (c1 != c2)
>> -			return 1;
>> -	} while (c1);
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(unicode_strncasecmp);
>> -
>> -/* String cf is expected to be a valid UTF-8 casefolded
>> - * string.
>> - */
>> -int unicode_strncasecmp_folded(const struct unicode_map *um,
>> -			       const struct qstr *cf,
>> -			       const struct qstr *s1)
>> +static int unicode_load_module(void)
>>   {
>> -	const struct utf8data *data = utf8nfdicf(um->version);
>> -	struct utf8cursor cur1;
>> -	int c1, c2;
>> -	int i = 0;
>> -
>> -	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
>> -		return -EINVAL;
>> -
>> -	do {
>> -		c1 = utf8byte(&cur1);
>> -		c2 = cf->name[i++];
>> -		if (c1 < 0)
>> -			return -EINVAL;
>> -		if (c1 != c2)
>> -			return 1;
>> -	} while (c1);
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(unicode_strncasecmp_folded);
>> -
>> -int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
>> -		     unsigned char *dest, size_t dlen)
>> -{
>> -	const struct utf8data *data = utf8nfdicf(um->version);
>> -	struct utf8cursor cur;
>> -	size_t nlen = 0;
>> -
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> +	int ret = request_module("utf8");
>>   
>> -	for (nlen = 0; nlen < dlen; nlen++) {
>> -		int c = utf8byte(&cur);
>> -
>> -		dest[nlen] = c;
>> -		if (!c)
>> -			return nlen;
>> -		if (c == -1)
>> -			break;
>> +	if (ret) {
>> +		pr_err("Failed to load UTF-8 module\n");
>> +		return ret;
>>   	}
>> -	return -EINVAL;
>> -}
>> -EXPORT_SYMBOL(unicode_casefold);
>> -
>> -int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
>> -			  struct qstr *str)
>> -{
>> -	const struct utf8data *data = utf8nfdicf(um->version);
>> -	struct utf8cursor cur;
>> -	int c;
>> -	unsigned long hash = init_name_hash(salt);
>>   
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> -
>> -	while ((c = utf8byte(&cur))) {
>> -		if (c < 0)
>> -			return -EINVAL;
>> -		hash = partial_name_hash((unsigned char)c, hash);
>> -	}
>> -	str->hash = end_name_hash(hash);
>>   	return 0;
>>   }
>> -EXPORT_SYMBOL(unicode_casefold_hash);
>>   
>> -int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
>> -		      unsigned char *dest, size_t dlen)
>> +struct unicode_map *unicode_load(const char *version)
>>   {
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -	struct utf8cursor cur;
>> -	ssize_t nlen = 0;
>> +	int ret = unicode_load_module();
>>   
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> +	if (ret)
>> +		return ERR_PTR(ret);
>>   
>> -	for (nlen = 0; nlen < dlen; nlen++) {
>> -		int c = utf8byte(&cur);
>> +	if (utf8_ops && !try_module_get(utf8_ops->owner))
>> +		return ERR_PTR(-ENODEV);
>>   
>> -		dest[nlen] = c;
>> -		if (!c)
>> -			return nlen;
>> -		if (c == -1)
>> -			break;
>> -	}
>> -	return -EINVAL;
>> +	else
>> +		return utf8_ops->load(version);
> This patch is a bit hard to review with the way git separated the
> hunks. I think you should be able to regenerate it in a simpler form
> by tinkering with git-format-patch parameters.


I agree, I will make sure to format it nicely for v3.

>
> Here, it seems that if utf8_ops is NULL (the first condition of the if
> leg), the else leg dereferences a NULL pointer by calling
> utf8_ops->load(), which can't be right.


Ah, right.

> Maybe, the if leg should be:
>
> if (!utf8_ops || !try_module_get(utf8_ops->owner)
>     return ERR_PTR(-ENODEV)
>
> But this is still racy, since you are not protecting utf8_ops before
> acquiring the reference.  If you race with module removal here, a
> NULL ptr dereference can still occur.  See below.


If module is removed before reaching this step, then unicode_unregister
function would make utf8_ops NULL. So the first condition of if will be true
and it will return error so how can we have a NULL ptr dereference then?
>>   }
>> -EXPORT_SYMBOL(unicode_normalize);
>> +EXPORT_SYMBOL(unicode_load);
>>   
>> -static int unicode_parse_version(const char *version, unsigned int *maj,
>> -				 unsigned int *min, unsigned int *rev)
>> +void unicode_unload(struct unicode_map *um)
>>   {
>> -	substring_t args[3];
>> -	char version_string[12];
>> -	static const struct match_token token[] = {
>> -		{1, "%d.%d.%d"},
>> -		{0, NULL}
>> -	};
>> -
>> -	strscpy(version_string, version, sizeof(version_string));
>> -
>> -	if (match_token(version_string, token, args) != 1)
>> -		return -EINVAL;
>> +	if (utf8_ops)
>> +		module_put(utf8_ops->owner);
>>
> How can we have a unicode_map to free if utf8_ops is NULL?  that seems
> to be an invalid use of API, which suggests a bug elsewhere
> in the kernel.  maybe this should read like this:
>
> void unicode_unload(struct unicode_map *um)
> {
>    if (WARN_ON(!utf8_ops))
>      return;
>
>    module_put(utf8_ops->owner);
>    kfree(um);
> }


The reason for adding the check if(utf8_ops) is that some of the filesystem
calls the unicode_unload function even before calling the unicode_load 
function.
if we try to decrement the reference without even having the reference. 
( i.e. not loading the module )
it would result in kernel panic.
fs/ext4/super.c
fs/f2fs/super.c
Both the above files call the unicode_unload function if CONFIG_UNICODE 
is enabled.
Not sure if this is an odd behavior or expected.


>> -	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
>> -	    match_int(&args[2], rev))
>> -		return -EINVAL;
>> -
>> -	return 0;
>> +	kfree(um);
>>   }
>> +EXPORT_SYMBOL(unicode_unload);
>>   
>> -struct unicode_map *unicode_load(const char *version)
>> +void unicode_register(struct unicode_ops *ops)
>>   {
>> -	struct unicode_map *um = NULL;
>> -	int unicode_version;
>> -
>> -	if (version) {
>> -		unsigned int maj, min, rev;
>> -
>> -		if (unicode_parse_version(version, &maj, &min, &rev) < 0)
>> -			return ERR_PTR(-EINVAL);
>> -
>> -		if (!utf8version_is_supported(maj, min, rev))
>> -			return ERR_PTR(-EINVAL);
>> -
>> -		unicode_version = UNICODE_AGE(maj, min, rev);
>> -	} else {
>> -		unicode_version = utf8version_latest();
>> -		printk(KERN_WARNING"UTF-8 version not specified. "
>> -		       "Assuming latest supported version (%d.%d.%d).",
>> -		       (unicode_version >> 16) & 0xff,
>> -		       (unicode_version >> 8) & 0xff,
>> -		       (unicode_version & 0xff));
>> -	}
>> -
>> -	um = kzalloc(sizeof(struct unicode_map), GFP_KERNEL);
>> -	if (!um)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> -	um->charset = "UTF-8";
>> -	um->version = unicode_version;
>> -
>> -	return um;
>> +	utf8_ops = ops;
> While we guarantee that utf8_ops isn't modified when a unicode_map is
> in-use by acquiring the module reference, registering/unregistering the
> module should be protected, to avoid that race I mentioned above.
>
>>   }
>> -EXPORT_SYMBOL(unicode_load);
>> +EXPORT_SYMBOL(unicode_register);
>>   
>> -void unicode_unload(struct unicode_map *um)
>> +void unicode_unregister(void)
>>   {
>> -	kfree(um);
>> +	utf8_ops = NULL;
>>   }
>> -EXPORT_SYMBOL(unicode_unload);
>> +EXPORT_SYMBOL(unicode_unregister);
>>   
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/fs/unicode/utf8mod.c b/fs/unicode/utf8mod.c
>> new file mode 100644
>> index 000000000000..9981960da863
>> --- /dev/null
>> +++ b/fs/unicode/utf8mod.c
> This is a bit nitpicky, but can you follow the naming scheme and call
> this file unicode-utf8.c or maybe utf8-mod.c ?


Sure, will name it as uncide-utf8.c

>
