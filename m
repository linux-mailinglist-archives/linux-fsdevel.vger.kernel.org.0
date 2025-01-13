Return-Path: <linux-fsdevel+bounces-39048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A9A0BAFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D883A13F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4122CA1F;
	Mon, 13 Jan 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYeevyod"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BD229808
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780111; cv=none; b=lj/FlQDksDlTTvBleAVVCVl80ho/JfYlC73Ye78FNYZ1dg86H4IYhKmQv59jAt2Y73tZdVjkFySaGxlXs1uqMAWiTDMCdUYKtBMgCnOgvRaenh5erFwabvtaSti7CCtnVmEHGXfPmEukeqdzN8XEMOY4UtMq2MfC5yo5qBRrcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780111; c=relaxed/simple;
	bh=f/T94yh48kxxpCXxCWdWwNTYocQpEAaBaubmg5/ycUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQp4R4XbV0f1QIbkb0MckVkl1eujRSXuCNLw2riD/9LqgiuSwiWEOJFB57T/w2vGx7L9NS3xL6xUBqL0p/Rv++uGSOR0UeQ3R7Sy7+TYi1WgiMUjpN9bLAqep7kx7bW4VmK4k0kA/QjbyKcN5j+4Xv4nNyhFrzxCuf1mB3fZOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYeevyod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F30DC4CED6;
	Mon, 13 Jan 2025 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780111;
	bh=f/T94yh48kxxpCXxCWdWwNTYocQpEAaBaubmg5/ycUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYeevyodbXh+qOG6mgOQa9MrPMiFh/tCTfPygyVnkdJZIfL6gcdy0DBQMjL9JIl3U
	 klYYfCInx5ZnaugbG+EZGajEPqK0eiAHYj2t7A1CvCTb7lR78qNHdqzkI8lU7EiWVn
	 FK59nxIQpPLAiGXVmOpWP3O372P1OVr2wh479rkuuDQj8hoDBLSfbQrayedzSJuarD
	 PTugRFgF+KsDqjML+8jvCKx0OTPy+MU+5EnmA/h9GewhKBAZz20RmPvsDu4W4W80cn
	 FDWm73lXKQV421AMr0G0foEH5FGY7YZzncbHrL0EtkAHooGwHPkGI5uLxIkoiWhsqU
	 k7wuZDVDaslrA==
Date: Mon, 13 Jan 2025 15:55:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 04/21] debugfs: don't mess with bits in ->d_fsdata
Message-ID: <20250113-reformieren-baurecht-921c48ce2e96@brauner>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
 <20250112080705.141166-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112080705.141166-4-viro@zeniv.linux.org.uk>

On Sun, Jan 12, 2025 at 08:06:48AM +0000, Al Viro wrote:
> The reason we need that crap is the dual use ->d_fsdata has there -
> it's both holding a debugfs_fsdata reference after the first
> debugfs_file_get() (actually, after the call of proxy ->open())
> *and* it serves as a place to stash a reference to real file_operations
> from object creation to the first open.  Oh, and it's triple use,
> actually - that stashed reference might be to debugfs_short_fops.
> 
> Bugger that for a game of solidiers - just put the operations

The most confusing part of this patch is this sentence. :)
"game of solidiers"?

> reference into debugfs-private augmentation of inode.  And split
> debugfs_full_file_operations into full and short cases, so that
> debugfs_get_file() could tell one from another.
> 
> Voila - ->d_fsdata holds NULL until the first (successful) debugfs_get_file()
> and a reference to struct debugfs_fsdata afterwards.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

