Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485C01A6BD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbgDMSDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 14:03:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbgDMSDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:03:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 181402A010D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] unicode: Expose available encodings in sysfs
Organization: Collabora
References: <20200413165352.598877-1-krisman@collabora.com>
        <2672d7de2033fa14b9835b17b6fc59ba2cc4cd14.camel@collabora.com>
Date:   Mon, 13 Apr 2020 14:02:56 -0400
In-Reply-To: <2672d7de2033fa14b9835b17b6fc59ba2cc4cd14.camel@collabora.com>
        (Ezequiel Garcia's message of "Mon, 13 Apr 2020 14:50:13 -0300")
Message-ID: <857dyjw9f3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ezequiel Garcia <ezequiel@collabora.com> writes:

> Hey Gabriel,
>
> On Mon, 2020-04-13 at 12:53 -0400, Gabriel Krisman Bertazi wrote:
>> A filesystem configuration utility has no way to detect which filename
>> encodings are supported by the running kernel.  This means, for
>> instance, mkfs has no way to tell if the generated filesystem will be
>> mountable in the current kernel or not.  Also, users have no easy way to
>> know if they can update the encoding in their filesystems and still have
>> something functional in the end.
>> 
>> This exposes details of the encodings available in the unicode
>> subsystem, to fill that gap.
>> 
>> Cc: Theodore Ts'o <tytso@mit.edu>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> 
>> ---
>> Changes since v1:
>>   - Make init functions static. (lkp)
>> 
>>  Documentation/ABI/testing/sysfs-fs-unicode | 13 +++++
>>  fs/unicode/utf8-core.c                     | 64 ++++++++++++++++++++++
>>  fs/unicode/utf8-norm.c                     | 18 ++++++
>>  fs/unicode/utf8n.h                         |  5 ++
>>  4 files changed, 100 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-fs-unicode
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-fs-unicode b/Documentation/ABI/testing/sysfs-fs-unicode
>> new file mode 100644
>> index 000000000000..15c63367bb8e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-fs-unicode
>> @@ -0,0 +1,13 @@
>> +What:		/sys/fs/unicode/latest
>> +Date:		April 2020
>> +Contact:	Gabriel Krisman Bertazi <krisman@collabora.com>
>> +Description:
>> +		The latest version of the Unicode Standard supported by
>> +		this kernel
>> +
>
> Missing stop at the end of the sentence?
>
>> +What:		/sys/fs/unicode/encodings
>> +Date:		April 2020
>> +Contact:	Gabriel Krisman Bertazi <krisman@collabora.com>
>> +Description:
>> +		List of encodings and corresponding versions supported
>> +		by this kernel
>
> Ditto.
>
>> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
>> index 2a878b739115..b48e13e823a5 100644
>> --- a/fs/unicode/utf8-core.c
>> +++ b/fs/unicode/utf8-core.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/parser.h>
>>  #include <linux/errno.h>
>>  #include <linux/unicode.h>
>> +#include <linux/fs.h>
>>  
>>  #include "utf8n.h"
>>  
>> @@ -212,4 +213,67 @@ void utf8_unload(struct unicode_map *um)
>>  }
>>  EXPORT_SYMBOL(utf8_unload);
>>  
>> +static ssize_t latest_show(struct kobject *kobj,
>> +			   struct kobj_attribute *attr, char *buf)
>> +{
>> +	int l = utf8version_latest();
>> +
>> +	return snprintf(buf, PAGE_SIZE, "UTF-8 %d.%d.%d\n", UNICODE_AGE_MAJ(l),
>> +			UNICODE_AGE_MIN(l), UNICODE_AGE_REV(l));
>> +
>> +}
>> +static ssize_t encodings_show(struct kobject *kobj,
>> +			      struct kobj_attribute *attr, char *buf)
>> +{
>> +	int n;
>> +
>> +	n = snprintf(buf, PAGE_SIZE, "UTF-8:");
>> +	n += utf8version_list(buf + n, PAGE_SIZE - n);
>> +	n += snprintf(buf+n, PAGE_SIZE-n, "\n");
>> +
>
> I was wondering how sysfs-compliant this was,
> in terms of one value per attribute.
>
> Although, we do seem to break this on a few cases.

I thought about making it more one-value-per-attribute, by considering
each tuple (encoding,version) a different object.  So the structure
would look like:

/sys/fs/unicode/utf-8/<version>/

But it felt completely over-engineered, considering we don't support
anything other than utf-8, and I don't see versions having specific
attributes.  But maybe this way is more future-proof.


>
>> +	return n;
>> +}
>> +
>> +#define UCD_ATTR(x) \
>> +	static struct kobj_attribute x ## _attr = __ATTR_RO(x)
>> +
>> +UCD_ATTR(latest);
>> +UCD_ATTR(encodings);
>> +
>> +static struct attribute *ucd_attrs[] = {
>> +	&latest_attr.attr,
>> +	&encodings_attr.attr,
>> +	NULL,
>> +};
>> +static const struct attribute_group ucd_attr_group = {
>> +	.attrs = ucd_attrs,
>> +};
>> +static struct kobject *ucd_root;
>> +
>> +static int __init ucd_init(void)
>> +{
>> +	int ret;
>> +
>> +	ucd_root = kobject_create_and_add("unicode", fs_kobj);
>> +	if (!ucd_root)
>> +		return -ENOMEM;
>> +
>> +	ret = sysfs_create_group(ucd_root, &ucd_attr_group);
>> +	if (ret) {
>> +		kobject_put(ucd_root);
>> +		ucd_root = NULL;
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit ucd_exit(void)
>> +{
>> +	kobject_put(ucd_root);
>> +}
>> +
>> +module_init(ucd_init);
>
> This code is not a module, so how about fs_initcall?

Right.  for the record, I'm planing to make part of it build as a module
in a future patch to reduce the large footprint of the decoding table on
systems that don't care about it.  Will fix on v3.


>
>> +module_exit(ucd_exit)
>> +
>
> I can be wrong, but I see no way to remove it :-)
>
> Thanks,
> Ezequiel

-- 
Gabriel Krisman Bertazi
