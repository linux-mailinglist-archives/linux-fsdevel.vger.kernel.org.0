Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6D168F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEGRSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 13:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfEGRSf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 13:18:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A9B2054F;
        Tue,  7 May 2019 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249514;
        bh=hUyqO09WIBqfjWypL7ljBQpZV9i+o71g/n2fC+RbtXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVmK2X9/HkVvJK/odUFxQy2WgRv1ctURKbTGIMlaMriRtxn+D1fxjo3/AGyJLovLp
         8KLQxeAN3ulRiJXYT5YkF3REXY29bjbEXR+Hsti1q/DTLbzEv+5vW6rFAOqvoP9nKf
         21L63T/ZstFMyReZ6z3sVyXBSyunNowbCkZlFCvI=
Date:   Tue, 7 May 2019 19:18:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ezemtsov@google.com
Cc:     linux-fsdevel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 1/6] incfs: Add first files of incrementalfs
Message-ID: <20190507171832.GB5885@kroah.com>
References: <20190502040331.81196-1-ezemtsov@google.com>
 <20190502040331.81196-2-ezemtsov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502040331.81196-2-ezemtsov@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

But since you did write some sysfs code, might as well review it so you
know how to do it better next time around :)

On Wed, May 01, 2019 at 09:03:26PM -0700, ezemtsov@google.com wrote:
> +static struct kobject *sysfs_root;
> +
> +static ssize_t version_show(struct kobject *kobj,
> +			    struct kobj_attribute *attr, char *buff)
> +{
> +	return snprintf(buff, PAGE_SIZE, "%d\n", INCFS_CORE_VERSION);

Hint about sysfs, it's "one value per file", so you NEVER care about the
size of the buffer because you "know" your single little number will
always fit.

So this should be:
	return sprintf(buff, "%d\n", INCFS_CORE_VERSION);

Yes, code checkers hate it, send them my way, I'll be glad to point out
their folly :)

> +static struct kobj_attribute version_attr = __ATTR_RO(version);
> +
> +static struct attribute *attributes[] = {
> +	&version_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group attr_group = {
> +	.attrs = attributes,
> +};

ATTRIBUTE_GROUP()?

> +static int __init init_sysfs(void)
> +{
> +	int res = 0;

No need to set to 0 here.

> +
> +	sysfs_root = kobject_create_and_add(INCFS_NAME, fs_kobj);
> +	if (!sysfs_root)
> +		return -ENOMEM;
> +
> +	res = sysfs_create_group(sysfs_root, &attr_group);
> +	if (res) {
> +		kobject_put(sysfs_root);
> +		sysfs_root = NULL;
> +	}
> +	return res;

To be extra "fancy", there's no real need to create a kobject for your
filesystem if all you are doing is creating a subdir and some individual
attributes.  Just add a "named" group to the parent kobject.  Can be
done in a single line, no need for having to deal with fancy error
cases.

> +}
> +
> +static void cleanup_sysfs(void)
> +{
> +	if (sysfs_root) {
> +		sysfs_remove_group(sysfs_root, &attr_group);
> +		kobject_put(sysfs_root);
> +		sysfs_root = NULL;

Why set it to NULL?

> +	}
> +}

thanks,

greg k-h
