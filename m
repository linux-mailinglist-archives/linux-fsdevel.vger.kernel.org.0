Return-Path: <linux-fsdevel+bounces-37133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC59EDF7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 07:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9611642F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C4A1F9F64;
	Thu, 12 Dec 2024 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="197QYJLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38FB1F9EBB;
	Thu, 12 Dec 2024 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985073; cv=none; b=cs4rgNBro4OBNLBXPsbmkdHOcSz+w4RRbgp1z36luhhgtwoIc3izD/g8H5HjGXbJpgVyX2X3HvjbpiMtXWWCCdyvVl+yY7w0uKt+L3wfDUC090jeo3MhB/IfJR4VwzUu4AGlgMDEuCpIi7tXtcNo7MMhX+d1eSTfZZRGEC0f8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985073; c=relaxed/simple;
	bh=OOe3qJwuiU5PN6Cvie/0DsFI7twc8H3oUoV9ke8IXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwM73wg0qQ6tSxu6+FmZdhvlbBChZKg4CqPD8M+s+E/r45JweCATjM/hfbACiIIBqHLyg0ah1GOBoUWQgpLMNNt0wd8kOFGRuYlHOMOsCTD+Jfn/TiykXOqYtOv/cQx55LwYK9d+4HoCmamgtOiIcrKgQ4ADwbDrdl44klflUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=197QYJLo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FKgA3Ux1TcmweyU18/LTQwOhDOq1BHQNtEEmqWuqfWY=; b=197QYJLoZR/5lotRCC0oK847R+
	S8hCSex9Lb/CsdLWKs27p+G9NJOCpCeP7DwPdSUnf13cjRWUdfn9bno0Nyw8SiLr+IIVFK8oneRAp
	iRt5dC7pQvfuROUDnFBwXPlS/rIJDUbYkLvCwegf/pyB1LNmBTFVbzuBHrKzN9LWp0pNILhDIapOt
	DG6DpvC2r6EWlIfiJ9p9mDKo7LRjeunVp8ey3c+pmSPHSthaz1qfepbPKgGOVo4oqvkF2/G3npgDl
	5suU69zGMcKDVNVtkhmTB3BdOgcgMEXklInOtYfUIU2gz3uWt12trMxlXtLPBEvWJDGyp/KwI6531
	G/PRZpKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcj7-0000000H3RU-3xaB;
	Thu, 12 Dec 2024 06:31:09 +0000
Date: Wed, 11 Dec 2024 22:31:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
	willy@infradead.org, kirill@shutemov.name,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, bfoster@redhat.com
Subject: Re: [PATCH 14/17] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <Z1qDLYPwfaYdoeXW@infradead.org>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-16-axboe@kernel.dk>
 <Z1p5my4wynAW_Vc3@infradead.org>
 <20241212062641.GD6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212062641.GD6678@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 11, 2024 at 10:26:41PM -0800, Darrick J. Wong wrote:
> > iomap.flags and the IOMAP_F_* namespace is used to communicate flags
> > from the file system to the iomap core, so this looks wrong.
> 
> Not entirely true -- IOMAP_F_SIZE_CHANGED is used to communicate state
> from iomap to gfs2, and IOMAP_F_STALE is set/checked only by the iomap
> core.  iomap.h even says as much.

Indeed, some of the non-initial additions already broke this.  And now
that you mentioned it I ran into that before because it was in the way
of some further constifycation I attempted in fs/iomap/.

> Though given that there's a 4-byte gap in struct iomap between flags and
> the bdev pointer (at least on 64-bit) maybe we should make a separate
> field for these iomap state bits?

Probably.  Preferably in a way that isn't too painful for Jens, though.


