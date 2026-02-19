Return-Path: <linux-fsdevel+bounces-77719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKuRIlExl2kcvgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:50:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E40301605FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1409030B48C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183F34A3DC;
	Thu, 19 Feb 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBb7ndUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3051734A76E;
	Thu, 19 Feb 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515931; cv=none; b=YpZQWQ0699m+/ePZwu1YFKxMW3sXDLZ0tMfcYGMQDPE8LEDIzFDo0qhgWBD6ld8ZbQug9LlCUA8PRJ7z4QxlBFlPNsxK94ZKqF0roNpbyu9hTnI06W4Cf+lRGQVdkhzaiOwRIU3p/NC/7mv0vBEuG4UzsqOeQloD0hjVsezIn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515931; c=relaxed/simple;
	bh=2tel+xr7GLPTXAeWWTV0pNMbxcro+AF4/Zk3M5cR9sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCU2FONYBtTBRwTbgHLm4t3ThPvltLEPhQEkPp2984NvWuLSP3mSsePg/Y8dH56jgaVZaU98/8USDhkHjNAXERZqE3J5QZJIJWzPaAdjB+e/uJOSwPtuOImpQrE+p46ZboXiW+KPzvkMmdKq7Y3EAf6z1iDQI5A73WsAtsoNtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBb7ndUW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771515928; x=1803051928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2tel+xr7GLPTXAeWWTV0pNMbxcro+AF4/Zk3M5cR9sc=;
  b=KBb7ndUWvK8jmmjRYAN/U3nkUUcJ56ZZoyo3jyEtSAf7PcSXxpQPfXCb
   NgQTE7ly+5uQsm3xzc9TZdv6irXkzFGfEogyv9hjbukT9uKPcAbffTMM5
   n+DdPTOFVx71NmaEpZcuS76dt58dtOtv689f05VWNdT1DK3I0jvwLddW5
   p16s5+3hTRUhsw64WJGVRrllKjFcu+8dkQUVKkgqLS3HnF/ovDLrgjKLD
   L1yrestfM4E5cJ/22HnigKGtl2ZRUCk1W6MfNoE50ZgrCrwRuIUNVLDop
   8EpnRs49vHrd7LzGtlCddW1tMhVcakI0yjmg2Jvk0XrPYru0S1U/ECFh8
   A==;
X-CSE-ConnectionGUID: iQ4CNZr/QSu4hccEnHVG0w==
X-CSE-MsgGUID: ggKRObpEQWyqzWrY+L21MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="90011824"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="90011824"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 07:41:48 -0800
X-CSE-ConnectionGUID: 2UNbJJT1QwWcglV/ZWOzMQ==
X-CSE-MsgGUID: 2+Zeibn4Samq6kR6s/gMAQ==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 07:41:45 -0800
Message-ID: <3d4f6d14-4b5e-42e4-bab6-2d055088de7b@intel.com>
Date: Thu, 19 Feb 2026 08:41:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 06/19] dax: Add dax_set_ops() for setting
 dax_operations at bind time
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
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223157.92407-1-john@jagalactic.com>
 <0100019bd33c9e30-6de962ed-6feb-4481-a68a-c225ee8808ff-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33c9e30-6de962ed-6feb-4481-a68a-c225ee8808ff-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77719-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,groves.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E40301605FB
X-Rspamd-Action: no action



On 1/18/26 3:32 PM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> Add a new dax_set_ops() function that allows drivers to set the
> dax_operations after the dax_device has been allocated. This is needed
> for fsdev_dax where the operations need to be set during probe and
> cleared during unbind.
> 
> The fsdev driver uses devm_add_action_or_reset() for cleanup consistency,
> avoiding the complexity of mixing devm-managed resources with manual
> cleanup in a remove() callback. This ensures cleanup happens automatically
> in the correct reverse order when the device is unbound.
> 
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dax/fsdev.c | 16 ++++++++++++++++
>  drivers/dax/super.c | 38 +++++++++++++++++++++++++++++++++++++-
>  include/linux/dax.h |  1 +
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 5d17ad39227f..4949aa41dcf4 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -119,6 +119,13 @@ static void fsdev_kill(void *dev_dax)
>  	kill_dev_dax(dev_dax);
>  }
>  
> +static void fsdev_clear_ops(void *data)
> +{
> +	struct dev_dax *dev_dax = data;
> +
> +	dax_set_ops(dev_dax->dax_dev, NULL);
> +}
> +
>  /*
>   * Page map operations for FS-DAX mode
>   * Similar to fsdax_pagemap_ops in drivers/nvdimm/pmem.c
> @@ -301,6 +308,15 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  	if (rc)
>  		return rc;
>  
> +	/* Set the dax operations for fs-dax access path */
> +	rc = dax_set_ops(dax_dev, &dev_dax_ops);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(dev, fsdev_clear_ops, dev_dax);
> +	if (rc)
> +		return rc;
> +
>  	run_dax(dax_dev);
>  	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
>  }
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c00b9dff4a06..ba0b4cd18a77 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -157,6 +157,9 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
>  	if (!dax_alive(dax_dev))
>  		return -ENXIO;
>  
> +	if (!dax_dev->ops)
> +		return -EOPNOTSUPP;
> +
>  	if (nr_pages < 0)
>  		return -EINVAL;
>  
> @@ -207,6 +210,10 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  
>  	if (!dax_alive(dax_dev))
>  		return -ENXIO;
> +
> +	if (!dax_dev->ops)
> +		return -EOPNOTSUPP;
> +
>  	/*
>  	 * There are no callers that want to zero more than one page as of now.
>  	 * Once users are there, this check can be removed after the
> @@ -223,7 +230,7 @@ EXPORT_SYMBOL_GPL(dax_zero_page_range);
>  size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *iter)
>  {
> -	if (!dax_dev->ops->recovery_write)
> +	if (!dax_dev->ops || !dax_dev->ops->recovery_write)
>  		return 0;
>  	return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes, iter);
>  }
> @@ -307,6 +314,35 @@ void set_dax_nomc(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(set_dax_nomc);
>  
> +/**
> + * dax_set_ops - set the dax_operations for a dax_device
> + * @dax_dev: the dax_device to configure
> + * @ops: the operations to set (may be NULL to clear)
> + *
> + * This allows drivers to set the dax_operations after the dax_device
> + * has been allocated. This is needed when the device is created before
> + * the driver that needs specific ops is bound (e.g., fsdev_dax binding
> + * to a dev_dax created by hmem).
> + *
> + * When setting non-NULL ops, fails if ops are already set (returns -EBUSY).
> + * When clearing ops (NULL), always succeeds.
> + *
> + * Return: 0 on success, -EBUSY if ops already set
> + */
> +int dax_set_ops(struct dax_device *dax_dev, const struct dax_operations *ops)
> +{
> +	if (ops) {
> +		/* Setting ops: fail if already set */
> +		if (cmpxchg(&dax_dev->ops, NULL, ops) != NULL)
> +			return -EBUSY;
> +	} else {
> +		/* Clearing ops: always allowed */
> +		dax_dev->ops = NULL;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dax_set_ops);
> +
>  bool dax_alive(struct dax_device *dax_dev)
>  {
>  	lockdep_assert_held(&dax_srcu);
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index fe1315135fdd..5aaaca135737 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -247,6 +247,7 @@ static inline void dax_break_layout_final(struct inode *inode)
>  
>  bool dax_alive(struct dax_device *dax_dev);
>  void *dax_get_private(struct dax_device *dax_dev);
> +int dax_set_ops(struct dax_device *dax_dev, const struct dax_operations *ops);
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
>  		enum dax_access_mode mode, void **kaddr, unsigned long *pfn);
>  size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,


