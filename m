Return-Path: <linux-fsdevel+bounces-59931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD8B3F4A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 07:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FA1A84E6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DF2E1C7A;
	Tue,  2 Sep 2025 05:41:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F71E5B71;
	Tue,  2 Sep 2025 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791675; cv=none; b=kvNhLEzTAGbDE+Xsqr6ZoUQoDeuICC86ng69aLryEN85SWecUsIJqfy8CwJia4u6Bt+UAkaHModTSVEX8RjGxoSsO7zzTTXXoEI1jlfryMq5LRAM9ZSYo8CdzyamVEEunoD9lWIQg1IHEAqsoNWl419EnYrmpVIvkT5ReCXTYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791675; c=relaxed/simple;
	bh=wH2ymnAXFuW40ZLt9OwafaDmlYRW/cRWqDPmB8j1+d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFJQmbqebkLwWUFZd4XSU8+sklgwF7c1MKfQzQaI81OqbJ0osmMfQf0fEslhSpcji1Ry5dEEaT7154r0ClzYcOHeqOZ3uNoHLxY/2dRmRPdEyNujInTZ1d3OysRAMlI58ZSR9ZFKYAdxFseT0xnIkTsb/vNCI8eMdcmhtNlOViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5FDDC68AA6; Tue,  2 Sep 2025 07:41:09 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:41:09 +0200
From: hch <hch@lst.de>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk
Subject: Re: [PATCH 1/3] fs: add an enum for number of life time hints
Message-ID: <20250902054108.GA11431@lst.de>
References: <20250901105128.14987-1-hans.holmberg@wdc.com> <20250901105128.14987-2-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901105128.14987-2-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good, but you probably want to add a few more folks that
created this constant and the header to the Cc list.

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Mon, Sep 01, 2025 at 10:52:04AM +0000, Hans Holmberg wrote:
> Add WRITE_LIFE_HINT_NR into the rw_hint enum to define the number of
> values write life time hints can be set to. This is useful for e.g.
> file systems which may want to map these values to allocation groups.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
>  include/linux/rw_hint.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
> index 309ca72f2dfb..adcc43042c90 100644
> --- a/include/linux/rw_hint.h
> +++ b/include/linux/rw_hint.h
> @@ -14,6 +14,7 @@ enum rw_hint {
>  	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
>  	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
>  	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
> +	WRITE_LIFE_HINT_NR,
>  } __packed;
>  
>  /* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
> -- 
> 2.34.1
---end quoted text---

