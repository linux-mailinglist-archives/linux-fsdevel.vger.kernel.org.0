Return-Path: <linux-fsdevel+bounces-72830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2B0D031A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 14:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A686530CA38C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF44F4C66;
	Thu,  8 Jan 2026 12:34:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC204D2449;
	Thu,  8 Jan 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875698; cv=none; b=XakUHbf8w30bJJj+CbLMjU9NIyFX7rQ08mj5h+toMMXZdrTQvn0rpWWBX7h44+ykBjY9zDQpSXUQqqbI2n3z+JAIOU/xRw+vU1+CciDqlLHIDFpr6K40YJxe8nfg1a0oVZZ8+HbWzQmCLpuFRvMDLG0SvdjUAte6/1O1INxTFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875698; c=relaxed/simple;
	bh=sOXOyLTiP/6AAkX4P6ptZI8GTCLwE7Rurc3N6kkkQWE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqsO3dsFH8w5yDzKbNHc67XaTm6TtgVyKot2TrAej8BBGt2LglOTLcKTxP452ZPAgc++qqGJ1RHQYDzBE4j/QOk2q9q/kccTRbWgQ4Gb/R9LVSNX/1dQEGTsWiBThrT6s8HTbgTL/AyQucUIyqCBeoJWi6hrGTpL7AhGCXdwDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn49N3W0LzJ468s;
	Thu,  8 Jan 2026 20:34:48 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5014640539;
	Thu,  8 Jan 2026 20:34:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 12:34:51 +0000
Date: Thu, 8 Jan 2026 12:34:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 07/21] dax: prevent driver unbind while filesystem
 holds device
Message-ID: <20260108123450.00004eac@huawei.com>
In-Reply-To: <20260107153332.64727-8-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-8-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:16 -0600
John Groves <John@Groves.net> wrote:

> From: John Groves <John@Groves.net>
> 
> Add custom bind/unbind sysfs attributes for the dax bus that check
> whether a filesystem has registered as a holder (via fs_dax_get())
> before allowing driver unbind.
> 
> When a filesystem like famfs mounts on a dax device, it registers
> itself as the holder via dax_holder_ops. Previously, there was no
> mechanism to prevent driver unbind while the filesystem was mounted,
> which could cause some havoc.
> 
> The new unbind_store() checks dax_holder() and returns -EBUSY if
> a holder is registered, giving userspace proper feedback that the
> device is in use.
> 
> To use our custom bind/unbind handlers instead of the default ones,
> set suppress_bind_attrs=true on all dax drivers during registration.

Whilst I appreciate that it is painful, so are many other driver unbinds
where services are provided to another driver.  Is there any precedence
for doing something like this? If not, I'd like to see a review on this
from one of the driver core folk. Maybe Greg KH.

Might just be a case of calling it something else to avoid userspace
tooling getting a surprise.

> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/dax/bus.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 6e0e28116edc..ed453442739d 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -151,9 +151,61 @@ static ssize_t remove_id_store(struct device_driver *drv, const char *buf,
>  }
>  static DRIVER_ATTR_WO(remove_id);
>  
> +static const struct bus_type dax_bus_type;
> +
> +/*
> + * Custom bind/unbind handlers for dax bus.
> + * The unbind handler checks if a filesystem holds the dax device and
> + * returns -EBUSY if so, preventing driver unbind while in use.
> + */
> +static ssize_t unbind_store(struct device_driver *drv, const char *buf,
> +		size_t count)
> +{
> +	struct device *dev;
> +	int rc = -ENODEV;
> +
> +	dev = bus_find_device_by_name(&dax_bus_type, NULL, buf);

	struct device *dev __free(put_device) = bus_find_device_by_name()...

and you can just return on error.

> +	if (dev && dev->driver == drv) {
With the __free I'd flip this
	if (!dev || !dev->driver == drv)
		return -ENODEV;

	...

> +		struct dev_dax *dev_dax = to_dev_dax(dev);
> +
> +		if (dax_holder(dev_dax->dax_dev)) {
> +			dev_dbg(dev,
> +				"%s: blocking unbind due to active holder\n",
> +				__func__);
> +			rc = -EBUSY;
> +			goto out;
> +		}
> +		device_release_driver(dev);
> +		rc = count;
> +	}
> +out:
> +	put_device(dev);
> +	return rc;
> +}
> +static DRIVER_ATTR_WO(unbind);
> +
> +static ssize_t bind_store(struct device_driver *drv, const char *buf,
> +		size_t count)
> +{
> +	struct device *dev;
> +	int rc = -ENODEV;
> +
> +	dev = bus_find_device_by_name(&dax_bus_type, NULL, buf);
Use __free magic here as well..
> +	if (dev) {
> +		rc = device_driver_attach(drv, dev);
> +		if (!rc)
> +			rc = count;
then this can be
		if (rc)
			return rc;
		return count;

> +	}
> +	put_device(dev);
> +	return rc;
> +}
> +static DRIVER_ATTR_WO(bind);
> +
>  static struct attribute *dax_drv_attrs[] = {
>  	&driver_attr_new_id.attr,
>  	&driver_attr_remove_id.attr,
> +	&driver_attr_bind.attr,
> +	&driver_attr_unbind.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(dax_drv);
> @@ -1591,6 +1643,7 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
>  	drv->name = mod_name;
>  	drv->mod_name = mod_name;
>  	drv->bus = &dax_bus_type;
> +	drv->suppress_bind_attrs = true;
>  
>  	return driver_register(drv);
>  }


