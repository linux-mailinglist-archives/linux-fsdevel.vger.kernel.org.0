Return-Path: <linux-fsdevel+bounces-29968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3C9842B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760C71C22782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF8158DD4;
	Tue, 24 Sep 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPrfZvUN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B754154BE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171633; cv=none; b=F2SeE7zBtrSrLG8iOKtyl4tPtSNV/V5Wu6dkaqAOjLDvGDcdQgpyIDaJwNWl93WGmf1n2/rSfdMHQlbWDQLu6vjLw7UJbvYeoTtX7tyVVe/Qwb8biRpvd1xlAcZT301gi+oEUGaXhPGzsI8VRgch4mz+D+5bgfPudHlZfdGHbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171633; c=relaxed/simple;
	bh=xUlVvlA3J6T3XUmGP6wOK0M7qflsdynl7PV3ve4Xp2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4Wy82pTPMrbwTeJthyFIlaMbwbXe9h/qeB2K2uVeWekMqcpCGHTmv+D+A+kNu4/t5e+iyxjxRDr7LLTDc4FrqlindcVSyrMBzt1IDW4lA04Irlq11raaUtcMuB4J11IuUYsZoV/lIPh2Vpcdo0KXjFq9AgCKwgZszily+q0CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPrfZvUN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727171631; x=1758707631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xUlVvlA3J6T3XUmGP6wOK0M7qflsdynl7PV3ve4Xp2w=;
  b=TPrfZvUN1jhKJEJE7+2V9m2pZE9UDgY79q5s9/lH080Tdjo1sIOpaL7M
   CHmECT6FudmhKZ8GvUs7S8YckUOmoa7X6CHPbHDuu0tSdO+UM12UAzsN+
   6fJLhO50xD5be+w5wdNCzx3EkC4wjHor6PcIMIx0KKk+U8PethrRNMj3l
   N/75EeSDJZmZoFYMvIakR92uc/QKPr/lgsJfmYIfVkM4YuYP1+4pse2yR
   hLSvXOMm9IdUFPq1aKQzW6cObVt70myBjAsWBYMpE7Dy/W7Hiv5LEhNsR
   g9ywFBlEADQKs8UDEdQ7Kgb0eKiWDJ8/UAi65yf8e55pptWj2Je8/vZ1y
   w==;
X-CSE-ConnectionGUID: 7JGPpGxUT2aVFawCh/V9Dg==
X-CSE-MsgGUID: TD5iBphAQcm6GlxzmWLQ8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43674225"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="43674225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 02:53:50 -0700
X-CSE-ConnectionGUID: KwYZeJ4GQDSYfjYoREQzeg==
X-CSE-MsgGUID: htUOPwTXTRywBsMSNeygMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="108819373"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 02:53:48 -0700
Date: Tue, 24 Sep 2024 17:52:41 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Peter-Jan Gootzen <pgootzen@nvidia.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>,
	virtualization@lists.linux.dev, yi1.lai@intel.com
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
Message-ID: <ZvKL6aTxu5rrcXLN@ly-workstation>
References: <20240529155210.2543295-1-mszeredi@redhat.com>
 <ZvFEAM6JfrBKsOU0@ly-workstation>
 <CAJnrk1YW10Ex3pxNR1Ew=pm+e1f83qbU4mCAL_TLW-CaEXutZw@mail.gmail.com>
 <CAJnrk1YA71v6zTE6iNk297VFK6PVP26SUX+zbb29yF+LG4JM7w@mail.gmail.com>
 <CAJfpegtfFtnTrjeuajay4+U+ob4RMgzeygwhXLeYiKqFsHczcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtfFtnTrjeuajay4+U+ob4RMgzeygwhXLeYiKqFsHczcw@mail.gmail.com>

Hi Miklos,

After applying your attached patch on top of linux-next next-20240924
tag, issue cannot be reproduced running the same repro binary.

Regards,
Yi Lai

On Tue, Sep 24, 2024 at 10:58:31AM +0200, Miklos Szeredi wrote:
> On Tue, 24 Sept 2024 at 01:48, Joanne Koong <joannelkoong@gmail.com> wrote:
> > So maybe just clear_bit(FR_PENDING, &req->flags) before we call
> > fuse_request_end() is the best.
> 
> Agreed.   Attached patch should fix it.
> 
> Yi, can you please verify?
> 
> Thanks,
> Miklos

> From fcd2d9e1fdcd7cada612f2e8737fb13a2bce7d0e Mon Sep 17 00:00:00 2001
> From: Miklos Szeredi <mszeredi@redhat.com>
> Date: Tue, 24 Sep 2024 10:47:23 +0200
> Subject: fuse: clear FR_PENDING if abort is detected when sending request
> 
> The (!fiq->connected) check was moved into the queuing method resulting in
> the following:
> 
> Fixes: 5de8acb41c86 ("fuse: cleanup request queuing towards virtiofs")
> Reported-by: Lai, Yi <yi1.lai@linux.intel.com>
> Closes: https://lore.kernel.org/all/ZvFEAM6JfrBKsOU0@ly-workstation/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index cdf925e0b317..53c4569d85a4 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -295,6 +295,7 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>  	} else {
>  		spin_unlock(&fiq->lock);
>  		req->out.h.error = -ENOTCONN;
> +		clear_bit(FR_PENDING, &req->flags);
>  		fuse_request_end(req);
>  	}
>  }
> -- 
> 2.46.0
> 


