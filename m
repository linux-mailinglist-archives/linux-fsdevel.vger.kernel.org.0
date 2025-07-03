Return-Path: <linux-fsdevel+bounces-53790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FDFAF72FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681C83BCE04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E63D2E3382;
	Thu,  3 Jul 2025 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SqV3PAE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF724DD07
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543522; cv=none; b=SRU0NkhLRYsUh+cwHBdkj18XS3CgFS2EQmCWPBRW6FwmU+IyF7Y0r2paYJ3CWDuynXn+zbbr95EkVyq40kJHLRM32pK5+Roel/UsMil3uZ1hZzaWZAZoSxRs+i0M1ZKgj/yzs9jprFQqOvbpIBYvaafzUlqqkbCucqPEBPokzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543522; c=relaxed/simple;
	bh=7Gxnx94aHcSczf85EKGqQzPeEpTVF1yVTvLY6uxD7Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pozZwHKSDG6cpWA87EychWu7h8QJMxlFDIqmk2nFLll0Agwl3Ky6AY6AcdFeLB1ew0Ig5CkQXw6kSI5YrvaIdEXydl8IA2cece2RMq4WFYDv4V2Qy9ToRaCD4EzSJ3V2GpMTrLNnTnnJ8oRPBpHoK2nBNGHNzJYHbS3AwIiiAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SqV3PAE8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8gqGNwk/aw7AQQO1FQ5aal4TZwL9ZOxfu4GeW6fMYeI=; b=SqV3PAE8kH+D1aRh0FKA6O+5jX
	aWz1ZZWlgIDG6TDmz8X5GWUOP1BF07togfdxtC2GX2hZsEV4l4+F4ldTs7qd3kM2dm9vsSO4JpuZg
	OBmdQ2BH6Z8+6u0qk8SaegJKcZlQXTVh2m0ietCdhI2iWFV1T7ZSVDe+jNfCgsFgmBdfGAf+QlXUX
	FwyW3WhCd9Z9uO2VRBF7yQx9TRiFkTKVjWRxmwXedfN6agug2TUVP+JaCNyBUqiyPdHyhZaLRbpyw
	O1GR0HzB+XLuop2WshkGAV2yPh7W99E2i4/f2bxkRxAn4eQiQJ5TrJTfSrkmHpMN3o6NZtTjaYtb6
	fYe5r84g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXITt-0000000CxVg-1zcj;
	Thu, 03 Jul 2025 11:51:57 +0000
Date: Thu, 3 Jul 2025 12:51:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/11] vmscan: don't bother with debugfs_real_fops()
Message-ID: <aGZu3Z730FQtqxsE@casper.infradead.org>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <20250702211739.GE3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211739.GE3406663@ZenIV>

On Wed, Jul 02, 2025 at 10:17:39PM +0100, Al Viro wrote:
> -	bool full = !debugfs_real_fops(m->file)->write;
> +	bool full = debugfs_get_aux_num(m->file);

> +	debugfs_create_file_aux_num("lru_gen", 0644, NULL, NULL, 1,
> +				    &lru_gen_rw_fops);
> +	debugfs_create_file_aux_num("lru_gen_full", 0444, NULL, NULL, 0,
> +				    &lru_gen_ro_fops);

Looks like you have the polarity inverted there?

