Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9A429738
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhJKTFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 15:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhJKTFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:05:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB13C061570;
        Mon, 11 Oct 2021 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lly2oV++EB8MLjlYRFL/38jQaOHMGIONvw6X549JSsE=; b=KQbWzxiVJMRkcpVwfk2l9dHU3T
        xyB4c2qqD/PoaETldJK6z8Yz97yWnLPiJch1snwoFn4gR2mbmkMfGiU4CmuUfqKMMfpmNS6twnf8K
        VIMijx2oNTCEDy+XXh2yujUogjCQ3vpMspQJyM0+hzrNZSZYG54y3DxGkUrV5PQ2p07MakgkGw2Ag
        yXCJ4ZEC+kssx3a43eD0mtUEKG+nkHEp5OoSnpIqi157chHG1qAmm1zNVQZxxXdz39vx6bC/B0Whu
        c/I+vVmGfG43+tVK8TV9IAF1F/s7KFRrD0l6gWmLOSahPUfipwptrP6lqknMd1nx3hZYdco3ECQGk
        U12+mc1A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma0aB-00ARXU-AN; Mon, 11 Oct 2021 19:03:31 +0000
Date:   Mon, 11 Oct 2021 12:03:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
Message-ID: <YWSKg7+og7ID8cCV@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-4-mcgrof@kernel.org>
 <202110050912.3DF681ED@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110050912.3DF681ED@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 09:30:10AM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 09:37:56AM -0700, Luis Chamberlain wrote:
> > --- /dev/null
> > +++ b/lib/test_sysfs.c
> > @@ -0,0 +1,921 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> > +/*
> > + * sysfs test driver
> > + *
> > + * Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; either version 2 of the License, or at your option any
> > + * later version; or, when distributed separately from the Linux kernel or
> > + * when incorporated into other software packages, subject to the following
> > + * license:
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of copyleft-next (version 0.3.1 or later) as published
> > + * at http://copyleft-next.org/.
> 
> As Greg suggested, please drop the boilerplate here.

Sure, sorry for missing that fixed.

> > +static ssize_t config_show(struct device *dev,
> > +			   struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	int len = 0;
> > +
> > +	test_dev_config_lock(test_dev);
> > +
> > +	len += snprintf(buf, PAGE_SIZE,
> > +			"Configuration for: %s\n",
> > +			dev_name(dev));
> 
> Please use sysfs_emit() instead of snprintf().

Oh nice, done and fixed also in the other places.

> > +static int sysfs_test_dev_alloc_blockdev(struct sysfs_test_device *test_dev)
> > +{
> > +	int ret = -ENOMEM;
> > +
> > +	test_dev->disk = blk_alloc_disk(NUMA_NO_NODE);
> > +	if (!test_dev->disk) {
> > +		pr_err("Error allocating disk structure for device %d\n",
> > +		       test_dev->dev_idx);
> > +		goto out;
> > +	}
> > +
> > +	test_dev->disk->major = sysfs_test_major;
> > +	test_dev->disk->first_minor = test_dev->dev_idx + 1;
> > +	test_dev->disk->fops = &sysfs_testdev_ops;
> > +	test_dev->disk->private_data = test_dev;
> > +	snprintf(test_dev->disk->disk_name, 16, "test_sysfs%d",
> > +		 test_dev->dev_idx);
> 
> Prefer sizeof(test_dev->disk->disk_name) over open-coded "16".

Sure.

> > +static ssize_t read_reset_first_test_dev(struct file *file,
> > +					 char __user *user_buf,
> > +					 size_t count, loff_t *ppos)
> > +{
> > +	ssize_t len;
> > +	char buf[32];
> > +
> > +	reset_first_test_dev++;
> > +	len = sprintf(buf, "%d\n", reset_first_test_dev);
> 
> Even though it's safe as-is, I was going to suggest scnprintf() here
> (i.e. explicit bounds and a bounds-checked "len"). However, scnprintf()
> returns ssize_t, and there's no bounds checking in
> simple_read_from_buffer. That needs fixing (I'll send a patch).

OK we can later change it to scnprintf() once your patch gets merged.

> > --- /dev/null
> > +++ b/tools/testing/selftests/sysfs/sysfs.sh
> > @@ -0,0 +1,1208 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> > +#
> > +# This program is free software; you can redistribute it and/or modify it
> > +# under the terms of the GNU General Public License as published by the Free
> > +# Software Foundation; either version 2 of the License, or at your option any
> > +# later version; or, when distributed separately from the Linux kernel or
> > +# when incorporated into other software packages, subject to the following
> > +# license:
> > +#
> > +# This program is free software; you can redistribute it and/or modify it
> > +# under the terms of copyleft-next (version 0.3.1 or later) as published
> > +# at http://copyleft-next.org/.
> > +
> > +# This performs a series tests against the sysfs filesystem.
> 
> -boilerplate

Nuked.

> > +check_dmesg()
> > +{
> > +	# filter out intentional WARNINGs or Oopses
> > +	local filter=${1:-_check_dmesg_filter}
> > +
> > +	_dmesg_since_test_start | $filter >$seqres.dmesg
> > +	egrep -q -e "kernel BUG at" \
> > +	     -e "WARNING:" \
> > +	     -e "\bBUG:" \
> > +	     -e "Oops:" \
> > +	     -e "possible recursive locking detected" \
> > +	     -e "Internal error" \
> > +	     -e "(INFO|ERR): suspicious RCU usage" \
> > +	     -e "INFO: possible circular locking dependency detected" \
> > +	     -e "general protection fault:" \
> > +	     -e "BUG .* remaining" \
> > +	     -e "UBSAN:" \
> > +	     $seqres.dmesg
> 
> Is just looking for "call trace" sufficient here?

So far from my testing yes. This strategy is also borrowed from fstests
and that's what is done there, and so quite a lot of testing has been
done with that. If we are to consider an enhancement here we should then
also consider an enhancement welcome for fstests.

  Luis
