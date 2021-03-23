Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F00346BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhCWWNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:13:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55156 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhCWWMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:12:42 -0400
Received: from [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147] (unknown [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8FA6F1F44AD4;
        Tue, 23 Mar 2021 22:12:35 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] fs: unicode: Add utf8 module and a unicode layer
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, ebiggers@google.com, drosen@google.com,
        ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
References: <20210323183201.812944-1-shreeya.patel@collabora.com>
 <20210323183201.812944-6-shreeya.patel@collabora.com>
 <87eeg5d4xb.fsf@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <ef5d98b8-391c-22b6-215f-c8103496ca50@collabora.com>
Date:   Wed, 24 Mar 2021 03:42:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87eeg5d4xb.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/03/21 1:21 am, Gabriel Krisman Bertazi wrote:
> Shreeya Patel <shreeya.patel@collabora.com> writes:
>
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions.
>> It is not necessary to load this large table in the kernel if no
>> file system is using it, hence make UTF-8 encoding loadable by converting
>> it into a module.
>> Modify the file called unicode-core which will act as a layer for
>> unicode subsystem. It will load the UTF-8 module and access it's functions
>> whenever any filesystem that needs unicode is mounted.
>> Also, indirect calls using function pointers are easily exploitable by
>> speculative execution attacks, hence use static_call() in unicode.h and
>> unicode-core.c files inorder to prevent these attacks by making direct
>> calls and also to improve the performance of function pointers.
>>
> This static call mechanism is indeed really interesting.  Thanks for
> doing it.  A few comments inline
>
>> ---
>>
>> Changes in v3
>>    - Correct the conditions to prevent NULL pointer dereference while
>>      accessing functions via utf8_ops variable.
>>    - Add spinlock to avoid race conditions that could occur if the module
>>      is deregistered after checking utf8_ops and before doing the
>>      try_module_get() in the following if condition
>>      if (!utf8_ops || !try_module_get(utf8_ops->owner)
>>    - Use static_call() for preventing speculative execution attacks.
>>    - WARN_ON in case utf8_ops is NULL in unicode_unload().
>>    - Rename module file from utf8mod to unicode-utf8.
>>
>> Changes in v2
>>    - Remove the duplicate file utf8-core.c
>>    - Make the wrapper functions inline.
>>    - Remove msleep and use try_module_get() and module_put()
>>      for ensuring that module is loaded correctly and also
>>      doesn't get unloaded while in use.
>>
>>   fs/unicode/Kconfig        |  11 +-
>>   fs/unicode/Makefile       |   5 +-
>>   fs/unicode/unicode-core.c | 268 +++++++++++++-------------------------
>>   fs/unicode/unicode-utf8.c | 255 ++++++++++++++++++++++++++++++++++++
>>   include/linux/unicode.h   |  99 ++++++++++++--
>>   5 files changed, 441 insertions(+), 197 deletions(-)
>>   create mode 100644 fs/unicode/unicode-utf8.c
>>
>> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
>> index 2c27b9a5c..2961b0206 100644
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
>> +utf8-y := unicode-utf8.o utf8-norm.o
>>   
>>   $(obj)/utf8-norm.o: $(obj)/utf8data.h
>> +$(obj)/unicode-utf8.o: $(obj)/utf8-norm.o
>>   
>>   # In the normal build, the checked-in utf8data.h is just shipped.
>>   #
>> --- a/fs/unicode/unicode-core.c
>> +++ b/fs/unicode/unicode-core.c
>> @@ -1,238 +1,144 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>> -#include <linux/string.h>
>>   #include <linux/slab.h>
>> -#include <linux/parser.h>
>>   #include <linux/errno.h>
>>   #include <linux/unicode.h>
>> -#include <linux/stringhash.h>
>> +#include <linux/spinlock.h>
>>   
>> -#include "utf8n.h"
>> +DEFINE_SPINLOCK(utf8ops_lock);
>>   
>> -int unicode_validate(const struct unicode_map *um, const struct qstr *str)
>> -{
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -
>> -	if (utf8nlen(data, str->name, str->len) < 0)
>> -		return -1;
>> -	return 0;
>> -}
>> +struct unicode_ops *utf8_ops;
>> +EXPORT_SYMBOL(utf8_ops);
>> +
>> +int _utf8_validate(const struct unicode_map *um, const struct qstr *str)
>> +{
>> +	return 0;
>> +}
>> -EXPORT_SYMBOL(unicode_validate);
> I think that any calls to the default static calls should return errors
> instead of succeeding without doing anything.
>
> In fact, are the default calls really necessary?


I used DEFINE_STATIC_CALL() for functions having non-void return type and
it isn't possible to return nothing from it and hence had to use return 0.
But as you and Eric said, succeeding without doing anything doesn't seem 
right
so I'll use DEFINE_STATIC_CALL_NULL() which would allow me to return 
nothing.


>    If someone gets here,
> there is a bug elsewhere, so WARN_ON and maybe -EIO.
>
> int unicode_validate_default_static_call(...)
> {
>     WARN_ON(1);
>     return -EIO;
> }
>
> Or just have a NULL default, as I mentioned below, if that is possible.
>
> Eric?
>
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
>> +int _utf8_strncmp(const struct unicode_map *um, const struct qstr *s1,
>> +		  const struct qstr *s2)
>> +{
>> +	return 0;
>> +}
>> -EXPORT_SYMBOL(unicode_strncmp);
>>   
>> -int unicode_strncasecmp(const struct unicode_map *um,
>> -			const struct qstr *s1, const struct qstr *s2)
>> -{
>> -	const struct utf8data *data = utf8nfdicf(um->version);
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
>> +int _utf8_strncasecmp(const struct unicode_map *um, const struct qstr *s1,
>> +		      const struct qstr *s2)
>> +{
>> +	return 0;
>> +}
>> -EXPORT_SYMBOL(unicode_strncasecmp);
>>   
>> -/* String cf is expected to be a valid UTF-8 casefolded
>> - * string.
>> - */
>> -int unicode_strncasecmp_folded(const struct unicode_map *um,
>> -			       const struct qstr *cf,
>> -			       const struct qstr *s1)
>> -{
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
>> +int _utf8_strncasecmp_folded(const struct unicode_map *um,
>> +			     const struct qstr *cf, const struct qstr *s1)
>> +{
>> +	return 0;
>> +}
>> -EXPORT_SYMBOL(unicode_strncasecmp_folded);
>>   
>> -int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
>> -		     unsigned char *dest, size_t dlen)
>> -{
>> -	const struct utf8data *data = utf8nfdicf(um->version);
>> -	struct utf8cursor cur;
>> -	size_t nlen = 0;
>> -
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> -
>> -	for (nlen = 0; nlen < dlen; nlen++) {
>> -		int c = utf8byte(&cur);
>> -
>> -		dest[nlen] = c;
>> -		if (!c)
>> -			return nlen;
>> -		if (c == -1)
>> -			break;
>> -	}
>> -	return -EINVAL;
>> -}
>> +int _utf8_normalize(const struct unicode_map *um, const struct qstr *str,
>> +		    unsigned char *dest, size_t dlen)
>> +{
>> +	return 0;
>> +}
>> -EXPORT_SYMBOL(unicode_casefold);
>>   
>> -int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
>> -			  struct qstr *str)
>> -{
>> -	const struct utf8data *data = utf8nfdicf(um->version);
>> -	struct utf8cursor cur;
>> -	int c;
>> -	unsigned long hash = init_name_hash(salt);
>> -
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> -
>> -	while ((c = utf8byte(&cur))) {
>> -		if (c < 0)
>> -			return -EINVAL;
>> -		hash = partial_name_hash((unsigned char)c, hash);
>> -	}
>> -	str->hash = end_name_hash(hash);
>> -	return 0;
>> -}
>> +int _utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>> +		   unsigned char *dest, size_t dlen)
>> +{
>> +	return 0;
>> +}
>> -EXPORT_SYMBOL(unicode_casefold_hash);
>>   
>> -int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
>> -		      unsigned char *dest, size_t dlen)
>> -{
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -	struct utf8cursor cur;
>> -	ssize_t nlen = 0;
>> -
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> -
>> -	for (nlen = 0; nlen < dlen; nlen++) {
>> -		int c = utf8byte(&cur);
>> -
>> -		dest[nlen] = c;
>> -		if (!c)
>> -			return nlen;
>> -		if (c == -1)
>> -			break;
>> -	}
>> -	return -EINVAL;
>> -}
>> +int _utf8_casefold_hash(const struct unicode_map *um, const void *salt,
>> +			struct qstr *str)
>> +{
>> +	return 0;
>> +}
>> +
>> +struct unicode_map *_utf8_load(const char *version)
>> +{
>> +	return NULL;
>> +}
>> -EXPORT_SYMBOL(unicode_normalize);
>>   
>> -static int unicode_parse_version(const char *version, unsigned int *maj,
>> -				 unsigned int *min, unsigned int *rev)
>> -{
>> -	substring_t args[3];
>> -	char version_string[12];
>> -	static const struct match_token token[] = {
>> -		{1, "%d.%d.%d"},
>> -		{0, NULL}
>> -	};
>> -
>> -	int ret = strscpy(version_string, version, sizeof(version_string));
>> -
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	if (match_token(version_string, token, args) != 1)
>> -		return -EINVAL;
>> -
>> -	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
>> -	    match_int(&args[2], rev))
>> -		return -EINVAL;
>> -
>> -	return 0;
>> -}
>> +void _utf8_unload(struct unicode_map *um)
>> +{
>> +	return;
>> +}
>> +
>> +DEFINE_STATIC_CALL(utf8_validate, _utf8_validate);
>> +DEFINE_STATIC_CALL(utf8_strncmp, _utf8_strncmp);
>> +DEFINE_STATIC_CALL(utf8_strncasecmp, _utf8_strncasecmp);
>> +DEFINE_STATIC_CALL(utf8_strncasecmp_folded, _utf8_strncasecmp_folded);
>> +DEFINE_STATIC_CALL(utf8_normalize, _utf8_normalize);
>> +DEFINE_STATIC_CALL(utf8_casefold, _utf8_casefold);
>> +DEFINE_STATIC_CALL(utf8_casefold_hash, _utf8_casefold_hash);
>> +DEFINE_STATIC_CALL(utf8_load, _utf8_load);
>> +DEFINE_STATIC_CALL_NULL(utf8_unload, _utf8_unload);
>> +EXPORT_STATIC_CALL(utf8_strncmp);
>> +EXPORT_STATIC_CALL(utf8_strncasecmp);
>> +EXPORT_STATIC_CALL(utf8_strncasecmp_folded);
> I'm having a hard time understanding why some use
> DEFINE_STATIC_CALL_NULL, while other use DEFINE_STATIC_CALL.  This new
> static call API is new to me :).  None of this can be called if the
> module is not loaded anyway, so perhaps the default function can just be
> NULL, per the documentation of include/linux/static_call.h?
>
> Anyway, Aren't utf8_{validate,casefold,normalize} missing the
> equivalent EXPORT_STATIC_CALL?


These functions aren't used by utf8-selftest.c files and hence there is 
no need to
export them.


>> +
>> +static int unicode_load_module(void)
>> +{
>> +	int ret = request_module("utf8");
>> +
>> +	if (ret) {
>> +		pr_err("Failed to load UTF-8 module\n");
>> +		return ret;
>> +	}
>> +	return 0;
>> +}
>>   
>>   struct unicode_map *unicode_load(const char *version)
>> -{
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
>> -}
>> +{
>> +	int ret = unicode_load_module();
>> +
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	spin_lock(&utf8ops_lock);
>> +	if (!utf8_ops || !try_module_get(utf8_ops->owner)) {
>> +		spin_unlock(&utf8ops_lock);
>> +		return ERR_PTR(-ENODEV);
>> +	} else {
>> +		spin_unlock(&utf8ops_lock);
>> +		return static_call(utf8_load)(version);
>> +	}
>> +}
>>   EXPORT_SYMBOL(unicode_load);
>>   
>>   void unicode_unload(struct unicode_map *um)
>>   {
>> -	kfree(um);
>> +	if (WARN_ON(!utf8_ops))
>> +		return;
>> +
>> +	module_put(utf8_ops->owner);
>> +	static_call(utf8_unload)(um);
> The module reference drop should happen after utf8_unload to prevent
> calling utf8_unload after it is removed if you race with module removal.
>
