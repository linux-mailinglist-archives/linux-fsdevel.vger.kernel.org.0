Return-Path: <linux-fsdevel+bounces-25704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AFF94F583
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CAF2854B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0353A18784F;
	Mon, 12 Aug 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YxNJEnqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415013AA47;
	Mon, 12 Aug 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482064; cv=none; b=TGatDm6aQG2WxNSgSmjhIMAqbMPAZlSxSM1JEWFsYtjhfo5ETRfE4KkZN/++cIIBt0mG0AdMdjbjgxHgEtRuAufbt74HzAWjzj8Ju6KCtj/w9SrW7sGYOOc9NSVIVR9ZGv8s1WsEHiufKQrWU5yRCu0qJgeXfJcaJGwtKz5OJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482064; c=relaxed/simple;
	bh=8b5pr16seuZpo9saeW2XCuySEgaFGIzdr02fA2Ln/d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITHvqIFfcJUrJ4c453E7ywSgn+4reVLmIZnIS9nYoBM/LUxUFOfKppwWQhmWxczOFt5tksQxTOzQMshDCcSNCoI7/RI8CjhCKnMssRqrhwn9OmN49JxqCybUz0o0JbHwFTD+YQetBp56vWqHqg/6tZytcNdTcRxlnBMqUE1/siQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YxNJEnqc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2UYFiu6HqmmpfFendkGxflUA9GYeKhm9rf3y5gZQMVg=; b=YxNJEnqcK6vjycw/IA5UbUiaGc
	TI1YjlzgLbKr84DRcTr+osV8NOs0PhUU+9eZgxB+L5sGrnJswrxcnbctAUfy3qt75SINVpgloY5jC
	Kz1C/r+C8gztqx6Nita+R7wyON/44PDhb76j2OuPjvlke5s9LF7xGdHBLGY0b/iMgMyzyOWIAjcus
	mqUzqxgkZe6k5iyPvq5jNFAnso6eweuenj0ZY+yTzOyfpvzOZutVrh1X3v2YsUlGm1on6BKYPw/HW
	6EeqmG1rZ51gDYtdo3RyZ7rCezDk6FLOC6yC8igUuQXdPM9ga9btwDHG709cbha19WO6CCdl9Zhib
	VAsSWkTw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdYPi-0000000FHcI-2r8I;
	Mon, 12 Aug 2024 17:00:58 +0000
Date: Mon, 12 Aug 2024 18:00:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 6/6] iomap: reduce unnecessary state_lock when setting
 ifs uptodate and dirty bits
Message-ID: <Zro_yj3agfdhM16Q@casper.infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-7-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:59PM +0800, Zhang Yi wrote:
> @@ -866,9 +899,8 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 */
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return false;
> -	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
> -	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
> -	filemap_dirty_folio(inode->i_mapping, folio);
> +
> +	iomap_set_range_dirty_uptodate(folio, from, copied);
>  	return true;

I wonder how often we overwrite a completely uptodate folio rather than
writing new data to a fresh folio?  iow, would this be a measurable
optimisation?

	if (folio_test_uptodate(folio))
		iomap_set_range_dirty(folio, from, copied);
	else
		iomap_set_range_dirty_uptodate(folio, from, copied);

