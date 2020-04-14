Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA51A77A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 11:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437796AbgDNJsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 05:48:42 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21421 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437776AbgDNJsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:48:40 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 05:48:40 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1586856809; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MZJmWu5+NaePmj3xKkNrelOBSAqhOmMUqlw7vbNqQj2QV4ioPCXdcVl1tosHvxGElVwo+Nf6R8ThRjSvy05uKU2DWX5w9iWmzSMk1RthlQV2/pA1s+QQmNTSvREanGPFh2XmXK5T4hfiniFR8zp0CCnDFf8Pye/Qfdos3VXWwuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1586856809; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7CHfC3aii0lOzsMjiJtZ908m+rVPf0rWqs+qREDOWKk=; 
        b=WJHQFY0drLO4+4Zc4StrC983gxDGq8F1EbBWTl9DXTGn7TlG7umJjN/nD6sQYEbi6StwAbuuvYVKrxSvTlC0Fxx/2vxnJtwbZIGDNuLC0P7Gw5jru4o8lJgQy97GrwCgLDA0OdGP7o4x5e8tyxHCOhapkMWZ8fCyPiLaw5UeUZA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
        dmarc=pass header.from=<anirudh@anirudhrb.com> header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1586856809;
        s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=7CHfC3aii0lOzsMjiJtZ908m+rVPf0rWqs+qREDOWKk=;
        b=oPYFwNXpi+zcKtg+uc+huVUIa8VoPFgN649jVOyF3Bwys/usMLb+VW6udRmKH84D
        gK23gJCRZ9h2x8ViBb16YPSVRyCFd5WSF4/JB2226AcXzXSlBOk7VjeWmr3dwgsP6Ha
        oWIBFdnFitFhMhkrJF2BZsZjapuQaStd4tgLhLxM=
Received: from anirudhrb.com (106.51.106.83 [106.51.106.83]) by mx.zohomail.com
        with SMTPS id 1586856807527506.16811547739223; Tue, 14 Apr 2020 02:33:27 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:03:13 +0530
From:   Anirudh Rayabharam <anirudh@anirudhrb.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] unicode: Expose available encodings in sysfs
Message-ID: <20200414093313.GA22099@anirudhrb.com>
References: <20200413165352.598877-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413165352.598877-1-krisman@collabora.com>
X-ZohoMailClient: External
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:53:52PM -0400, Gabriel Krisman Bertazi wrote:
> A filesystem configuration utility has no way to detect which filename
> encodings are supported by the running kernel.  This means, for
> instance, mkfs has no way to tell if the generated filesystem will be
> mountable in the current kernel or not.  Also, users have no easy way to
> know if they can update the encoding in their filesystems and still have
> something functional in the end.
> 
> This exposes details of the encodings available in the unicode
> subsystem, to fill that gap.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v1:
>   - Make init functions static. (lkp)
> 
>  Documentation/ABI/testing/sysfs-fs-unicode | 13 +++++
>  fs/unicode/utf8-core.c                     | 64 ++++++++++++++++++++++
>  fs/unicode/utf8-norm.c                     | 18 ++++++
>  fs/unicode/utf8n.h                         |  5 ++
>  4 files changed, 100 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-fs-unicode
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-unicode b/Documentation/ABI/testing/sysfs-fs-unicode
> new file mode 100644
> index 000000000000..15c63367bb8e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-fs-unicode
> @@ -0,0 +1,13 @@
> +What:		/sys/fs/unicode/latest
> +Date:		April 2020
> +Contact:	Gabriel Krisman Bertazi <krisman@collabora.com>
> +Description:
> +		The latest version of the Unicode Standard supported by
> +		this kernel
> +
> +What:		/sys/fs/unicode/encodings
> +Date:		April 2020
> +Contact:	Gabriel Krisman Bertazi <krisman@collabora.com>
> +Description:
> +		List of encodings and corresponding versions supported
> +		by this kernel
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index 2a878b739115..b48e13e823a5 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c
> @@ -6,6 +6,7 @@
>  #include <linux/parser.h>
>  #include <linux/errno.h>
>  #include <linux/unicode.h>
> +#include <linux/fs.h>
>  
>  #include "utf8n.h"
>  
> @@ -212,4 +213,67 @@ void utf8_unload(struct unicode_map *um)
>  }
>  EXPORT_SYMBOL(utf8_unload);
>  
> +static ssize_t latest_show(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	int l = utf8version_latest();
> +
> +	return snprintf(buf, PAGE_SIZE, "UTF-8 %d.%d.%d\n", UNICODE_AGE_MAJ(l),
> +			UNICODE_AGE_MIN(l), UNICODE_AGE_REV(l));
> +
> +}
> +static ssize_t encodings_show(struct kobject *kobj,
> +			      struct kobj_attribute *attr, char *buf)
> +{
> +	int n;
> +
> +	n = snprintf(buf, PAGE_SIZE, "UTF-8:");
> +	n += utf8version_list(buf + n, PAGE_SIZE - n);
> +	n += snprintf(buf+n, PAGE_SIZE-n, "\n");

Spaces before and after the '+' and '-' operators?

	n += snprintf(buf + n, PAGE_SIZE - n, "\n");

Thanks,
Anirudh

> +
> +	return n;
> +}
> +
> +#define UCD_ATTR(x) \
> +	static struct kobj_attribute x ## _attr = __ATTR_RO(x)
> +
> +UCD_ATTR(latest);
> +UCD_ATTR(encodings);
> +
> +static struct attribute *ucd_attrs[] = {
> +	&latest_attr.attr,
> +	&encodings_attr.attr,
> +	NULL,
> +};
> +static const struct attribute_group ucd_attr_group = {
> +	.attrs = ucd_attrs,
> +};
> +static struct kobject *ucd_root;
> +
> +static int __init ucd_init(void)
> +{
> +	int ret;
> +
> +	ucd_root = kobject_create_and_add("unicode", fs_kobj);
> +	if (!ucd_root)
> +		return -ENOMEM;
> +
> +	ret = sysfs_create_group(ucd_root, &ucd_attr_group);
> +	if (ret) {
> +		kobject_put(ucd_root);
> +		ucd_root = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit ucd_exit(void)
> +{
> +	kobject_put(ucd_root);
> +}
> +
> +module_init(ucd_init);
> +module_exit(ucd_exit)
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
> index 1d2d2e5b906a..f9ebba89a138 100644
> --- a/fs/unicode/utf8-norm.c
> +++ b/fs/unicode/utf8-norm.c
> @@ -35,6 +35,24 @@ int utf8version_latest(void)
>  }
>  EXPORT_SYMBOL(utf8version_latest);
>  
> +int utf8version_list(char *buf, int len)
> +{
> +	int i = ARRAY_SIZE(utf8agetab) - 1;
> +	int ret = 0;
> +
> +	/*
> +	 * Print most relevant (latest) first.  No filesystem uses
> +	 * unicode <= 12.0.0, so don't expose them to userspace.
> +	 */
> +	for (; utf8agetab[i] >= UNICODE_AGE(12, 0, 0); i--) {
> +		ret += snprintf(buf+ret, len-ret, " %d.%d.%d",
> +				UNICODE_AGE_MAJ(utf8agetab[i]),
> +				UNICODE_AGE_MIN(utf8agetab[i]),
> +				UNICODE_AGE_REV(utf8agetab[i]));
> +	}
> +	return ret;
> +}
> +
>  /*
>   * UTF-8 valid ranges.
>   *
> diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
> index 0acd530c2c79..5dea2c4af1f3 100644
> --- a/fs/unicode/utf8n.h
> +++ b/fs/unicode/utf8n.h
> @@ -21,9 +21,14 @@
>  	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
>  	 ((unsigned int)(REV)))
>  
> +#define UNICODE_AGE_MAJ(x) ((x) >> UNICODE_MAJ_SHIFT & 0xff)
> +#define UNICODE_AGE_MIN(x) ((x) >> UNICODE_MIN_SHIFT & 0xff)
> +#define UNICODE_AGE_REV(x) ((x) & 0xff)
> +
>  /* Highest unicode version supported by the data tables. */
>  extern int utf8version_is_supported(u8 maj, u8 min, u8 rev);
>  extern int utf8version_latest(void);
> +extern int utf8version_list(char *buf, int len);
>  
>  /*
>   * Look for the correct const struct utf8data for a unicode version.
> -- 
> 2.26.0
> 
