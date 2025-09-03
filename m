Return-Path: <linux-fsdevel+bounces-60166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D612B42549
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CC31B25550
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39333257837;
	Wed,  3 Sep 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ2QsfmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622324A06D;
	Wed,  3 Sep 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913024; cv=none; b=NGwACcFuJZeLbYeYLHQtRX1vX7Tevvxjz1yfjghzyPnljBW99PZN1uQKigxj5RigvjNWWwGR4XhnJEPI3qLk/tL8r/CSLcn3o2Gb5vDhX0A6mR/sw0KyD4KYyjWB7udnBzlkJ57jWFJ+ftWBfl0QNg00AYLslp60vvnxXwx/19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913024; c=relaxed/simple;
	bh=ix8GRvOzNTVU5th9XnzMvP/PXmdtFaambLcJNQNGPsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqywnSgm3w8qmB/R7WmjIo0ytxRTdm02aKTkshmhLw/hknbHOth0H0m4bizaJ5wHqHv33AIAJN0I4ocLB6p/7Vxj+9qODmWug9RJBP+fzDJ6GyaHJ89M2Qp0DWcBs7D6k2tYu4x+ZXOftSjNp8yZ9ZSDhTZ++uy4RBoF6BmNXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ2QsfmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E45C19421;
	Wed,  3 Sep 2025 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756913023;
	bh=ix8GRvOzNTVU5th9XnzMvP/PXmdtFaambLcJNQNGPsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ2QsfmBfyeKXydtEUTslFhsCL+7v4G9wPFj7X/ky0/pXJ7c/ng+pWeentKNlBCKU
	 rH4caFRq6cMMAVDlnKltRSsVws7QvOZFPpW9GWthmQF5+JVDzWp5uHT3WTwLzZkJFX
	 3Er71NELqUAVl9tgUTSj97qVoOgmyl4C7go0mIlyrRon1oidwBSEmJJVWXCEUUfLsn
	 Z5yDYK+9iuAx8v6ELijXmvINCTcu82B0ol16JHnMFgU6bAh/nXKOC+B9LYaKZ2344g
	 m5/Lm2NyPNcmpk2eQSJYaZKwp5k5sCW5SbO3UBdo5r7xM/QlVPauLne7EKCySGpiQu
	 lx6w0wFxLahjA==
Date: Wed, 3 Sep 2025 08:23:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: stable@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
	John@groves.net, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com
Subject: Re: [PATCH 1/7] fuse: fix livelock in synchronous file put from
 fuseblk workers
Message-ID: <20250903152343.GL8117@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708568.15537.7644981804415837951.stgit@frogsfrogsfrogs>
 <CAJfpegv2xzmMCN9Gvy=4Z-vC-ENM-4MoKRwoQrC39jfoa2q-Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv2xzmMCN9Gvy=4Z-vC-ENM-4MoKRwoQrC39jfoa2q-Jw@mail.gmail.com>

On Wed, Sep 03, 2025 at 05:20:13PM +0200, Miklos Szeredi wrote:
> On Thu, 21 Aug 2025 at 02:50, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Fix this by only using synchronous fputs for fuseblk servers if the
> > process doesn't have PF_LOCAL_THROTTLE.  Hopefully the fuseblk server
> > had the good sense to call PR_SET_IO_FLUSHER to mark itself as a
> > filesystem server.
> 
> I'm still not convinced.   This patch adds complexity and depends on
> the server doing some magic, which makes it unreliable.
> 
> Doing it async unconditionally removes complexity and fixes the issue reliably.

Works for me, I'll make it use async mode unconditionally.

--D

> Thanks,
> Miklos

