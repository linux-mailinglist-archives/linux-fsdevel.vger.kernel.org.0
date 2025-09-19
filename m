Return-Path: <linux-fsdevel+bounces-62257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23261B8AE16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 20:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D463AB19E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7525CC64;
	Fri, 19 Sep 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFgODTm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E215241664
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305653; cv=none; b=j9Ui3wILblylSC09yOrCE4zfByqdK0yL/Lz2aRr00e07bb5KciQnqiQI3/E4Or2ptJbSyeW/iTtc55QhgjuU6tYe+ZhRFLA7ZQUPxVAzT/78Io6u/kPLBD1MB019HY/XpLoWRdb8Jp6tJzncrJ16MK6DzshofJXd92eQ2KuQ2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305653; c=relaxed/simple;
	bh=n3bWL20BOMNoCIK/ccNRnV3pz1RNj2ndisi4mb/xVGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFqxhMjYn+DNLtyTmVIe1gw4H0NYARPGp+dYxd2wml70zG7VKxXDXvnRr/aiQeZUeuLFSA0Y0bGfxBmhvQOVyQaUEQQFmmNhJHd1ToxFPNIGQxZbuVQrB96bJHlDud3bd7tS9CEkQUTSME408jkW5b+CJTX150p55kZpx3pLwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFgODTm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435B0C4CEF7;
	Fri, 19 Sep 2025 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758305653;
	bh=n3bWL20BOMNoCIK/ccNRnV3pz1RNj2ndisi4mb/xVGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFgODTm0iJYhBw0jn/O7UZUDaTP/sJDT2hKmi76BR6OMfVo93G9bVBRHiVTg5fLnu
	 AoC6W0u6HPvEahZiUK7arjRmHC+o5arlI2oDShVugu1Su67LftWixhDqN7eNVPFJpV
	 03Qk/yqMEXF6GISoj4ioegMOHybLpzbThwLCCwdxXd4zwp66VRT0BymPYphwjD+GNY
	 S7Z7yfLpTqwHtyoNUNOEWiamF+0yEXZYgtW5EZTa/FpPRTqINiSzWhpxrAa38hCZxK
	 YR5gHZOKlhOexNG40jLzC1T0BH5YB1jCCs+qmKSZlC+C7ad25qlvwsv6ZwsTE4Bvhb
	 RtvubfB1JXD9w==
Date: Fri, 19 Sep 2025 11:14:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET v5.1] iomap: cleanups ahead of adding fuse support
Message-ID: <20250919181412.GC1587915@frogsfrogsfrogs>
References: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
 <20250919-eisblock-pferde-d5d6190f82be@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-eisblock-pferde-d5d6190f82be@brauner>

On Fri, Sep 19, 2025 at 02:17:38PM +0200, Christian Brauner wrote:
> On Tue, 16 Sep 2025 08:00:24 -0700, Darrick J. Wong wrote:
> > In preparation for making fuse use the fs/iomap code for regular file
> > data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.
> > These patches can go in immediately.
> > 
> > If you're going to start using this code, I strongly recommend pulling
> > from my git trees, which are linked below.
> > 
> > [...]
> 
> Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.iomap branch should appear in linux-next soon.

Thank you!

--D

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.18.iomap
> 
> [1/2] iomap: trace iomap_zero_iter zeroing activities
>       https://git.kernel.org/vfs/vfs/c/231af8c14f0f
> [2/2] iomap: error out on file IO when there is no inline_data buffer
>       https://git.kernel.org/vfs/vfs/c/6a96fb653b64
> 

