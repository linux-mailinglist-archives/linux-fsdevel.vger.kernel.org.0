Return-Path: <linux-fsdevel+bounces-10804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F390384E7AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311D71C223CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED58663B;
	Thu,  8 Feb 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRc+TAnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46C85C77;
	Thu,  8 Feb 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416968; cv=none; b=tj1c4GAWJKkDU5s7CJgV5l6AMrpcRgK+MewyjcCNDpkM4JhDp4tScsam32a+VSLMfTZHYTB9MDFLcU3qfyo3aClmJXsHmRddUX1w1APxymiU4H+QVFDUuIJcTkAYuLil2jGb0kC2hWIIfy8WQACvf6HiItk+zSeeD/ZVqbsCRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416968; c=relaxed/simple;
	bh=+Mgb9O8JxfiO2LjvLytloVwnGb5SjOO6d7SN0mzNpYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdg9zGJTZh21QSEOWprCkPAKZh7yidddzhGrBy3Km7nHShv7FXxrGRxtVmcHPwmEGjNbm97/jaYMla2k2iAHAnDRCS3pb1+n76admvZWFOrfYla4oJsZD/kf5aEDcpFsy25x4r7gM1Vu2n1Zp+ELvgknE7/7Nc8XWzswQhQADf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRc+TAnK; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707416967; x=1738952967;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+Mgb9O8JxfiO2LjvLytloVwnGb5SjOO6d7SN0mzNpYo=;
  b=nRc+TAnKfsQRnfRNWfILQg0ohJ6GGIGpbNzsiSFnsq+vqTOxcEDjzf/e
   YMdRFhDXlPn1d0rd5hB2hGwWpe1elwGhCh3hgTNZUiRGAweisQUH4QEzG
   ubBQFUC1ZPn9m0MHBkDSexgGKU19QP+QdWuMyP9XNBHmwBPYnwC8Rd7PW
   DLzQyQZFc4iqTmuoLA56AZlU/BCyGF5fb77MZKdp+Gm/OAX7C7n0Ei+PY
   IbwSRBAYxS+hPNfxAxWUUtx5yzivVmBYU4NzQjcVlaNH5kcJPSb/Z1o4u
   8H9uCl21OxqO8gANj7s+pnGkIu2cefepH9Rwjiv8sJYaBEv32g09u9ijM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="395702300"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="395702300"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:29:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="2099541"
Received: from ercutler-mobl.amr.corp.intel.com (HELO [10.209.94.1]) ([10.209.94.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:29:26 -0800
Message-ID: <ba75294dfb5bf4dd046d54de6c3e57698592dacc.camel@linux.intel.com>
Subject: Re: [PATCH 1/7] fs/writeback: avoid to writeback non-expired inode
 in kupdate writeback
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 10:29:26 -0800
In-Reply-To: <20240208172024.23625-2-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
	 <20240208172024.23625-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 01:20 +0800, Kemeng Shi wrote:
>=20
> =20
> +static void filter_expired_io(struct bdi_writeback *wb)
> +{
> +	struct inode *inode, *tmp;
> +	unsigned long expired_jiffies =3D jiffies -
> +		msecs_to_jiffies(dirty_expire_interval * 10);

We have kupdate trigger time hard coded with a factor of 10 to expire inter=
val here.
The kupdate trigger time "mssecs_to_jiffies(dirty_expire_interval * 10)" is
also used in wb_writeback().  It will be better to have a macro or #define
to encapsulate the trigger time so if for any reason we need
to tune the trigger time, we just need to change it at one place.

Tim

> +
> +	spin_lock(&wb->list_lock);
> +	list_for_each_entry_safe(inode, tmp, &wb->b_io, i_io_list)
> +		if (inode_dirtied_after(inode, expired_jiffies))
> +			redirty_tail(inode, wb);
> +
> +	list_for_each_entry_safe(inode, tmp, &wb->b_more_io, i_io_list)
> +		if (inode_dirtied_after(inode, expired_jiffies))
> +			redirty_tail(inode, wb);
> +	spin_unlock(&wb->list_lock);
> +}
> +
>  /*
>   * Explicit flushing or periodic writeback of "old" data.
>   *
> @@ -2070,6 +2087,9 @@ static long wb_writeback(struct bdi_writeback *wb,
>  	long progress;
>  	struct blk_plug plug;
> =20
> +	if (work->for_kupdate)
> +		filter_expired_io(wb);
> +
>  	blk_start_plug(&plug);
>  	for (;;) {
>  		/*


