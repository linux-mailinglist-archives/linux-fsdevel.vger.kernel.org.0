Return-Path: <linux-fsdevel+bounces-10829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BA784E8FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B92892D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930F381C7;
	Thu,  8 Feb 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSerNsBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47189149DFF;
	Thu,  8 Feb 2024 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420879; cv=none; b=Wlymc8d532wRvj/RFyui5Sn/gkdCAo7Pei6O0IvgANtY8DrFhqJMZ3djzmkww1HWDrwSOvoLaTo4B9oVeNEHdOqQYN7bGnGXI6/cUUyDBlxk4i4SPfdpsoZHvaHkEmdjpGaotwDou1sajsjQHsNipsj+8A67uoxgKIaEfbD0R74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420879; c=relaxed/simple;
	bh=jfFt98aIUuomsKcXihueoohkKAJPf25VK+fpiRdbjcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pK1gnQglN2EMfWK/wru5BhBtVvRJRVbcb/eRH24/xAA7HMMGD5yIRR18hvEp1WoJTHEs8jWeg7HzuxncMd1WEiH66Bc2OEouyFfSiptst3IT9NMqsw3ZQpokkl8QNRsmrKzKiTOJ73Ovc48fQ9A3luegdR8u/zZ9VhBfdY2hI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSerNsBx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707420878; x=1738956878;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jfFt98aIUuomsKcXihueoohkKAJPf25VK+fpiRdbjcM=;
  b=FSerNsBxAfqzw8TWiiAZ75aTZsEqND7yffMFQ4+t/srPWzvhTXtMQdEs
   sPpiDppNZteVMdLkaXiEpoEQ90FvdWqwKw1j9UxKyeV02h2BLRnGc9Y/o
   08NKiaJAos6PSnFnDj1Q8zgtwqd5NnAbmjuFHM6rTCq2BE8nfUj/1Yn4w
   roWnNegROrln7ZwCVnRI8Q0r0/iL0fD+bIu/xKgAoC96BqHqnH116kzH4
   V2Sunw6750PUOf11B9n+lhso8EnYtX0MeckX4yMBtdbC87jpqLe8oKeIn
   MlF/n7pDmEiyXqYkHk2jwzIuwFPly8lNShfUTJAj8oSlRLOmvAXC1fJL9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="26750608"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="26750608"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1774319"
Received: from ercutler-mobl.amr.corp.intel.com (HELO [10.209.94.1]) ([10.209.94.1])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:34:37 -0800
Message-ID: <623f1fe08c8bbd7e49f2dc124892ac864cd7dac0.camel@linux.intel.com>
Subject: Re: [PATCH 4/7] fs/writeback: remove unneeded check in
 writeback_single_inode
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 11:34:36 -0800
In-Reply-To: <20240208172024.23625-5-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
	 <20240208172024.23625-5-shikemeng@huaweicloud.com>
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
> I_DIRTY_ALL consists of I_DIRTY_TIME and I_DIRTY, so I_DIRTY_TIME must
> be set when any bit of I_DIRTY_ALL is set but I_DIRTY is not set.

/s/any bit of/some bit in/

>=20
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2619f74ced70..b61bf2075931 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1788,7 +1788,7 @@ static int writeback_single_inode(struct inode *ino=
de,
>  		else if (!(inode->i_state & I_SYNC_QUEUED)) {
>  			if ((inode->i_state & I_DIRTY))
>  				redirty_tail_locked(inode, wb);
> -			else if (inode->i_state & I_DIRTY_TIME) {
> +			else {
>  				inode->dirtied_when =3D jiffies;
>  				inode_io_list_move_locked(inode,
>  							  wb,


