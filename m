Return-Path: <linux-fsdevel+bounces-19140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C658C08BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5221F22B17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11C54676;
	Thu,  9 May 2024 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0za5rf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831283C482;
	Thu,  9 May 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216407; cv=none; b=RL1grU9u8BizPG2QPtO1zPIwJngMB3Zi9pNHr37fol/9BUIDZyWojMkoec3avbqqlb4MebiE4F+rgltEecTrGwcW4RPRQdbv/hUEXXBlsIoKmTX1+hrlVTtxooeKz67AgpFkOH3BWLcZE9QW/DdYWp0igkpZZ1IT3ndMGxF0yrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216407; c=relaxed/simple;
	bh=9n6emzJJV1YX0cAHx4F9eAW5P1FzVQRtiGBpOCeJFX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwTcP3GNqcXYU2MyuzppKuCymmVzS1qKHYHT7jA4w8Px9g5tXzzM+WPpVyu/Tx/O4vi1iVyN4bLbSrfbLkJpKV3Jwxk4iQtBnyE6dV3nFpCo0tf1TVmPz+ddfAxAdgPLWALtRyWTyPixU/8zcdsLRoxXdEPPfU9tcbpl64YLVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0za5rf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5827C113CC;
	Thu,  9 May 2024 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715216405;
	bh=9n6emzJJV1YX0cAHx4F9eAW5P1FzVQRtiGBpOCeJFX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0za5rf8sBZLeTFfBwvH/5N1DEtRx4ddPaEKSxntYldtCZFiYr+kZfL/DPfTpd57y
	 FkhTonAdznnnMsG/Jp8zcJ/5PM+gP0HSB24OIa5SvzI6O66EgZUZWygQB8n3m664Vk
	 iw2gLzWak8zQqGD7NWJHmLYv7ayRF7VNeJDvoJQbuuL4ka1sD6Vgqp+3H5xH816G20
	 IgUv7nVLhAegE3iIM6ZwFEP1kfHbzk6yoOEt4uVmR2mApKLXHKB1BZi2CcWGV8jx04
	 kONXdu6CLktRjchT/w65rRI6tXLJZuu9lzLKHyav3WPKnjku1XOKMFyOYjqa3XcRWl
	 nEfGC6fd23pIg==
Date: Wed, 8 May 2024 18:00:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Joel Granados <j.granados@samsung.com>,
 Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org,
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240508180003.548af21b@kernel.org>
In-Reply-To: <202405080959.104A73A914@keescook>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
	<20240424201234.3cc2b509@kernel.org>
	<202405080959.104A73A914@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 10:11:35 -0700 Kees Cook wrote:
> > Split this per subsystem, please.  
> 
> I've done a few painful API transitions before, and I don't think the
> complexity of these changes needs a per-subsystem constification pass. I
> think this series is the right approach, but that patch 11 will need
> coordination with Linus. We regularly do system-wide prototype changes
> like this right at the end of the merge window before -rc1 comes out.

Right. I didn't read the code closely enough before responding.
Chalk my response up to being annoyed by the constant stream of
cross-tree changes in procfs without proper cover letter explaining 
how they will be merged :|

