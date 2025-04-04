Return-Path: <linux-fsdevel+bounces-45741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F0A7B9A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6E53B7191
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCCB1A315C;
	Fri,  4 Apr 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+L7kr28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AF1C68F;
	Fri,  4 Apr 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757803; cv=none; b=E7yCnZmGS2oFULY13Rnm+/tL1VpHvy0TyGRZ6cWKx1JSSLMzDJO6uw9laUHx6MNV0uDcmcx6aI/Opo6LlWmOoEo/xo0vaQK/PpLM2qvzGoFTML6iCX7Xq1nEDZa9UeXRurYDarwkv4KtmcR5ClpEVPAoYvki9FUZlxP4/d9x2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757803; c=relaxed/simple;
	bh=S/teuTD2v8oRiTzTg+SzTiOtVjFtdknPG646smxU3vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WddV9qp4SPKh8rmtidDZz2AlyLnBiRWX4NFQ6PjlCDxVu+RSirnVVkbm5cEnPBqNRgMvFIsHzPfKH8CKXZEwOKYitHE4xd6c6tyCJ7M3QHpsRZJ3FkDmmR2smSviTHk26L/DdvdtbUQYMes76l+d6bwWPtpaD1kpmIVHUheg6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+L7kr28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1885C4CEE9;
	Fri,  4 Apr 2025 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743757802;
	bh=S/teuTD2v8oRiTzTg+SzTiOtVjFtdknPG646smxU3vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+L7kr28Zm3mRKOff+3I4JASslHt+iskWPDl7jrVw2HRzxlEg7zrOQEiFzH8NPwkF
	 OujqNbNXGZO+dMvB6xmYA+F8XBDbkeBk/Wh+NS3tI5z7LPLvQ847v0WD8EsCnghd9M
	 MP3NFXG2jRuqWFZv8yW/7pb8Nu61lQADsHGr4kc3xykr+MOInWHq04c6YwXHdDHEGd
	 d/sXzUud4mWZEh5bqpWWx6oz4kViECoM6KgUI6DxEMHTcNyCxQ3AhU7hCWD641Y1LH
	 NI+36vKaoo+5C70FedPEUIrfM/HqHFqxHDSspvbxbZFTYyd4gQj4T3rVtK9p1nZ668
	 4C6r1ote/D5VQ==
Date: Fri, 4 Apr 2025 11:09:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in
 may_open()
Message-ID: <20250404-entflammen-report-f8797ac37cde@brauner>
References: <20250403015946.5283-1-superman.xpt@gmail.com>
 <Z--Y_pEL9NAXWloL@infradead.org>
 <20250404-kammer-fahrrad-516fe910491e@brauner>
 <Z--ckIgXpv_-tE1l@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z--ckIgXpv_-tE1l@infradead.org>

On Fri, Apr 04, 2025 at 01:47:12AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 04, 2025 at 10:45:43AM +0200, Christian Brauner wrote:
> > On Fri, Apr 04, 2025 at 01:31:58AM -0700, Christoph Hellwig wrote:
> > > Please make sure anon inodes have a valid mode set.  Leaving this
> > > landmine around where we have inodes without a valid mode is just going
> > > to create more problems in the future.
> > 
> > We've tried to change it, it immediately leads to userspace tools
> > regressions as they've started to rely on that behavior because it's been
> > like that since the dawn of time. We even had to work around that crap
> > in pidfs because lsof regressed. So now, we can't do this.
> 
> Just because i_mode has something useful, we don't need to report that
> to userspace.  We can still clear kstat.mode (with a big fat comment
> explaining why).

Yes, that's what we do in pidfs. I can do this for anon_inode as well.
> 

