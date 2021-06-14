Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80A43A6AF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhFNPyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233894AbhFNPyd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:54:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6292860FEE;
        Mon, 14 Jun 2021 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623685950;
        bh=trCbMGPAbt9/hzrWlV6LYuE+SaIgEDWh+DuiywOoDhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1BXHD7aM5xf8LRFVUUHxCZ+Yl93ZkZLcH9KouwmBEbG/fCvejrJXDiOYN0Js5XS8k
         8TSvta5Pm1Po7SmLwZ4YqKncEIcqI9CPnPZFqhyjRpq9PRPWzHmdwLp460+PGcldi9
         pwUibem6vahztLNFxVphy+pMq5W1O681ZGxp+Bbg=
Date:   Mon, 14 Jun 2021 17:52:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin <hpa@zytor.com>, Greg Kroah-Hartman
        <gregkh@linuxfoundation.org>, Rafael J. Wysocki " <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] driver core: Allow showing cpu as offline if not
 valid in cpuset context
Message-ID: <YMd7PEU0KPulsgMz@kroah.com>
References: <20210614152306.25668-1-longman@redhat.com>
 <20210614152306.25668-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614152306.25668-5-longman@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:23:06AM -0400, Waiman Long wrote:
> Make /sys/devices/system/cpu/cpu<n>/online file to show a cpu as
> offline if it is not a valid cpu in a proper cpuset context when the
> cpuset_bound_cpuinfo sysctl parameter is turned on.

This says _what_ you are doing, but I do not understand _why_ you want
to do this.

What is going to use this information?  And now you are showing more
files than you previously did, so what userspace tool is now going to
break?



> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/base/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 54ba506e5a89..176b927fade2 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sysfs.h>
>  #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> +#include <linux/cpuset.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -2378,11 +2379,24 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(uevent);
>  
> +static bool is_device_cpu(struct device *dev)
> +{
> +	return dev->bus && dev->bus->dev_name
> +			&& !strcmp(dev->bus->dev_name, "cpu");
> +}

No, this is not ok, there is a reason we did not put RTTI in struct
devices, so don't try to fake one here please.

> +
>  static ssize_t online_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
>  	bool val;
>  
> +	/*
> +	 * Show a cpu as offline if the cpu number is not valid in a
> +	 * proper cpuset bounding cpuinfo context.
> +	 */
> +	if (is_device_cpu(dev) && !cpuset_current_cpu_valid(dev->id))
> +		return sysfs_emit(buf, "0\n");

Why are you changing the driver core for a single random, tiny set of
devices?  The device code for those devices can handle this just fine,
do NOT modify the driver core for each individual driver type, that way
lies madness.

This change is not ok, sorry.

greg k-h
