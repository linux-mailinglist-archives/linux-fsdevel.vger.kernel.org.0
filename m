Return-Path: <linux-fsdevel+bounces-27525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD4A961E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54016285592
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19E1514EE;
	Wed, 28 Aug 2024 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mG8H0gyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EE14E2ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822200; cv=none; b=D+VzliaXUe5qh8wiN5xnVWxYenZFgrconL0vi/hj8ThVmUyuk7gLGnqJ31vKsHqYsqc0cIndRyQGGPKoaXAmYSX+g9MEqKUkWxacGXhqFMn2Rp5EGW1Utx/yqBSgTOfXtO7yMhXhCllOvckf4ilq6enRByLZaJ2ENsoKd76M3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822200; c=relaxed/simple;
	bh=zHvLvnZm0lxc8Q+X59ZnO8E3VsK4asCe4mNuoQrnJLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcaUy1oau6n4UwmUvYr7GUn9vfBjADN9/vk+2Bxaywb9uQiyhHyMYhQGDBqS6AmyEsTO5CoAVBate9n8LHB/3Yp0jQYh2tfqqGbeiICnt0JioTqzc1SSDOzRhn66qoKXB0yATRICqO1TrtceDVQ4k369FYTnPLXMLoKxQuls29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mG8H0gyA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UnAlQz87wd7AuJvwT6UObbMcgfmPrpnRMxTmX4U8Ve4=; b=mG8H0gyAnxVZ0awFwN6TEqBpvk
	B1KpiRiUElA/gKDv5n3n5RfnGxgqqWBsBTEF4wGdA66i04W0pUNTv3ck6uCZA2N4MKtThMwthnJ/L
	upiLTjinHsmyx4NOdK5Wa+obrgNlVXFL4Dr6tAWM8CL+L4MYfRKwA3SUJlKOVHCWoxTCc0dwkCGmw
	RJGaY9rD83Y/56FTSKUtpe0f8vir+JtOF9PMMFCTppFSbHK9vHCgzW9UoNVAbg4OcyPz59ML1HaeK
	4C9/iEE2dFRCKMgJPFg7l2XiUxxydB52TeD4h9bfKJ8ZVf8tBfvDscEl9692sQ3vZFm4rFbdPSHOn
	/6rUvwgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjB2s-0000000DtFz-0Edz;
	Wed, 28 Aug 2024 05:16:38 +0000
Date: Tue, 27 Aug 2024 22:16:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, bschubert@ddn.com
Subject: Re: [PATCH 06/11] fuse: use iomap for writeback cache buffered writes
Message-ID: <Zs6ytd-L9u6D45PI@infradead.org>
References: <cover.1724791233.git.josef@toxicpanda.com>
 <11b0ac855816688f6ae9a6653ddb0b814a62c3bc.1724791233.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b0ac855816688f6ae9a6653ddb0b814a62c3bc.1724791233.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 27, 2024 at 04:45:19PM -0400, Josef Bacik wrote:
> We're currently using the old ->write_begin()/->write_end() method of
> doing buffered writes.  This isn't a huge deal for fuse since we
> basically just want to copy the pages and move on, but the iomap
> infrastructure gives us access to having huge folios.  Rework the
> buffered write path when we have writeback cache to use the iomap
> buffered write code, the ->get_folio() callback now handles the work
> that we did in ->write_begin(), the rest of the work is handled inside
> of iomap so we don't need a replacement for ->write_end.

Fuse probably needs to select FS_IOMAP with this.  And BLOCK as
well as buffered-io.o depends on it, but I suspect that is relatvely
easily fixable.


