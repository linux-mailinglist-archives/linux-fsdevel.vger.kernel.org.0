Return-Path: <linux-fsdevel+bounces-77744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKjAHDmFl2mwzgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:48:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41E162F22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F1B304C4BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29032AAD8;
	Thu, 19 Feb 2026 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJvm/R/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94E329E62;
	Thu, 19 Feb 2026 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537667; cv=none; b=MIqdVfPg57W5WfZrKIbRUi45W8SuxBkA5ZI3OpN14BFYl22rmoqvBCjJBmtrF4XGVuUEW+GNFP7GYE/4l6438qyv6RA9t+NEw2J29tPTsXWbUfF6fF6IwrmNt1xinbRpkTX81b3YIy9+UZo5ATbIrusXyIPvNb6V4g5Q3jOTkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537667; c=relaxed/simple;
	bh=VhveE971Wol08NHrou9PFE3GW2B0Q08SyEFuYI0D+ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koypskj43tesxgf09XFr2S7sNzl6lq8rzF4OYvs96Fjwi5lTDIDGjFZtVM6Yb23xEjAAZwk9r97TTaXlytS1ZX7OBpl5yddCo1GH5WG784qobW9vCQ8mGOSqSV8B/pzsEv3K8i45hliV4q8KWRJf3H55MbYxCSWzWtFbyyDSXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJvm/R/F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771537666; x=1803073666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VhveE971Wol08NHrou9PFE3GW2B0Q08SyEFuYI0D+ec=;
  b=ZJvm/R/FotSJ5KZxfioql5mmw6jjuFAbjSf38JH5nL848WfVllWJ4pu+
   Cayuys4FPqT1qoIo+ZsLbnOZCEsRqo948t3mSqrY/LbrlNI52ASy0DRxJ
   pFTi2ORhiHhvrx9A9j8awvFOZMX5Rxz3a5Q4aBhmtahbRrDckvnm+Ujc4
   YrVHND/yp6JvxpGYJ/6ja8h/PGZrcAVsspEvSE7nAqQVpX5WFaCH52aQn
   N/VDO9HP5SbC7/14OJ3/bpjYpnNsiYJ0B4PgMIFpcdh6lm9eVyQsaPw6K
   aZ0wD0l4XHMk7b0XbykjlVFoPq70xg9nlLS6i4xuJznRTOxm6OV0H7ZhR
   A==;
X-CSE-ConnectionGUID: KbDTSnW8SVC/rwVswnUaaw==
X-CSE-MsgGUID: +kQQW5jMRWCPqzdxtd5xyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76251294"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76251294"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:47:45 -0800
X-CSE-ConnectionGUID: y/tUrnZ9TZ+cEs+cK5kDrQ==
X-CSE-MsgGUID: 8znDFJuQTzScyR2OV9OTjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219670182"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:47:43 -0800
Message-ID: <2de8faba-2157-44b3-8983-c239776f1c98@intel.com>
Date: Thu, 19 Feb 2026 14:47:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] daxctl: Add support for famfs mode
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
 <20260118223629.92852-1-john@jagalactic.com>
 <0100019bd340cdd5-89036a70-3ef5-4c34-abf8-07a3ea4d9f92-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd340cdd5-89036a70-3ef5-4c34-abf8-07a3ea4d9f92-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77744-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[groves.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: EE41E162F22
X-Rspamd-Action: no action



On 1/18/26 3:36 PM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> Putting a daxdev in famfs mode means binding it to fsdev_dax.ko
> (drivers/dax/fsdev.c). Finding a daxdev bound to fsdev_dax means
> it is in famfs mode.
> 
> The test is added to the destructive test suite since it
> modifies device modes.
> 
> With devdax, famfs, and system-ram modes, the previous logic that assumed
> 'not in mode X means in mode Y' needed to get slightly more complicated
> 
> Add explicit mode detection functions:
> - daxctl_dev_is_famfs_mode(): check if bound to fsdev_dax driver
> - daxctl_dev_is_devdax_mode(): check if bound to device_dax driver
> 
> Fix mode transition logic in device.c:
> - disable_devdax_device(): verify device is actually in devdax mode
> - disable_famfs_device(): verify device is actually in famfs mode
> - All reconfig_mode_*() functions now explicitly check each mode
> - Handle unknown mode with error instead of wrong assumption
> 
> Modify json.c to show 'unknown' if device is not in a recognized mode.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  daxctl/device.c                | 126 ++++++++++++++++++++++++++++++---
>  daxctl/json.c                  |   6 +-
>  daxctl/lib/libdaxctl-private.h |   2 +
>  daxctl/lib/libdaxctl.c         |  77 ++++++++++++++++++++
>  daxctl/lib/libdaxctl.sym       |   7 ++
>  daxctl/libdaxctl.h             |   3 +
>  6 files changed, 210 insertions(+), 11 deletions(-)
> 
> diff --git a/daxctl/device.c b/daxctl/device.c
> index e3993b1..14e1796 100644
> --- a/daxctl/device.c
> +++ b/daxctl/device.c
> @@ -42,6 +42,7 @@ enum dev_mode {
>  	DAXCTL_DEV_MODE_UNKNOWN,
>  	DAXCTL_DEV_MODE_DEVDAX,
>  	DAXCTL_DEV_MODE_RAM,
> +	DAXCTL_DEV_MODE_FAMFS,
>  };
>  
>  struct mapping {
> @@ -471,6 +472,13 @@ static const char *parse_device_options(int argc, const char **argv,
>  					"--no-online is incompatible with --mode=devdax\n");
>  				rc =  -EINVAL;
>  			}
> +		} else if (strcmp(param.mode, "famfs") == 0) {
> +			reconfig_mode = DAXCTL_DEV_MODE_FAMFS;
> +			if (param.no_online) {
> +				fprintf(stderr,
> +					"--no-online is incompatible with --mode=famfs\n");
> +				rc =  -EINVAL;
> +			}
>  		}
>  		break;
>  	case ACTION_CREATE:
> @@ -696,8 +704,42 @@ static int disable_devdax_device(struct daxctl_dev *dev)
>  	int rc;
>  
>  	if (mem) {
> -		fprintf(stderr, "%s was already in system-ram mode\n",
> -			devname);
> +		fprintf(stderr, "%s is in system-ram mode\n", devname);
> +		return 1;
> +	}
> +	if (daxctl_dev_is_famfs_mode(dev)) {
> +		fprintf(stderr, "%s is in famfs mode\n", devname);
> +		return 1;
> +	}
> +	if (!daxctl_dev_is_devdax_mode(dev)) {
> +		fprintf(stderr, "%s is not in devdax mode\n", devname);
> +		return 1;
> +	}
> +	rc = daxctl_dev_disable(dev);
> +	if (rc) {
> +		fprintf(stderr, "%s: disable failed: %s\n",
> +			daxctl_dev_get_devname(dev), strerror(-rc));
> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +static int disable_famfs_device(struct daxctl_dev *dev)
> +{
> +	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +	const char *devname = daxctl_dev_get_devname(dev);
> +	int rc;
> +
> +	if (mem) {
> +		fprintf(stderr, "%s is in system-ram mode\n", devname);
> +		return 1;
> +	}
> +	if (daxctl_dev_is_devdax_mode(dev)) {
> +		fprintf(stderr, "%s is in devdax mode\n", devname);
> +		return 1;
> +	}
> +	if (!daxctl_dev_is_famfs_mode(dev)) {
> +		fprintf(stderr, "%s is not in famfs mode\n", devname);
>  		return 1;
>  	}
>  	rc = daxctl_dev_disable(dev);
> @@ -711,6 +753,7 @@ static int disable_devdax_device(struct daxctl_dev *dev)
>  
>  static int reconfig_mode_system_ram(struct daxctl_dev *dev)
>  {
> +	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
>  	const char *devname = daxctl_dev_get_devname(dev);
>  	int rc, skip_enable = 0;
>  
> @@ -724,11 +767,21 @@ static int reconfig_mode_system_ram(struct daxctl_dev *dev)
>  	}
>  
>  	if (daxctl_dev_is_enabled(dev)) {
> -		rc = disable_devdax_device(dev);
> -		if (rc < 0)
> -			return rc;
> -		if (rc > 0)
> +		if (mem) {
> +			/* already in system-ram mode */
>  			skip_enable = 1;
> +		} else if (daxctl_dev_is_famfs_mode(dev)) {
> +			rc = disable_famfs_device(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_devdax_mode(dev)) {
> +			rc = disable_devdax_device(dev);
> +			if (rc)
> +				return rc;
> +		} else {
> +			fprintf(stderr, "%s: unknown mode\n", devname);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	if (!skip_enable) {
> @@ -750,7 +803,7 @@ static int disable_system_ram_device(struct daxctl_dev *dev)
>  	int rc;
>  
>  	if (!mem) {
> -		fprintf(stderr, "%s was already in devdax mode\n", devname);
> +		fprintf(stderr, "%s is not in system-ram mode\n", devname);
>  		return 1;
>  	}
>  
> @@ -786,12 +839,28 @@ static int disable_system_ram_device(struct daxctl_dev *dev)
>  
>  static int reconfig_mode_devdax(struct daxctl_dev *dev)
>  {
> +	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +	const char *devname = daxctl_dev_get_devname(dev);
>  	int rc;
>  
>  	if (daxctl_dev_is_enabled(dev)) {
> -		rc = disable_system_ram_device(dev);
> -		if (rc)
> -			return rc;
> +		if (mem) {
> +			rc = disable_system_ram_device(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_famfs_mode(dev)) {
> +			rc = disable_famfs_device(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_devdax_mode(dev)) {
> +			/* already in devdax mode, just re-enable */
> +			rc = daxctl_dev_disable(dev);
> +			if (rc)
> +				return rc;
> +		} else {
> +			fprintf(stderr, "%s: unknown mode\n", devname);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	rc = daxctl_dev_enable_devdax(dev);
> @@ -801,6 +870,40 @@ static int reconfig_mode_devdax(struct daxctl_dev *dev)
>  	return 0;
>  }
>  
> +static int reconfig_mode_famfs(struct daxctl_dev *dev)
> +{
> +	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +	const char *devname = daxctl_dev_get_devname(dev);
> +	int rc;
> +
> +	if (daxctl_dev_is_enabled(dev)) {
> +		if (mem) {
> +			fprintf(stderr,
> +				"%s is in system-ram mode, must be in devdax mode to convert to famfs\n",
> +				devname);
> +			return -EINVAL;
> +		} else if (daxctl_dev_is_famfs_mode(dev)) {
> +			/* already in famfs mode, just re-enable */
> +			rc = daxctl_dev_disable(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_devdax_mode(dev)) {
> +			rc = disable_devdax_device(dev);
> +			if (rc)
> +				return rc;
> +		} else {
> +			fprintf(stderr, "%s: unknown mode\n", devname);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	rc = daxctl_dev_enable_famfs(dev);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
>  static int do_create(struct daxctl_region *region, long long val,
>  		     struct json_object **jdevs)
>  {
> @@ -887,6 +990,9 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
>  	case DAXCTL_DEV_MODE_DEVDAX:
>  		rc = reconfig_mode_devdax(dev);
>  		break;
> +	case DAXCTL_DEV_MODE_FAMFS:
> +		rc = reconfig_mode_famfs(dev);
> +		break;
>  	default:
>  		fprintf(stderr, "%s: unknown mode requested: %d\n",
>  			devname, mode);
> diff --git a/daxctl/json.c b/daxctl/json.c
> index 3cbce9d..01f139b 100644
> --- a/daxctl/json.c
> +++ b/daxctl/json.c
> @@ -48,8 +48,12 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
>  
>  	if (mem)
>  		jobj = json_object_new_string("system-ram");
> -	else
> +	else if (daxctl_dev_is_famfs_mode(dev))
> +		jobj = json_object_new_string("famfs");
> +	else if (daxctl_dev_is_devdax_mode(dev))
>  		jobj = json_object_new_string("devdax");
> +	else
> +		jobj = json_object_new_string("unknown");
>  	if (jobj)
>  		json_object_object_add(jdev, "mode", jobj);
>  
> diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
> index ae45311..0bb73e8 100644
> --- a/daxctl/lib/libdaxctl-private.h
> +++ b/daxctl/lib/libdaxctl-private.h
> @@ -21,12 +21,14 @@ static const char *dax_subsystems[] = {
>  enum daxctl_dev_mode {
>  	DAXCTL_DEV_MODE_DEVDAX = 0,
>  	DAXCTL_DEV_MODE_RAM,
> +	DAXCTL_DEV_MODE_FAMFS,
>  	DAXCTL_DEV_MODE_END,
>  };
>  
>  static const char *dax_modules[] = {
>  	[DAXCTL_DEV_MODE_DEVDAX] = "device_dax",
>  	[DAXCTL_DEV_MODE_RAM] = "kmem",
> +	[DAXCTL_DEV_MODE_FAMFS] = "fsdev_dax",
>  };
>  
>  enum memory_op {
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index b7fa0de..0a6cbfe 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -418,6 +418,78 @@ DAXCTL_EXPORT int daxctl_dev_is_system_ram_capable(struct daxctl_dev *dev)
>  	return false;
>  }
>  
> +/*
> + * Check if device is currently in famfs mode (bound to fsdev_dax driver)
> + */
> +DAXCTL_EXPORT int daxctl_dev_is_famfs_mode(struct daxctl_dev *dev)

Should this return bool?

> +{
> +	const char *devname = daxctl_dev_get_devname(dev);
> +	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +	char *mod_path, *mod_base;
> +	char path[200];
> +	const int len = sizeof(path);
> +
> +	if (!device_model_is_dax_bus(dev))
> +		return false;
> +
> +	if (!daxctl_dev_is_enabled(dev))
> +		return false;
> +
> +	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
> +		err(ctx, "%s: buffer too small!\n", devname);
> +		return false;
> +	}
> +
> +	mod_path = realpath(path, NULL);
> +	if (!mod_path)
> +		return false;
> +
> +	mod_base = basename(mod_path);
> +	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_FAMFS]) == 0) {
> +		free(mod_path);
> +		return true;
> +	}
> +
> +	free(mod_path);
> +	return false;
> +}
> +
> +/*
> + * Check if device is currently in devdax mode (bound to device_dax driver)
> + */
> +DAXCTL_EXPORT int daxctl_dev_is_devdax_mode(struct daxctl_dev *dev)

return bool?

DJ

> +{
> +	const char *devname = daxctl_dev_get_devname(dev);
> +	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +	char *mod_path, *mod_base;
> +	char path[200];
> +	const int len = sizeof(path);
> +
> +	if (!device_model_is_dax_bus(dev))
> +		return false;
> +
> +	if (!daxctl_dev_is_enabled(dev))
> +		return false;
> +
> +	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
> +		err(ctx, "%s: buffer too small!\n", devname);
> +		return false;
> +	}
> +
> +	mod_path = realpath(path, NULL);
> +	if (!mod_path)
> +		return false;
> +
> +	mod_base = basename(mod_path);
> +	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_DEVDAX]) == 0) {
> +		free(mod_path);
> +		return true;
> +	}
> +
> +	free(mod_path);
> +	return false;
> +}
> +
>  /*
>   * This checks for the device to be in system-ram mode, so calling
>   * daxctl_dev_get_memory() on a devdax mode device will always return NULL.
> @@ -982,6 +1054,11 @@ DAXCTL_EXPORT int daxctl_dev_enable_ram(struct daxctl_dev *dev)
>  	return daxctl_dev_enable(dev, DAXCTL_DEV_MODE_RAM);
>  }
>  
> +DAXCTL_EXPORT int daxctl_dev_enable_famfs(struct daxctl_dev *dev)
> +{
> +	return daxctl_dev_enable(dev, DAXCTL_DEV_MODE_FAMFS);
> +}
> +
>  DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
>  {
>  	const char *devname = daxctl_dev_get_devname(dev);
> diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
> index 3098811..2a812c6 100644
> --- a/daxctl/lib/libdaxctl.sym
> +++ b/daxctl/lib/libdaxctl.sym
> @@ -104,3 +104,10 @@ LIBDAXCTL_10 {
>  global:
>  	daxctl_dev_is_system_ram_capable;
>  } LIBDAXCTL_9;
> +
> +LIBDAXCTL_11 {
> +global:
> +	daxctl_dev_enable_famfs;
> +	daxctl_dev_is_famfs_mode;
> +	daxctl_dev_is_devdax_mode;
> +} LIBDAXCTL_10;
> diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
> index 53c6bbd..84fcdb4 100644
> --- a/daxctl/libdaxctl.h
> +++ b/daxctl/libdaxctl.h
> @@ -72,12 +72,15 @@ int daxctl_dev_is_enabled(struct daxctl_dev *dev);
>  int daxctl_dev_disable(struct daxctl_dev *dev);
>  int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
>  int daxctl_dev_enable_ram(struct daxctl_dev *dev);
> +int daxctl_dev_enable_famfs(struct daxctl_dev *dev);
>  int daxctl_dev_get_target_node(struct daxctl_dev *dev);
>  int daxctl_dev_will_auto_online_memory(struct daxctl_dev *dev);
>  int daxctl_dev_has_online_memory(struct daxctl_dev *dev);
>  
>  struct daxctl_memory;
>  int daxctl_dev_is_system_ram_capable(struct daxctl_dev *dev);
> +int daxctl_dev_is_famfs_mode(struct daxctl_dev *dev);
> +int daxctl_dev_is_devdax_mode(struct daxctl_dev *dev);
>  struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev);
>  struct daxctl_dev *daxctl_memory_get_dev(struct daxctl_memory *mem);
>  const char *daxctl_memory_get_node_path(struct daxctl_memory *mem);


