Return-Path: <linux-fsdevel+bounces-20630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA338D6401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075C11F26878
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5615B975;
	Fri, 31 May 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TpMr8I+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5B155C8E;
	Fri, 31 May 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164341; cv=none; b=bFpCqp+wgiKcdyDtW9u6Ouo48B0xO0bq0dZAYc9SEqA6O1lKFiaWQjaJkLpMn6hZw5x2V9l8Qg2VQn1up7BV7p18d8kJEq0QIoBgLYz8280eqUlnyFNi+bT65bfjZj6vJgByA7nb6crWDNW+m+6sr3KfQLHkLAbj70Bl5a1eH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164341; c=relaxed/simple;
	bh=8vBlPwHaxEwRcsYd9GsTqJI41u/YSqgeRaG06NEqjYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgEqp7rYtdD2lv3w8ZK6Tqy8l7z+2fKg2a5YoPNLoqFKWo/ZL3N6xj0xqSs+fvDWEmtv5mZYFOv/h950PlKw2SxCY7EapUg2hmmwGJPvZsPtrzX/ZIggsmh2ZkonmOoJZCzg9RiZEC1yNLpIgQqzr6e17B6scjmqYkLg4ePNIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TpMr8I+B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mc4Z71sdMwN4heTeb/sLKN+8AiLMl/vGU3VtZcBbWrU=; b=TpMr8I+BqMuG9Q7OUZAv02fo2f
	RCBb9rRru+WRce4a9hKsgSCduC1wr5nOGCZFRw+ch8Jx1vk1aiJp/t+6a240b0osLAoxW0ggqhjfg
	KBhmm2uL+iVI+piRMvuQOkqFVZp5kdDcLcBonf5oBFw9CICp6v2wLQl5f2IOQO4b7gqyUVmPCG52q
	Di4EdawpL0Z+UI14ye0IfS/9cwhr+SvSiaTtXOjTavDIfqBoDQWWJRJ4Hq9POC6gB4vuMXYMGnliK
	1HwZ+xB1g1OFMTAkUpWtUVM6XentAfqu1Qg8c2n4vETqysQi1s2gdfUyUZzfYb2CHvKzLeIZTaxKJ
	8YlViJgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2t0-0000000ARo2-3cxa;
	Fri, 31 May 2024 14:05:38 +0000
Date: Fri, 31 May 2024 07:05:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 1/8] iomap: zeroing needs to be pagecache aware
Message-ID: <ZlnZMiBJ6Fapor5G@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
 <ZlnMfSJcm5k6Dg_e@infradead.org>
 <20240531140358.GF52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531140358.GF52987@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 31, 2024 at 07:03:58AM -0700, Darrick J. Wong wrote:
> > +			/*
> > +			 * XXX: It would be nice if we could get the offset of
> > +			 * the next entry in the pagecache so that we don't have
> > +			 * to iterate one page at a time here.
> > +			 */
> > +			offset = offset_in_page(pos);
> > +			if (bytes > PAGE_SIZE - offset)
> > +				bytes = PAGE_SIZE - offset;
> 
> Why is it PAGE_SIZE here and not folio_size() like below?
> 
> (I know you're just copying the existing code; I'm merely wondering if
> this is some minor bug.)

See the comment just above :)


