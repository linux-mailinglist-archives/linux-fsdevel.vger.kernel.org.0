Return-Path: <linux-fsdevel+bounces-51225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0535AD49E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BF73A1B7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 04:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE20E20766C;
	Wed, 11 Jun 2025 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fjghksHt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F3801;
	Wed, 11 Jun 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614498; cv=none; b=U4xKWwGnBpfU9G47WMq1Owc3WJ4jHGgmONZUUE/WivKRcV4pNkyZjfDzAy7aEeHrwyaxfknJIq/SZN5R6esp3hdM4s65MJkRvV8WaxfveeOEYjrCNH57ibLvHzugvQvXhvr9BIGDdwjc5D3ELqhdg0GsG7wckHmlBuKMszjKy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614498; c=relaxed/simple;
	bh=JA4BxlVGG8rwZwyApEyol0jFN0CNle/CCa9XNFaW1PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HogDwItkb062Ci1QKuT7JsbQ+D0EbaRZ8bZPaSyyJpnNxMS5xyAnAw+JAwlcV8DpTk4GueAHgmWWJSf+IMOHQQ4vKrxRVAFBdK7ET6Oux2HBLQRqX40RUtkikz266qh+oZ4dtLx1ouYhJthbf8ojwwcp1LIbE2MYy09zzmleusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fjghksHt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tfKoKJ8aBiZNpN5nDk7FqFG96znr7L6T8d7MfAp4cgY=; b=fjghksHtohG2U35DQoS2M81HN9
	NwunsyBEZGFBbC8ZKivRT5eiRM5QchXonwb2XJXNrjJssLTJelKvhvHf9l2TwAlDgPo0C+lhwif5l
	ccQPlFD2iGdHopP+kC0E2t9RuijvENnnWe1pAJ+X8DzGpN/mRTMwvBJaPrpLsNs7KNzt0izagKZlX
	MC6EyJC+zkHECafCJW6JpyBF65umnbkndJK9CZTkNeTNSmJm5kUCxkVFpnIlnOX2fYaaSX7tLajpD
	CfhKtzeyQwvWaq+DeRscMVswI7xI/arkPJKFy3N0ZaKLQa9MJTAeRPbLT4N2GX/+CrXXv/bhA2IOB
	96dbZeBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCee-00000008nmW-1SE4;
	Wed, 11 Jun 2025 04:01:36 +0000
Date: Tue, 10 Jun 2025 21:01:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM
 iomaps
Message-ID: <aEj_oKty0z2945P_@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com>
 <aEZx5FKK13v36wRv@infradead.org>
 <CAJnrk1ZuuE9HKa0OWRjrt6qaPvP5R4DTPBA90PV8M3ke+zqNnw@mail.gmail.com>
 <aEetTojb-DbXpllw@infradead.org>
 <CAJnrk1YNM5fotdoRmmHi3ZTig_3GDb-kcSce9haZDxG97insKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YNM5fotdoRmmHi3ZTig_3GDb-kcSce9haZDxG97insKw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 11:23:27AM -0700, Joanne Koong wrote:
> count is unused by ->writeback_folio(), so it's always just zero. But
> I see what you're saying now. I should just increment count after
> doing the ->writeback_folio() call and then we could just leave the
> "if (!count)" check untouched. I like this suggestion a lot, i'll make
> this change in v2.

I think you'll need to add count.  Not only to support the block
mappings through the common interface, but also to deal with the
case where due to races with e.g. truncate we end up not kicking
off any writeback at all.  In that case the folio_end_writeback
here needs to happen.

