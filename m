Return-Path: <linux-fsdevel+bounces-54609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993EB018C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47831CA549D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683327FB02;
	Fri, 11 Jul 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeDPm+Zr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8C27D781;
	Fri, 11 Jul 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227427; cv=none; b=BuoH0rwZuvB6UFWjtpJJ7tl+AkajJ2UGFOdP18jUwwLEJmDzeI67/OWRs4ymo0uY3i2KOWgtILGafYTvcsdOXMCKSmKnnhK3ZLHzU3drDkgrva3DvlQ7a48ikQZ+HAd0AAzyRfcW+BD0urhOxBmygJ+IzEwakuDcGoh2xlYBYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227427; c=relaxed/simple;
	bh=S68Sdm3hdWr54+bPb5x8Y8IVtYlBfiSa2mWJPoASf20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKVBOzo4xAeGwxPQUXP46KnY74Wfe/RGft7GFynJTez38NuMEv7F5hKoeS8nqCtMLh1BztQ/1JTYln9tzfYEHhG1OlEodvsA9RGeniWC80222YCly1Us5YhUEpyCF/bgIOylWj8wQaqWyckiclETC8RkNir9QXyL6sCs6xXTONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeDPm+Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93771C4CEED;
	Fri, 11 Jul 2025 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752227426;
	bh=S68Sdm3hdWr54+bPb5x8Y8IVtYlBfiSa2mWJPoASf20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeDPm+ZrFrTcdefpS7XvoMofuc20g1V4u+g04xPrAMaMqlNolELtQgO7XCkbKbBlE
	 aX2+hZi57GYv0uXAfwg7W6hkynfftmQEvHO0nMx5ZQZDaF5GMJ6mDHmHfmpvwooVRf
	 KawJBQ3F0dhHNmH7DTm5LRm8xcyMQ06BjxYkT0Nq7wfsFPX1H4+K7ccAbO2HVZd82o
	 Qa4a9ZyNbVsYBQ174vRSHeY8hqcjZeMLLHjGgDDMjMLmAr2YCLL6pCdbFEvnaLIDS3
	 Ws3Ao9qi6y3Ky2KtcfInoiOv9oO3U0PJYH/Vi/NFhGz0hMcagF+kW6EbyJO5MwA+pn
	 gg5X0I+tb7dCA==
Date: Fri, 11 Jul 2025 11:50:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: refactor the iomap writeback code v5
Message-ID: <20250711-arten-randlage-1a867323e2ce@brauner>
References: <20250710133343.399917-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710133343.399917-1-hch@lst.de>

On Thu, Jul 10, 2025 at 03:33:24PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is an alternative approach to the writeback part of the
> "fuse: use iomap for buffered writes + writeback" series from Joanne.
> It doesn't try to make the code build without CONFIG_BLOCK yet.

I'm confused, the last commit in the series makes the code built with
!CONFIG_BLOCK? So this is ready to go?

