Return-Path: <linux-fsdevel+bounces-10823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493384E8E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323FC289DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18C376F2;
	Thu,  8 Feb 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3Pgy5m/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313636114;
	Thu,  8 Feb 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420373; cv=none; b=DYIsIUHpVnefnhLBidXhcbgn91X7aZhK2+RUB/re34Bu/vKjz3ZXyzxuu1EvmsexwffFgP65IX3Bl7OwjqkDTRpLhDHGue9yUqWTwPUR/5Q0/WTUhQjqJIFe56tAwxRxNI0tr9sEQt9UgBINdQu7JeU1up/uC0lzO36yiLJ99aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420373; c=relaxed/simple;
	bh=fB7uOyMAsWVEuwqynjdh1cVw3jz/F6DAt3Qm5z1G9HQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PE2PTWRekOp0TRl+Jm0cYH+G6qFOZXxp7vReDf6K//Xl/Jqu9vXzBmken6CnS/dvZzKPq6VR/uOSIV215QI/GR2WMeSEzDPINJvJ/Rgz6Y28iDTJ/z/dhrtGD/nGKKlf2qXyEDOTpHCY2APObw0Hm3n0LG7ezhTs8vjHWdnJmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3Pgy5m/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707420372; x=1738956372;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fB7uOyMAsWVEuwqynjdh1cVw3jz/F6DAt3Qm5z1G9HQ=;
  b=Q3Pgy5m/og+PeCbS5NV/1SFZJ0aDOrt4O4+IOWdTT8YztsBGQfyGrbPN
   3nxg2wAmfM6jBb7SP8eBVC8iq8R9t4gfZJIUSLSNkTFbCbQxh9X6ajygo
   3BQSQ8jw/8y+ZyaT6+1iQzIdor8lTKU+DyhSkzdcSNfjnmk+/rtImW2Ih
   fTOmS+v0cAvmrVkY2WlyCku+hDKbg+yl+ywRRjd1U2OIvc+mfFdkknu43
   +FJfMp8ekiUgnDz7guOooML8f8Ig3ZJblr0flFtrUFBfUA8h03k3roboN
   3JMq2EAWRk7alPeFkynjlc8YBlgchbBlrdhRo0m0fLYvvKCe9CxAtaiT4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1156770"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1156770"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:26:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6375977"
Received: from ercutler-mobl.amr.corp.intel.com (HELO [10.209.94.1]) ([10.209.94.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:26:10 -0800
Message-ID: <8e9bf21039eb3ea9ee72c93cadc33f18e849933f.camel@linux.intel.com>
Subject: Re: [PATCH 3/7] fs/writeback: remove unused parameter wb of
 finish_writeback_work
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 11:26:10 -0800
In-Reply-To: <20240208172024.23625-4-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
	 <20240208172024.23625-4-shikemeng@huaweicloud.com>
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
> Remove unused parameter wb of finish_writeback_work.
>=20
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
>  fs/fs-writeback.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index edb0cff51673..2619f74ced70 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -166,8 +166,7 @@ static void wb_wakeup_delayed(struct bdi_writeback *w=
b)
>  	spin_unlock_irq(&wb->work_lock);
>  }
> =20
> -static void finish_writeback_work(struct bdi_writeback *wb,
> -				  struct wb_writeback_work *work)
> +static void finish_writeback_work(struct wb_writeback_work *work)
>  {
>  	struct wb_completion *done =3D work->done;
> =20
> @@ -196,7 +195,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  		list_add_tail(&work->list, &wb->work_list);
>  		mod_delayed_work(bdi_wq, &wb->dwork, 0);
>  	} else
> -		finish_writeback_work(wb, work);
> +		finish_writeback_work(work);
> =20
>  	spin_unlock_irq(&wb->work_lock);
>  }
> @@ -2285,7 +2284,7 @@ static long wb_do_writeback(struct bdi_writeback *w=
b)
>  	while ((work =3D get_next_work_item(wb)) !=3D NULL) {
>  		trace_writeback_exec(wb, work);
>  		wrote +=3D wb_writeback(wb, work);
> -		finish_writeback_work(wb, work);
> +		finish_writeback_work(work);
>  	}
> =20
>  	/*


