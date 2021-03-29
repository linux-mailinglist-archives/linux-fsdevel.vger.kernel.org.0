Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEFB34DBFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 00:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhC2WjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 18:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhC2Wiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:38:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B9C061762;
        Mon, 29 Mar 2021 15:38:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 99FC41F4174D
Subject: Re: [PATCH v5 4/4] fs: unicode: Add utf8 module and a unicode layer
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, ebiggers@google.com, drosen@google.com,
        ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-5-shreeya.patel@collabora.com>
 <87o8f1r71p.fsf@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <bf430ae7-16a1-d4ca-3241-6f654524e7f9@collabora.com>
Date:   Tue, 30 Mar 2021 04:08:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87o8f1r71p.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 30/03/21 2:50 am, Gabriel Krisman Bertazi wrote:
> Shreeya Patel <shreeya.patel@collabora.com> writes:
>
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions.
>> It is not necessary to load this large table in the kernel if no
>> filesystem is using it, hence make UTF-8 encoding loadable by converting
>> it into a module.
>> Modify the file called unicode-core which will act as a layer for
>> unicode subsystem. It will load the UTF-8 module and access it's functions
>> whenever any filesystem that needs unicode is mounted.
>> Also, indirect calls using function pointers are slow, use static calls to
>> avoid overhead caused in case of repeated indirect calls. Static calls
>> improves the performance by directly calling the functions as opposed to
>> indirect calls.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
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
>>
>>   fs/unicode/Kconfig        |  17 ++-
>>   fs/unicode/Makefile       |   5 +-
>>   fs/unicode/unicode-core.c | 241 +++++++----------------------------
>>   fs/unicode/unicode-utf8.c | 256 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/unicode.h   | 123 +++++++++++++++---
>>   5 files changed, 426 insertions(+), 216 deletions(-)
>>   create mode 100644 fs/unicode/unicode-utf8.c
>>
>> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
>> index 2c27b9a5cd6c..ad4b837f2eb2 100644
>> --- a/fs/unicode/Kconfig
>> +++ b/fs/unicode/Kconfig
>> @@ -2,13 +2,26 @@
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
>> +# utf8data.h_shipped has a large database table which is an auto-generated
>> +# decodification trie for the unicode normalization functions and it is not
>> +# necessary to carry this large table in the kernel.
>> +# Enabling UNICODE_UTF8 option will allow UTF-8 encoding to be built as a
>> +# module and this module will be loaded by the unicode subsystem layer only
>> +# when any filesystem needs it.
>> +config UNICODE_UTF8
>> +	tristate "UTF-8 module"
>>   	help
>>   	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>>   	  support.
>> +	select UNICODE
>>   
>>   config UNICODE_NORMALIZATION_SELFTEST
>>   	tristate "Test UTF-8 normalization support"
>> -	depends on UNICODE
>> +	depends on UNICODE_UTF8
>>   	default n
>> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
>> index fbf9a629ed0d..49d50083e6ee 100644
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
>> diff --git a/fs/unicode/unicode-core.c b/fs/unicode/unicode-core.c
>> index 730dbaedf593..07d42f471e42 100644
>> --- a/fs/unicode/unicode-core.c
>> +++ b/fs/unicode/unicode-core.c
>> @@ -1,237 +1,80 @@
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
>> +static struct module *utf8mod;
>>   
>> -int unicode_validate(const struct unicode_map *um, const struct qstr *str)
>> -{
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> +DEFINE_STATIC_CALL(_unicode_validate, unicode_validate_default);
>> +EXPORT_STATIC_CALL(_unicode_validate);
>>   
>> -	if (utf8nlen(data, str->name, str->len) < 0)
>> -		return -1;
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(unicode_validate);
>> +DEFINE_STATIC_CALL(_unicode_strncmp, unicode_strncmp_default);
>> +EXPORT_STATIC_CALL(_unicode_strncmp);
>>   
>> -int unicode_strncmp(const struct unicode_map *um,
>> -		    const struct qstr *s1, const struct qstr *s2)
>> -{
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -	struct utf8cursor cur1, cur2;
>> -	int c1, c2;
>> +DEFINE_STATIC_CALL(_unicode_strncasecmp, unicode_strncasecmp_default);
>> +EXPORT_STATIC_CALL(_unicode_strncasecmp);
> Why are these here if the _default functions are defined in the header
> file?  I think the definitions could be in this file. No?


Inline functions defined in header file are using these functions so
cannot define them here in .c file.


>> -	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
>> -		return -EINVAL;
>> +DEFINE_STATIC_CALL(_unicode_strncasecmp_folded, unicode_strncasecmp_folded_default);
>> +EXPORT_STATIC_CALL(_unicode_strncasecmp_folded);
>>   
>> -	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
>> -		return -EINVAL;
>> +DEFINE_STATIC_CALL(_unicode_normalize, unicode_normalize_default);
>> +EXPORT_STATIC_CALL(_unicode_normalize);
>>   
>> -	do {
>> -		c1 = utf8byte(&cur1);
>> -		c2 = utf8byte(&cur2);
>> +DEFINE_STATIC_CALL(_unicode_casefold, unicode_casefold_default);
>> +EXPORT_STATIC_CALL(_unicode_casefold);
>>   
>> -		if (c1 < 0 || c2 < 0)
>> -			return -EINVAL;
>> -		if (c1 != c2)
>> -			return 1;
>> -	} while (c1);
>> +DEFINE_STATIC_CALL(_unicode_casefold_hash, unicode_casefold_hash_default);
>> +EXPORT_STATIC_CALL(_unicode_casefold_hash);
>>   
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(unicode_strncmp);
>> +DEFINE_STATIC_CALL(_unicode_load, unicode_load_default);
>> +EXPORT_STATIC_CALL(_unicode_load);
>>   
>> -int unicode_strncasecmp(const struct unicode_map *um,
>> -			const struct qstr *s1, const struct qstr *s2)
>> +static int unicode_load_module(void)
>>   {
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
>> -EXPORT_SYMBOL(unicode_strncasecmp);
>> -
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
>> -EXPORT_SYMBOL(unicode_casefold);
>> +	int ret = request_module("utf8");
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
>> +	if (ret) {
>> +		pr_err("Failed to load UTF-8 module\n");
>> +		return ret;
>>   	}
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
>> -
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> +	int ret = unicode_load_module();
> Splitting this in two functions sound unnecessary, since the other
> function just calls request_module.  By the way, is there any protection
> against calling request_module if the module is already loaded?  Surely
> that's not necessary, perhaps try_then_request_module(utf8mod, "utf8")?


Yes, try_then_request_module  would be a better choice.


>> -	for (nlen = 0; nlen < dlen; nlen++) {
>> -		int c = utf8byte(&cur);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>>   
>> -		dest[nlen] = c;
>> -		if (!c)
>> -			return nlen;
>> -		if (c == -1)
>> -			break;
>> -	}
>> -	return -EINVAL;
>> +	if (!try_module_get(utf8mod))
> Can't module_unregister be called in between the register_module and
> here, and then you have a bogus utf8mod pointer? true, try_module_get
> checks for NULL, but if you are unlucky module_is_live will it breaks.
> I still think utf8mod needs to be protected while you don't have a
> reference to the module.
>
>> +		return ERR_PTR(-ENODEV);
>> +	else
>> +		return static_call(_unicode_load)(version);
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
>> +	kfree(um);
>>   
>> -	return 0;
>> +	if (utf8mod)
>> +		module_put(utf8mod);
>>   }
>> +EXPORT_SYMBOL(unicode_unload);
>>   
>> -struct unicode_map *unicode_load(const char *version)
>> +void unicode_register(struct module *owner)
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
>> +	utf8mod = owner;
>>   }
>> -EXPORT_SYMBOL(unicode_load);
>> +EXPORT_SYMBOL(unicode_register);
>>   
>> -void unicode_unload(struct unicode_map *um)
>> +void unicode_unregister(void)
>>   {
>> -	kfree(um);
>> +	utf8mod = NULL;
>>   }
>> -EXPORT_SYMBOL(unicode_unload);
>> +EXPORT_SYMBOL(unicode_unregister);
>>   
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/fs/unicode/unicode-utf8.c b/fs/unicode/unicode-utf8.c
>> new file mode 100644
>> index 000000000000..9c6b58239067
>> --- /dev/null
>> +++ b/fs/unicode/unicode-utf8.c
>> @@ -0,0 +1,256 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/string.h>
>> +#include <linux/slab.h>
>> +#include <linux/parser.h>
>> +#include <linux/errno.h>
>> +#include <linux/unicode.h>
>> +#include <linux/stringhash.h>
>> +#include <linux/static_call.h>
>> +
>> +#include "utf8n.h"
>> +
>> +static int utf8_validate(const struct unicode_map *um, const struct qstr *str)
>> +{
>> +	const struct utf8data *data = utf8nfdi(um->version);
>> +
>> +	if (utf8nlen(data, str->name, str->len) < 0)
>> +		return -1;
>> +	return 0;
>> +}
>> +
>> +static int utf8_strncmp(const struct unicode_map *um,
>> +			const struct qstr *s1, const struct qstr *s2)
>> +{
>> +	const struct utf8data *data = utf8nfdi(um->version);
>> +	struct utf8cursor cur1, cur2;
>> +	int c1, c2;
>> +
>> +	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
>> +		return -EINVAL;
>> +
>> +	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
>> +		return -EINVAL;
>> +
>> +	do {
>> +		c1 = utf8byte(&cur1);
>> +		c2 = utf8byte(&cur2);
>> +
>> +		if (c1 < 0 || c2 < 0)
>> +			return -EINVAL;
>> +		if (c1 != c2)
>> +			return 1;
>> +	} while (c1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int utf8_strncasecmp(const struct unicode_map *um,
>> +			    const struct qstr *s1, const struct qstr *s2)
>> +{
>> +	const struct utf8data *data = utf8nfdicf(um->version);
>> +	struct utf8cursor cur1, cur2;
>> +	int c1, c2;
>> +
>> +	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
>> +		return -EINVAL;
>> +
>> +	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
>> +		return -EINVAL;
>> +
>> +	do {
>> +		c1 = utf8byte(&cur1);
>> +		c2 = utf8byte(&cur2);
>> +
>> +		if (c1 < 0 || c2 < 0)
>> +			return -EINVAL;
>> +		if (c1 != c2)
>> +			return 1;
>> +	} while (c1);
>> +
>> +	return 0;
>> +}
>> +
>> +/* String cf is expected to be a valid UTF-8 casefolded
>> + * string.
>> + */
>> +static int utf8_strncasecmp_folded(const struct unicode_map *um,
>> +				   const struct qstr *cf,
>> +				   const struct qstr *s1)
>> +{
>> +	const struct utf8data *data = utf8nfdicf(um->version);
>> +	struct utf8cursor cur1;
>> +	int c1, c2;
>> +	int i = 0;
>> +
>> +	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
>> +		return -EINVAL;
>> +
>> +	do {
>> +		c1 = utf8byte(&cur1);
>> +		c2 = cf->name[i++];
>> +		if (c1 < 0)
>> +			return -EINVAL;
>> +		if (c1 != c2)
>> +			return 1;
>> +	} while (c1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>> +			 unsigned char *dest, size_t dlen)
>> +{
>> +	const struct utf8data *data = utf8nfdicf(um->version);
>> +	struct utf8cursor cur;
>> +	size_t nlen = 0;
>> +
>> +	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> +		return -EINVAL;
>> +
>> +	for (nlen = 0; nlen < dlen; nlen++) {
>> +		int c = utf8byte(&cur);
>> +
>> +		dest[nlen] = c;
>> +		if (!c)
>> +			return nlen;
>> +		if (c == -1)
>> +			break;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
>> +			      struct qstr *str)
>> +{
>> +	const struct utf8data *data = utf8nfdicf(um->version);
>> +	struct utf8cursor cur;
>> +	int c;
>> +	unsigned long hash = init_name_hash(salt);
>> +
>> +	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> +		return -EINVAL;
>> +
>> +	while ((c = utf8byte(&cur))) {
>> +		if (c < 0)
>> +			return -EINVAL;
>> +		hash = partial_name_hash((unsigned char)c, hash);
>> +	}
>> +	str->hash = end_name_hash(hash);
>> +	return 0;
>> +}
>> +
>> +static int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
>> +			  unsigned char *dest, size_t dlen)
>> +{
>> +	const struct utf8data *data = utf8nfdi(um->version);
>> +	struct utf8cursor cur;
>> +	ssize_t nlen = 0;
>> +
>> +	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> +		return -EINVAL;
>> +
>> +	for (nlen = 0; nlen < dlen; nlen++) {
>> +		int c = utf8byte(&cur);
>> +
>> +		dest[nlen] = c;
>> +		if (!c)
>> +			return nlen;
>> +		if (c == -1)
>> +			break;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static int utf8_parse_version(const char *version, unsigned int *maj,
>> +			      unsigned int *min, unsigned int *rev)
>> +{
>> +	substring_t args[3];
>> +	char version_string[12];
>> +	static const struct match_token token[] = {
>> +		{1, "%d.%d.%d"},
>> +		{0, NULL}
>> +	};
>> +
>> +	int ret = strscpy(version_string, version, sizeof(version_string));
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (match_token(version_string, token, args) != 1)
>> +		return -EINVAL;
>> +
>> +	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
>> +	    match_int(&args[2], rev))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct unicode_map *utf8_load(const char *version)
>> +{
>> +	struct unicode_map *um = NULL;
>> +	int unicode_version;
>> +
>> +	if (version) {
>> +		unsigned int maj, min, rev;
>> +
>> +		if (utf8_parse_version(version, &maj, &min, &rev) < 0)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		if (!utf8version_is_supported(maj, min, rev))
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		unicode_version = UNICODE_AGE(maj, min, rev);
>> +	} else {
>> +		unicode_version = utf8version_latest();
>> +		pr_warn("UTF-8 version not specified. Assuming latest supported version (%d.%d.%d).",
>> +			(unicode_version >> 16) & 0xff,
>> +			(unicode_version >> 8) & 0xff,
>> +			(unicode_version & 0xfe));
>> +	}
>> +
>> +	um = kzalloc(sizeof(*um), GFP_KERNEL);
>> +	if (!um)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	um->charset = "UTF-8";
>> +	um->version = unicode_version;
>> +
>> +	return um;
>> +}
>> +
>> +static int __init utf8_init(void)
>> +{
>> +	static_call_update(_unicode_validate, utf8_validate);
>> +	static_call_update(_unicode_strncmp, utf8_strncmp);
>> +	static_call_update(_unicode_strncasecmp, utf8_strncasecmp);
>> +	static_call_update(_unicode_strncasecmp_folded, utf8_strncasecmp_folded);
>> +	static_call_update(_unicode_normalize, utf8_normalize);
>> +	static_call_update(_unicode_casefold, utf8_casefold);
>> +	static_call_update(_unicode_casefold_hash, utf8_casefold_hash);
>> +	static_call_update(_unicode_load, utf8_load);
>> +
>> +	unicode_register(THIS_MODULE);
>> +	return 0;
>> +}
>> +
>> +static void __exit utf8_exit(void)
>> +{
>> +	static_call_update(_unicode_validate, unicode_validate_default);
>> +	static_call_update(_unicode_strncmp, unicode_strncmp_default);
>> +	static_call_update(_unicode_strncasecmp, unicode_strncasecmp_default);
>> +	static_call_update(_unicode_strncasecmp_folded, unicode_strncasecmp_folded_default);
>> +	static_call_update(_unicode_normalize, unicode_normalize_default);
>> +	static_call_update(_unicode_casefold, unicode_casefold_default);
>> +	static_call_update(_unicode_casefold_hash, unicode_casefold_hash_default);
>> +	static_call_update(_unicode_load, unicode_load_default);
>> +
>> +	unicode_unregister();
>> +}
>> +
>> +module_init(utf8_init);
>> +module_exit(utf8_exit);
>> +
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/unicode.h b/include/linux/unicode.h
>> index de23f9ee720b..18a1d3db9de5 100644
>> --- a/include/linux/unicode.h
>> +++ b/include/linux/unicode.h
>> @@ -4,33 +4,128 @@
>>   
>>   #include <linux/init.h>
>>   #include <linux/dcache.h>
>> +#include <linux/static_call.h>
>> +
>>   
>>   struct unicode_map {
>>   	const char *charset;
>>   	int version;
>>   };
>>   
>> -int unicode_validate(const struct unicode_map *um, const struct qstr *str);
>> +static int unicode_warn_on(void)
>> +{
>> +	WARN_ON(1);
>> +	return -EIO;
>> +}
> Creating this extra function adds the same number of lines than if you
> write `WARN_ON(1); return -EIO;` in each of the few handlers below, but
> the later would be more clear, and you already do it for
> unicode_load_default anyway. :)
>> +
>> +static int unicode_validate_default(const struct unicode_map *um,
>> +				    const struct qstr *str)
>> +{
>> +	return unicode_warn_on();
>> +}
>> +
>> +static int unicode_strncmp_default(const struct unicode_map *um,
>> +				   const struct qstr *s1,
>> +				   const struct qstr *s2)
>> +{
>> +	return unicode_warn_on();
>> +}
>> +
>> +static int unicode_strncasecmp_default(const struct unicode_map *um,
>> +				       const struct qstr *s1,
>> +				       const struct qstr *s2)
>> +{
>> +	return unicode_warn_on();
>> +}
>> +
>> +static int unicode_strncasecmp_folded_default(const struct unicode_map *um,
>> +					      const struct qstr *cf,
>> +					      const struct qstr *s1)
>> +{
>> +	return unicode_warn_on();
>> +}
>> +
>> +static int unicode_normalize_default(const struct unicode_map *um,
>> +				     const struct qstr *str,
>> +				     unsigned char *dest, size_t dlen)
>> +{
>> +	return unicode_warn_on();
>> +}
>> +
>> +static int unicode_casefold_default(const struct unicode_map *um,
>> +				    const struct qstr *str,
>> +				    unsigned char *dest, size_t dlen)
>> +{
>> +	return unicode_warn_on();
>> +}
>>   
>> -int unicode_strncmp(const struct unicode_map *um,
>> -		    const struct qstr *s1, const struct qstr *s2);
>> +static int unicode_casefold_hash_default(const struct unicode_map *um,
>> +					 const void *salt, struct qstr *str)
>> +{
>> +	return unicode_warn_on();
>> +}
> Again, why isn't this in a .c ?  Does it need to be here?
>
>>   
>> -int unicode_strncasecmp(const struct unicode_map *um,
>> -			const struct qstr *s1, const struct qstr *s2);
>> -int unicode_strncasecmp_folded(const struct unicode_map *um,
>> -			       const struct qstr *cf,
>> -			       const struct qstr *s1);
>> +static struct unicode_map *unicode_load_default(const char *version)
>> +{
>> +	unicode_warn_on();
>> +	return ERR_PTR(-EIO);
>> +}
>>   
>> -int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
>> -		      unsigned char *dest, size_t dlen);
>> +DECLARE_STATIC_CALL(_unicode_validate, unicode_validate_default);
>> +DECLARE_STATIC_CALL(_unicode_strncmp, unicode_strncmp_default);
>> +DECLARE_STATIC_CALL(_unicode_strncasecmp, unicode_strncasecmp_default);
>> +DECLARE_STATIC_CALL(_unicode_strncasecmp_folded, unicode_strncasecmp_folded_default);
>> +DECLARE_STATIC_CALL(_unicode_normalize, unicode_normalize_default);
>> +DECLARE_STATIC_CALL(_unicode_casefold, unicode_casefold_default);
>> +DECLARE_STATIC_CALL(_unicode_casefold_hash, unicode_casefold_hash_default);
>> +DECLARE_STATIC_CALL(_unicode_load, unicode_load_default);
> nit: I hate this functions starting with a single  _ .  they are not common in the
> rest of the kernel either.
>> -int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
>> -		     unsigned char *dest, size_t dlen);
>> +static inline int unicode_validate(const struct unicode_map *um, const struct qstr *str)
>> +{
>> +	return static_call(_unicode_validate)(um, str);
>> +}
>>   
>> -int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
>> -			  struct qstr *str);
>> +static inline int unicode_strncmp(const struct unicode_map *um,
>> +				  const struct qstr *s1, const struct qstr *s2)
>> +{
>> +	return static_call(_unicode_strncmp)(um, s1, s2);
>> +}
>> +
>> +static inline int unicode_strncasecmp(const struct unicode_map *um,
>> +				      const struct qstr *s1, const struct qstr *s2)
>> +{
>> +	return static_call(_unicode_strncasecmp)(um, s1, s2);
>> +}
>> +
>> +static inline int unicode_strncasecmp_folded(const struct unicode_map *um,
>> +					     const struct qstr *cf,
>> +					     const struct qstr *s1)
>> +{
>> +	return static_call(_unicode_strncasecmp_folded)(um, cf, s1);
>> +}
>> +
>> +static inline int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
>> +				    unsigned char *dest, size_t dlen)
>> +{
>> +	return static_call(_unicode_normalize)(um, str, dest, dlen);
>> +}
>> +
>> +static inline int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
>> +				   unsigned char *dest, size_t dlen)
>> +{
>> +	return static_call(_unicode_casefold)(um, str, dest, dlen);
>> +}
>> +
>> +static inline int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
>> +					struct qstr *str)
>> +{
>> +	return static_call(_unicode_casefold_hash)(um, salt, str);
>> +}
>>   
>>   struct unicode_map *unicode_load(const char *version);
>>   void unicode_unload(struct unicode_map *um);
>>   
>> +void unicode_register(struct module *owner);
>> +void unicode_unregister(void);
>> +
>>   #endif /* _LINUX_UNICODE_H */
