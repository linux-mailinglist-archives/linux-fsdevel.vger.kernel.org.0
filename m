Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881B433A536
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCNOqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Mar 2021 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhCNOqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Mar 2021 10:46:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04958C061574;
        Sun, 14 Mar 2021 07:46:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 5D4CA1F40C05
Subject: Re: [PATCH 3/3] fs: unicode: Add utf8 module and a unicode layer
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        andre.almeida@collabora.com
References: <20210313231214.383576-1-shreeya.patel@collabora.com>
 <20210313231214.383576-4-shreeya.patel@collabora.com>
 <8735wymrm5.fsf@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <e4013ca4-db2f-8b29-a5b2-6d100a6a5059@collabora.com>
Date:   Sun, 14 Mar 2021 20:16:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <8735wymrm5.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 14/03/21 7:19 am, Gabriel Krisman Bertazi wrote:
> Shreeya Patel <shreeya.patel@collabora.com> writes:
>
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions.
>> It is not necessary to carry this large table in the kernel hence make
>> UTF-8 encoding loadable by converting it into a module.
>> Also, modify the file called unicode-core which will act as a layer for
>> unicode subsystem. It will load the UTF-8 module and access it's functions
>> whenever any filesystem that needs unicode is mounted.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Hi Shreeya,
Hi Gabriel,
>
>> ---
>>   fs/unicode/Kconfig        |   7 +-
>>   fs/unicode/Makefile       |   5 +-
>>   fs/unicode/unicode-core.c | 201 ++++++-------------------------
>>   fs/unicode/utf8-core.c    | 112 +++++++++++++++++
>>   fs/unicode/utf8mod.c      | 246 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/unicode.h   |  20 ++++
>>   6 files changed, 427 insertions(+), 164 deletions(-)
>>   create mode 100644 fs/unicode/utf8-core.c
>>   create mode 100644 fs/unicode/utf8mod.c
>>
>> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
>> index 2c27b9a5cd6c..33a27deef729 100644
>> --- a/fs/unicode/Kconfig
>> +++ b/fs/unicode/Kconfig
>> @@ -8,7 +8,12 @@ config UNICODE
>>   	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>>   	  support.
>>   
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
>> index d5f09e022ac5..b832341f1e7b 100644
>> --- a/fs/unicode/unicode-core.c
>> +++ b/fs/unicode/unicode-core.c
>> @@ -7,70 +7,29 @@
>>   #include <linux/errno.h>
>>   #include <linux/unicode.h>
>>   #include <linux/stringhash.h>
>> +#include <linux/delay.h>
>>   
>> -#include "utf8n.h"
>> +struct unicode_ops *utf8_ops;
>> +
>> +static int unicode_load_module(void);
> This is unnecessary
>>   
>>   int unicode_validate(const struct unicode_map *um, const struct qstr *str)
>>   {
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -
>> -	if (utf8nlen(data, str->name, str->len) < 0)
>> -		return -1;
>> -	return 0;
>> +	return utf8_ops->validate(um, str);
>>   }
>>   EXPORT_SYMBOL(unicode_validate);
>>   
>>   int unicode_strncmp(const struct unicode_map *um,
>>   		    const struct qstr *s1, const struct qstr *s2)
>>   {
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
>> +	return utf8_ops->strncmp(um, s1, s2);
>>   }
> I think these would go on a header file and  inlined.
>
>>   EXPORT_SYMBOL(unicode_strncmp);
>>   
>>   int unicode_strncasecmp(const struct unicode_map *um,
>>   			const struct qstr *s1, const struct qstr *s2)
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
>> +	return utf8_ops->strncasecmp(um, s1, s2);
>>   }
>>   EXPORT_SYMBOL(unicode_strncasecmp);
>>   
>> @@ -81,155 +40,73 @@ int unicode_strncasecmp_folded(const struct unicode_map *um,
>>   			       const struct qstr *cf,
>>   			       const struct qstr *s1)
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
>> +	return utf8_ops->strncasecmp_folded(um, cf, s1);
>>   }
>>   EXPORT_SYMBOL(unicode_strncasecmp_folded);
>>   
>>   int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
>>   		     unsigned char *dest, size_t dlen)
>>   {
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
>> +	return utf8_ops->casefold(um, str, dest, dlen);
>>   }
>>   EXPORT_SYMBOL(unicode_casefold);
>>   
>>   int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
>>   			  struct qstr *str)
>>   {
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
>> +	return utf8_ops->casefold_hash(um, salt, str);
>>   }
>>   EXPORT_SYMBOL(unicode_casefold_hash);
>>   
>>   int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
>>   		      unsigned char *dest, size_t dlen)
>>   {
>> -	const struct utf8data *data = utf8nfdi(um->version);
>> -	struct utf8cursor cur;
>> -	ssize_t nlen = 0;
>> +	return utf8_ops->normalize(um, str, dest, dlen);
>> +}
>> +EXPORT_SYMBOL(unicode_normalize);
>>   
>> -	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
>> -		return -EINVAL;
>> +struct unicode_map *unicode_load(const char *version)
>> +{
>> +	int ret = unicode_load_module();
>>   
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
>> +	else
>> +		return utf8_ops->load(version);
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
>> +	kfree(um);
>> +}
>> +EXPORT_SYMBOL(unicode_unload);
>>   
>> -	strncpy(version_string, version, sizeof(version_string));
>> +static int unicode_load_module(void)
>> +{
>> +	int ret = request_module("utf8");
>>   
>> -	if (match_token(version_string, token, args) != 1)
>> -		return -EINVAL;
>> +	msleep(100);
> I think I misunderstood when you mentioned you did this msleep.  It was
> ok to debug the issue you were observing, but it is not a solution.
> Setting an arbitrary amount of time will either waste time, or you can
> still fail if things take longer than expected.  There are mechanisms to
> load and wait on a module.  See how fs/nls/nls_base.c do exactly this.
>
>> -	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
>> -	    match_int(&args[2], rev))
>> -		return -EINVAL;
>> +	if (ret) {
>> +		pr_err("Failed to load UTF-8 module\n");
>> +		return ret;
>> +	}
>>   
>>   	return 0;
>>   }
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
>> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
>> new file mode 100644
>> index 000000000000..009faa68330c
>> --- /dev/null
>> +++ b/fs/unicode/utf8-core.c
>> @@ -0,0 +1,112 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/string.h>
>> +#include <linux/slab.h>
>> +#include <linux/parser.h>
>> +#include <linux/errno.h>
>> +#include <linux/unicode.h>
>> +#include <linux/stringhash.h>
>> +#include <linux/delay.h>
>> +
>> +struct unicode_ops *utf8_ops;
>> +
>> +static int unicode_load_module(void);
>> +
>> +int unicode_validate(const struct unicode_map *um, const struct qstr *str)
>> +{
>> +	return utf8_ops->validate(um, str);
>> +}
>> +EXPORT_SYMBOL(unicode_validate);
>> +
>> +int unicode_strncmp(const struct unicode_map *um,
>> +		    const struct qstr *s1, const struct qstr *s2)
>> +{
>> +	return utf8_ops->strncmp(um, s1, s2);
>> +}
>> +EXPORT_SYMBOL(unicode_strncmp);
> I'm confused now.  Isn't this redefining unicode_strncmp ?  It was
> defined in unicode_core.c on the hunk above and now it is redefined on
> utf8_core.c.  There is something odd here.
sorry, I think I messed up patches while using git send-email and that 
is why you might see
two copies of the last patch. Let me resend the series and then it might 
make sense. One question
though, why would unicode_strncmp go into the header file?
>
>> +
>> +int unicode_strncasecmp(const struct unicode_map *um,
>> +			const struct qstr *s1, const struct qstr *s2)
>> +{
>> +	return utf8_ops->strncasecmp(um, s1, s2);
>> +}
>> +EXPORT_SYMBOL(unicode_strncasecmp);
>> +
>> +/* String cf is expected to be a valid UTF-8 casefolded
>> + * string.
>> + */
>> +int unicode_strncasecmp_folded(const struct unicode_map *um,
>> +			       const struct qstr *cf,
>> +			       const struct qstr *s1)
>> +{
>> +	return utf8_ops->strncasecmp_folded(um, cf, s1);
>> +}
>> +EXPORT_SYMBOL(unicode_strncasecmp_folded);
>> +
>> +int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
>> +		     unsigned char *dest, size_t dlen)
>> +{
>> +	return utf8_ops->casefold(um, str, dest, dlen);
>> +}
>> +EXPORT_SYMBOL(unicode_casefold);
>> +
>> +int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
>> +			  struct qstr *str)
>> +{
>> +	return utf8_ops->casefold_hash(um, salt, str);
>> +}
>> +EXPORT_SYMBOL(unicode_casefold_hash);
>> +
>> +int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
>> +		      unsigned char *dest, size_t dlen)
>> +{
>> +	return utf8_ops->normalize(um, str, dest, dlen);
>> +}
>> +EXPORT_SYMBOL(unicode_normalize);
>> +
>> +struct unicode_map *unicode_load(const char *version)
>> +{
>> +	int ret = unicode_load_module();
>> +
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	else
>> +		return utf8_ops->load(version);
>> +}
>> +EXPORT_SYMBOL(unicode_load);
>> +
>> +void unicode_unload(struct unicode_map *um)
>> +{
>> +	kfree(um);
>> +}
>> +EXPORT_SYMBOL(unicode_unload);
>> +
>> +void unicode_register(struct unicode_ops *ops)
>> +{
>> +	utf8_ops = ops;
>> +}
>> +EXPORT_SYMBOL(unicode_register);
>> +
>> +void unicode_unregister(void)
>> +{
>> +	utf8_ops = NULL;
>> +}
>> +EXPORT_SYMBOL(unicode_unregister);
>> +
>> +static int unicode_load_module(void)
>> +{
>> +	int ret = request_module("utf8");
>> +
>> +	msleep(100);
>> +
>> +	if (ret) {
>> +		pr_err("Failed to load UTF-8 module\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/fs/unicode/utf8mod.c b/fs/unicode/utf8mod.c
>> new file mode 100644
>> index 000000000000..8eaeeb27255c
>> --- /dev/null
>> +++ b/fs/unicode/utf8mod.c
>> @@ -0,0 +1,246 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/string.h>
>> +#include <linux/slab.h>
>> +#include <linux/parser.h>
>> +#include <linux/errno.h>
>> +#include <linux/unicode.h>
>> +#include <linux/stringhash.h>
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
>> +	strncpy(version_string, version, sizeof(version_string));
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
>> +		printk(KERN_WARNING"UTF-8 version not specified. "
>> +		       "Assuming latest supported version (%d.%d.%d).",
>> +		       (unicode_version >> 16) & 0xff,
>> +		       (unicode_version >> 8) & 0xff,
>> +		       (unicode_version & 0xff));
>> +	}
>> +
>> +	um = kzalloc(sizeof(struct unicode_map), GFP_KERNEL);
>> +	if (!um)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	um->charset = "UTF-8";
>> +	um->version = unicode_version;
>> +
>> +	return um;
>> +}
>> +
>> +static struct unicode_ops ops = {
>> +	.validate = utf8_validate,
>> +	.strncmp = utf8_strncmp,
>> +	.strncasecmp = utf8_strncasecmp,
>> +	.strncasecmp_folded = utf8_strncasecmp_folded,
>> +	.casefold = utf8_casefold,
>> +	.casefold_hash = utf8_casefold_hash,
>> +	.normalize = utf8_normalize,
>> +	.load = utf8_load,
>> +};
>> +
>> +static int __init utf8_init(void)
>> +{
>> +	unicode_register(&ops);
>> +	return 0;
>> +}
>> +
>> +static void __exit utf8_exit(void)
>> +{
>> +	unicode_unregister();
>> +}
>> +
>> +module_init(utf8_init);
>> +module_exit(utf8_exit);
>> +
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/unicode.h b/include/linux/unicode.h
>> index de23f9ee720b..b0d59069e438 100644
>> --- a/include/linux/unicode.h
>> +++ b/include/linux/unicode.h
>> @@ -10,6 +10,23 @@ struct unicode_map {
>>   	int version;
>>   };
>>   
>> +struct unicode_ops {
>> +	int (*validate)(const struct unicode_map *um, const struct qstr *str);
>> +	int (*strncmp)(const struct unicode_map *um, const struct qstr *s1,
>> +		       const struct qstr *s2);
>> +	int (*strncasecmp)(const struct unicode_map *um, const struct qstr *s1,
>> +			   const struct qstr *s2);
>> +	int (*strncasecmp_folded)(const struct unicode_map *um, const struct qstr *cf,
>> +				  const struct qstr *s1);
>> +	int (*normalize)(const struct unicode_map *um, const struct qstr *str,
>> +			 unsigned char *dest, size_t dlen);
>> +	int (*casefold)(const struct unicode_map *um, const struct qstr *str,
>> +			unsigned char *dest, size_t dlen);
>> +	int (*casefold_hash)(const struct unicode_map *um, const void *salt,
>> +			     struct qstr *str);
>> +	struct unicode_map* (*load)(const char *version);
>> +};
> Also, make sure you run checkpatch.pl on the patch series before
> submitting.
I ran checkpatch.pl over the patch, but it seems there were some 
previously existing warnings
which are not introduced due to any change made in this patch series.
I am not sure if I am supposed to resolve those warnings in this patch 
series.

>> +
>>   int unicode_validate(const struct unicode_map *um, const struct qstr *str);
>>   
>>   int unicode_strncmp(const struct unicode_map *um,
>> @@ -33,4 +50,7 @@ int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
>>   struct unicode_map *unicode_load(const char *version);
>>   void unicode_unload(struct unicode_map *um);
>>   
>> +void unicode_register(struct unicode_ops *ops);
>> +void unicode_unregister(void);
>> +
>>   #endif /* _LINUX_UNICODE_H */
