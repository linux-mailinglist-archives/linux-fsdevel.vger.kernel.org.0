Return-Path: <linux-fsdevel+bounces-10821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDFC84E8DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A13E2877EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABE36B0E;
	Thu,  8 Feb 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsd8AOU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD1374C2;
	Thu,  8 Feb 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420072; cv=none; b=K13W5ZGTMhyd8vlzFmHEnp70rRWrEwCK5afC3AvCWbVZthpNkYw00L958hAeZKb65tuskwtbPLFFnR4JzCRZi5odTLI05SCrGCqXNU63AgNrqfQ5f/Cag0hJdCGULRE6p3MmedhuBQ1idB6KgmjnM6L5YA6ITPBqiY0GH9g4m3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420072; c=relaxed/simple;
	bh=JGQ5tKd6XAom6G1Poi75ROmPl44YcOrUZ1JCKoTGF5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Da1dzddmsTxitS4XoTp6fd09ueZtNDkTfAgNiiID1p6UZJCUem3HJHMVy8urStNHAb6qtiaXxGKrIkuIQ7AjVNtWM2O42N6yce+SqMNa8bLojYJuIl1jC7HyZIi3nIutmpa6bH7HaNK7YFZ1wONdSMtOHFUcWRdx/G+eg8vHOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsd8AOU8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707420070; x=1738956070;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JGQ5tKd6XAom6G1Poi75ROmPl44YcOrUZ1JCKoTGF5w=;
  b=lsd8AOU8XlX9B2gjre5EF/qbCBjPkeTYiOsP39KD3GywBcJhY9+cAwRC
   66b4tDh3I7DeAVo+4WRrV55sGyh1K+9u3DlwkwK9Jdy1eXzutCSzXt9d0
   VOmxz1hoI5tOG4JaT7TYLeR5iErvk8IxdBaHg4ijElp9bLqslP7WuV8BS
   dVDefVIYIcVO5tv2ubbrMhI3cx2a9eLj4Sg1bA1vveEG3CGkRY7wWfxqj
   MeNOxKfNrIopCTgDm+i1VDnGeF7vKGaerqWG+uJUgHwEQXruiUj5WpOFg
   /QWONOhesrro9MfzRrpXHqAd5L3w55a+7XwNYNC/T/ffW1UWoBFbkY4C4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1201891"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1201891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="824926374"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="824926374"
Received: from ercutler-mobl.amr.corp.intel.com (HELO [10.209.94.1]) ([10.209.94.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:21:00 -0800
Message-ID: <acc5ebbcd6a378b090d7ce56c47ed66fd1e0ccdc.camel@linux.intel.com>
Subject: Re: [PATCH 2/7] fs/writeback: bail out if there is no more inodes
 for IO and queued once
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 11:21:00 -0800
In-Reply-To: <20240208172024.23625-3-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
	 <20240208172024.23625-3-shikemeng@huaweicloud.com>
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
> For case there is no more inodes for IO in io list from last wb_writeback=
,
> We may bail out early even there is inode in dirty list should be written
> back. Only bail out when we queued once to avoid missing dirtied inode.
>=20
> This is from code reading...
>=20
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/fs-writeback.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a9a918972719..edb0cff51673 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2086,6 +2086,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>  	struct inode *inode;
>  	long progress;
>  	struct blk_plug plug;
> +	bool queued =3D false;
> =20
>  	if (work->for_kupdate)
>  		filter_expired_io(wb);
> @@ -2131,8 +2132,10 @@ static long wb_writeback(struct bdi_writeback *wb,
>  			dirtied_before =3D jiffies;
> =20
>  		trace_writeback_start(wb, work);
> -		if (list_empty(&wb->b_io))
> +		if (list_empty(&wb->b_io)) {
>  			queue_io(wb, work, dirtied_before);
> +			queued =3D true;
> +		}
>  		if (work->sb)
>  			progress =3D writeback_sb_inodes(work->sb, wb, work);
>  		else
> @@ -2155,7 +2158,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		/*
>  		 * No more inodes for IO, bail
>  		 */
> -		if (list_empty(&wb->b_more_io)) {
> +		if (list_empty(&wb->b_more_io) && queued) {

Wonder if we can simply do
		if (list_empty(&wb->b_more_io) && list_empty(&wb->b_io)) {

if the intention is to not bail if there are still inodes to be be flushed.

Tim

>  			spin_unlock(&wb->list_lock);
>  			break;
>  		}


