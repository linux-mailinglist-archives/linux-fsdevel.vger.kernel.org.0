Return-Path: <linux-fsdevel+bounces-20702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6278D6EB5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 09:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A1BB241DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82018C36;
	Sat,  1 Jun 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tAVDAFwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A199D304;
	Sat,  1 Jun 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717227632; cv=none; b=jNvoxphTCwtA5WPs8z8gIVO+QS3GV/joEai3fpqZZzCKP6NT+kLv4w0omReLJHoFw3+XtKcV+xVVtRckFhNX28Df4vMeUcyD1MmUSMGCnsGyfevtVBTMSxcsrsyVggCtgekTOQjSpaRLEh+EcJa4uXTlB5/QXcutl2UnGUdYaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717227632; c=relaxed/simple;
	bh=UeEUzuD8XTeRRnI546NIegEy9aLDPGAKPdT0NemTr5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkkIExN+UwhWq04H8uoVQAdSdxHdRhWGGR/cMF6Y/x2KnVZ3tiGjdoeDth952JYtm538L3n2u0nJPmtzJefXQrdE3DAZH+fH8WbDnt6UayEVj6LnuAehJwEVYlVSWANn+D4Fk06hTBqnkHrXmlRSITPN9KNWroGBdDVTXcHi2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tAVDAFwR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8V+VFFJ0IYMes6ziaSVrkRVG1tqciBV+DDkla1HEeVQ=; b=tAVDAFwRmhisqoam3U+Y61yQCb
	YhaV8JYIH06FQz4ImTGnyp6ae83RnZgax0CEhIlIb2FLurIZLjH43vEMGXqxG5MfxXwZ1sNvI09Ij
	NFfAYbne6KcAuGdfIp8/q5NJIFRMQ7RERJxg729E8OhYh/hFTUeDMR2nbSNoWpIPYJP9LtKN0cay2
	MVzfwPZr4yWtM0WlCBedZEcRHuUtJHjWP3wu4SQLhUy9pWLC7rYor40YxByV57F9QbEAxnOJKUr2H
	z+SBH38nLwESbJxsDO0PKETweGZFLlV0KRJxwsPdCoZ8lyfaVrbpmhPBuFFsMeS9/6+tb9u9qD6Da
	nKst9ABA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDJLp-0000000CArU-04Bu;
	Sat, 01 Jun 2024 07:40:29 +0000
Date: Sat, 1 Jun 2024 00:40:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandanbabu@kernel.org, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 0/8] iomap/xfs: fix stale data exposure when
 truncating realtime inodes
Message-ID: <ZlrQbAksIDoQ_IuE@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <ZlnCAo0aM8tP__hc@infradead.org>
 <eb8872e2-4651-5158-cd7c-33ef8cf3cd03@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8872e2-4651-5158-cd7c-33ef8cf3cd03@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 01, 2024 at 03:38:37PM +0800, Zhang Yi wrote:
> will send out a patch to revert the commit '943bc0882ceb ("iomap:
> don't increase i_size if it's not a write operation")' soon, other
> commits in my previous series looks harmless, so I think we can
> keep them.

Agreed and thanks!  For 6.11 we'll also need to figure out how to
keep the related changes together.  I suspect we should just re-merge
that iomap change through the XFS tree, but we can talk about that
later.


