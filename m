Return-Path: <linux-fsdevel+bounces-25878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7939513ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661EDB22B06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBEE5FBBA;
	Wed, 14 Aug 2024 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3EKiqd3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA941A80;
	Wed, 14 Aug 2024 05:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613566; cv=none; b=QxdJ7qD143i23cY+d2NTxwD4P+Xu9QqKIAX9yMwsU4Ebhp9Tm1hFEkFF+hK5VbU7R6XcSCjXQPSYHHewXXbk67bgZBIApvPWyPZyZnWTrpO8oNWwQelPN/2yAhJNovFmJyX7OMv/annSFnqGgqU7nc1tmiRE8FfmSC4IvvCEg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613566; c=relaxed/simple;
	bh=1SraA/eAFP9lFYWgtA2oWrXzPNSDOFARgqj668r8GLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsi9nkg+8SjIscqVaYi+0o/uIS+Nr9cAIsB40Uui2EPkoogGttuM9R7P50zlMcvNDWneZ5CgP9NRJDygNgco1aaHsSa3XwXd2iB5FfbC4W2fysM4cehb0dqjhv7CDijs3WQQvGrJZ42iFQ7QnGn6Sat7gHAb70coAhC/d2GyYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3EKiqd3A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bFdNPcly9q002YCik5SIuwJxh7NBwj43r8V17plHTYw=; b=3EKiqd3A39sOOtYWMV9ub9ZV4A
	xsDGmn/zFTw5BJ4pUa6FT8agpRc7fjIy7lGQM6OXFwCa0TGZ7AE4YWsjUp7USqe0dJI2/g03A3z9Q
	l2GVY7+r8HlQFjrUOLT3ErHePSG9c6QCyEq4GBxb0N/zWUzQVcxwuUvk9wU2dgKhaNh12lauNyv8P
	AnavGNnD+LdX6x+nuFy6o9AxoeGAe70FHfhrs5XUnEYH75d6M5ZHgPvJ0znv8B5epgbO8r1Hwh0uj
	5WshEjQGSwg/ibx8xSpod4RYVyTiUaY9EfAOJO3YLvMFHfVTqGwPP4qEMi4du0QOOamB3FYSrG0mT
	tDiocyxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6cm-00000005ofY-3b96;
	Wed, 14 Aug 2024 05:32:44 +0000
Date: Tue, 13 Aug 2024 22:32:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more
 than one blocks per folio
Message-ID: <ZrxBfKi_DpThYo94@infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 08:11:56PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now we allocate ifs if i_blocks_per_folio is larger than one when
> writing back dirty folios in iomap_writepage_map(), so we don't attach
> an ifs after buffer write to an entire folio until it starts writing
> back, if we partial truncate that folio, iomap_invalidate_folio() can't
> clear counterpart block's dirty bit as expected. Fix this by advance the
> ifs allocation to __iomap_write_begin().

Wouldn't it make more sense to only allocate the ifѕ in
iomap_invalidate_folio when it actually is needed?

Also do you have a reproducer for this?


