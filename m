Return-Path: <linux-fsdevel+bounces-53730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91474AF63EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AC11C4437C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1327A452;
	Wed,  2 Jul 2025 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fn7Bv1Zl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E481CCB4B
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491479; cv=none; b=E0p9A23rGiWVGAinUjilsyRDPnl5yQdVTfRgr6PAtM1j/B79lG6fKF/DSbilzin0t27GqOb87kLBPqFjeDUYr9HxKp8hSXaxiUd56C9yPDLY2s/kITH+Ms88FblZpMim7U8KGqvCaKUlxQS9kWoxJETOJzTCJfCUNcF2YlvHaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491479; c=relaxed/simple;
	bh=Vyso77Lbmng94SaSnElGt0LA3/wYlL1V7KmVPGimFHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIf+RrnRCMpVEwkWhvndv1a/8Hs4AM/SrC5/CMEVMb+ccm/s46/l0Gx9m2D6G2/skS1W8zyVgbmariqBXvG8HjAsSQYGKxetAL6MCQfHLaeDsXer2H5IRZVfFGGaiomqXiPikv8K70Cquw08BMFxa/PAbCSIp7qj8WM466egwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fn7Bv1Zl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751491478; x=1783027478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vyso77Lbmng94SaSnElGt0LA3/wYlL1V7KmVPGimFHc=;
  b=fn7Bv1ZlMRZFiOJzAjZyAV3/QM4/k2TFw0uzq8ISZ66aTI1nSFSARwyU
   95CQbpQGiUerkzJNJ8+v94lpboJDcbgde0cJwyE/glq1q4WsPTTLFN1K2
   n1oPnNxjYOwxi2HtGBYB+D73a3B8KzIbfbNNgaqAoyKkMyGwgvoaP1gdA
   torRo0GDdnaOQeecnMHe3J2tUA1CHKMrflobhdkx/HjKb536ByMPZXwEu
   ZdtpN+zEp0jbcUpzWf02TA9F8Ko8Kpizn7h0IKk83L3P+EbQ1Vv89Jnp3
   ru7pyr2JWHgIxUcK/8Nu1KuQ3qfjrxuvTCenRGK+eR0ii4DSJVuQO7G++
   Q==;
X-CSE-ConnectionGUID: CLYgt3GoQQ+gWlvdb+ylrQ==
X-CSE-MsgGUID: HmCID6HHQh66+Yk9vuLxdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53915965"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="53915965"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 14:24:37 -0700
X-CSE-ConnectionGUID: Mz6gvYc6Q6eGtIOp4cjyBg==
X-CSE-MsgGUID: HA9Izx8nRk2Vr4dX7t68Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="159874924"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 14:24:32 -0700
Date: Wed, 2 Jul 2025 14:24:26 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/11] resctrl: get rid of pointless
 debugfs_file_{get,put}()
Message-ID: <aGWjig2vNfmtl-FZ@agluck-desk3>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <20250702211650.GD3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211650.GD3406663@ZenIV>

On Wed, Jul 02, 2025 at 10:16:50PM +0100, Al Viro wrote:

+Reinette

> ->write() of file_operations that gets used only via debugfs_create_file()
> is called only under debugfs_file_get()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/resctrl/pseudo_lock.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
> index ccc2f9213b4b..87bbc2605de1 100644
> --- a/fs/resctrl/pseudo_lock.c
> +++ b/fs/resctrl/pseudo_lock.c
> @@ -764,13 +764,9 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
>  	if (ret == 0) {
>  		if (sel != 1 && sel != 2 && sel != 3)
>  			return -EINVAL;
> -		ret = debugfs_file_get(file->f_path.dentry);
> -		if (ret)
> -			return ret;
>  		ret = pseudo_lock_measure_cycles(rdtgrp, sel);
>  		if (ret == 0)
>  			ret = count;
> -		debugfs_file_put(file->f_path.dentry);
>  	}
>  
>  	return ret;
> -- 
> 2.39.5
> 

