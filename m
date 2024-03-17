Return-Path: <linux-fsdevel+bounces-14656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117F87E00B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245F32816B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E92C2032A;
	Sun, 17 Mar 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kWbwE/vZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2D1862A;
	Sun, 17 Mar 2024 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710708839; cv=none; b=ctVPXAB6vLiHKz/6xbI9l5HC7+WJkvk/Ee8zLvZCLh/90zoh2OOjRxh+OrWy58ZJhzSqRSeY6lGJo6Rx6aySyeJ4J0M4pt7yW2AJUTuJ95eHi2WnD90gPqHVGcAHl8IABNbCAib57Fz8jcvCvLOt+XQL+sOV4UXml06jtYHtumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710708839; c=relaxed/simple;
	bh=FIgC6Sxl+GwOsR6NxWtewBGO37BT/+PkHOOjiwpZvG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSdbwDKSajKbYihZf4MnVCEOF7kFsnOwTjc1blgkIOc63UUB/FLg7U+2yyTuHYOcd7u6jhpYJUsBJgB+SoVX28NOtyA3AKm8t4DY88j6gB2DXdKLPXvGlRU1V3aJRvXXqrfXAJzMGrBOmp+tv2AWJ/Qxsmw+54zPlhRUVhdhfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kWbwE/vZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0GB5DfMGKdq6HGKWCczxZ1L967bWyRiMOW3zchEEmj0=; b=kWbwE/vZiIvUVajFt7/yoFj+bg
	DWl5KuMnxUC5sidnrGS2SIckYtYEbmRg2vOn6b9EgUF5z5FLbDfRZnmAkoT1PvcC1Qbsn/E4hoP4l
	9QIgb1tSyFFFuHvOhT3iBP5Jv5rEJjUx333y7hYQwYRpz9nN2hHOY0ehppejKvVKSNA4HgFTUOvVW
	ejlPfEKUnmloHNkoUG+N/1Dt+IqVQGfMD9IEaHj5W8QgOMOKCHqmMMkxM4IkL00/u1HhZODLaANpU
	BtndPMHb2xJqBhq5rWa5WDJ5AOkbDqjAesk8mJlzIg7MnDj8UuNbHHvOedVv8e6GtzkjNwXjj3wMi
	zHifIpIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlxVv-00000006PV8-3sYj;
	Sun, 17 Mar 2024 20:53:51 +0000
Date: Sun, 17 Mar 2024 13:53:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs,block: get holder during claim
Message-ID: <ZfdYX3-_53txEYTa@infradead.org>
References: <20240314165814.tne3leyfmb4sqk2t@quack3>
 <20240315-freibad-annehmbar-ca68c375af91@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-freibad-annehmbar-ca68c375af91@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 15, 2024 at 02:23:07PM +0100, Christian Brauner wrote:
> Now that we open block devices as files we need to deal with the
> realities that closing is a deferred operation. An operation on the
> block device such as e.g., freeze, thaw, or removal that runs
> concurrently with umount, tries to acquire a stable reference on the
> holder. The holder might already be gone though. Make that reliable by
> grabbing a passive reference to the holder during bdev_open() and
> releasing it during bdev_release().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

does bcachefs also need a fix for it's holder ops?  Or does it get to
keep the pieces as it has it's own NULL holder_ops and obviously doens't
care about getting any of this right?

