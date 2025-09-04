Return-Path: <linux-fsdevel+bounces-60249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDFB43223
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D738416DD9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292C25A343;
	Thu,  4 Sep 2025 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rcgi4xjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509E25A2BB;
	Thu,  4 Sep 2025 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966542; cv=none; b=VFYbapLsUCg3PkAkFSFfXbKgQ3r7hooI4NJqEZXWJXo/ADUQQjSXSTfGTnn0TFtnPj12aHeBGqv7TGkRzjHjlovjeC6LS0h1LXrxCEh8LZHQlnQfU0DmCDrezTROCH/ecMktwbQZ8U/1dVwyUhdl6heHYKIFhUzi+iqQsIsBqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966542; c=relaxed/simple;
	bh=RLT5pyGzJlDmXpappCVovTcOzHJTaVBRzfTSarecuxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTnpg/cB9rjCkLJPu/pth3k6ocT8NC4lUrv3/jIx29jZzb53QRsctmaTgi3XuwzbtUI+mo8Q5PRdkbqY66clZRnUZT603Q1PGn2V+wmfneOhHCp47B+qzTwSY1FroHI9U7u/C3VYHTYYlRevaYzbFxa3MCJQ1gmoFvM2bxp3QfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rcgi4xjK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RLT5pyGzJlDmXpappCVovTcOzHJTaVBRzfTSarecuxs=; b=Rcgi4xjKLy0A3h+md3uotW5tPb
	tAvsX1VciIb9UUccH8n9QQAvxkvYEYMCjM76+Npw5j2s5fkbX8LmHhX+f5a5LYuaQgeaxVHTt9iNI
	orOi8mOzwUAymVZw9L2MlIyrVFp23u/GP1ZKMtt32+zaZhUkzyLHLnh1emSC2iyq3NgM17sd4ioGp
	1CrOOItzVP2+9lyPLkKkoteCxmTTDMJvz5mY/TpoMXxXXtooIQBIMPriL7Gcy81lWo7PJpeDxD9mL
	S0vyDsI+v3ln7io7Geb9YLl90dn/W6u9v7Fi05fYxe6FZX8xrMxjEHgkJk9eINTN92SsBqqz41mMT
	TRcaP9+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3G0-00000009Sk7-3ulT;
	Thu, 04 Sep 2025 06:15:40 +0000
Date: Wed, 3 Sep 2025 23:15:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 11/16] iomap: make start folio read and finish folio
 read public APIs
Message-ID: <aLkujN3U6e5l6clS@infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-12-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 29, 2025 at 04:56:22PM -0700, Joanne Koong wrote:
> Make iomap_start_folio_read() and iomap_finish_folio_read() publicly
> accessible. These need to be accessible in order to support
> user-provided read folio callbacks for read/readahead.

Probably easier to follow if you merge this into the previous patch.


