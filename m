Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6762A3F058E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhHROCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHROCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:02:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14403C061764;
        Wed, 18 Aug 2021 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M49e5fRdzxP+WAz6agalOAkH+gEGzdtK28u46qYFewM=; b=pjr0KkObkq2sPqeUf9uGA3pUrI
        BeI4o1aTpzVMvCzL+0nCOZ8t14v4865BJw5kqPdNZQgTwqIY/DWfkHsFue+nMHn0AjuWFtgl1HPxU
        m2zqmUoYrmdkim5QL8IKEg1/lHvvZT/u+txwFV+l0NDDz/3gfR7T/0XdcBxG1InAdmcy89E8UT5vv
        B+x3IUwayPwojdNcG6HopHyCbWtLx6O72Sbg6qISmH5M9hUuWOsf2MGduuoggxDXgw9WwHjqw2ReW
        69GNMH1y69IhRXnH9ZfQdHTOeeMzgT6ndu4a3/nLqED1Y4wiXr5g4eLg8DdnQFuQo40b5r0HAMVOI
        fOB45tsQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGM7m-003ttm-UM; Wed, 18 Aug 2021 14:01:12 +0000
Date:   Wed, 18 Aug 2021 15:00:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     krisman@collabora.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCHi v2] fs: unicode: Add utf8-data module
Message-ID: <YR0SmudQbJu8GXt+@infradead.org>
References: <20210817213411.27944-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817213411.27944-1-shreeya.patel@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This still seems overly complex.  I'll post a series that just uses
request_symbol instead in a bit, everyone let me know what you think.

On Wed, Aug 18, 2021 at 03:04:11AM +0530, Shreeya Patel wrote:
> utf8data.h_shipped has a large database table which is an auto-generated
> decodification trie for the unicode normalization functions.
> We can avoid carrying this large table in the kernel unless it is required
> by the filesystem during boot process.
> 
> Hence, add utf8-data module which will be loaded only when UTF-8 encoding
> support is needed by the filesystem, provided it is selected as M.
> utf8-data will provide access to the data tables present in utf8data.h.
> 
> Also, add support for enabling utf8-data as a built-in option so that
> filesystems that require UTF-8 encoding during boot process can access
> the data tables without any failure.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v2
>  - Since there are no function pointer fields anymore, use utf8_data
> as the name instead of utf8_ops
>  - Remove unnecessary variable utf8data_loaded
> 
>  fs/unicode/Kconfig         | 23 +++++++++++--
>  fs/unicode/Makefile        |  3 +-
>  fs/unicode/utf8-core.c     | 50 ++++++++++++++++++++++++++--
>  fs/unicode/utf8-data.c     | 42 +++++++++++++++++++++++
>  fs/unicode/utf8-norm.c     | 68 ++++++++++++++++++++++----------------
>  fs/unicode/utf8-selftest.c | 25 ++++++--------
>  fs/unicode/utf8n.h         | 30 +++++++++++++++++
>  7 files changed, 193 insertions(+), 48 deletions(-)
>  create mode 100644 fs/unicode/utf8-data.c
> 
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index 2c27b9a5cd6c..80341fae5e63 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -2,13 +2,30 @@
>  #
>  # UTF-8 normalization
>  #
> +# This config option will be automatically selected when UNICODE_UTF8_DATA
> +# is enabled. UNICODE config will provide all the UTF-8 core and normalization
> +# functions which will use UTF-8 data tables.
>  config UNICODE
>  	bool "UTF-8 normalization and casefolding support"
> +
> +config UNICODE_UTF8_DATA
> +	tristate "UTF-8 support for native Case-Insensitive filesystems"
> +	select UNICODE
>  	help
> -	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
> -	  support.
> +	  Say M here to enable UTF-8 NFD normalization and NFD+CF casefolding
> +	  support as a loadable module or say Y for building it into the kernel.
> +	  It is currently supported by EXT4 and F2FS filesystems.
> +
> +	  utf8data.h_shipped has a large database table which is an
> +	  auto-generated decodification trie for the unicode normalization
> +	  functions. Enabling UNICODE_UTF8_DATA as M will allow you to avoid
> +	  carrying this large table into the kernel and module will only be
> +	  loaded with the data tables whenever required by any filesystem.
> +	  If your filesystem requires to have the utf8-data during boot time
> +	  then you should have it built into the kernel by saying Y here to
> +	  avoid any boot failure.
>  
>  config UNICODE_NORMALIZATION_SELFTEST
>  	tristate "Test UTF-8 normalization support"
> -	depends on UNICODE
> +	depends on UNICODE_UTF8_DATA
>  	default n
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index b88aecc86550..fc28a6e2c56f 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -2,10 +2,11 @@
>  
>  obj-$(CONFIG_UNICODE) += unicode.o
>  obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_UTF8_DATA) += utf8-data.o
>  
>  unicode-y := utf8-norm.o utf8-core.o
>  
> -$(obj)/utf8-norm.o: $(obj)/utf8data.h
> +$(obj)/utf8-data.o: $(obj)/utf8data.h
>  
>  # In the normal build, the checked-in utf8data.h is just shipped.
>  #
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index dc25823bfed9..4eb08385e680 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c
> @@ -192,7 +192,7 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
>  	return 0;
>  }
>  
> -struct unicode_map *utf8_load(const char *version)
> +static struct unicode_map *utf8_load_core(const char *version)
>  {
>  	struct unicode_map *um = NULL;
>  	int unicode_version;
> @@ -225,11 +225,57 @@ struct unicode_map *utf8_load(const char *version)
>  
>  	return um;
>  }
> +
> +static void utf8_unload_core(struct unicode_map *um)
> +{
> +	kfree(um);
> +}
> +
> +static int utf8mod_get(void)
> +{
> +	int ret;
> +
> +	spin_lock(&utf8_lock);
> +	ret = utf8_data && try_module_get(utf8_data->owner);
> +	spin_unlock(&utf8_lock);
> +	return ret;
> +}
> +
> +struct unicode_map *utf8_load(const char *version)
> +{
> +	struct unicode_map *um;
> +
> +	/*
> +	 * try_then_request_module() is used here instead of using
> +	 * request_module() because of the following problems that
> +	 * could occur with the usage of request_module().
> +	 * 1) Multiple calls in parallel to utf8_load() would fail if
> +	 * kmod_concurrent_max == 0
> +	 * 2) There would be unnecessary memory allocation and userspace
> +	 * invocation in call_modprobe() that would always happen even if
> +	 * the module is already loaded.
> +	 * Hence, using try_then_request_module() would first check if the
> +	 * module is already loaded, if not then it calls the request_module()
> +	 * and finally would aquire the reference of the loaded module.
> +	 */
> +	if (!try_then_request_module(utf8mod_get(), "utf8-data")) {
> +		pr_err("Failed to load UTF-8 module\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +	um = utf8_load_core(version);
> +	if (IS_ERR(um))
> +		module_put(utf8_data->owner);
> +
> +	return um;
> +}
>  EXPORT_SYMBOL(utf8_load);
>  
>  void utf8_unload(struct unicode_map *um)
>  {
> -	kfree(um);
> +	if (um) {
> +		utf8_unload_core(um);
> +		module_put(utf8_data->owner);
> +	}
>  }
>  EXPORT_SYMBOL(utf8_unload);
>  
> diff --git a/fs/unicode/utf8-data.c b/fs/unicode/utf8-data.c
> new file mode 100644
> index 000000000000..1ae3c5dda6c7
> --- /dev/null
> +++ b/fs/unicode/utf8-data.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include "utf8n.h"
> +
> +#define __INCLUDED_FROM_UTF8NORM_C__
> +#include "utf8data.h"
> +#undef __INCLUDED_FROM_UTF8NORM_C__
> +
> +struct utf8data_table data = {
> +	.owner = THIS_MODULE,
> +
> +	.utf8vers = utf8vers,
> +
> +	.utf8agetab = utf8agetab,
> +	.utf8agetab_size = ARRAY_SIZE(utf8agetab),
> +
> +	.utf8nfdicfdata = utf8nfdicfdata,
> +	.utf8nfdicfdata_size = ARRAY_SIZE(utf8nfdicfdata),
> +
> +	.utf8nfdidata = utf8nfdidata,
> +	.utf8nfdidata_size = ARRAY_SIZE(utf8nfdidata),
> +
> +	.utf8data = utf8data,
> +	.utf8data_size = ARRAY_SIZE(utf8data),
> +};
> +
> +static int __init utf8_init(void)
> +{
> +	unicode_register(&data);
> +	return 0;
> +}
> +
> +static void __exit utf8_exit(void)
> +{
> +	unicode_unregister();
> +}
> +
> +module_init(utf8_init);
> +module_exit(utf8_exit);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
> index 1d2d2e5b906a..a6276f50a18f 100644
> --- a/fs/unicode/utf8-norm.c
> +++ b/fs/unicode/utf8-norm.c
> @@ -6,22 +6,18 @@
>  
>  #include "utf8n.h"
>  
> -struct utf8data {
> -	unsigned int maxage;
> -	unsigned int offset;
> -};
> +/* Spinlock for protecting utf8_data */
> +DEFINE_SPINLOCK(utf8_lock);
>  
> -#define __INCLUDED_FROM_UTF8NORM_C__
> -#include "utf8data.h"
> -#undef __INCLUDED_FROM_UTF8NORM_C__
> +struct utf8data_table *utf8_data;
>  
>  int utf8version_is_supported(u8 maj, u8 min, u8 rev)
>  {
> -	int i = ARRAY_SIZE(utf8agetab) - 1;
> +	int i = utf8_data->utf8agetab_size - 1;
>  	unsigned int sb_utf8version = UNICODE_AGE(maj, min, rev);
>  
> -	while (i >= 0 && utf8agetab[i] != 0) {
> -		if (sb_utf8version == utf8agetab[i])
> +	while (i >= 0 && utf8_data->utf8agetab[i] != 0) {
> +		if (sb_utf8version == utf8_data->utf8agetab[i])
>  			return 1;
>  		i--;
>  	}
> @@ -31,7 +27,7 @@ EXPORT_SYMBOL(utf8version_is_supported);
>  
>  int utf8version_latest(void)
>  {
> -	return utf8vers;
> +	return utf8_data->utf8vers;
>  }
>  EXPORT_SYMBOL(utf8version_latest);
>  
> @@ -168,7 +164,7 @@ typedef const unsigned char utf8trie_t;
>   * underlying datatype: unsigned char.
>   *
>   * leaf[0]: The unicode version, stored as a generation number that is
> - *          an index into utf8agetab[].  With this we can filter code
> + *          an index into utf8_data->utf8agetab[].  With this we can filter code
>   *          points based on the unicode version in which they were
>   *          defined.  The CCC of a non-defined code point is 0.
>   * leaf[1]: Canonical Combining Class. During normalization, we need
> @@ -330,7 +326,7 @@ static utf8leaf_t *utf8nlookup(const struct utf8data *data,
>  	if (len == 0)
>  		return NULL;
>  
> -	trie = utf8data + data->offset;
> +	trie = utf8_data->utf8data + data->offset;
>  	node = 1;
>  	while (node) {
>  		offlen = (*trie & OFFLEN) >> OFFLEN_SHIFT;
> @@ -418,7 +414,7 @@ int utf8agemax(const struct utf8data *data, const char *s)
>  		if (!leaf)
>  			return -1;
>  
> -		leaf_age = utf8agetab[LEAF_GEN(leaf)];
> +		leaf_age = utf8_data->utf8agetab[LEAF_GEN(leaf)];
>  		if (leaf_age <= data->maxage && leaf_age > age)
>  			age = leaf_age;
>  		s += utf8clen(s);
> @@ -446,7 +442,7 @@ int utf8agemin(const struct utf8data *data, const char *s)
>  		leaf = utf8lookup(data, hangul, s);
>  		if (!leaf)
>  			return -1;
> -		leaf_age = utf8agetab[LEAF_GEN(leaf)];
> +		leaf_age = utf8_data->utf8agetab[LEAF_GEN(leaf)];
>  		if (leaf_age <= data->maxage && leaf_age < age)
>  			age = leaf_age;
>  		s += utf8clen(s);
> @@ -473,7 +469,7 @@ int utf8nagemax(const struct utf8data *data, const char *s, size_t len)
>  		leaf = utf8nlookup(data, hangul, s, len);
>  		if (!leaf)
>  			return -1;
> -		leaf_age = utf8agetab[LEAF_GEN(leaf)];
> +		leaf_age = utf8_data->utf8agetab[LEAF_GEN(leaf)];
>  		if (leaf_age <= data->maxage && leaf_age > age)
>  			age = leaf_age;
>  		len -= utf8clen(s);
> @@ -501,7 +497,7 @@ int utf8nagemin(const struct utf8data *data, const char *s, size_t len)
>  		leaf = utf8nlookup(data, hangul, s, len);
>  		if (!leaf)
>  			return -1;
> -		leaf_age = utf8agetab[LEAF_GEN(leaf)];
> +		leaf_age = utf8_data->utf8agetab[LEAF_GEN(leaf)];
>  		if (leaf_age <= data->maxage && leaf_age < age)
>  			age = leaf_age;
>  		len -= utf8clen(s);
> @@ -529,7 +525,7 @@ ssize_t utf8len(const struct utf8data *data, const char *s)
>  		leaf = utf8lookup(data, hangul, s);
>  		if (!leaf)
>  			return -1;
> -		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
> +		if (utf8_data->utf8agetab[LEAF_GEN(leaf)] > data->maxage)
>  			ret += utf8clen(s);
>  		else if (LEAF_CCC(leaf) == DECOMPOSE)
>  			ret += strlen(LEAF_STR(leaf));
> @@ -557,7 +553,7 @@ ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len)
>  		leaf = utf8nlookup(data, hangul, s, len);
>  		if (!leaf)
>  			return -1;
> -		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
> +		if (utf8_data->utf8agetab[LEAF_GEN(leaf)] > data->maxage)
>  			ret += utf8clen(s);
>  		else if (LEAF_CCC(leaf) == DECOMPOSE)
>  			ret += strlen(LEAF_STR(leaf));
> @@ -690,7 +686,7 @@ int utf8byte(struct utf8cursor *u8c)
>  
>  		ccc = LEAF_CCC(leaf);
>  		/* Characters that are too new have CCC 0. */
> -		if (utf8agetab[LEAF_GEN(leaf)] > u8c->data->maxage) {
> +		if (utf8_data->utf8agetab[LEAF_GEN(leaf)] > u8c->data->maxage) {
>  			ccc = STOPPER;
>  		} else if (ccc == DECOMPOSE) {
>  			u8c->len -= utf8clen(u8c->s);
> @@ -769,24 +765,40 @@ EXPORT_SYMBOL(utf8byte);
>  
>  const struct utf8data *utf8nfdi(unsigned int maxage)
>  {
> -	int i = ARRAY_SIZE(utf8nfdidata) - 1;
> +	int i = utf8_data->utf8nfdidata_size - 1;
>  
> -	while (maxage < utf8nfdidata[i].maxage)
> +	while (maxage < utf8_data->utf8nfdidata[i].maxage)
>  		i--;
> -	if (maxage > utf8nfdidata[i].maxage)
> +	if (maxage > utf8_data->utf8nfdidata[i].maxage)
>  		return NULL;
> -	return &utf8nfdidata[i];
> +	return &utf8_data->utf8nfdidata[i];
>  }
>  EXPORT_SYMBOL(utf8nfdi);
>  
>  const struct utf8data *utf8nfdicf(unsigned int maxage)
>  {
> -	int i = ARRAY_SIZE(utf8nfdicfdata) - 1;
> +	int i = utf8_data->utf8nfdicfdata_size - 1;
>  
> -	while (maxage < utf8nfdicfdata[i].maxage)
> +	while (maxage < utf8_data->utf8nfdicfdata[i].maxage)
>  		i--;
> -	if (maxage > utf8nfdicfdata[i].maxage)
> +	if (maxage > utf8_data->utf8nfdicfdata[i].maxage)
>  		return NULL;
> -	return &utf8nfdicfdata[i];
> +	return &utf8_data->utf8nfdicfdata[i];
>  }
>  EXPORT_SYMBOL(utf8nfdicf);
> +
> +void unicode_register(struct utf8data_table *data)
> +{
> +	spin_lock(&utf8_lock);
> +	utf8_data = data;
> +	spin_unlock(&utf8_lock);
> +}
> +EXPORT_SYMBOL(unicode_register);
> +
> +void unicode_unregister(void)
> +{
> +	spin_lock(&utf8_lock);
> +	utf8_data = NULL;
> +	spin_unlock(&utf8_lock);
> +}
> +EXPORT_SYMBOL(unicode_unregister);
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
> index 6fe8af7edccb..d8069f4ad452 100644
> --- a/fs/unicode/utf8-selftest.c
> +++ b/fs/unicode/utf8-selftest.c
> @@ -16,6 +16,7 @@
>  
>  unsigned int failed_tests;
>  unsigned int total_tests;
> +struct unicode_map *table;
>  
>  /* Tests will be based on this version. */
>  #define latest_maj 12
> @@ -232,16 +233,9 @@ static void check_utf8_nfdicf(void)
>  	}
>  }
>  
> -static void check_utf8_comparisons(void)
> +static void check_utf8_comparisons(struct unicode_map *table)
>  {
>  	int i;
> -	struct unicode_map *table = utf8_load("12.1.0");
> -
> -	if (IS_ERR(table)) {
> -		pr_err("%s: Unable to load utf8 %d.%d.%d. Skipping.\n",
> -		       __func__, latest_maj, latest_min, latest_rev);
> -		return;
> -	}
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>  		const struct qstr s1 = {.name = nfdi_test_data[i].str,
> @@ -262,8 +256,6 @@ static void check_utf8_comparisons(void)
>  		test_f(!utf8_strncasecmp(table, &s1, &s2),
>  		       "%s %s comparison mismatch\n", s1.name, s2.name);
>  	}
> -
> -	utf8_unload(table);
>  }
>  
>  static void check_supported_versions(void)
> @@ -274,9 +266,6 @@ static void check_supported_versions(void)
>  	/* Unicode 9.0.0 should be supported. */
>  	test(utf8version_is_supported(9, 0, 0));
>  
> -	/* Unicode 1x.0.0 (the latest version) should be supported. */
> -	test(utf8version_is_supported(latest_maj, latest_min, latest_rev));
> -
>  	/* Next versions don't exist. */
>  	test(!utf8version_is_supported(13, 0, 0));
>  	test(!utf8version_is_supported(0, 0, 0));
> @@ -288,10 +277,17 @@ static int __init init_test_ucd(void)
>  	failed_tests = 0;
>  	total_tests = 0;
>  
> +	table = utf8_load("12.1.0");
> +	if (IS_ERR(table)) {
> +		pr_err("%s: Unable to load utf8 %d.%d.%d. Could not run the tests\n",
> +		       __func__, latest_maj, latest_min, latest_rev);
> +		return -EINVAL;
> +	}
> +
>  	check_supported_versions();
>  	check_utf8_nfdi();
>  	check_utf8_nfdicf();
> -	check_utf8_comparisons();
> +	check_utf8_comparisons(table);
>  
>  	if (!failed_tests)
>  		pr_info("All %u tests passed\n", total_tests);
> @@ -303,6 +299,7 @@ static int __init init_test_ucd(void)
>  
>  static void __exit exit_test_ucd(void)
>  {
> +	utf8_unload(table);
>  }
>  
>  module_init(init_test_ucd);
> diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
> index 0acd530c2c79..eb73fee9efc4 100644
> --- a/fs/unicode/utf8n.h
> +++ b/fs/unicode/utf8n.h
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/string.h>
>  #include <linux/module.h>
> +#include <linux/spinlock.h>
>  
>  /* Encoding a unicode version number as a single unsigned int. */
>  #define UNICODE_MAJ_SHIFT		(16)
> @@ -21,6 +22,9 @@
>  	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
>  	 ((unsigned int)(REV)))
>  
> +extern spinlock_t utf8_lock;
> +extern struct utf8data_table *utf8_data;
> +
>  /* Highest unicode version supported by the data tables. */
>  extern int utf8version_is_supported(u8 maj, u8 min, u8 rev);
>  extern int utf8version_latest(void);
> @@ -105,4 +109,30 @@ extern int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
>   */
>  extern int utf8byte(struct utf8cursor *u8c);
>  
> +struct utf8data {
> +	unsigned int maxage;
> +	unsigned int offset;
> +};
> +
> +struct utf8data_table {
> +	struct module *owner;
> +
> +	const unsigned int utf8vers;
> +
> +	const unsigned int *utf8agetab;
> +	int utf8agetab_size;
> +
> +	const struct utf8data *utf8nfdicfdata;
> +	int utf8nfdicfdata_size;
> +
> +	const struct utf8data *utf8nfdidata;
> +	int utf8nfdidata_size;
> +
> +	const unsigned char *utf8data;
> +	int utf8data_size;
> +};
> +
> +void unicode_register(struct utf8data_table *data);
> +void unicode_unregister(void);
> +
>  #endif /* UTF8NORM_H */
> -- 
> 2.30.2
> 
---end quoted text---
